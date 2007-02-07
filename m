From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Fix "git log -z" behaviour
Date: Wed, 7 Feb 2007 11:49:56 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702071139090.8424@woody.linux-foundation.org>
References: <68948ca0702070841m76817d9el7ce2ec69835c50e@mail.gmail.com>
 <Pine.LNX.4.64.0702070856190.8424@woody.linux-foundation.org>
 <Pine.LNX.4.64.0702070919320.8424@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Don Zickus <dzickus@gmail.com>, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Feb 07 20:50:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEsnv-0000PG-O9
	for gcvg-git@gmane.org; Wed, 07 Feb 2007 20:50:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422720AbXBGTuD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 14:50:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422723AbXBGTuD
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 14:50:03 -0500
Received: from smtp.osdl.org ([65.172.181.24]:33414 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422720AbXBGTuB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 14:50:01 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l17JnvdD016117
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 7 Feb 2007 11:49:57 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l17JnukL025110;
	Wed, 7 Feb 2007 11:49:56 -0800
In-Reply-To: <Pine.LNX.4.64.0702070919320.8424@woody.linux-foundation.org>
X-Spam-Status: No, hits=-0.452 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.113__
X-MIMEDefang-Filter: osdl$Revision: 1.175 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38955>



For commit messages, we should really put the "line_termination" when we 
output the character in between different commits, *not* between the 
commit and the diff. The diff goes hand-in-hand with the commit, it 
shouldn't be separated from it with the termination character.

So this:
 - uses the termination character for true inter-commit spacing
 - uses a regular newline between the commit log and the diff

We had it the other way around.

For the normal case where the termination character is '\n', this 
obviously doesn't change anything at all, since we just switched two 
identical characters around. So it's very safe - it doesn't change any 
normal usage, but it definitely fixes "git log -z".

By fixing "git log -z", you can now also do insane things like

	git log -p -z |
		grep -z "some patch expression" |
		tr '\0' '\n' |
		less -S

and you will see only those commits that have the "some patch expression" 
in their commit message _or_ their patches.

(This is slightly different from 'git log -S"some patch expression"', 
since the latter requires the expression to literally *change* in the 
patch, while the "git log -p -z | grep .." approach will see it if it's 
just an unchanged _part_ of the patch context)

Of course, if you actually do something like the above, you're probably 
insane, but hey, it works!

Try the above command line for a demonstration (of course, you need to 
change the "some patch expression" to be something relevant). The old 
behaviour of "git log -p -z" was useless (and got things completely wrong 
for log entries without patches).

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

On Wed, 7 Feb 2007, Linus Torvalds wrote:
> 
> Also, I just checked, and we have a bug. Merges do not have the ending 
> zero in "git log -z" output. It seems to be connected to the fact that we 
> handle the "always_show_header" commits differently (the ones that we 
> wouldn't normally show because they have no diffs associated with them).
> 
> The obvious fix for that failed. I'll look at it some more.

Actually, the obvious fix was right, I just did the *wrong* obvious fix at 
first ;)

 log-tree.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index d8ca36b..85acd66 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -143,7 +143,7 @@ void show_log(struct rev_info *opt, const char *sep)
 	if (*sep != '\n' && opt->commit_format == CMIT_FMT_ONELINE)
 		extra = "\n";
 	if (opt->shown_one && opt->commit_format != CMIT_FMT_ONELINE)
-		putchar('\n');
+		putchar(opt->diffopt.line_termination);
 	opt->shown_one = 1;
 
 	/*
@@ -270,9 +270,8 @@ int log_tree_diff_flush(struct rev_info *opt)
 		    opt->commit_format != CMIT_FMT_ONELINE) {
 			int pch = DIFF_FORMAT_DIFFSTAT | DIFF_FORMAT_PATCH;
 			if ((pch & opt->diffopt.output_format) == pch)
-				printf("---%c", opt->diffopt.line_termination);
-			else
-				putchar(opt->diffopt.line_termination);
+				printf("---");
+			putchar('\n');
 		}
 	}
 	diff_flush(&opt->diffopt);
