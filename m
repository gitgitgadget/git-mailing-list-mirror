Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15620C2D0FB
	for <git@archiver.kernel.org>; Wed, 13 May 2020 00:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E26FE23126
	for <git@archiver.kernel.org>; Wed, 13 May 2020 00:55:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="NZbfCSFc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732063AbgEMAz2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 May 2020 20:55:28 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38270 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732052AbgEMAzZ (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 12 May 2020 20:55:25 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id B68B160D14;
        Wed, 13 May 2020 00:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1589331293;
        bh=3bTsmEHMqlsl1PYPzdiFXgmzIHg++osLP7PoCkW072Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=NZbfCSFcMY7YemJiHYRIW3fhPmktFWK1iAOAYTh4fJHczkDKCX2i/qQTIOZWsDznk
         nCVyCAn9h6o3Hi3YxMFhSoDSkVwRosUCnyjlOWm4LV04vCgXw9wSxByDShQPhccZem
         SMZbtbAAmWHxPyaJpE7xnrj1ufEVE2Tk1YQ1xbcvqucBIOAYGems05fjSpedjb4QqH
         x/a3MHxOXAH1tptd0TnbYPP9V0e2fUD6kU891tC6IYpTA/YSog0W97rSKxgQev/OB2
         i2fkO7ZnVJ+U2RuEoENwvNxBI6Vg3+pn9K60JEmKul/J767kVyi1kQ+aL3+zi2LdMi
         8UuJ3ZcrB58+clykwuxEuqGABulpgjJRA4kSuS+qBIvfWaWUvVSCuTkw4apZQcZNV1
         YoubuqFjBeOsdU++jjAgpcz/iQmmiTbO4Fn8f5LOIoC9QjfzQkIpnOP/IJ8j2cvdJ7
         wbNqOP0XIIUhRvNFL1jaXLO4d7B9f6VLYS1fLi45ge4vkPDyg8A
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 35/44] remote-curl: detect algorithm for dumb HTTP by size
Date:   Wed, 13 May 2020 00:54:15 +0000
Message-Id: <20200513005424.81369-36-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be
In-Reply-To: <20200513005424.81369-1-sandals@crustytoothpaste.net>
References: <20200513005424.81369-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When reading the info/refs file for a repository, we have no explicit
way to detect which hash algorithm is in use because the file doesn't
provide one. Detect the hash algorithm in use by the size of the first
object ID.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 remote-curl.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index 3ed0dfec1b..35275b42e9 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -252,6 +252,19 @@ static struct ref *parse_git_refs(struct discovery *heads, int for_push)
 	return list;
 }
 
+static const struct git_hash_algo *detect_hash_algo(struct discovery *heads)
+{
+	const char *p = memchr(heads->buf, '\t', heads->len);
+	int algo;
+	if (!p)
+		return NULL;
+
+	algo = hash_algo_by_length((p - heads->buf) / 2);
+	if (algo == GIT_HASH_UNKNOWN)
+		return NULL;
+	return &hash_algos[algo];
+}
+
 static struct ref *parse_info_refs(struct discovery *heads)
 {
 	char *data, *start, *mid;
@@ -262,6 +275,12 @@ static struct ref *parse_info_refs(struct discovery *heads)
 	struct ref *ref = NULL;
 	struct ref *last_ref = NULL;
 
+	options.hash_algo = detect_hash_algo(heads);
+	if (!options.hash_algo)
+		die("%sinfo/refs not valid: could not determine hash algorithm; "
+		    "is this a git repository?",
+		    url.buf);
+
 	data = heads->buf;
 	start = NULL;
 	mid = data;
@@ -272,13 +291,13 @@ static struct ref *parse_info_refs(struct discovery *heads)
 		if (data[i] == '\t')
 			mid = &data[i];
 		if (data[i] == '\n') {
-			if (mid - start != the_hash_algo->hexsz)
+			if (mid - start != options.hash_algo->hexsz)
 				die(_("%sinfo/refs not valid: is this a git repository?"),
 				    transport_anonymize_url(url.buf));
 			data[i] = 0;
 			ref_name = mid + 1;
 			ref = alloc_ref(ref_name);
-			get_oid_hex(start, &ref->old_oid);
+			get_oid_hex_algop(start, &ref->old_oid, options.hash_algo);
 			if (!refs)
 				refs = ref;
 			if (last_ref)
