From: David Turner <dturner@twopensource.com>
Subject: [PATCH v4 3/6] bisect: treat BISECT_HEAD as a ref
Date: Sat, 27 Jun 2015 00:23:53 -0400
Message-ID: <1435379036-30894-4-git-send-email-dturner@twopensource.com>
References: <1435379036-30894-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Sat Jun 27 06:24:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8hfb-0005t5-CV
	for gcvg-git-2@plane.gmane.org; Sat, 27 Jun 2015 06:24:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753514AbbF0EYe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Jun 2015 00:24:34 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:34761 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752523AbbF0EY1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jun 2015 00:24:27 -0400
Received: by igcsj18 with SMTP id sj18so45398844igc.1
        for <git@vger.kernel.org>; Fri, 26 Jun 2015 21:24:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=G+d7zRLkFF5CfrhVBjIKEsCwskG3Zs2NWcIBJs28jZQ=;
        b=PCQrMw/TVxbfoKEOtU8CgNl69i1RyGxcXEphjwzm0l+lHM4tJrI8wPJlTyrgGma79A
         FBe+nsG4AhbsTsK5Zj/4XSPRrdRn4bIh2creAhLWf8gXivd8NwNKbyTanBhZ1ehagyAB
         QcefGG4e1ZZa0AWq7tCeCP8o+d52y2FHzkqS4au9MQDobmsoRotGeHudoY8mX23UTEiB
         V+A52R6t8cD0kmPIbJizk/VzarPcDgVmeXkJciFj1e9hGw9H/EHF/bglmVwLwtyhmcQJ
         oJWbBhuTRELrM+1WnefElw5i0nl4t/sI/57Z5giimgQB9Vr1QqYB1SiKl2JUT2aXd36b
         eyxQ==
X-Gm-Message-State: ALoCoQniiawgKTXzA3qhT73fdb/lGbYr0mB+Wr6PO/pAy5qZi9doCqYg87BXREsbycoQ+7XXWm+V
X-Received: by 10.107.134.16 with SMTP id i16mr6825216iod.6.1435379066466;
        Fri, 26 Jun 2015 21:24:26 -0700 (PDT)
Received: from ubuntu.twitter.corp? (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by mx.google.com with ESMTPSA id k74sm22930720iok.30.2015.06.26.21.24.24
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 26 Jun 2015 21:24:25 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
In-Reply-To: <1435379036-30894-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272845>

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
