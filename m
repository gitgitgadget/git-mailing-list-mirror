From: Fabian Ruch <bafain@gmail.com>
Subject: [RFC PATCH 1/7] rebase -i: Make option handling in pick_one more
 flexible
Date: Thu, 19 Jun 2014 05:28:26 +0200
Message-ID: <53A258DA.3030903@gmail.com>
References: <cover.1403146774.git.bafain@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 19 05:28:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxT1f-0002sh-BT
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jun 2014 05:28:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756663AbaFSD2b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2014 23:28:31 -0400
Received: from mail-wg0-f51.google.com ([74.125.82.51]:57220 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751674AbaFSD2a (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2014 23:28:30 -0400
Received: by mail-wg0-f51.google.com with SMTP id x12so1675715wgg.10
        for <git@vger.kernel.org>; Wed, 18 Jun 2014 20:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=2tDSi/7NjUoIhC5kektBU2DTrov1/L4O0oL8iKV+UKA=;
        b=N+RqkxRsWwqrb1kgbF/DqNowp4vjGEve1JVU6IKGPKWR8Io1D1tM6xaBBH6/CvWTl/
         +u4PMmGEYJVWaN012X2xqq5r3B3Aok60g/JDCi3yPeRicEFbJHyzpZngzOcs/PpgAL9H
         TCtjyT0JkgBXXFvDquB8T8tYC0eb2LbGAY4p+12rzC/rZN1eMyseOmfQPRtnHswUV1T2
         bO9mLSADKQ8ddAwutgqA1ETNDWd8/pJ5IiNr9nhCkpFrfy4cW+GcyE/vsDP5W83hucSj
         MFKAdzAN+s7+nx3EZdK2x9odQj1V4BnMmxnFLF5zG5whK9lypqGHoeJFOj+lhsL5nbP5
         DapQ==
X-Received: by 10.180.105.68 with SMTP id gk4mr2557580wib.24.1403148508705;
        Wed, 18 Jun 2014 20:28:28 -0700 (PDT)
Received: from client.googlemail.com (nat-wh-nan.rz.uni-karlsruhe.de. [141.70.81.135])
        by mx.google.com with ESMTPSA id g9sm5775812wja.39.2014.06.18.20.28.27
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 18 Jun 2014 20:28:27 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <cover.1403146774.git.bafain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252089>

`pick_one` and `pick_one_preserving_merges` are wrappers around
`cherry-pick` in `rebase --interactive`. They take the hash of a commit
and build a `cherry-pick` command line that

 - respects the user-supplied merge options
 - disables complaints about empty commits
 - tries to fast-forward the rebase head unless rebase is forced
 - suppresses output unless the user requested higher verbosity
 - rewrites merge commits to point to their rebased parents.

`pick_one` is used to implement not only `pick` but also `squash`, which
amends the previous commit rather than creating a new one. When
`pick_one` is called from `squash`, it receives a second argument `-n`.
This tells `pick_one` to apply the changes to the index without
committing them. Since the argument is almost directly passed to
`cherry-pick`, we might want to do the same with other `cherry-pick`
options. Currently, `pick_one` expects `-n` to be the first and only
argument except for the commit hash.

Prepare `pick_one` for additional `cherry-pick` options by allowing `-n`
to appear anywhere before the commit hash in the argument list. Loop
over the argument list and pop each handled item until the commit hash
is the only parameter left on the list. If an option is not supported,
ignore it and issue a warning on the console. Construct a new arguments
list `extra_args` of recognized options that shall be passed to
`cherry-pick` on the command line.

Signed-off-by: Fabian Ruch <bafain@gmail.com>
---
 git-rebase--interactive.sh | 61 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 45 insertions(+), 16 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index f267d8b..ea5514e 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -237,8 +237,26 @@ git_sequence_editor () {
 
 pick_one () {
 	ff=--ff
+	extra_args=
+	while test $# -gt 0
+	do
+		case "$1" in
+		-n)
+			ff=
+			extra_args="$extra_args -n"
+			;;
+		-*)
+			warn "pick_one: ignored option -- $1"
+			;;
+		*)
+			break
+			;;
+		esac
+		shift
+	done
+	test $# -ne 1 && die "pick_one: wrong number of arguments"
+	sha1=$1
 
-	case "$1" in -n) sha1=$2; ff= ;; *) sha1=$1 ;; esac
 	case "$force_rebase" in '') ;; ?*) ff= ;; esac
 	output git rev-parse --verify $sha1 || die "Invalid commit name: $sha1"
 
@@ -248,24 +266,35 @@ pick_one () {
 	fi
 
 	test -d "$rewritten" &&
-		pick_one_preserving_merges "$@" && return
+		pick_one_preserving_merges $extra_args $sha1 && return
 	output eval git cherry-pick \
 			${gpg_sign_opt:+$(git rev-parse --sq-quote "$gpg_sign_opt")} \
-			"$strategy_args" $empty_args $ff "$@"
+			"$strategy_args" $empty_args $ff $extra_args $sha1
 }
 
 pick_one_preserving_merges () {
 	fast_forward=t
-	case "$1" in
-	-n)
-		fast_forward=f
-		sha1=$2
-		;;
-	*)
-		sha1=$1
-		;;
-	esac
-	sha1=$(git rev-parse $sha1)
+	no_commit=
+	extra_args=
+	while test $# -gt 0
+	do
+		case "$1" in
+		-n)
+			fast_forward=f
+			extra_args="$extra_args -n"
+			no_commit=y
+			;;
+		-*)
+			warn "pick_one_preserving_merges: ignored option -- $1"
+			;;
+		*)
+			break
+			;;
+		esac
+		shift
+	done
+	test $# -ne 1 && die "pick_one_preserving_merges: wrong number of arguments"
+	sha1=$(git rev-parse $1)
 
 	if test -f "$state_dir"/current-commit
 	then
@@ -335,7 +364,7 @@ pick_one_preserving_merges () {
 	f)
 		first_parent=$(expr "$new_parents" : ' \([^ ]*\)')
 
-		if [ "$1" != "-n" ]
+		if test -z "$no_commit"
 		then
 			# detach HEAD to current parent
 			output git checkout $first_parent 2> /dev/null ||
@@ -344,7 +373,7 @@ pick_one_preserving_merges () {
 
 		case "$new_parents" in
 		' '*' '*)
-			test "a$1" = a-n && die "Refusing to squash a merge: $sha1"
+			test -n "$no_commit" && die "Refusing to squash a merge: $sha1"
 
 			# redo merge
 			author_script_content=$(get_author_ident_from_commit $sha1)
@@ -365,7 +394,7 @@ pick_one_preserving_merges () {
 		*)
 			output eval git cherry-pick \
 				${gpg_sign_opt:+$(git rev-parse --sq-quote "$gpg_sign_opt")} \
-				"$strategy_args" "$@" ||
+				"$strategy_args" $extra_args $sha1 ||
 				die_with_patch $sha1 "Could not pick $sha1"
 			;;
 		esac
-- 
2.0.0
