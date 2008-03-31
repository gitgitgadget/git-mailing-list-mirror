From: "Sverre Hvammen Johansen" <hvammen@gmail.com>
Subject: Re: [RFC/PATCH 5/5] Introduce fast forward option only
Date: Sun, 30 Mar 2008 20:32:36 -0800
Message-ID: <402c10cd0803302132v7ddc6625tf72436e02e70a4e7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 31 06:33:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JgBhy-0002l5-3G
	for gcvg-git-2@gmane.org; Mon, 31 Mar 2008 06:33:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751482AbYCaEck (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2008 00:32:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751468AbYCaEcj
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Mar 2008 00:32:39 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:14731 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751372AbYCaEcj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2008 00:32:39 -0400
Received: by fg-out-1718.google.com with SMTP id l27so1682735fgb.17
        for <git@vger.kernel.org>; Sun, 30 Mar 2008 21:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=mkQm9toCkEaQRN2jPU4ee7OJj3Fud5IOEul02pN9QIY=;
        b=eaL2DRyJSq4UCRthyOcB7sexoAQlcRJkjNR4v6of3lDc7VNef7O+Zjprq+aDTVTf03cZ6XQLxlY7kEizOwYCEbtqZeDw/s1mfTvSuzIp/pWnY6/ethZDhn0D54NUBtClLahoGO/qceBbfarZyz+EHGDVukceiHgaZEyCPhoT3O4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=jzm7bwGiqbBSPSuPr8laNK3xj/kWP5hpsBEPRvreoAuXppjMH/R/Rar8SWkXijHL/Q5QN6iO3tTCUYWOCblXLn8AvIZY9RoLL5Y8jLEGO4h8DjbwFpj9QaxR9VtVokeV+azGNtcpYhVJVdt+GtW10b4yY9CZ4D4kKK40dyPYds0=
Received: by 10.82.175.17 with SMTP id x17mr15476584bue.19.1206937956941;
        Sun, 30 Mar 2008 21:32:36 -0700 (PDT)
Received: by 10.82.172.14 with HTTP; Sun, 30 Mar 2008 21:32:36 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78556>

This feature is needed for git integration with accurev.
See the documentation for an explanation of this feature.

Signed-off-by: Sverre Hvammen Johansen <hvammen@gmail.com>
---
 Documentation/fast-forward-options.txt |    9 ++
 git-merge.sh                           |   12 +-
 git-pull.sh                            |    2 +-
 t/t7601-merge-ff-options.sh            |  214 ++++++++++++++++++++++++++++++++
 4 files changed, 231 insertions(+), 6 deletions(-)

diff --git a/Documentation/fast-forward-options.txt
b/Documentation/fast-forward-options.txt
index 95d0e6f..4445b0e 100644
--- a/Documentation/fast-forward-options.txt
+++ b/Documentation/fast-forward-options.txt
@@ -12,6 +12,10 @@ never::
        Generate a merge commit even if the merge resolves as a
        fast-forward.  This option is equivalent of '--no-ff'.

+only::
+       Only allow a fast-forward.  The merge will fail unless HEAD is
+       up to date or the merge resolves as a fast-forward.
+
 If your workflow is always to branch from the special branch
 ("master") when working on a topic and merge that back to "master", if
 you happen to have worked only on a single topic and the "master" was
@@ -42,3 +46,8 @@ The first merge of topicA or the only merge of
topicB would have
 resulted in a fast forward without '--ff=never'.  Topic A consist of
 those commits that can be reached from master^2 without passing
 through any of the first-parent ancestries of master.
+
+However, if the workflow require that the branch you are merging with
+is based on the current HEAD you can use "only fast forward" policy to
+enforce fast forward or a failure.  The last merge of topicA in
+the example above would have failed with '--ff=only'.
diff --git a/git-merge.sh b/git-merge.sh
index 7c70c56..68f627d 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -162,21 +162,21 @@ parse_config () {
                        no_commit=t ;;
                --ff)
                        case "$2" in
-                       allow|never)
+                       allow|never|only)
                                fast_forward=$2; shift ;;
                        -*)
                                fast_forward=allow ;;
                        *)
-                               die "Available fast-forward options
are: allow and newer" ;;
+                               die "Available fast-forward options
are: allow, newer, and only" ;;
                        esac
                        ;;
                --ff=*)
                        fast_forward=${1#--ff=}
                        case "$fast_forward" in
-                       allow|never)
+                       allow|never|only)
                                ;;
                        *)
-                               die "Available fast-forward options
are: allow and newer" ;;
+                               die "Available fast-forward options
are: allow, newer, and only" ;;
                        esac
                        ;;
                --no-ff)
@@ -203,7 +203,7 @@ parse_config () {
                shift
        done
        test "$fast_forward" = allow -o "$squash" = "" ||
-               die "You cannot combine --squash with --ff=never"
+               die "You cannot combine --squash with --ff=never or --ff=only."
        args_left=$#
 }

@@ -340,6 +340,8 @@ find_reduced_parents "$@"
 # ff_head may be included here or later in actual parents
 if test -n "$reduced_parents"
 then
+       test $fast_forward = only &&
+               die "--ff=only can not handle more than one real parent"
        test $head = $ff_head ||
                reduced_parents="$ff_head$LF$reduced_parents"
 fi
diff --git a/git-pull.sh b/git-pull.sh
index 2d7293a..5bc84a6 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -41,7 +41,7 @@ do
                no_ff=--ff ;;
        --no-ff)
                no_ff=--no-ff ;;
-       --ff=allow|--ff=never)
+       --ff=allow|--ff=only|--ff=never)
                no_ff=$1 ;;
        -s=*|--s=*|--st=*|--str=*|--stra=*|--strat=*|--strate=*|\
                --strateg=*|--strategy=*|\
diff --git a/t/t7601-merge-ff-options.sh b/t/t7601-merge-ff-options.sh
index 2749f4f..ea36549 100755
--- a/t/t7601-merge-ff-options.sh
+++ b/t/t7601-merge-ff-options.sh
@@ -646,4 +646,218 @@ test_expect_success 'merge c1 with new
repository (pull --ff=never)' '

 test_debug 'gitk --all'

+test_expect_success 'merge c0 with c1 (--ff=only overrides --no-ff)' '
+       git reset --hard c0 &&
+       git config branch.master.mergeoptions "--no-ff" &&
+       git merge --ff=only c1 &&
+       verify_merge file result.1 &&
+       verify_head $c1
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge c0 with c1 (--ff=only in config)' '
+       git reset --hard c0 &&
+       git config branch.master.mergeoptions "--ff=only" &&
+       git merge c1 &&
+       test_tick &&
+       verify_merge file result.1 &&
+       verify_head $c1
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge c1 with c0 (--ff=only in config)' '
+       git reset --hard c1 &&
+       git config branch.master.mergeoptions "--ff=only" &&
+       git merge c0 &&
+       verify_merge file result.1 &&
+       verify_head $c1
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge c1 with c2 (--ff=only in config)' '
+       git reset --hard c1 &&
+       test_tick &&
+       git config branch.master.mergeoptions "--ff=only" &&
+       test_must_fail git merge c2 &&
+       verify_merge file result.1 &&
+       verify_head $c1
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge c0 with c1 (--ff=only)' '
+       git reset --hard c0 &&
+       test_tick &&
+       git merge --ff=only c1 &&
+       verify_merge file result.1 &&
+       verify_head $c1
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge c1 with c0 (--ff=only)' '
+       git reset --hard c1 &&
+       test_tick &&
+       git merge --ff=only c0 &&
+       verify_merge file result.1 &&
+       verify_head $c1
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge c0 with c1 and c2 (--ff=only)' '
+       git reset --hard c0 &&
+       test_must_fail git merge --ff=only c1 c2 &&
+       verify_merge file result.0 &&
+       verify_head $c0
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge c1 with c0 (--ff=only)' '
+       git reset --hard c1 &&
+       test_tick &&
+       git merge --ff=only c0 &&
+       verify_merge file result.1 &&
+       verify_head $c1
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge c1 with c2 (--ff=only overrides --no-ff)' '
+       git reset --hard c1 &&
+       git config branch.master.mergeoptions "--no-ff" &&
+       test_tick &&
+       test_must_fail git merge c2 --ff=only &&
+       verify_merge file result.1 &&
+       verify_head $c1
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge c0 with c1 (--no-ff overrides --ff=only)' '
+       git reset --hard c0 &&
+       git config branch.master.mergeoptions "--ff=only" &&
+       test_tick &&
+       git merge --no-ff c1 &&
+       verify_merge file result.1 &&
+       verify_parents $c0 $c1
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge c1 with c2 (--ff owerrides --ff=only)' '
+       git reset --hard c1 &&
+       git config branch.master.mergeoptions "--ff=only" &&
+       test_tick &&
+       git merge --ff c2 &&
+       verify_merge file result.1-5 &&
+       verify_parents $c1 $c2
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge c1 with x0 (--squash combined with --ff=only)' '
+       git reset --hard c1 &&
+       git config branch.master.mergeoptions "" &&
+       test_tick &&
+       test_must_fail git merge x0 --squash --ff=only &&
+       verify_merge file result.1 &&
+       verify_head $c1
+'
+
+test_debug 'gitk --all'
+
+
+test_expect_success 'merge x0 with c1 (--squash combined with --ff=only)' '
+       git reset --hard x0 &&
+       git config branch.master.mergeoptions "" &&
+       test_tick &&
+       test_must_fail git merge c1 --squash --ff=only &&
+       verify_merge file result.1-5 &&
+       verify_head $x0
+'
+
+test_debug 'gitk --all'
+
+
+test_expect_success 'merge c1 with c2 (--squash combined with --ff=only)' '
+       git reset --hard c1 &&
+       git config branch.master.mergeoptions "" &&
+       test_tick &&
+       test_must_fail git merge c2 --squash --ff=only &&
+       verify_merge file result.1 &&
+       verify_head $c1
+'
+
+test_debug 'gitk --all'
+
+
+test_expect_success 'merge c1 with x0 (--no-commit combined with --ff=only)' '
+       git reset --hard c1 &&
+       git config branch.master.mergeoptions "" &&
+       test_tick &&
+       git merge x0 --no-commit --ff=only &&
+       verify_merge file result.1-5 &&
+       verify_head $x0
+'
+
+test_debug 'gitk --all'
+
+
+test_expect_success 'merge x0 with c1 (--no-commit combined with --ff=only)' '
+       git reset --hard x0 &&
+       git config branch.master.mergeoptions "" &&
+       test_tick &&
+       git merge c1 --no-commit --ff=only &&
+       verify_merge file result.1-5 &&
+       verify_head $x0
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge c1 with c2 (--no-commit combined with --ff=only)' '
+       git reset --hard c1 &&
+       git config branch.master.mergeoptions "" &&
+       test_tick &&
+       test_must_fail git merge c2 --no-commit --ff=only &&
+       verify_merge file result.1 &&
+       verify_head $c1
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge c1 with x1 (pull --ff=only)' '
+       git reset --hard c1 &&
+       test_tick &&
+       git pull --ff=only clone refs/heads/master &&
+       verify_merge file result.1-13 &&
+       verify_head $x1
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge x2 with x1 (pull --ff=only)' '
+       git reset --hard x2 &&
+       test_tick &&
+       test_must_fail git pull --ff=only clone refs/heads/master &&
+       verify_merge file result.5-13 &&
+       verify_head $x2
+'
+
+test_debug 'gitk --all'
+
+test_expect_success 'merge c1 with new repository (pull --ff=only)' '
+       git reset --hard c1 &&
+       test_tick &&
+       test_must_fail git pull --ff=only new refs/heads/master &&
+       verify_merge file result.1 &&
+       verify_head $c1
+'
+
+test_debug 'gitk --all'
+
 test_done
-- 
Sverre Hvammen Johansen
