From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v3 3/3] patch-id-test: test --stable and --unstable flags
Date: Sun, 30 Mar 2014 21:09:29 +0300
Message-ID: <1396202583-2572-3-git-send-email-mst@redhat.com>
References: <1396202583-2572-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: sunshine@sunshineco.com, jrnieder@gmail.com, peff@peff.net,
	gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 30 20:09:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUKAg-0006eV-Pk
	for gcvg-git-2@plane.gmane.org; Sun, 30 Mar 2014 20:09:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751897AbaC3SJQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Mar 2014 14:09:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:7708 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751768AbaC3SJO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Mar 2014 14:09:14 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s2UI93ws018831
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Sun, 30 Mar 2014 14:09:03 -0400
Received: from redhat.com (vpn1-7-185.ams2.redhat.com [10.36.7.185])
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id s2UI90sq011921;
	Sun, 30 Mar 2014 14:09:01 -0400
Content-Disposition: inline
In-Reply-To: <1396202583-2572-1-git-send-email-mst@redhat.com>
X-Mutt-Fcc: =sent
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.27
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245485>

Verify that patch ID is now stable against diff split and reordering.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

Changes from v2:
	added test to verify patch ID is stable against diff splitting

 t/t4204-patch-id.sh | 117 ++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 109 insertions(+), 8 deletions(-)

diff --git a/t/t4204-patch-id.sh b/t/t4204-patch-id.sh
index d2c930d..1679714 100755
--- a/t/t4204-patch-id.sh
+++ b/t/t4204-patch-id.sh
@@ -5,12 +5,46 @@ test_description='git patch-id'
 . ./test-lib.sh
 
 test_expect_success 'setup' '
-	test_commit initial foo a &&
-	test_commit first foo b &&
-	git checkout -b same HEAD^ &&
-	test_commit same-msg foo b &&
-	git checkout -b notsame HEAD^ &&
-	test_commit notsame-msg foo c
+	cat > a <<-\EOF &&
+		a
+		a
+		a
+		a
+		a
+		a
+		a
+		a
+		EOF
+	(cat a; echo b) > ab &&
+	(echo d; cat a; echo b) > dab &&
+	cp a foo &&
+	cp a bar &&
+	git add foo bar &&
+	git commit -a -m initial &&
+	cp ab foo &&
+	cp ab bar &&
+	git commit -a -m first &&
+	git checkout -b same master &&
+	git commit --amend -m same-msg &&
+	git checkout -b notsame master &&
+	echo c > foo &&
+	echo c > bar &&
+	git commit --amend -a -m notsame-msg &&
+	git checkout -b split master &&
+	cp dab foo &&
+	cp dab bar &&
+	git commit -a -m split &&
+	git checkout -b merged master &&
+	git checkout split -- foo bar &&
+	git commit --amend -a -m merged &&
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
@@ -23,11 +57,33 @@ calc_patch_id () {
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
@@ -52,10 +108,55 @@ test_expect_success 'patch-id supports git-format-patch output' '
 test_expect_success 'whitespace is irrelevant in footer' '
 	get_patch_id master &&
 	git checkout same &&
-	git format-patch -1 --stdout | sed "s/ \$//" | calc_patch_id same &&
+	git format-patch -1 --stdout | sed "s/ \$//" |
+		calc_patch_id same &&
 	test_cmp patch-id_master patch-id_same
 '
 
+test_expect_success 'file order is irrelevant by default' '
+	get_patch_id master &&
+	git checkout same &&
+	git format-patch -1 --stdout -O foo-then-bar |
+		calc_patch_id same &&
+	test_cmp patch-id_master patch-id_same
+'
+
+test_expect_success 'file order is irrelevant with --stable' '
+	get_patch_id_stable master &&
+	git checkout same &&
+	git format-patch -1 --stdout -O foo-then-bar |
+		calc_patch_id_stable same &&
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
+test_expect_success 'splitting patch does not affect id by default' '
+	get_patch_id merged &&
+	(git log -p -1 -O foo-then-bar split~1; git diff split~1..split) |
+		calc_patch_id split &&
+	test_cmp patch-id_merged patch-id_split
+'
+
+test_expect_success 'splitting patch does not affect id with --stable' '
+	get_patch_id_stable merged &&
+	(git log -p -1 -O foo-then-bar split~1; git diff split~1..split) |
+		calc_patch_id_stable split &&
+	test_cmp patch-id_merged patch-id_split
+'
+
+test_expect_success 'splitting patch affects id with --unstable' '
+	get_patch_id_unstable merged &&
+	(git log -p -1 -O foo-then-bar split~1; git diff split~1..split) |
+		calc_patch_id_unstable split &&
+	! test_cmp patch-id_merged patch-id_split
+'
+
 test_expect_success 'patch-id supports git-format-patch MIME output' '
 	get_patch_id master &&
 	git checkout same &&
-- 
MST
