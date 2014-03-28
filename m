From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v2 3/3] patch-id-test: test new --stable and --unstable flags
Date: Fri, 28 Mar 2014 14:30:18 +0200
Message-ID: <1396009159-2078-3-git-send-email-mst@redhat.com>
References: <1396009159-2078-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: sunshine@sunshineco.com, jrnieder@gmail.com, peff@peff.net,
	gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 28 13:30:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTVvT-0007Nl-Vq
	for gcvg-git-2@plane.gmane.org; Fri, 28 Mar 2014 13:30:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752022AbaC1MaB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Mar 2014 08:30:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47563 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751304AbaC1MaA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Mar 2014 08:30:00 -0400
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s2SCTusp009396
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Fri, 28 Mar 2014 08:29:56 -0400
Received: from redhat.com (vpn1-7-130.ams2.redhat.com [10.36.7.130])
	by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with SMTP id s2SCTshw029514;
	Fri, 28 Mar 2014 08:29:54 -0400
Content-Disposition: inline
In-Reply-To: <1396009159-2078-1-git-send-email-mst@redhat.com>
X-Mutt-Fcc: =sent
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245384>

Verify that patch ID is now stable against hunk reordering.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

changes from v1:
	Use <<-\EOF to address comment by Eric Sunshine

 t/t4204-patch-id.sh | 68 +++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 63 insertions(+), 5 deletions(-)

diff --git a/t/t4204-patch-id.sh b/t/t4204-patch-id.sh
index d2c930d..44dfd33 100755
--- a/t/t4204-patch-id.sh
+++ b/t/t4204-patch-id.sh
@@ -5,12 +5,27 @@ test_description='git patch-id'
 . ./test-lib.sh
 
 test_expect_success 'setup' '
-	test_commit initial foo a &&
-	test_commit first foo b &&
+	test_commit initial-foo foo a &&
+	test_commit initial-bar bar a &&
+	echo b > foo &&
+	echo b > bar &&
+	git commit -a -m first &&
 	git checkout -b same HEAD^ &&
-	test_commit same-msg foo b &&
+	echo b > foo &&
+	echo b > bar &&
+	git commit -a -m same-msg &&
 	git checkout -b notsame HEAD^ &&
-	test_commit notsame-msg foo c
+	echo c > foo &&
+	echo c > bar &&
+	git commit -a -m notsame-msg &&
+	cat > bar-then-foo <<-\EOF &&
+		bar
+		foo
+		EOF
+	cat > foo-then-bar <<-\EOF
+		foo
+		bar
+		EOF
 '
 
 test_expect_success 'patch-id output is well-formed' '
@@ -23,11 +38,33 @@ calc_patch_id () {
 		sed "s# .*##" > patch-id_"$1"
 }
 
+calc_patch_id_unstable () {
+	git patch-id --unstable |
+		sed "s# .*##" > patch-id_"$1"
+}
+
+calc_patch_id_stable () {
+	git patch-id --stable |
+		sed "s# .*##" > patch-id_"$1"
+}
+
+
 get_patch_id () {
-	git log -p -1 "$1" | git patch-id |
+	git log -p -1 "$1" -O bar-then-foo -- | git patch-id |
 		sed "s# .*##" > patch-id_"$1"
 }
 
+get_patch_id_stable () {
+	git log -p -1 "$1" -O bar-then-foo | git patch-id --stable |
+		sed "s# .*##" > patch-id_"$1"
+}
+
+get_patch_id_unstable () {
+	git log -p -1 "$1" -O bar-then-foo | git patch-id --unstable |
+		sed "s# .*##" > patch-id_"$1"
+}
+
+
 test_expect_success 'patch-id detects equality' '
 	get_patch_id master &&
 	get_patch_id same &&
@@ -56,6 +93,27 @@ test_expect_success 'whitespace is irrelevant in footer' '
 	test_cmp patch-id_master patch-id_same
 '
 
+test_expect_success 'file order is irrelevant by default' '
+	get_patch_id master &&
+	git checkout same &&
+	git format-patch -1 --stdout -O foo-then-bar | calc_patch_id same &&
+	test_cmp patch-id_master patch-id_same
+'
+
+test_expect_success 'file order is irrelevant with --stable' '
+	get_patch_id_stable master &&
+	git checkout same &&
+	git format-patch -1 --stdout -O foo-then-bar | calc_patch_id_stable same &&
+	test_cmp patch-id_master patch-id_same
+'
+
+test_expect_success 'file order is relevant with --unstable' '
+	get_patch_id_unstable master &&
+	git checkout same &&
+	git format-patch -1 --stdout -O foo-then-bar | calc_patch_id_unstable notsame &&
+	! test_cmp patch-id_master patch-id_notsame
+'
+
 test_expect_success 'patch-id supports git-format-patch MIME output' '
 	get_patch_id master &&
 	git checkout same &&
-- 
MST
