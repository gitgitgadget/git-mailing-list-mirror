From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] git-am: add --directory=<dir> option
Date: Sun, 11 Jan 2009 22:33:56 -0800
Message-ID: <7vbpudjanf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>,
	Kevin Ballard <kevin@sb.org>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jan 12 07:35:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMGOY-0001df-Py
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 07:35:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751471AbZALGeI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 01:34:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751449AbZALGeG
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 01:34:06 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:42207 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750825AbZALGeE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 01:34:04 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 086B08F0B9;
	Mon, 12 Jan 2009 01:34:03 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id F23BF8F0B8; Mon,
 12 Jan 2009 01:33:58 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 00CC1D6A-E073-11DD-B679-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105298>

Thanks to a200337 (git-am: propagate -C<n>, -p<n> options as well,
2008-12-04) and commits around it, "git am" is equipped to correctly
propagate the command line flags such as -C/-p/-whitespace across a patch
failure and restart.

It is trivial to support --directory option now, resurrecting previous
attempts by Kevin and Simon.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 "What's cooking" has listed kb/am-directory in "Stalled" category for too
 long a time and I dropped it entirely.  This resurrects the feature.

 git-am.sh             |   17 +++++++++++++----
 t/t4252-am-options.sh |    8 ++++++++
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git c/git-am.sh w/git-am.sh
index 4b157fe..7e6329b 100755
--- c/git-am.sh
+++ w/git-am.sh
@@ -16,6 +16,7 @@ s,signoff       add a Signed-off-by line to the commit message
 u,utf8          recode into utf8 (default)
 k,keep          pass -k flag to git-mailinfo
 whitespace=     pass it through git-apply
+directory=      pass it through git-apply
 C=              pass it through git-apply
 p=              pass it through git-apply
 resolvemsg=     override error message when patch failure occurs
@@ -33,6 +34,14 @@ cd_to_toplevel
 git var GIT_COMMITTER_IDENT >/dev/null ||
 	die "You need to set your committer info first"
 
+sq () {
+	for sqarg
+	do
+		printf "%s" "$sqarg" |
+		sed -e 's/'\''/'\''\'\'''\''/g' -e 's/.*/ '\''&'\''/'
+	done
+}
+
 stop_here () {
     echo "$1" >"$dotest/next"
     exit 1
@@ -155,10 +164,10 @@ do
 		;;
 	--resolvemsg)
 		shift; resolvemsg=$1 ;;
-	--whitespace)
-		git_apply_opt="$git_apply_opt $1=$2"; shift ;;
+	--whitespace|--directory)
+		git_apply_opt="$git_apply_opt $(sq "$1=$2")"; shift ;;
 	-C|-p)
-		git_apply_opt="$git_apply_opt $1$2"; shift ;;
+		git_apply_opt="$git_apply_opt $(sq "$1$2")"; shift ;;
 	--)
 		shift; break ;;
 	*)
@@ -459,7 +468,7 @@ do
 
 	case "$resolved" in
 	'')
-		git apply $git_apply_opt --index "$dotest/patch"
+		eval 'git apply '"$git_apply_opt"' --index "$dotest/patch"'
 		apply_status=$?
 		;;
 	t)
diff --git c/t/t4252-am-options.sh w/t/t4252-am-options.sh
index 3ab9e8e..e91a6da 100755
--- c/t/t4252-am-options.sh
+++ w/t/t4252-am-options.sh
@@ -50,4 +50,12 @@ test_expect_success 'interrupted am -C1 -p2' '
 	grep "^Three$" file-2
 '
 
+test_expect_success 'interrupted am --directory="frotz nitfol"' '
+	rm -rf .git/rebase-apply &&
+	git reset --hard initial &&
+	test_must_fail git am --directory="frotz nitfol" "$tm"/am-test-5-? &&
+	git am --skip &&
+	grep One "frotz nitfol/file-5"
+'
+
 test_done
