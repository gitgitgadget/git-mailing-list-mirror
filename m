Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A4621F403
	for <e@80x24.org>; Thu,  7 Jun 2018 14:12:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932987AbeFGOMi (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Jun 2018 10:12:38 -0400
Received: from siwi.pair.com ([209.68.5.199]:45519 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933028AbeFGOMc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jun 2018 10:12:32 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 5656D3F4823;
        Thu,  7 Jun 2018 10:12:32 -0400 (EDT)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id E297F3F481B;
        Thu,  7 Jun 2018 10:12:31 -0400 (EDT)
From:   git@jeffhostetler.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v8 2/2] json-writer: t0019: add perl unit test
Date:   Thu,  7 Jun 2018 14:12:09 +0000
Message-Id: <20180607141209.24423-3-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20180607141209.24423-1-git@jeffhostetler.com>
References: <20180607141209.24423-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Test json-writer output using perl script.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 t/t0019-json-writer.sh  | 38 ++++++++++++++++++++++++++++++++++++
 t/t0019/parse_json.perl | 52 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 90 insertions(+)
 create mode 100644 t/t0019/parse_json.perl

diff --git a/t/t0019-json-writer.sh b/t/t0019-json-writer.sh
index c9c2e23..fd61fe4 100755
--- a/t/t0019-json-writer.sh
+++ b/t/t0019-json-writer.sh
@@ -233,4 +233,42 @@ test_expect_success 'inline array with no members' '
 	test_cmp expect actual
 '
 
+# As a sanity check, ask Perl to parse our generated JSON and recursively
+# dump the resulting data in sorted order.  Confirm that that matches our
+# expectations.
+test_expect_success 'parse JSON using Perl' '
+	cat >expect <<-\EOF &&
+	row[0].a abc
+	row[0].b 42
+	row[0].sub1 hash
+	row[0].sub1.c 3.14
+	row[0].sub1.d 1
+	row[0].sub1.sub2 array
+	row[0].sub1.sub2[0] 0
+	row[0].sub1.sub2[1] hash
+	row[0].sub1.sub2[1].g 0
+	row[0].sub1.sub2[1].h 1
+	row[0].sub1.sub2[2] null
+	EOF
+	test-json-writer >output.json \
+		@object \
+			@object-string a abc \
+			@object-int b 42 \
+			@object-object "sub1" \
+				@object-double c 2 3.140 \
+				@object-true d \
+				@object-array "sub2" \
+					@array-false \
+					@array-object \
+						@object-int g 0 \
+						@object-int h 1 \
+					@end \
+					@array-null \
+				@end \
+			@end \
+		@end &&
+	perl "$TEST_DIRECTORY"/t0019/parse_json.perl <output.json >actual &&
+	test_cmp expect actual
+'
+
 test_done
diff --git a/t/t0019/parse_json.perl b/t/t0019/parse_json.perl
new file mode 100644
index 0000000..ca4e5bf
--- /dev/null
+++ b/t/t0019/parse_json.perl
@@ -0,0 +1,52 @@
+#!/usr/bin/perl
+use strict;
+use warnings;
+use JSON;
+
+sub dump_array {
+    my ($label_in, $ary_ref) = @_;
+    my @ary = @$ary_ref;
+
+    for ( my $i = 0; $i <= $#{ $ary_ref }; $i++ )
+    {
+	my $label = "$label_in\[$i\]";
+	dump_item($label, $ary[$i]);
+    }
+}
+
+sub dump_hash {
+    my ($label_in, $obj_ref) = @_;
+    my %obj = %$obj_ref;
+
+    foreach my $k (sort keys %obj) {
+	my $label = (length($label_in) > 0) ? "$label_in.$k" : "$k";
+	my $value = $obj{$k};
+
+	dump_item($label, $value);
+    }
+}
+
+sub dump_item {
+    my ($label_in, $value) = @_;
+    if (ref($value) eq 'ARRAY') {
+	print "$label_in array\n";
+	dump_array($label_in, $value);
+    } elsif (ref($value) eq 'HASH') {
+	print "$label_in hash\n";
+	dump_hash($label_in, $value);
+    } elsif (defined $value) {
+	print "$label_in $value\n";
+    } else {
+	print "$label_in null\n";
+    }
+}
+
+my $row = 0;
+while (<>) {
+    my $data = decode_json( $_ );
+    my $label = "row[$row]";
+
+    dump_hash($label, $data);
+    $row++;
+}
+
-- 
2.9.3

