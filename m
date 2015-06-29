From: David Turner <dturner@twopensource.com>
Subject: [PATCH v5 3/7] bisect: treat BISECT_HEAD as a ref
Date: Mon, 29 Jun 2015 13:54:24 -0400
Message-ID: <1435600468-21710-4-git-send-email-dturner@twopensource.com>
References: <1435600468-21710-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Mon Jun 29 19:54:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9dGd-0005pa-Ro
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jun 2015 19:54:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753420AbbF2Rys (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jun 2015 13:54:48 -0400
Received: from mail-qc0-f175.google.com ([209.85.216.175]:34971 "EHLO
	mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753441AbbF2Ryl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jun 2015 13:54:41 -0400
Received: by qcmc1 with SMTP id c1so45189862qcm.2
        for <git@vger.kernel.org>; Mon, 29 Jun 2015 10:54:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=G+d7zRLkFF5CfrhVBjIKEsCwskG3Zs2NWcIBJs28jZQ=;
        b=d2RGvt6GOJMzNz8+ycraezvQLE8S7sGK82jtLFAPSfPbLirFudY01W4cw71ljd8r//
         d4ILEpa3LD91mrja7YTht66rbdpI2aF/UiC1lKgSQtWQubv5GN9CdzmiFmdghmjtEi+y
         AbfbLVKInKEvoebGphX+pOvf6J7w16Ffvmzbb3W6mOWfBsLOrA756wiMaJ2Ny6LQLB77
         ama1wkiLO+qH3pXtx7FG/bMOl0+0LBH1b+IgPx4k0oF71PdDLzGfkfmGAHSoZFdCNUKU
         TTfy99Bca7NmfSnoQylnvBEcS5b8YxRn2R0h+KJL/ebDiRRfT05nNdll9BgW+gjOn7F4
         g1eQ==
X-Gm-Message-State: ALoCoQmWVXHt1pGCAe7KIIQgIk6amVWr/X3nEWM18yhB8Iz0eqHeR3Y3dYZKWoBdYePhypwN0Zfd
X-Received: by 10.55.18.197 with SMTP id 66mr15763970qks.13.1435600480960;
        Mon, 29 Jun 2015 10:54:40 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.145])
        by mx.google.com with ESMTPSA id w67sm11860026qgw.41.2015.06.29.10.54.39
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 29 Jun 2015 10:54:39 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
In-Reply-To: <1435600468-21710-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272982>

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
