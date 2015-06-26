From: David Turner <dturner@twopensource.com>
Subject: [PATCH v3 3/7] bisect: treat BISECT_HEAD as a ref
Date: Thu, 25 Jun 2015 20:29:04 -0400
Message-ID: <1435278548-3790-3-git-send-email-dturner@twopensource.com>
References: <1435278548-3790-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Fri Jun 26 02:29:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8HWW-00054N-DI
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jun 2015 02:29:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751500AbbFZA3i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2015 20:29:38 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:34270 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751169AbbFZA3e (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2015 20:29:34 -0400
Received: by igcsj18 with SMTP id sj18so21055017igc.1
        for <git@vger.kernel.org>; Thu, 25 Jun 2015 17:29:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=W2nd371/ewnngTbZjluMua4IHEEKAJHr6n8k23q2OG4=;
        b=GEe9ri9LmD/H5N3c/929TjbqViszywF0WzwIaOtTPuaPIRLAjXxIykgbWZFldlmPwT
         jwqbEC1QpVXBWs48uQLKidNiaVHakAiHB8gkH1JMKMX0MLMgOeYNcMDQE4FUY3vBvwP9
         SUL3ioZPAz+MtBpIelXzgvPKGVZOv1gKu28i1R2pGpMuU1IM3NtlD8qf/Hm70VQm1e+P
         VyQhkr16ZyT+901cr8DFkVKovurTI7lLyHLE/UVXdO9B58XiDWMsT0/e3nhpN7frX1nM
         8vYEcm79yXoMqzLEYFcJmVe7fr8mbIVlfrpPoreJAm54p/H2SvKgMagXkQhSBOs/829d
         9x7g==
X-Gm-Message-State: ALoCoQnand93kV1lxXgT13GZdp/3jaB+rYy/O5Dh2jl/XeOloPs1qUvyVoyfpLJsJQMwuD3wD5fU
X-Received: by 10.42.214.144 with SMTP id ha16mr304463icb.70.1435278572616;
        Thu, 25 Jun 2015 17:29:32 -0700 (PDT)
Received: from ubuntu.twitter.corp? (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by mx.google.com with ESMTPSA id i85sm20714344iod.41.2015.06.25.17.29.30
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 25 Jun 2015 17:29:31 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.314.gdbf7a51-twtrsrc
In-Reply-To: <1435278548-3790-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272749>

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
2.0.4.314.gdbf7a51-twtrsrc
