From: David Turner <dturner@twopensource.com>
Subject: [PATCH v7 3/8] bisect: treat BISECT_HEAD as a ref
Date: Tue,  7 Jul 2015 20:55:58 -0400
Message-ID: <1436316963-25520-3-git-send-email-dturner@twopensource.com>
References: <1436316963-25520-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Wed Jul 08 02:56:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCdfD-0007Ba-UJ
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jul 2015 02:56:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932247AbbGHA4h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 20:56:37 -0400
Received: from mail-qk0-f179.google.com ([209.85.220.179]:36287 "EHLO
	mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757494AbbGHA4V (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 20:56:21 -0400
Received: by qkei195 with SMTP id i195so152904493qke.3
        for <git@vger.kernel.org>; Tue, 07 Jul 2015 17:56:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IWxctUqlY4PK0aJXBqVj32QKqE0SsV7fYNouZ1p4b3A=;
        b=jrLU7emNOz5u0VApDwybDH1PoRUr/fb6f8bKQqFqFKmTfYq2d8PDkM5fV6wFUBiSfU
         I9AgSkt6XeKPh07hDVIwUdrjtlg8MYQ64Zcn1Fa5k9fOntTleYKATNeao22jDif2hgZO
         TB76fC5TOb3HWEuIuBvaRRLdM6scXVpy1QURG6ajfkmuAha118kMPav973SzyCLMVDUG
         YwlPr+IB8AW1wlqsbhFPg0WzUvKEd5kLH0c7/MfB1uDWmcHBWPR5wKvbC2/lYxtnBgye
         4R5YlGlUqsdPHmlIAr1jbbF2Be2vn61b6y73on7sGTJfY0iA3itvyzy/bJqgkmyER5uA
         VzZA==
X-Gm-Message-State: ALoCoQnnT/iMmaAkb6lBekd4s7r7Uu6fAWjXmuIKpsnB1d2sAACiOLPv5o2AQhU3ogQnr72dxrZM
X-Received: by 10.140.19.203 with SMTP id 69mr11578678qgh.33.1436316979230;
        Tue, 07 Jul 2015 17:56:19 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id z135sm278447qhd.29.2015.07.07.17.56.18
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 Jul 2015 17:56:18 -0700 (PDT)
X-Mailer: git-send-email 2.0.5.499.g01f6352.dirty-twtrsrc
In-Reply-To: <1436316963-25520-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273623>

Instead of directly writing to and reading from files in
$GIT_DIR, use ref API to interact with BISECT_HEAD.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 git-bisect.sh | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index ae3fec2..2fd8ea6 100755
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
+	git rev-parse --quiet --verify "BISECT_HEAD" >/dev/null
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
2.0.5.499.g01f6352.dirty-twtrsrc
