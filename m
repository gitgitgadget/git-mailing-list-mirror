From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 2/6] i18n win32: add git-bisect eval_gettext variable prefix
Date: Wed, 25 May 2011 23:19:50 +0000
Message-ID: <1306365594-22061-3-git-send-email-avarab@gmail.com>
References: <1306365594-22061-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 26 01:20:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPNNN-00080b-NG
	for gcvg-git-2@lo.gmane.org; Thu, 26 May 2011 01:20:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755561Ab1EYXUZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 May 2011 19:20:25 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:36574 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752428Ab1EYXUF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2011 19:20:05 -0400
Received: by eyx24 with SMTP id 24so106226eyx.19
        for <git@vger.kernel.org>; Wed, 25 May 2011 16:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=CZn2yfEXO7By1a4DQ/4DMV4IWhM4uUzvX2no+YWGRw4=;
        b=iEwShnpOmJtEAHLk1qb1XPnYMiOyGs+ARfSek0cQ2VJ1CvV00eA9PwAxfR1yqALYG8
         M8ma+aDEj8UWBtFx3M2rav2rqSeirdYb2BgsWm+/hRQpTW1JkKXcYdKJsbNPP7CShCNM
         Ob3k/QbJQ7jyF97fsLHgOaE0tzoBuTV1ubUYM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=VpvkFd4y4bVGHs5CM9/kULfmZCx5y7r72xrixmRXYfUwH01PZCHfkcg9X3UJIS4PbR
         3DmLRlQQxLD26Ru+6WpSNwx4F2fYfSufCvhgGwvL72e4hdWK2ehQCgAQTizysjoTIrbX
         YOuAcuwJ664NfUmGYbYkNtN0ZOvotUVE4klYc=
Received: by 10.213.108.147 with SMTP id f19mr1844350ebp.9.1306365603922;
        Wed, 25 May 2011 16:20:03 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id b1sm102972eeg.19.2011.05.25.16.20.03
        (version=SSLv3 cipher=OTHER);
        Wed, 25 May 2011 16:20:03 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
In-Reply-To: <1306365594-22061-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174479>

Change the eval_gettext() invocations to use the GIT_I18N_VARIABLE_
prefix for variables used in eval_gettext. On Windows environment
variables are case insensitive, so e.g. $PATH clashes with $path. By
using a sufficiently unique prefix we work around that issue.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-bisect.sh |   39 ++++++++++++++++++++++++++-------------
 1 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index 375b187..6a6ea43 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -116,8 +116,11 @@ bisect_start() {
 		;;
 	    *)
 		rev=3D$(git rev-parse -q --verify "$arg^{commit}") || {
-		    test $has_double_dash -eq 1 &&
-		        die "$(eval_gettext "'\$arg' does not appear to be a valid r=
evision")"
+		    if test $has_double_dash -eq 1
+		    then
+		        $GIT_I18N_VARIABLE_arg=3D$arg
+		        die "$(eval_gettext "'\$GIT_I18N_VARIABLE_arg' does not appe=
ar to be a valid revision")"
+		    fi
 		    break
 		}
 		case $bad_seen in
@@ -162,7 +165,8 @@ bisect_write() {
 	case "$state" in
 		bad)		tag=3D"$state" ;;
 		good|skip)	tag=3D"$state"-"$rev" ;;
-		*)		die "$(eval_gettext "Bad bisect_write argument: \$state")" ;;
+		*)		GIT_I18N_VARIABLE_state=3D$state
+				die "$(eval_gettext "Bad bisect_write argument: \$GIT_I18N_VARIABL=
E_state")" ;;
 	esac
 	git update-ref "refs/bisect/$tag" "$rev" || exit
 	echo "# $state: $(git show-branch $rev)" >>"$GIT_DIR/BISECT_LOG"
@@ -190,7 +194,8 @@ bisect_skip() {
 	do
 	    case "$arg" in
             *..*)
-                revs=3D$(git rev-list "$arg") || die "$(eval_gettext "=
Bad rev input: \$arg")" ;;
+				GIT_I18N_VARIABLE_arg=3D$arg
+                revs=3D$(git rev-list "$arg") || die "$(eval_gettext "=
Bad rev input: \$GIT_I18N_VARIABLE_arg")" ;;
             *)
                 revs=3D$(git rev-parse --sq-quote "$arg") ;;
 	    esac
@@ -215,8 +220,9 @@ bisect_state() {
 		eval=3D''
 		for rev in "$@"
 		do
+			GIT_I18N_VARIABLE_rev=3D$rev
 			sha=3D$(git rev-parse --verify "$rev^{commit}") ||
-				die "$(eval_gettext "Bad rev input: \$rev")"
+				die "$(eval_gettext "Bad rev input: \$GIT_I18N_VARIABLE_rev")"
 			eval=3D"$eval bisect_write '$state' '$sha'; "
 		done
 		eval "$eval"
@@ -333,8 +339,8 @@ bisect_reset() {
 	case "$#" in
 	0) branch=3D$(cat "$GIT_DIR/BISECT_START") ;;
 	1) git rev-parse --quiet --verify "$1^{commit}" > /dev/null || {
-	       invalid=3D"$1"
-	       die "$(eval_gettext "'\$invalid' is not a valid commit")"
+	       GIT_I18N_VARIABLE_invalid=3D"$1"
+	       die "$(eval_gettext "'\$GIT_I18N_VARIABLE_invalid' is not a va=
lid commit")"
 	   }
 	   branch=3D"$1" ;;
 	*)
@@ -343,7 +349,8 @@ bisect_reset() {
 	if git checkout "$branch" -- ; then
 		bisect_clean_state
 	else
-		die "$(eval_gettext "Could not check out original HEAD '\$branch'.
+		GIT_I18N_VARIABLE_branch=3D$branch
+		die "$(eval_gettext "Could not check out original HEAD '\$GIT_I18N_V=
ARIABLE_branch'.
 Try 'git bisect reset <commit>'.")"
 	fi
 }
@@ -369,7 +376,10 @@ bisect_clean_state() {
 bisect_replay () {
 	file=3D"$1"
 	test "$#" -eq 1 || die "$(gettext "No logfile given")"
-	test -r "$file" || die "$(eval_gettext "cannot read \$file for replay=
ing")"
+	test -r "$file" || {
+		GIT_I18N_VARIABLE_file=3D$file
+		die "$(eval_gettext "cannot read \$GIT_I18N_VARIABLE_file for replay=
ing")"
+	}
 	bisect_reset
 	while read git bisect command rev
 	do
@@ -396,16 +406,17 @@ bisect_run () {
=20
     while true
     do
-      command=3D"$@"
-      eval_gettext "running \$command"; echo
+      GIT_I18N_VARIABLE_command=3D"$@"
+      eval_gettext "running \$GIT_I18N_VARIABLE_command"; echo
       "$@"
       res=3D$?
=20
       # Check for really bad run error.
       if [ $res -lt 0 -o $res -ge 128 ]; then
 	  (
+	    GIT_I18N_VARIABLE_res=3D$res
 	    eval_gettext "bisect run failed:
-exit code \$res from '\$command' is < 0 or >=3D 128" &&
+exit code \$GIT_I18N_VARIABLE_res from '\$GIT_I18N_VARIABLE_command' i=
s < 0 or >=3D 128" &&
 	    echo
 	  ) >&2
 	  exit $res
@@ -438,8 +449,10 @@ exit code \$res from '\$command' is < 0 or >=3D 12=
8" &&
=20
       if [ $res -ne 0 ]; then
 	  (
+	      GIT_I18N_VARIABLE_state=3D$state
+	      GIT_I18N_VARIABLE_res=3D$res
 	      eval_gettext "bisect run failed:
-'bisect_state \$state' exited with error code \$res" &&
+'bisect_state \$GIT_I18N_VARIABLE_state' exited with error code \$GIT_=
I18N_VARIABLE_res" &&
 	      echo
 	  ) >&2
 	  exit $res
--=20
1.7.5.1
