Return-Path: <SRS0=QBG1=2L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48429C2D0C3
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 19:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08635206B7
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 19:50:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="hR3qRXxc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbfLUTua (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Dec 2019 14:50:30 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:41960 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727126AbfLUTuI (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 21 Dec 2019 14:50:08 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 40FA9607F3;
        Sat, 21 Dec 2019 19:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1576957807;
        bh=/Fgd7Q2DZV3TOaDNq6V5s2Eimq5+5QAE9XdfQSUzq+Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=hR3qRXxcIvzX5k9fyw91Gs8Ut9b2+GUHEBPqfpWKFm5BVpjxDHB71PQuu3mB1bq+K
         CTBxZCzxrvY+l+4ZVMUNW5G2CdOmArTOQ+v6wcPTN+moJxx3dnfSyQyYiz5mnIXsNf
         oglQbQQFZZpM/TaJCd0gE4ctRWm/Be0kR8x0icEXSGxmt0Zq0Ky4R5SxMlU2uwgwgt
         WJhihrPTTPr8Wi35jOvTErHK7vtAYJwrBuilVHaV8IBPoLCfXWCffjZWqP6YDrekd0
         NhkJdf1slad3Ugo9cAcPg76FDT7TcXdOv58sKgCn1lMZbhp/tGZYBmi2kYz4GcpFZk
         uRI8U4g4VC8HkVVSDcpwH+xiHefxsHpwBFgSdN94K13CUPzXcWUnGekz0YRdpAFi4Y
         HpTqQ5vMy+/cG/QBlxt5WqMWJr8EM3FcErFnIqdYFgFPpNwFwSW9XaH9pBYOQ2Acg0
         RiZEmrkqjud7sXrfvXl7v1fWRVSET16wbJZTOTUPQkNaRE489ff
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 05/20] t4202: abstract away SHA-1-specific constants
Date:   Sat, 21 Dec 2019 19:49:21 +0000
Message-Id: <20191221194936.1346664-6-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.24.1.658.g99f4b37f93
In-Reply-To: <20191221194936.1346664-1-sandals@crustytoothpaste.net>
References: <20191221194936.1346664-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adjust the test so that it computes values for object IDs instead of
using hard-coded hashes.  Additionally, update the sanitize_output
function to sanitize the index lines in diff output, since it's clear
from the assertions in question that we are not interested in the
specific object IDs.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/t4202-log.sh | 127 +++++++++++++++++++++++++------------------------
 1 file changed, 65 insertions(+), 62 deletions(-)

diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 2c9489484a..192347a3e1 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -87,12 +87,12 @@ test_expect_success 'format %w(,1,2)' '
 '
 
 cat > expect << EOF
-804a787 sixth
-394ef78 fifth
-5d31159 fourth
-2fbe8c0 third
-f7dab8e second
-3a2fdcb initial
+$(git rev-parse --short :/sixth  ) sixth
+$(git rev-parse --short :/fifth  ) fifth
+$(git rev-parse --short :/fourth ) fourth
+$(git rev-parse --short :/third  ) third
+$(git rev-parse --short :/second ) second
+$(git rev-parse --short :/initial) initial
 EOF
 test_expect_success 'oneline' '
 
@@ -173,43 +173,45 @@ test_expect_success 'git config log.follow is overridden by --no-follow' '
 	verbose test "$actual" = "$expect"
 '
 
+# Note that these commits are intentionally listed out of order.
+last_three="$(git rev-parse :/fourth :/sixth :/fifth)"
 cat > expect << EOF
-804a787 sixth
-394ef78 fifth
-5d31159 fourth
+$(git rev-parse --short :/sixth ) sixth
+$(git rev-parse --short :/fifth ) fifth
+$(git rev-parse --short :/fourth) fourth
 EOF
 test_expect_success 'git log --no-walk <commits> sorts by commit time' '
-	git log --no-walk --oneline 5d31159 804a787 394ef78 > actual &&
+	git log --no-walk --oneline $last_three > actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'git log --no-walk=sorted <commits> sorts by commit time' '
-	git log --no-walk=sorted --oneline 5d31159 804a787 394ef78 > actual &&
+	git log --no-walk=sorted --oneline $last_three > actual &&
 	test_cmp expect actual
 '
 
 cat > expect << EOF
-=== 804a787 sixth
-=== 394ef78 fifth
-=== 5d31159 fourth
+=== $(git rev-parse --short :/sixth ) sixth
+=== $(git rev-parse --short :/fifth ) fifth
+=== $(git rev-parse --short :/fourth) fourth
 EOF
 test_expect_success 'git log --line-prefix="=== " --no-walk <commits> sorts by commit time' '
-	git log --line-prefix="=== " --no-walk --oneline 5d31159 804a787 394ef78 > actual &&
+	git log --line-prefix="=== " --no-walk --oneline $last_three > actual &&
 	test_cmp expect actual
 '
 
 cat > expect << EOF
-5d31159 fourth
-804a787 sixth
-394ef78 fifth
+$(git rev-parse --short :/fourth) fourth
+$(git rev-parse --short :/sixth ) sixth
+$(git rev-parse --short :/fifth ) fifth
 EOF
 test_expect_success 'git log --no-walk=unsorted <commits> leaves list of commits as given' '
-	git log --no-walk=unsorted --oneline 5d31159 804a787 394ef78 > actual &&
+	git log --no-walk=unsorted --oneline $last_three > actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'git show <commits> leaves list of commits as given' '
-	git show --oneline -s 5d31159 804a787 394ef78 > actual &&
+	git show --oneline -s $last_three > actual &&
 	test_cmp expect actual
 '
 
@@ -957,7 +959,7 @@ cat >expect <<\EOF
 | |
 | | diff --git a/reach.t b/reach.t
 | | new file mode 100644
-| | index 0000000..10c9591
+| | index BEFORE..AFTER
 | | --- /dev/null
 | | +++ b/reach.t
 | | @@ -0,0 +1 @@
@@ -980,7 +982,7 @@ cat >expect <<\EOF
 | | |
 | | |   diff --git a/octopus-b.t b/octopus-b.t
 | | |   new file mode 100644
-| | |   index 0000000..d5fcad0
+| | |   index BEFORE..AFTER
 | | |   --- /dev/null
 | | |   +++ b/octopus-b.t
 | | |   @@ -0,0 +1 @@
@@ -996,7 +998,7 @@ cat >expect <<\EOF
 | |
 | |   diff --git a/octopus-a.t b/octopus-a.t
 | |   new file mode 100644
-| |   index 0000000..11ee015
+| |   index BEFORE..AFTER
 | |   --- /dev/null
 | |   +++ b/octopus-a.t
 | |   @@ -0,0 +1 @@
@@ -1012,7 +1014,7 @@ cat >expect <<\EOF
 |
 |   diff --git a/seventh.t b/seventh.t
 |   new file mode 100644
-|   index 0000000..9744ffc
+|   index BEFORE..AFTER
 |   --- /dev/null
 |   +++ b/seventh.t
 |   @@ -0,0 +1 @@
@@ -1046,7 +1048,7 @@ cat >expect <<\EOF
 | | | |
 | | | | diff --git a/tangle-a b/tangle-a
 | | | | new file mode 100644
-| | | | index 0000000..7898192
+| | | | index BEFORE..AFTER
 | | | | --- /dev/null
 | | | | +++ b/tangle-a
 | | | | @@ -0,0 +1 @@
@@ -1068,7 +1070,7 @@ cat >expect <<\EOF
 | | | |
 | | | |   diff --git a/2 b/2
 | | | |   new file mode 100644
-| | | |   index 0000000..0cfbf08
+| | | |   index BEFORE..AFTER
 | | | |   --- /dev/null
 | | | |   +++ b/2
 | | | |   @@ -0,0 +1 @@
@@ -1084,7 +1086,7 @@ cat >expect <<\EOF
 | | | |
 | | | | diff --git a/1 b/1
 | | | | new file mode 100644
-| | | | index 0000000..d00491f
+| | | | index BEFORE..AFTER
 | | | | --- /dev/null
 | | | | +++ b/1
 | | | | @@ -0,0 +1 @@
@@ -1100,7 +1102,7 @@ cat >expect <<\EOF
 | | | |
 | | | | diff --git a/one b/one
 | | | | new file mode 100644
-| | | | index 0000000..9a33383
+| | | | index BEFORE..AFTER
 | | | | --- /dev/null
 | | | | +++ b/one
 | | | | @@ -0,0 +1 @@
@@ -1116,7 +1118,7 @@ cat >expect <<\EOF
 | | |
 | | |   diff --git a/a/two b/a/two
 | | |   deleted file mode 100644
-| | |   index 9245af5..0000000
+| | |   index BEFORE..AFTER
 | | |   --- a/a/two
 | | |   +++ /dev/null
 | | |   @@ -1 +0,0 @@
@@ -1132,7 +1134,7 @@ cat >expect <<\EOF
 | | |
 | | | diff --git a/a/two b/a/two
 | | | new file mode 100644
-| | | index 0000000..9245af5
+| | | index BEFORE..AFTER
 | | | --- /dev/null
 | | | +++ b/a/two
 | | | @@ -0,0 +1 @@
@@ -1148,7 +1150,7 @@ cat >expect <<\EOF
 | |
 | |   diff --git a/ein b/ein
 | |   new file mode 100644
-| |   index 0000000..9d7e69f
+| |   index BEFORE..AFTER
 | |   --- /dev/null
 | |   +++ b/ein
 | |   @@ -0,0 +1 @@
@@ -1165,14 +1167,14 @@ cat >expect <<\EOF
 |
 |   diff --git a/ichi b/ichi
 |   new file mode 100644
-|   index 0000000..9d7e69f
+|   index BEFORE..AFTER
 |   --- /dev/null
 |   +++ b/ichi
 |   @@ -0,0 +1 @@
 |   +ichi
 |   diff --git a/one b/one
 |   deleted file mode 100644
-|   index 9d7e69f..0000000
+|   index BEFORE..AFTER
 |   --- a/one
 |   +++ /dev/null
 |   @@ -1 +0,0 @@
@@ -1187,7 +1189,7 @@ cat >expect <<\EOF
 |  1 file changed, 1 insertion(+), 1 deletion(-)
 |
 | diff --git a/one b/one
-| index 5626abf..9d7e69f 100644
+| index BEFORE..AFTER 100644
 | --- a/one
 | +++ b/one
 | @@ -1 +1 @@
@@ -1204,7 +1206,7 @@ cat >expect <<\EOF
 
   diff --git a/one b/one
   new file mode 100644
-  index 0000000..5626abf
+  index BEFORE..AFTER
   --- /dev/null
   +++ b/one
   @@ -0,0 +1 @@
@@ -1221,7 +1223,8 @@ sanitize_output () {
 	    -e 's/, 0 insertions(+)//' \
 	    -e 's/ 1 files changed, / 1 file changed, /' \
 	    -e 's/, 1 deletions(-)/, 1 deletion(-)/' \
-	    -e 's/, 1 insertions(+)/, 1 insertion(+)/'
+	    -e 's/, 1 insertions(+)/, 1 insertion(+)/' \
+	    -e 's/index [0-9a-f]*\.\.[0-9a-f]*/index BEFORE..AFTER/'
 }
 
 test_expect_success 'log --graph with diff and stats' '
@@ -1247,7 +1250,7 @@ cat >expect <<\EOF
 *** | |
 *** | | diff --git a/reach.t b/reach.t
 *** | | new file mode 100644
-*** | | index 0000000..10c9591
+*** | | index BEFORE..AFTER
 *** | | --- /dev/null
 *** | | +++ b/reach.t
 *** | | @@ -0,0 +1 @@
@@ -1270,7 +1273,7 @@ cat >expect <<\EOF
 *** | | |
 *** | | |   diff --git a/octopus-b.t b/octopus-b.t
 *** | | |   new file mode 100644
-*** | | |   index 0000000..d5fcad0
+*** | | |   index BEFORE..AFTER
 *** | | |   --- /dev/null
 *** | | |   +++ b/octopus-b.t
 *** | | |   @@ -0,0 +1 @@
@@ -1286,7 +1289,7 @@ cat >expect <<\EOF
 *** | |
 *** | |   diff --git a/octopus-a.t b/octopus-a.t
 *** | |   new file mode 100644
-*** | |   index 0000000..11ee015
+*** | |   index BEFORE..AFTER
 *** | |   --- /dev/null
 *** | |   +++ b/octopus-a.t
 *** | |   @@ -0,0 +1 @@
@@ -1302,7 +1305,7 @@ cat >expect <<\EOF
 *** |
 *** |   diff --git a/seventh.t b/seventh.t
 *** |   new file mode 100644
-*** |   index 0000000..9744ffc
+*** |   index BEFORE..AFTER
 *** |   --- /dev/null
 *** |   +++ b/seventh.t
 *** |   @@ -0,0 +1 @@
@@ -1336,7 +1339,7 @@ cat >expect <<\EOF
 *** | | | |
 *** | | | | diff --git a/tangle-a b/tangle-a
 *** | | | | new file mode 100644
-*** | | | | index 0000000..7898192
+*** | | | | index BEFORE..AFTER
 *** | | | | --- /dev/null
 *** | | | | +++ b/tangle-a
 *** | | | | @@ -0,0 +1 @@
@@ -1358,7 +1361,7 @@ cat >expect <<\EOF
 *** | | | |
 *** | | | |   diff --git a/2 b/2
 *** | | | |   new file mode 100644
-*** | | | |   index 0000000..0cfbf08
+*** | | | |   index BEFORE..AFTER
 *** | | | |   --- /dev/null
 *** | | | |   +++ b/2
 *** | | | |   @@ -0,0 +1 @@
@@ -1374,7 +1377,7 @@ cat >expect <<\EOF
 *** | | | |
 *** | | | | diff --git a/1 b/1
 *** | | | | new file mode 100644
-*** | | | | index 0000000..d00491f
+*** | | | | index BEFORE..AFTER
 *** | | | | --- /dev/null
 *** | | | | +++ b/1
 *** | | | | @@ -0,0 +1 @@
@@ -1390,7 +1393,7 @@ cat >expect <<\EOF
 *** | | | |
 *** | | | | diff --git a/one b/one
 *** | | | | new file mode 100644
-*** | | | | index 0000000..9a33383
+*** | | | | index BEFORE..AFTER
 *** | | | | --- /dev/null
 *** | | | | +++ b/one
 *** | | | | @@ -0,0 +1 @@
@@ -1406,7 +1409,7 @@ cat >expect <<\EOF
 *** | | |
 *** | | |   diff --git a/a/two b/a/two
 *** | | |   deleted file mode 100644
-*** | | |   index 9245af5..0000000
+*** | | |   index BEFORE..AFTER
 *** | | |   --- a/a/two
 *** | | |   +++ /dev/null
 *** | | |   @@ -1 +0,0 @@
@@ -1422,7 +1425,7 @@ cat >expect <<\EOF
 *** | | |
 *** | | | diff --git a/a/two b/a/two
 *** | | | new file mode 100644
-*** | | | index 0000000..9245af5
+*** | | | index BEFORE..AFTER
 *** | | | --- /dev/null
 *** | | | +++ b/a/two
 *** | | | @@ -0,0 +1 @@
@@ -1438,7 +1441,7 @@ cat >expect <<\EOF
 *** | |
 *** | |   diff --git a/ein b/ein
 *** | |   new file mode 100644
-*** | |   index 0000000..9d7e69f
+*** | |   index BEFORE..AFTER
 *** | |   --- /dev/null
 *** | |   +++ b/ein
 *** | |   @@ -0,0 +1 @@
@@ -1455,14 +1458,14 @@ cat >expect <<\EOF
 *** |
 *** |   diff --git a/ichi b/ichi
 *** |   new file mode 100644
-*** |   index 0000000..9d7e69f
+*** |   index BEFORE..AFTER
 *** |   --- /dev/null
 *** |   +++ b/ichi
 *** |   @@ -0,0 +1 @@
 *** |   +ichi
 *** |   diff --git a/one b/one
 *** |   deleted file mode 100644
-*** |   index 9d7e69f..0000000
+*** |   index BEFORE..AFTER
 *** |   --- a/one
 *** |   +++ /dev/null
 *** |   @@ -1 +0,0 @@
@@ -1477,7 +1480,7 @@ cat >expect <<\EOF
 *** |  1 file changed, 1 insertion(+), 1 deletion(-)
 *** |
 *** | diff --git a/one b/one
-*** | index 5626abf..9d7e69f 100644
+*** | index BEFORE..AFTER 100644
 *** | --- a/one
 *** | +++ b/one
 *** | @@ -1 +1 @@
@@ -1494,7 +1497,7 @@ cat >expect <<\EOF
 ***
 ***   diff --git a/one b/one
 ***   new file mode 100644
-***   index 0000000..5626abf
+***   index BEFORE..AFTER
 ***   --- /dev/null
 ***   +++ b/one
 ***   @@ -0,0 +1 @@
@@ -1709,10 +1712,10 @@ test_expect_success 'set up --source tests' '
 '
 
 test_expect_success 'log --source paints branch names' '
-	cat >expect <<-\EOF &&
-	09e12a9	source-b three
-	8e393e1	source-a two
-	1ac6c77	source-b one
+	cat >expect <<-EOF &&
+	$(git rev-parse --short :/three)	source-b three
+	$(git rev-parse --short :/two  )	source-a two
+	$(git rev-parse --short :/one  )	source-b one
 	EOF
 	git log --oneline --source source-a source-b >actual &&
 	test_cmp expect actual
@@ -1720,19 +1723,19 @@ test_expect_success 'log --source paints branch names' '
 
 test_expect_success 'log --source paints tag names' '
 	git tag -m tagged source-tag &&
-	cat >expect <<-\EOF &&
-	09e12a9	source-tag three
-	8e393e1	source-a two
-	1ac6c77	source-tag one
+	cat >expect <<-EOF &&
+	$(git rev-parse --short :/three)	source-tag three
+	$(git rev-parse --short :/two  )	source-a two
+	$(git rev-parse --short :/one  )	source-tag one
 	EOF
 	git log --oneline --source source-tag source-a >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'log --source paints symmetric ranges' '
-	cat >expect <<-\EOF &&
-	09e12a9	source-b three
-	8e393e1	source-a two
+	cat >expect <<-EOF &&
+	$(git rev-parse --short :/three)	source-b three
+	$(git rev-parse --short :/two  )	source-a two
 	EOF
 	git log --oneline --source source-a...source-b >actual &&
 	test_cmp expect actual
