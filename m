From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git annotate runs out of memory
Date: Tue, 11 Dec 2007 13:14:18 -0800 (PST)
Message-ID: <alpine.LFD.0.9999.0712111300440.25032@woody.linux-foundation.org>
References: <4aca3dc20712110933i636342fbifb15171d3e3cafb3@mail.gmail.com>  <alpine.LFD.0.9999.0712111018540.25032@woody.linux-foundation.org> <4aca3dc20712111109y5d74a292rf29be6308932393c@mail.gmail.com>
 <alpine.LFD.0.9999.0712111122400.25032@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Daniel Berlin <dberlin@dberlin.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 11 22:16:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2CSM-0000ge-TM
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 22:15:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753851AbXLKVPa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 16:15:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753798AbXLKVPa
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 16:15:30 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:54850 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753704AbXLKVP3 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Dec 2007 16:15:29 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lBBLEJXo028923
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 11 Dec 2007 13:14:20 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lBBLEIs6009176;
	Tue, 11 Dec 2007 13:14:18 -0800
In-Reply-To: <alpine.LFD.0.9999.0712111122400.25032@woody.linux-foundation.org>
X-Spam-Status: No, hits=-2.716 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67942>



On Tue, 11 Dec 2007, Linus Torvalds wrote:
> 
> PS. I also do agree that we seem to use an excessive amount of memory 
> there. As to whether it's the same issue or not, I'd not go as far as Nico 
> and say "yes" yet. But it's interesting.

I think the answer here is that git-annotate is a totally different issue.

The blame machinery keeps around all the blobs it has ever needed to do a 
diff, which explains why something like gcc/ChangeLog blows up badly.

Try this trivial patch.

It will cause us to potentially re-generate some blobs much more, but 
that's a reasonably cheap operation, and our delta base cache will get the 
expensive cases.

It's still not a free operation, but I get

	[torvalds@woody gcc]$ /usr/bin/time ~/git/git-blame gcc/ChangeLog > /dev/null
	20.68user 1.25system 0:21.94elapsed 100%CPU (0avgtext+0avgdata 0maxresident)k
	0inputs+0outputs (0major+599833minor)pagefaults 0swaps

so it took 22s and I never saw it grow very large either (it grew to 72M 
resident, but I don't know how much of that was the mmap of the 
pack-file, so that number is pretty meaningless). Valgrind reports that 
it used a maximum heap of about 24M, and almost all of that seems to have 
been in the delta cache (which is all good).

		Linus

----
 builtin-blame.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/builtin-blame.c b/builtin-blame.c
index c158d31..18f9924 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -87,6 +87,14 @@ struct origin {
 	char path[FLEX_ARRAY];
 };
 
+static void drop_origin_blob(struct origin *o)
+{
+	if (o->file.ptr) {
+		free(o->file.ptr);
+		o->file.ptr = NULL;
+	}
+}
+
 /*
  * Given an origin, prepare mmfile_t structure to be used by the
  * diff machinery
@@ -558,6 +566,8 @@ static struct patch *get_patch(struct origin *parent, struct origin *origin)
 	if (!file_p.ptr || !file_o.ptr)
 		return NULL;
 	patch = compare_buffer(&file_p, &file_o, 0);
+	drop_origin_blob(parent);
+	drop_origin_blob(origin);
 	num_get_patch++;
 	return patch;
 }
