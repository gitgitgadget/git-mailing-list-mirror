X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's in git.git (stable)
Date: Thu, 14 Dec 2006 13:58:54 -0800
Message-ID: <7v4pry16n5.fsf@assigned-by-dhcp.cox.net>
References: <7v4przfpir.fsf@assigned-by-dhcp.cox.net>
	<200612140959.19209.andyparkins@gmail.com>
	<7v7iwu93rv.fsf@assigned-by-dhcp.cox.net>
	<200612141136.59041.andyparkins@gmail.com>
	<20061214114546.GI1747@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 14 Dec 2006 21:59:02 +0000 (UTC)
Cc: git@vger.kernel.org, Andy Parkins <andyparkins@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061214114546.GI1747@spearce.org> (Shawn Pearce's message of
	"Thu, 14 Dec 2006 06:45:46 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34414>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuybT-0006lv-Ev for gcvg-git@gmane.org; Thu, 14 Dec
 2006 22:58:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964840AbWLNV64 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 16:58:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964863AbWLNV64
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 16:58:56 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:46396 "EHLO
 fed1rmmtao05.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S964840AbWLNV6z (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006
 16:58:55 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao05.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061214215855.SJFS15640.fed1rmmtao05.cox.net@fed1rmimpo02.cox.net>; Thu, 14
 Dec 2006 16:58:55 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id ylz61V00H1kojtg0000000; Thu, 14 Dec 2006
 16:59:06 -0500
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

Shawn Pearce <spearce@spearce.org> writes:

> Andy Parkins <andyparkins@gmail.com> wrote:
>> How's this then:
>> 
>> $ git commit
>> $ git commit
>> $ git commit
>> $ git reset HEAD^^^
>> 
>> "AGGGHHHHHH!  I meant HEAD^^"
>> 
>> At this point I start running "git-prune -n | grep commit" and some liberal 
>> use of git-show to try and find the hash of the object so I can do
>
> At this point I usually try to politely suggest that users do:
>
>   git repo-config --global core.logAllRefUpdates true
>
> and in the future do something like:
>
>> $ git commit         # {4}
>> $ git commit         # {3}
>> $ git commit         # {2}
>> $ git reset HEAD^^^  # {1}
>> 
>> "AGGGHHHHHH!  I meant HEAD^^"
>
>   $ git reset HEAD@{4}
>
> should give you what
>
>   $ git reset HEAD^^
>
> would have given had you not added the extra ^.  :-)

Correct but a bad example that does not demonstrate the real
power of reflog.  Andy's AGGGHHHHHH can be recovered with a
simple:

	$ git reset ORIG_HEAD

The real beauty of reflog is that you can usually count number
of commands (not just commit) the way you did and recover with
the @{n} syntax.  With one caveat -- a porcelain might implement
what it does as more than one transaction on the ref, in which
case counting commands does not help.  You need to first make
sure the value of n in @{n} you thought is appropriate is really
the one you want; you would always run "git show -s HEAD@{4}"
before doing the recovering reset in practice, in other words.

And it is not very easy to view where ref was in each step with
existing set of tools.

Not until the attached patch, which was very lightly tested.
You would use it like this:

    $ git-show-branch --reflog next
    ! [next@{0}] Merge branch 'js/show' into next
     ! [next@{1}] Merge branch 'jc/cdup' into next
      ! [next@{2}] Merge branch 'master' into next
       ! [next@{3}] Merge branch 'jc/cdup' into next
    ----
    -    [next@{0}] Merge branch 'js/show' into next
    +    [next@{0}^2] git-show: grok blobs, trees and tags, too
    --   [next@{1}] Merge branch 'jc/cdup' into next
    ++   [next@{1}^2] git-reset [--mixed] <tree> [--] <paths>...
    ++   [next@{1}^2^] git-reset: make it work from within a subdirectory.
    ++   [next@{1}^2~2] git-fetch: make it work from within a subdirectory.
    ++   [next@{0}^2^] INSTALL: no need to have GNU diff installed
    --   [next@{0}^2~2] Merge branch 'maint'
    ++   [next@{0}^2~2^2] Bypass expensive content comparsion during...
       - [next@{3}] Merge branch 'jc/cdup' into next
       + [next@{3}^2] git-reset [--mixed] <tree> [--] <paths>...
       + [next@{3}^2^] git-reset: make it work from within a subdirectory.
       + [next@{3}^2~2] git-fetch: make it work from within a subdirectory.
       + [next@{3}^2~3] Bypass expensive content comparsion during re...
    ++ + [next@{0}^2~3] Update git-diff documentation
    -- - [next@{0}^2~4] Merge branch 'jc/diff--cached'
    ++ + [next@{0}^2~5] git-svn: allow both diff.color and color.diff
    ++ + [next@{0}^2~6] repacked packs should be read-only
    ---- [next@{2}] Merge branch 'master' into next

This shows the actual reflog from the 'next' branch on my
primary repository.  It shows that I did a merge of jc/cdup
branch into 'next' to run tests at next@{3}, but later rewound
that merge at next@{2} and merged the rebased jc/cdup again
later at next@{1} [*1*].  


[Footnote]

*1* Of course, I did all of the above rewinding and rebasing
before pushing the result out, so the general public do not have
to worry about rewinding and rebasing.


---

diff --git a/builtin-show-branch.c b/builtin-show-branch.c
index fb1a400..559bb18 100644
--- a/builtin-show-branch.c
+++ b/builtin-show-branch.c
@@ -6,7 +6,7 @@
 #include "builtin.h"
 
 static const char show_branch_usage[] =
-"git-show-branch [--sparse] [--current] [--all] [--heads] [--tags] [--topo-order] [--more=count | --list | --independent | --merge-base ] [--topics] [<refs>...]";
+"git-show-branch [--sparse] [--current] [--all] [--heads] [--tags] [--topo-order] [--more=count | --list | --independent | --merge-base ] [--topics] [<refs>...] | --reflog[=n] <branch>";
 
 static int default_num;
 static int default_alloc;
@@ -17,6 +17,8 @@ static const char **default_arg;
 #define REV_SHIFT	 2
 #define MAX_REVS	(FLAG_BITS - REV_SHIFT) /* should not exceed bits_per_int - REV_SHIFT */
 
+#define DEFAULT_REFLOG	4
+
 static struct commit *interesting(struct commit_list *list)
 {
 	while (list) {
@@ -570,6 +572,7 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 	int head_at = -1;
 	int topics = 0;
 	int dense = 1;
+	int reflog = 0;
 
 	git_config(git_show_branch_config);
 
@@ -615,6 +618,15 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 			dense = 0;
 		else if (!strcmp(arg, "--date-order"))
 			lifo = 0;
+		else if (!strcmp(arg, "--reflog")) {
+			reflog = DEFAULT_REFLOG;
+		}
+		else if (!strncmp(arg, "--reflog=", 9)) {
+			char *end;
+			reflog = strtoul(arg + 9, &end, 10);
+			if (*end != '\0')
+				die("unrecognized reflog count '%s'", arg + 9);
+		}
 		else
 			usage(show_branch_usage);
 		ac--; av++;
@@ -622,7 +634,7 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 	ac--; av++;
 
 	/* Only one of these is allowed */
-	if (1 < independent + merge_base + (extra != 0))
+	if (1 < independent + merge_base + (extra != 0) + (!!reflog))
 		usage(show_branch_usage);
 
 	/* If nothing is specified, show all branches by default */
@@ -631,9 +643,22 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 
 	if (all_heads + all_tags)
 		snarf_refs(all_heads, all_tags);
-	while (0 < ac) {
-		append_one_rev(*av);
-		ac--; av++;
+	if (reflog) {
+		int reflen;
+		if (!ac)
+			die("--reflog option needs one branch name");
+		reflen = strlen(*av);
+		for (i = 0; i < reflog; i++) {
+			char *name = xmalloc(reflen + 20);
+			sprintf(name, "%s@{%d}", *av, i);
+			append_one_rev(name);
+		}
+	}
+	else {
+		while (0 < ac) {
+			append_one_rev(*av);
+			ac--; av++;
+		}
 	}
 
 	head_p = resolve_ref("HEAD", head_sha1, 1, NULL);




