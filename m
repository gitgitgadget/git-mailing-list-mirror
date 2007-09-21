From: Eygene Ryabinkin <rea-git@codelabs.ru>
Subject: [PATCH] Allow shell scripts to run with non-Bash /bin/sh
Date: Sat, 22 Sep 2007 01:43:46 +0400
Message-ID: <20070921214346.GF97288@void.codelabs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 22 00:04:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYqbX-0002T5-Vl
	for gcvg-git-2@gmane.org; Sat, 22 Sep 2007 00:04:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760675AbXIUWEB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2007 18:04:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760363AbXIUWEB
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Sep 2007 18:04:01 -0400
Received: from pobox.codelabs.ru ([144.206.177.45]:62477 "EHLO
	pobox.codelabs.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759433AbXIUWEA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2007 18:04:00 -0400
X-Greylist: delayed 1208 seconds by postgrey-1.27 at vger.kernel.org; Fri, 21 Sep 2007 18:03:59 EDT
DomainKey-Signature: a=rsa-sha1; q=dns; c=simple; s=one; d=codelabs.ru;
	h=Received:Date:From:To:Message-ID:MIME-Version:Content-Type:Content-Disposition:Sender:X-Spam-Status:Subject;
	b=AujmDXhJayIAZvvZlFK4rY7sJ1ToOcwQLDlIKGhedOAx+g9Mjr4KbvLMS/I9JOwdDYtbyB7du3IxF5w360WYuA1TctEg+2uFPF7WBWoRXzQ+OriCunZGHEaKvVcA8u/IsthUYaRR2r7XIb/aq15S1AATuE9wvxDHyST9nHL/irE=;
Received: from void.codelabs.ru (void.codelabs.ru [144.206.177.25])
	by pobox.codelabs.ru with esmtpsa (TLSv1:AES256-SHA:256)
	id 1IYqHu-0002RN-Jd for git@vger.kernel.org; Sat, 22 Sep 2007 01:43:50 +0400
Content-Disposition: inline
X-Spam-Status: No, score=-0.8 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_50
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58889>

Good day.

I had found that FreeBSD's /bin/sh refuses to work with git 1.5.3.2.
correctly: no flags are recognized.  The details and fix are below.
I don't currently know if the Bash's behaviour is POSIXly correct
or the 'case' statement semantics is not very well defined.   But
the following patch fixes the things for the FreeBSD.

Here we go.

-----

Option parsing in the Git shell scripts uses the construct 'while
case "$#" in 0) break ;; esac; do ... done'.  This is neat, because
it needs no external commands invocation.  But in the case when
/bin/sh is not GNU Bash (for example, on FreeBSD) this cycle will
not be executed at all.

The fix is to add the case branch '*) : ;;'.  It also needs no
external commands invocation and it does its work, because ':'
always returns zero.

Signed-off-by: Eygene Ryabinkin <rea-git@codelabs.ru>
---
 git-am.sh                  |    2 +-
 git-clean.sh               |    2 +-
 git-commit.sh              |    2 +-
 git-fetch.sh               |    2 +-
 git-filter-branch.sh       |    2 +-
 git-instaweb.sh            |    2 +-
 git-ls-remote.sh           |    2 +-
 git-merge.sh               |    2 +-
 git-mergetool.sh           |    2 +-
 git-pull.sh                |    2 +-
 git-quiltimport.sh         |    2 +-
 git-rebase--interactive.sh |    2 +-
 git-rebase.sh              |    2 +-
 git-repack.sh              |    2 +-
 git-reset.sh               |    2 +-
 git-submodule.sh           |    2 +-
 16 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 6809aa0..0bd8d34 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -109,7 +109,7 @@ dotest=.dotest sign= utf8=t keep= skip= interactive= resolved= binary=
 resolvemsg= resume=
 git_apply_opt=
 
-while case "$#" in 0) break;; esac
+while case "$#" in 0) break;; *) : ;; esac
 do
 	case "$1" in
 	-d=*|--d=*|--do=*|--dot=*|--dote=*|--dotes=*|--dotest=*)
diff --git a/git-clean.sh b/git-clean.sh
index a5cfd9f..1fac731 100755
--- a/git-clean.sh
+++ b/git-clean.sh
@@ -26,7 +26,7 @@ rmrf="rm -rf --"
 rm_refuse="echo Not removing"
 echo1="echo"
 
-while case "$#" in 0) break ;; esac
+while case "$#" in 0) break ;; *) : ;; esac
 do
 	case "$1" in
 	-d)
diff --git a/git-commit.sh b/git-commit.sh
index bb113e8..5f298c1 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -89,7 +89,7 @@ force_author=
 only_include_assumed=
 untracked_files=
 templatefile="`git config commit.template`"
-while case "$#" in 0) break;; esac
+while case "$#" in 0) break;; *) : ;; esac
 do
 	case "$1" in
 	-F|--F|-f|--f|--fi|--fil|--file)
diff --git a/git-fetch.sh b/git-fetch.sh
index c3a2001..dac2d72 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -27,7 +27,7 @@ shallow_depth=
 no_progress=
 test -t 1 || no_progress=--no-progress
 quiet=
-while case "$#" in 0) break ;; esac
+while case "$#" in 0) break ;; *) : ;; esac
 do
 	case "$1" in
 	-a|--a|--ap|--app|--appe|--appen|--append)
diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index a4b6577..02b567b 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -105,7 +105,7 @@ filter_tag_name=
 filter_subdir=
 orig_namespace=refs/original/
 force=
-while case "$#" in 0) usage;; esac
+while case "$#" in 0) usage;; *) : ;; esac
 do
 	case "$1" in
 	--)
diff --git a/git-instaweb.sh b/git-instaweb.sh
index b79c6b6..c85f8c0 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -61,7 +61,7 @@ stop_httpd () {
 	test -f "$fqgitdir/pid" && kill `cat "$fqgitdir/pid"`
 }
 
-while case "$#" in 0) break ;; esac
+while case "$#" in 0) break ;; *) : ;; esac
 do
 	case "$1" in
 	--stop|stop)
diff --git a/git-ls-remote.sh b/git-ls-remote.sh
index b7e5d04..4ef4341 100755
--- a/git-ls-remote.sh
+++ b/git-ls-remote.sh
@@ -13,7 +13,7 @@ die () {
 }
 
 exec=
-while case "$#" in 0) break;; esac
+while case "$#" in 0) break;; *) : ;; esac
 do
   case "$1" in
   -h|--h|--he|--hea|--head|--heads)
diff --git a/git-merge.sh b/git-merge.sh
index 3a01db0..94a50aa 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -122,7 +122,7 @@ merge_name () {
 case "$#" in 0) usage ;; esac
 
 have_message=
-while case "$#" in 0) break ;; esac
+while case "$#" in 0) break ;; *) : ;; esac
 do
 	case "$1" in
 	-n|--n|--no|--no-|--no-s|--no-su|--no-sum|--no-summ|\
diff --git a/git-mergetool.sh b/git-mergetool.sh
index 47a8055..0e286dd 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -268,7 +268,7 @@ merge_file () {
     cleanup_temp_files
 }
 
-while case $# in 0) break ;; esac
+while case $# in 0) break ;; *) : ;; esac
 do
     case "$1" in
 	-t|--tool*)
diff --git a/git-pull.sh b/git-pull.sh
index 5e96d1f..722ed4e 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -16,7 +16,7 @@ test -z "$(git ls-files -u)" ||
 	die "You are in the middle of a conflicted merge."
 
 strategy_args= no_summary= no_commit= squash=
-while case "$#,$1" in 0) break ;; *,-*) ;; *) break ;; esac
+while case "$#,$1" in 0) break ;; *,-*) : ;; *) break ;; esac
 do
 	case "$1" in
 	-n|--n|--no|--no-|--no-s|--no-su|--no-sum|--no-summ|\
diff --git a/git-quiltimport.sh b/git-quiltimport.sh
index 9de54d1..4039617 100755
--- a/git-quiltimport.sh
+++ b/git-quiltimport.sh
@@ -5,7 +5,7 @@ SUBDIRECTORY_ON=Yes
 
 dry_run=""
 quilt_author=""
-while case "$#" in 0) break;; esac
+while case "$#" in 0) break;; *) : ;; esac
 do
 	case "$1" in
 	--au=*|--aut=*|--auth=*|--autho=*|--author=*)
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index abc2b1c..54e4299 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -317,7 +317,7 @@ do_rest () {
 	done
 }
 
-while case $# in 0) break ;; esac
+while case $# in 0) break ;; *) : ;; esac
 do
 	case "$1" in
 	--continue)
diff --git a/git-rebase.sh b/git-rebase.sh
index 3bd66b0..f7ae22c 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -122,7 +122,7 @@ finish_rb_merge () {
 
 is_interactive () {
 	test -f "$dotest"/interactive ||
-	while case $#,"$1" in 0,|*,-i|*,--interactive) break ;; esac
+	while case $#,"$1" in 0,|*,-i|*,--interactive) break ;; *) : ;; esac
 	do
 		shift
 	done && test -n "$1"
diff --git a/git-repack.sh b/git-repack.sh
index 156c5e8..aac771e 100755
--- a/git-repack.sh
+++ b/git-repack.sh
@@ -9,7 +9,7 @@ SUBDIRECTORY_OK='Yes'
 
 no_update_info= all_into_one= remove_redundant=
 local= quiet= no_reuse= extra=
-while case "$#" in 0) break ;; esac
+while case "$#" in 0) break ;; *) : ;; esac
 do
 	case "$1" in
 	-n)	no_update_info=t ;;
diff --git a/git-reset.sh b/git-reset.sh
index 1dc606f..eb92610 100755
--- a/git-reset.sh
+++ b/git-reset.sh
@@ -11,7 +11,7 @@ require_work_tree
 update= reset_type=--mixed
 unset rev
 
-while case $# in 0) break ;; esac
+while case $# in 0) break ;; *) : ;; esac
 do
 	case "$1" in
 	--mixed | --soft | --hard)
diff --git a/git-submodule.sh b/git-submodule.sh
index 3320998..78a25ad 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -251,7 +251,7 @@ modules_list()
 	done
 }
 
-while case "$#" in 0) break ;; esac
+while case "$#" in 0) break ;; *) : ;; esac
 do
 	case "$1" in
 	add)
-- 
1.5.3.2
-- 
Eygene
