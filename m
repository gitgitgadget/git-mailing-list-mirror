From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v5 6/9] patch-id-test: test stable and unstable behaviour
Date: Thu, 24 Apr 2014 12:31:07 +0300
Message-ID: <1398331809-11309-6-git-send-email-mst@redhat.com>
References: <1398331809-11309-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: sunshine@sunshineco.com, jrnieder@gmail.com, peff@peff.net,
	gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 24 11:52:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdGKh-0006Br-Az
	for gcvg-git-2@plane.gmane.org; Thu, 24 Apr 2014 11:52:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754584AbaDXJwi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Apr 2014 05:52:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48562 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754754AbaDXJwc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Apr 2014 05:52:32 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s3O9q8Lb032467;
	Thu, 24 Apr 2014 05:52:08 -0400
Received: from redhat.com (ovpn-116-36.ams2.redhat.com [10.36.116.36])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id s3O9ULQe013158;
	Thu, 24 Apr 2014 05:30:21 -0400
Content-Disposition: inline
In-Reply-To: <1398331809-11309-1-git-send-email-mst@redhat.com>
X-Mutt-Fcc: =sent
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.26
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246956>

Verify that patch ID supports an algorithm
that is stable against diff split and reordering.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 t/t4204-patch-id.sh | 128 +++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 117 insertions(+), 11 deletions(-)

diff --git a/t/t4204-patch-id.sh b/t/t4204-patch-id.sh
index d2c930d..cd13e8e 100755
--- a/t/t4204-patch-id.sh
+++ b/t/t4204-patch-id.sh
@@ -5,27 +5,51 @@ test_description='git patch-id'
 . ./test-lib.sh
 
 test_expect_success 'setup' '
-	test_commit initial foo a &&
-	test_commit first foo b &&
-	git checkout -b same HEAD^ &&
-	test_commit same-msg foo b &&
-	git checkout -b notsame HEAD^ &&
-	test_commit notsame-msg foo c
+	as="a a a a a a a a" && # eight a
+	test_write_lines $as >foo &&
+	test_write_lines $as >bar &&
+	git add foo bar &&
+	git commit -a -m initial &&
+	test_write_lines $as b >foo &&
+	test_write_lines $as b >bar &&
+	git commit -a -m first &&
+	git checkout -b same master &&
+	git commit --amend -m same-msg &&
+	git checkout -b notsame master &&
+	echo c >foo &&
+	echo c >bar &&
+	git commit --amend -a -m notsame-msg &&
+	git checkout -b split master &&
+	test_write_lines d $as b >foo &&
+	test_write_lines d $as b >bar &&
+	git commit -a -m split &&
+	git checkout -b merged master &&
+	git checkout split -- foo bar &&
+	git commit --amend -a -m merged &&
+	test_write_lines bar foo >bar-then-foo &&
+	test_write_lines foo bar >foo-then-bar
 '
 
 test_expect_success 'patch-id output is well-formed' '
-	git log -p -1 | git patch-id > output &&
+	git log -p -1 | git patch-id >output &&
 	grep "^[a-f0-9]\{40\} $(git rev-parse HEAD)$" output
 '
 
+#calculate patch id. Make sure output is not empty.
 calc_patch_id () {
-	git patch-id |
-		sed "s# .*##" > patch-id_"$1"
+	name="$1"
+	shift
+	git patch-id "$@" |
+	sed "s/ .*//" >patch-id_"$name" &&
+	test_line_count -gt 0 patch-id_"$name"
+}
+
+get_top_diff () {
+	git log -p -1 "$@" -O bar-then-foo --
 }
 
 get_patch_id () {
-	git log -p -1 "$1" | git patch-id |
-		sed "s# .*##" > patch-id_"$1"
+	get_top_diff "$1" | calc_patch_id "$@"
 }
 
 test_expect_success 'patch-id detects equality' '
@@ -56,6 +80,88 @@ test_expect_success 'whitespace is irrelevant in footer' '
 	test_cmp patch-id_master patch-id_same
 '
 
+cmp_patch_id () {
+	if
+		test "$1" = "relevant"
+	then
+		! test_cmp patch-id_"$2" patch-id_"$3"
+	else
+		test_cmp patch-id_"$2" patch-id_"$3"
+	fi
+}
+
+test_patch_id_file_order () {
+	relevant="$1"
+	shift
+	name="order-${1}-$relevant"
+	shift
+	get_top_diff "master" | calc_patch_id "$name" "$@" &&
+	git checkout same &&
+	git format-patch -1 --stdout -O foo-then-bar |
+		calc_patch_id "ordered-$name" "$@" &&
+	cmp_patch_id $relevant "$name" "ordered-$name"
+		
+}
+
+test_patch_id_split () {
+	relevant="$1"
+	shift
+	name="split-${1}-$relevant"
+	shift
+	get_top_diff merged | calc_patch_id "$name" "$@" &&
+	(git log -p -1 -O foo-then-bar split~1; git diff split~1..split) |
+		calc_patch_id "split-$name" "$@" &&
+	cmp_patch_id "$relevant" "$name" "split-$name"
+}
+
+# combined test for options
+test_patch_id () {
+	test_patch_id_file_order "$@" &&
+	test_patch_id_split "$@"
+}
+
+# small tests with detailed diagnostic for basic options.
+test_expect_success 'file order is irrelevant with --stable' '
+	test_patch_id_file_order irrelevant --stable --stable
+'
+
+test_expect_success 'file order is relevant with --unstable' '
+	test_patch_id_file_order relevant --unstable --unstable
+'
+
+test_expect_success 'splitting patch is irrelevant with --stable' '
+	test_patch_id_split irrelevant --stable --stable
+'
+
+test_expect_success 'splitting patch affects id with --unstable' '
+	test_patch_id_split relevant --unstable --unstable
+'
+
+#Now test various option combinations.
+test_expect_success 'default is unstable' '
+	test_patch_id relevant default
+'
+
+test_expect_success 'patchid.stable = true is stable' '
+	test_config patchid.stable true &&
+	test_patch_id irrelevant patchid.stable=true
+'
+
+test_expect_success 'patchid.stable = false is unstable' '
+	test_config patchid.stable false &&
+	test_patch_id relevant patchid.stable=false
+'
+
+test_expect_success '--unstable overrides patchid.stable = true' '
+	test_config patchid.stable true &&
+	test_patch_id relevant patchid.stable=true--unstable --unstable
+'
+
+test_expect_success '--stable overrides patchid.stable = false' '
+	test_config patchid.stable false &&
+	test_patch_id irrelevant patchid.stable=false--stable --stable
+'
+
 test_expect_success 'patch-id supports git-format-patch MIME output' '
 	get_patch_id master &&
 	git checkout same &&
-- 
MST
