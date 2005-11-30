From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-name-rev off-by-one bug
Date: Tue, 29 Nov 2005 21:06:10 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511292031280.3099@g5.osdl.org>
References: <20051130001503.28498.qmail@science.horizon.com>
 <Pine.LNX.4.64.0511291742000.3135@g5.osdl.org> <7v4q5u50gp.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0511291852530.3099@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux@horizon.com, git@vger.kernel.org, pasky@suse.cz
X-From: git-owner@vger.kernel.org Wed Nov 30 06:10:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EhKDy-0006Mu-Cc
	for gcvg-git@gmane.org; Wed, 30 Nov 2005 06:09:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751006AbVK3FJn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 Nov 2005 00:09:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751007AbVK3FJn
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Nov 2005 00:09:43 -0500
Received: from smtp.osdl.org ([65.172.181.4]:55240 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751003AbVK3FJn (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Nov 2005 00:09:43 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jAU56CnO021356
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 29 Nov 2005 21:06:12 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jAU56Axc006087;
	Tue, 29 Nov 2005 21:06:11 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.64.0511291852530.3099@g5.osdl.org>
X-Spam-Status: No, hits=-6 required=5 tests=PATCH_UNIFIED_DIFF_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.57__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12985>



On Tue, 29 Nov 2005, Linus Torvalds wrote:
> 
> Something like this (untested, of course).
> 
> It _should_ write out
> 
> 	* Unmerged path <filename>
> 
> followed by a regular diff, exactly like you'd want.

The more I thinking about this, the more I think this is a wonderful 
approach, but it would be even better to add a flag to let it choose 
between diffing against stage2 by default or diffing against stage3 (and 
hey, maybe even diffing against the original).

In fact, here's a patch that does that, and also makes the "resolve" merge 
create these kinds of merges. As usual, my python knowledge is useless, 
since the only thing I know about python is that thou shalt not count to 
four. As a result, the standard recursive merge doesn't do this yet ;(

The magic incantation is to just do

	git diff

and you'll get a diff against the first branch. If you want a diff against 
the second branch, just use the "-2" option, and if you want a diff 
against the common base (which is actually surprisingly useful, I noticed, 
when I tried this with a conflict), use "-0".

I've also changed "git diff" to _not_ drop the "-M" and "-p" options just 
because you give some other diff option. That was always a mistake. If you 
really want the raw git diff format, use the raw "git-diff-xyz" programs 
directly.

Whaddaya think? I really like it. Here's an example, where I merged two 
branches that had the file "hello" in it, and the first branch had:

	Hi there
	This is the master branch

and the second one had

	Hi there
	This is the 'other' branch

and the base version had just the "Hi there", of course.

The default (or "-1" arg) behaviour is:

	[torvalds@g5 test-merge]$ git diff
	* Unmerged path hello
	diff --git a/hello b/hello
	index 7cebcf8..3fa4697 100644
	--- a/hello
	+++ b/hello
	@@ -1,2 +1,6 @@
	 Hi there
	+<<<<<<< hello
	 This is the master branch
	+=======
	+This is the 'other' branch
	+>>>>>>> .merge_file_fJWiNf

which is obvious enough. You see exactly the conflict, and you see the 
part of the first branch that is unchanged.

Diffing against the original gives you

	[torvalds@g5 test-merge]$ git diff -0
	* Unmerged path hello
	diff --git a/hello b/hello
	index 6530b63..3fa4697 100644
	--- a/hello
	+++ b/hello
	@@ -1 +1,6 @@
	 Hi there
	+<<<<<<< hello
	+This is the master branch
	+=======
	+This is the 'other' branch
	+>>>>>>> .merge_file_fJWiNf

which I actually found really readable. I realize that this is a really 
stupid example, but for a lot of trivial merges, this won't be _that_ far 
off, and it basically shows what happened in both branches, and ignores 
what neither side changed.

The "-2" in this case is just the same as "-1" except obviously the "+" 
characters are situated differently. Still useful (especially if the 
changes were more complex).

Me likee. Hope you guys do too.

(And this is quite independently of the advantage that you can't commit an 
unmerged state by mistake, which is perhaps an even bigger one).

		Linus

---
diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 6b496ed..afc7334 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -18,6 +18,12 @@
 	object name of pre- and post-image blob on the "index"
 	line when generating a patch format output.	
 
+-0 -1 -2::
+	When an unmerged entry is seen, diff against the base version,
+	the "first branch" or the "second branch" respectively.
+
+	The default is to diff against the first branch.
+
 -B::
 	Break complete rewrite changes into pairs of delete and create.
 
diff --git a/diff-files.c b/diff-files.c
index 38599b5..d744636 100644
--- a/diff-files.c
+++ b/diff-files.c
@@ -13,6 +13,7 @@ COMMON_DIFF_OPTIONS_HELP;
 
 static struct diff_options diff_options;
 static int silent = 0;
+static int diff_unmerged_stage = 2;
 
 static void show_unmerge(const char *path)
 {
@@ -46,7 +47,13 @@ int main(int argc, const char **argv)
 			argc--;
 			break;
 		}
-		if (!strcmp(argv[1], "-q"))
+		if (!strcmp(argv[1], "-0"))
+			diff_unmerged_stage = 1;
+		else if (!strcmp(argv[1], "-1"))
+			diff_unmerged_stage = 2;
+		else if (!strcmp(argv[1], "-2"))
+			diff_unmerged_stage = 3;
+		else if (!strcmp(argv[1], "-q"))
 			silent = 1;
 		else if (!strcmp(argv[1], "-r"))
 			; /* no-op */
@@ -95,11 +102,23 @@ int main(int argc, const char **argv)
 
 		if (ce_stage(ce)) {
 			show_unmerge(ce->name);
-			while (i < entries &&
-			       !strcmp(ce->name, active_cache[i]->name))
+			while (i < entries) {
+				struct cache_entry *nce = active_cache[i];
+
+				if (strcmp(ce->name, nce->name))
+					break;
+				/* Prefer to diff against the proper unmerged stage */
+				if (ce_stage(nce) == diff_unmerged_stage)
+					ce = nce;
 				i++;
-			i--; /* compensate for loop control increments */
-			continue;
+			}
+			/*
+			 * Compensate for loop update
+			 */
+			i--;
+			/*
+			 * Show the diff for the 'ce' we chose
+			 */
 		}
 
 		if (lstat(ce->name, &st) < 0) {
diff --git a/git-diff.sh b/git-diff.sh
index b3ec84b..efe8f75 100755
--- a/git-diff.sh
+++ b/git-diff.sh
@@ -3,12 +3,13 @@
 # Copyright (c) 2005 Linus Torvalds
 # Copyright (c) 2005 Junio C Hamano
 
+# Some way to turn these off?
+default_flags="-M -p"
+
 rev=$(git-rev-parse --revs-only --no-flags --sq "$@") || exit
-flags=$(git-rev-parse --no-revs --flags --sq "$@")
+flags=$(git-rev-parse --no-revs --flags --sq $default_flags "$@")
 files=$(git-rev-parse --no-revs --no-flags --sq "$@")
 
-: ${flags:="'-M' '-p'"}
-
 # I often say 'git diff --cached -p' and get scolded by git-diff-files, but
 # obviously I mean 'git diff --cached -p HEAD' in that case.
 case "$rev" in
diff --git a/git-merge-one-file.sh b/git-merge-one-file.sh
index c3eca8b..739a072 100755
--- a/git-merge-one-file.sh
+++ b/git-merge-one-file.sh
@@ -79,11 +79,7 @@ case "${1:-.}${2:-.}${3:-.}" in
 		;;
 	esac
 
-	# We reset the index to the first branch, making
-	# git-diff-file useful
-	git-update-index --add --cacheinfo "$6" "$2" "$4"
-		git-checkout-index -u -f -- "$4" &&
-		merge "$4" "$orig" "$src2"
+	merge "$4" "$orig" "$src2"
 	ret=$?
 	rm -f -- "$orig" "$src2"
 
