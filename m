From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Avoid running lstat(2) on the same cache entry.
Date: Sat, 19 Jan 2008 11:47:56 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801191133330.2957@woody.linux-foundation.org>
References: <alpine.LFD.1.00.0801181911560.2957@woody.linux-foundation.org> <7vfxwu9s2z.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 19 20:49:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGJgq-0005ef-Gw
	for gcvg-git-2@gmane.org; Sat, 19 Jan 2008 20:49:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755238AbYASTso (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jan 2008 14:48:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755140AbYASTso
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jan 2008 14:48:44 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:47093 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754918AbYASTsn (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Jan 2008 14:48:43 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0JJlvQu031787
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 19 Jan 2008 11:47:58 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0JJlulC018770;
	Sat, 19 Jan 2008 11:47:57 -0800
In-Reply-To: <7vfxwu9s2z.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-4.716 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71127>



On Fri, 18 Jan 2008, Junio C Hamano wrote:
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

Acked-by: Linus Torvalds <torvalds@linux-foundation.org>

>  * Again, this is a rebase on top of your "Updated in-memory
>    index".  "echo >>Makefile && git commit -m test Makefile" in
>    the kernel repository does 23k lstat(2) with this patch, 46k
>    without.

Sadly, doing a simple "git commit" without anything else, will still 
apparently get us 69230 lstat() calls, with or without this patch. So we 
get 3 lstat() calls per path.

The call trace for the first one is

 - builtin-commit.c: line 786
	prepare_index
	  refresh_index
	    refresh_cache_ent
	      lstat

while the second one is

 - builtin-commit.c: line 793
	prepare_log_message
	  run_status
	    wt_status_print
	      wt_status_print_changed
	        run_diff_files
	          lstat

and the third one is

 - builtin-commit.c: line 795
	run_status
	  wt_status_print
	    wt_status_print_changed
	      run_diff_files
	        lstat

and the reason is that 
 - "run_diff_files()" doesn't honor ce_uptodate
 - ..but even if it did, wt_status_print_changed() does a wt_read_cache() 
   which will invalidate and re-read the index!

The first problem is trivially fixed (appended), the second one is notas 
trivial.

		Linus
---
 diff-lib.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index 4a05b02..5d5a950 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -435,6 +435,8 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 				continue;
 		}
 
+		if (ce_uptodate(ce))
+			continue;
 		if (lstat(ce->name, &st) < 0) {
 			if (errno != ENOENT && errno != ENOTDIR) {
 				perror(ce->name);
