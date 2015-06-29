From: David Turner <dturner@twopensource.com>
Subject: [PATCH v6 3/7] bisect: treat BISECT_HEAD as a ref
Date: Mon, 29 Jun 2015 16:17:52 -0400
Message-ID: <1435609076-8592-4-git-send-email-dturner@twopensource.com>
References: <1435609076-8592-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Mon Jun 29 22:18:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9fW5-0006eX-92
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jun 2015 22:18:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752989AbbF2USu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jun 2015 16:18:50 -0400
Received: from mail-qk0-f179.google.com ([209.85.220.179]:35350 "EHLO
	mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752434AbbF2USo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jun 2015 16:18:44 -0400
Received: by qkbp125 with SMTP id p125so100394226qkb.2
        for <git@vger.kernel.org>; Mon, 29 Jun 2015 13:18:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=G+d7zRLkFF5CfrhVBjIKEsCwskG3Zs2NWcIBJs28jZQ=;
        b=akf/mMzNJ3saDRzEVQ/xcN9XRSaZbJGxRaBMt70mnQZe1x6PUrPEgpnnvHdTUAwuOi
         Wi287DNgVFDL5vnj5y7NPzjdwPV89RZqHFaBW6AnwHyy/gY56z+/LfI67uXqteW0rTa8
         HqIrIsm70UUp+g97l4I9FuRFe1DtuMxL6to0RgG9wG1aFYhi51KdX+on8MALamqBJ1oX
         PoCPLtYKMTZJi3wLs2zI7i65x7QiwQtWMzFTT56t7jo5MAZ+RozsTASL1rW6o+Qs6MqD
         veX4BxMlyqUrSadsbvl4OGCcRmpDG95EfClbaPKTGpJjuzP/Fl9H0YPQp5bu51t8wl//
         8Q/A==
X-Gm-Message-State: ALoCoQnGsOCnamLKEjEAFbPlW730nnP/Q/Yo3u0NMiAvPFiuQac72NnHtNh5uSMNk4inJVVyWZVM
X-Received: by 10.140.42.247 with SMTP id c110mr21244301qga.100.1435609123524;
        Mon, 29 Jun 2015 13:18:43 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.145])
        by mx.google.com with ESMTPSA id 139sm11906090qhx.22.2015.06.29.13.18.42
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 29 Jun 2015 13:18:42 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
In-Reply-To: <1435609076-8592-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273005>

Instead of directly writing to and reading from files in
$GIT_DIR, use ref API to interact with BISECT_HEAD.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 git-bisect.sh | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index ae3fec2..dddcc89 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -35,7 +35,7 @@ _x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
 
 bisect_head()
 {
-	if test -f "$GIT_DIR/BISECT_HEAD"
+	if bisect_head_exists
 	then
 		echo BISECT_HEAD
 	else
@@ -209,6 +209,10 @@ check_expected_revs() {
 	done
 }
 
+bisect_head_exists() {
+    git rev-parse --quiet --verify "BISECT_HEAD" >/dev/null
+}
+
 bisect_skip() {
 	all=''
 	for arg in "$@"
@@ -310,7 +314,7 @@ bisect_next() {
 	bisect_next_check good
 
 	# Perform all bisection computation, display and checkout
-	git bisect--helper --next-all $(test -f "$GIT_DIR/BISECT_HEAD" && echo --no-checkout)
+	git bisect--helper --next-all $(bisect_head_exists && echo --no-checkout)
 	res=$?
 
 	# Check if we should exit because bisection is finished
@@ -377,7 +381,7 @@ bisect_reset() {
 		usage ;;
 	esac
 
-	if ! test -f "$GIT_DIR/BISECT_HEAD" && ! git checkout "$branch" --
+	if ! bisect_head_exists && ! git checkout "$branch" --
 	then
 		die "$(eval_gettext "Could not check out original HEAD '\$branch'.
 Try 'git bisect reset <commit>'.")"
-- 
2.0.4.315.gad8727a-twtrsrc
