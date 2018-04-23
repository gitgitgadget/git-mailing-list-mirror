Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD2811F424
	for <e@80x24.org>; Mon, 23 Apr 2018 23:41:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932755AbeDWXkf (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 19:40:35 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:60624 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932739AbeDWXka (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 23 Apr 2018 19:40:30 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 9AF1560B3A;
        Mon, 23 Apr 2018 23:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1524526830;
        bh=dbGAF5hZH/hOj0T68tSeEeyuLTlM/HPAGFuGtU3PvgI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=Kq0gwwO+aNJJNNyqNXl0NsCJWKLJzFHfZW1pm9mrRNs3VYg9pHWtqB+WzgxVW6DBr
         /IVjLeyOfUbUlcP8pJjF04HaSIR/FdXIAHDb00Y1asdhsCUBOPzVR/dIvX9GlAYkBI
         k91HfvNXhuoZu8ztCamlgiLu9cyLOnsYzXQMUdWdgFq+tZhUyKbY6tgvuhVyYmA26F
         nw2ZTGAH8t2s3GFNOaFe9RN6FB/xnnBPzgPmfBR7bwrdjZsypGrqvxA60Y0Hz1Oevi
         euXl8OIA7RDHue2aFxXmHkmxMiU7PVQHrMUfACiSEm7S8jXvPehuuHA23ozB18gXli
         6xsjFyBB6rV6ZXMRpgnmz3X+QyXjpFP2tPS8iTj98p1pkYoVm3DMjPJEdVpeB6kWeZ
         kqpQknMweGP8kOwwHfhGE7r5pn8mNV+FYhXSGTHGYOqqoGGzI6QP6AHFLmjZ+hcWX5
         nC3PRxgVItIXCH9GVHnfw/PzuPfks8oZh955FN/6q+R9VVmufAz
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 23/41] upload-pack: replace use of several hard-coded constants
Date:   Mon, 23 Apr 2018 23:39:33 +0000
Message-Id: <20180423233951.276447-24-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180423233951.276447-1-sandals@crustytoothpaste.net>
References: <20180423233951.276447-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Update several uses of hard-coded 40-based constants to use either
the_hash_algo or GIT_MAX_HEXSZ, as appropriate.  Replace a combined use
of oid_to_hex and memcpy with oid_to_hex_r, which not only avoids the
need for a constant, but is more efficient.  Make use of parse_oid_hex
to eliminate the need for constants and simplify the code at the same
time.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 upload-pack.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 4a82602be5..0858527c5b 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -450,7 +450,7 @@ static int get_common_commits(void)
 				break;
 			default:
 				got_common = 1;
-				memcpy(last_hex, oid_to_hex(&oid), 41);
+				oid_to_hex_r(last_hex, &oid);
 				if (multi_ack == 2)
 					packet_write_fmt(1, "ACK %s common\n", last_hex);
 				else if (multi_ack)
@@ -492,7 +492,7 @@ static int do_reachable_revlist(struct child_process *cmd,
 		"rev-list", "--stdin", NULL,
 	};
 	struct object *o;
-	char namebuf[42]; /* ^ + SHA-1 + LF */
+	char namebuf[GIT_MAX_HEXSZ + 2]; /* ^ + SHA-1 + LF */
 	int i;
 
 	cmd->argv = argv;
@@ -561,15 +561,17 @@ static int get_reachable_list(struct object_array *src,
 	struct child_process cmd = CHILD_PROCESS_INIT;
 	int i;
 	struct object *o;
-	char namebuf[42]; /* ^ + SHA-1 + LF */
+	char namebuf[GIT_MAX_HEXSZ + 2]; /* ^ + SHA-1 + LF */
+	const unsigned hexsz = the_hash_algo->hexsz;
 
 	if (do_reachable_revlist(&cmd, src, reachable) < 0)
 		return -1;
 
-	while ((i = read_in_full(cmd.out, namebuf, 41)) == 41) {
+	while ((i = read_in_full(cmd.out, namebuf, hexsz + 1)) == hexsz + 1) {
 		struct object_id sha1;
+		const char *p;
 
-		if (namebuf[40] != '\n' || get_oid_hex(namebuf, &sha1))
+		if (parse_oid_hex(namebuf, &sha1, &p) || *p != '\n')
 			break;
 
 		o = lookup_object(sha1.hash);
@@ -820,11 +822,9 @@ static void receive_needs(void)
 			continue;
 		}
 		if (!skip_prefix(line, "want ", &arg) ||
-		    get_oid_hex(arg, &oid_buf))
+		    parse_oid_hex(arg, &oid_buf, &features))
 			die("git upload-pack: protocol error, "
-			    "expected to get sha, not '%s'", line);
-
-		features = arg + 40;
+			    "expected to get object ID, not '%s'", line);
 
 		if (parse_feature_request(features, "deepen-relative"))
 			deepen_relative = 1;
