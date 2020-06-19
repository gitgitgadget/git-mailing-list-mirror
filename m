Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C09C433DF
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 17:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91B6E20786
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 17:56:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Lj8UJAX+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404547AbgFSR4f (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 13:56:35 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39446 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2393840AbgFSR41 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 19 Jun 2020 13:56:27 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7d4e:cde:7c41:71c2])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id ADCB960A6D;
        Fri, 19 Jun 2020 17:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1592589382;
        bh=z/hbO9Pa9kw3i3ydW7bPReUQR2B2iix4X60keH+Bypw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=Lj8UJAX++WYB0FVPztFOWzVWb/VOYhNgu5InsfA7cdf4ayulYTp/evDwsV8ZAeOEi
         ownh8WtGba34MJZhNlG3Z62NUTn5STvP+nC4GtDS3vIJr9Xt9arwXGHjvEA/lG+1SH
         18+tdxt3EjrO7rM3k6hmmicQz1DOdVQVaQiolOhjj7KV1TAj1ywfch16SLfBhzmWDt
         C0FcJbWRmjX51bZg8IdoOhCGn4dfxJGq2fu/wOjU/cPnCjMQJiZmO7Yd8w7VCUBoLA
         UK2Sddv0XTQoQ37KQ32AWoKLwn5VYeBjT2gLjb9mJBx4LaAByyCh7XgycOIAQLiq3A
         ZuJ9+B/ofcm8OvhiR8olLiw5YcNkdCl1uK5eUS5RxcLZ6lyOo/UPVYntOFMmIBnIuW
         DUe4ug4v7Ymqs/Y4qNdcjp0cwqVKOo8WVc8yUtavYlfSBbBMh/JoG/rfYELZYo8JJG
         jDf47Y3utgn/BwKDciG7JXke9Ga21poz5n+421gq7M21FQel8PZ
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v3 17/44] transport-helper: implement object-format extensions
Date:   Fri, 19 Jun 2020 17:55:34 +0000
Message-Id: <20200619175601.569856-18-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9
In-Reply-To: <20200619175601.569856-1-sandals@crustytoothpaste.net>
References: <20200513005424.81369-1-sandals@crustytoothpaste.net>
 <20200619175601.569856-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Implement the object-format extensions that let us determine the hash
algorithm in use when pushing or pulling data.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 transport-helper.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index a46afcb69d..ae33b0eea7 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -32,7 +32,8 @@ struct helper_data {
 		signed_tags : 1,
 		check_connectivity : 1,
 		no_disconnect_req : 1,
-		no_private_update : 1;
+		no_private_update : 1,
+		object_format : 1;
 
 	/*
 	 * As an optimization, the transport code may invoke fetch before
@@ -207,6 +208,8 @@ static struct child_process *get_helper(struct transport *transport)
 			data->import_marks = xstrdup(arg);
 		} else if (starts_with(capname, "no-private-update")) {
 			data->no_private_update = 1;
+		} else if (starts_with(capname, "object-format")) {
+			data->object_format = 1;
 		} else if (mandatory) {
 			die(_("unknown mandatory capability %s; this remote "
 			      "helper probably needs newer version of Git"),
@@ -1103,6 +1106,12 @@ static struct ref *get_refs_list_using_list(struct transport *transport,
 	data->get_refs_list_called = 1;
 	helper = get_helper(transport);
 
+	if (data->object_format) {
+		write_str_in_full(helper->in, "option object-format\n");
+		if (recvline(data, &buf) || strcmp(buf.buf, "ok"))
+			exit(128);
+	}
+
 	if (data->push && for_push)
 		write_str_in_full(helper->in, "list for-push\n");
 	else
@@ -1115,6 +1124,17 @@ static struct ref *get_refs_list_using_list(struct transport *transport,
 
 		if (!*buf.buf)
 			break;
+		else if (buf.buf[0] == ':') {
+			const char *value;
+			if (skip_prefix(buf.buf, ":object-format ", &value)) {
+				int algo = hash_algo_by_name(value);
+				if (algo == GIT_HASH_UNKNOWN)
+					die(_("unsupported object format '%s'"),
+					    value);
+				transport->hash_algo = &hash_algos[algo];
+			}
+			continue;
+		}
 
 		eov = strchr(buf.buf, ' ');
 		if (!eov)
@@ -1127,7 +1147,7 @@ static struct ref *get_refs_list_using_list(struct transport *transport,
 		if (buf.buf[0] == '@')
 			(*tail)->symref = xstrdup(buf.buf + 1);
 		else if (buf.buf[0] != '?')
-			get_oid_hex(buf.buf, &(*tail)->old_oid);
+			get_oid_hex_algop(buf.buf, &(*tail)->old_oid, transport->hash_algo);
 		if (eon) {
 			if (has_attribute(eon + 1, "unchanged")) {
 				(*tail)->status |= REF_STATUS_UPTODATE;
