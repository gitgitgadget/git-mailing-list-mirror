From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git-commit fatal: Out of memory? mmap failed: Bad file
 descriptor
Date: Tue, 15 Jan 2008 10:50:19 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801151036110.2806@woody.linux-foundation.org>
References: <4787E981.7010200@nrlssc.navy.mil> <478C1D7A.6090103@nrlssc.navy.mil> <alpine.LFD.1.00.0801142140560.2806@woody.linux-foundation.org> <478CECAB.2030906@nrlssc.navy.mil> <alpine.LFD.1.00.0801150931260.2806@woody.linux-foundation.org>
 <478CFAFF.6010006@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>, drafnel@gmail.com,
	Junio C Hamano <gitster@pobox.com>,
	Alex Riesen <raa.lkml@gmail.com>,
	=?ISO-8859-15?Q?Kristian_H=F8gsberg?= <krh@redhat.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Tue Jan 15 19:52:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEqtB-0004wk-Ck
	for gcvg-git-2@gmane.org; Tue, 15 Jan 2008 19:51:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751676AbYAOSv2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 13:51:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751470AbYAOSv2
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 13:51:28 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:34337 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751320AbYAOSv1 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Jan 2008 13:51:27 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0FIoLYR014051
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 15 Jan 2008 10:50:22 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0FIoJnq030252;
	Tue, 15 Jan 2008 10:50:20 -0800
In-Reply-To: <478CFAFF.6010006@nrlssc.navy.mil>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.721 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70540>



On Tue, 15 Jan 2008, Brandon Casey wrote:
>
> Linus Torvalds wrote:
> > It would obviously be interesting to see the base repository and the 
> > commit you are trying to do - is that possibly publicly available?
> 
> I wish it was.

It's ok, I found the bug in your full strace.

The bug really is pretty stupid:

 - prepare_index() does a 

	fd = hold_lock_file_for_update(&false_lock, ...
	...
	if (write_cache(fd, active_cache, active_nr) || close(fd))
		die("unable to write temporary index file");

and the magic here is that *it*closes*the*fd*.

But that's not how "hold_lock_file_for_update()" works. It still has that 
fd squirrelled away in it's "false_lock.fd", and later on, when we do 

	rollback_lock_file(&false_lock);

(in the COMMIT_PARTIAL case of either "commit_index_files()" or 
"rollback_index_files()"), that rollback_lock_file() will do:

	void rollback_lock_file(struct lock_file *lk)
	{
	        if (lk->filename[0]) {
	                close(lk->fd);
	                unlink(lk->filename);
	        }
	        lk->filename[0] = 0;
	}

and now it's trying to close that fd *again* and would normally get a 
EBADF there. But in the meantime, somebody already re-used it for 
something else, and what rollback_lock_file() ends up doing is to just 
close some random file descriptor.

In other words, I'm pretty sure that the bug goes away with this really 
ugly hack. The real problem is that that "false_lockfile" thing simply 
mis-uses the whole lockfile interface. So this is not a pretty fix, but it 
at least should hide the effects of the mis-use of the interface.

In other words: the file descriptor that is returned by the lock_file 
interface functions *MUST*NOT* be closed. But if you violate that rule, 
you'd better make sure that you also fix the effects.

		Linus

---
 builtin-commit.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 265ba6b..7a52224 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -308,6 +308,9 @@ static char *prepare_index(int argc, const char **argv, const char *prefix)
 
 	if (write_cache(fd, active_cache, active_nr) || close(fd))
 		die("unable to write temporary index file");
+
+	/* We closed the false lock-file fd, make sure we don't do anything else to it */
+	false_lock.fd = -1;
 	return false_lock.filename;
 }
 
