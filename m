From: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
Subject: Re: git-commit fatal: Out of memory? mmap failed: Bad file
	descriptor
Date: Tue, 15 Jan 2008 15:00:02 -0500
Message-ID: <1200427202.5821.7.camel@gaara.boston.redhat.com>
References: <4787E981.7010200@nrlssc.navy.mil>
	 <478C1D7A.6090103@nrlssc.navy.mil>
	 <alpine.LFD.1.00.0801142140560.2806@woody.linux-foundation.org>
	 <478CECAB.2030906@nrlssc.navy.mil>
	 <alpine.LFD.1.00.0801150931260.2806@woody.linux-foundation.org>
	 <478CFAFF.6010006@nrlssc.navy.mil>
	 <alpine.LFD.1.00.0801151036110.2806@woody.linux-foundation.org>
	 <478D0CDA.5050709@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>, drafnel@gmail.com,
	Junio C Hamano <gitster@pobox.com>,
	Alex Riesen <raa.lkml@gmail.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Tue Jan 15 21:03:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEs0A-0007E0-0W
	for gcvg-git-2@gmane.org; Tue, 15 Jan 2008 21:03:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751887AbYAOUCo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 15:02:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751883AbYAOUCo
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 15:02:44 -0500
Received: from mx1.redhat.com ([66.187.233.31]:52899 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751871AbYAOUCn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2008 15:02:43 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m0FK093L029251;
	Tue, 15 Jan 2008 15:00:09 -0500
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m0FK08hG010234;
	Tue, 15 Jan 2008 15:00:08 -0500
Received: from [192.168.1.105] (dhcp83-9.boston.redhat.com [172.16.83.9])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m0FK081p013336;
	Tue, 15 Jan 2008 15:00:08 -0500
In-Reply-To: <478D0CDA.5050709@nrlssc.navy.mil>
X-Mailer: Evolution 2.21.4 (2.21.4-1.fc9) 
X-Scanned-By: MIMEDefang 2.58 on 172.16.52.254
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70545>

On Tue, 2008-01-15 at 13:43 -0600, Brandon Casey wrote:
> Linus Torvalds wrote:
> > 
> > On Tue, 15 Jan 2008, Brandon Casey wrote:
> >> Linus Torvalds wrote:
> >>> It would obviously be interesting to see the base repository and the 
> >>> commit you are trying to do - is that possibly publicly available?
> >> I wish it was.
> > 
> > It's ok, I found the bug in your full strace.
> 
> Good catch, but that wasn't it. Still getting the same error.
> 
> > and now it's trying to close that fd *again*
> 
> In that same vein, just above your changes in prepare_index() is:
> 
> 	if (!pathspec || !*pathspec) {
> 		fd = hold_locked_index(&index_lock, 1);
> 		refresh_cache(REFRESH_QUIET);
> 		if (write_cache(fd, active_cache, active_nr) ||
> 		    close(fd) || commit_locked_index(&index_lock))
> 			die("unable to write new_index file");
> 		commit_style = COMMIT_AS_IS;
> 		return get_index_file();
> 	}
> 
> If I followed hold_locked_index() correctly, then fd and index_lock.fd
> are equal, and commit_locked_index() does a close(lk->fd) making the
> close(fd) above, redundant (or vice-versa).

To my defense, the lockfile API is used a little inconsitently in git.
Many places in git does a close(fd) and the call commit_locked_index(),
which will close the fd again.  Normally that will just cause an EBADFD
which we ignore, but the problem here is that there's a longer time
between close(fd) and the commit/rollback of the lock file.  I guess the
correct way to use the API is to never close the fd manually, but I
copied and pasted the lockfile use in builtin-commit.c from somewhere
else and along with it the double close.

There's four close(fd) calls in prepare_index() and they're all
incorrect.  The open fd's are cleaned up in rollback_index_files() and
shouldn't be closed manually.  The patch below gets rid of the extra
close() calls and should fix the problem.

cheers,
Kristian

diff --git a/builtin-commit.c b/builtin-commit.c
index 73f1e35..4494c9c 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -212,7 +212,7 @@ static char *prepare_index(int argc, const char **argv, const char *prefix)
 		int fd = hold_locked_index(&index_lock, 1);
 		add_files_to_cache(0, also ? prefix : NULL, pathspec);
 		refresh_cache(REFRESH_QUIET);
-		if (write_cache(fd, active_cache, active_nr) || close(fd))
+		if (write_cache(fd, active_cache, active_nr))
 			die("unable to write new_index file");
 		commit_style = COMMIT_NORMAL;
 		return index_lock.filename;
@@ -231,7 +231,7 @@ static char *prepare_index(int argc, const char **argv, const char *prefix)
 		fd = hold_locked_index(&index_lock, 1);
 		refresh_cache(REFRESH_QUIET);
 		if (write_cache(fd, active_cache, active_nr) ||
-		    close(fd) || commit_locked_index(&index_lock))
+		    commit_locked_index(&index_lock))
 			die("unable to write new_index file");
 		commit_style = COMMIT_AS_IS;
 		return get_index_file();
@@ -273,7 +273,7 @@ static char *prepare_index(int argc, const char **argv, const char *prefix)
 	fd = hold_locked_index(&index_lock, 1);
 	add_remove_files(&partial);
 	refresh_cache(REFRESH_QUIET);
-	if (write_cache(fd, active_cache, active_nr) || close(fd))
+	if (write_cache(fd, active_cache, active_nr))
 		die("unable to write new_index file");
 
 	fd = hold_lock_file_for_update(&false_lock,
@@ -289,7 +289,7 @@ static char *prepare_index(int argc, const char **argv, const char *prefix)
 	add_remove_files(&partial);
 	refresh_cache(REFRESH_QUIET);
 
-	if (write_cache(fd, active_cache, active_nr) || close(fd))
+	if (write_cache(fd, active_cache, active_nr))
 		die("unable to write temporary index file");
 	return false_lock.filename;
 }
