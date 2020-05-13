Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02117C2D0F8
	for <git@archiver.kernel.org>; Wed, 13 May 2020 00:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D305220675
	for <git@archiver.kernel.org>; Wed, 13 May 2020 00:56:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="CrKiqQSl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732167AbgEMA4I (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 May 2020 20:56:08 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38112 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731683AbgEMAyq (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 12 May 2020 20:54:46 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id DA5E860D05;
        Wed, 13 May 2020 00:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1589331285;
        bh=z/hbO9Pa9kw3i3ydW7bPReUQR2B2iix4X60keH+Bypw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=CrKiqQSlWSav9pkfdO2+y/n1EL+HgTAV8XsvVc5nfN6L/xQesNUqRKycSIT+oVLE8
         JAAGGCBzzvHJdme/D2SHuomSx7wkoJDdpPuFcDynEqyf25JBWZ661Qk4fcxHctrKaH
         cIakhm/8aKSdjLNPa2PzXN5CEYgI9WWv63VW7n/QV8zBxdzoZ9JSI/Ub6DNSfuR/bV
         kWzksl60wcIPooBlg+kYSd0RBqNF8y1ROiVYUY1pnNRE5M+0a7JnqvepWc14rjHAPn
         tcm8cC86yH27hh3WjQ+56fcn4rZxHy5K5q/ZgoxIJfsxN3C7eRatsyDWGl4Lp56gbB
         1bHFm131ZhJZfrAVzIqnQjoZXYYOgXrr1CpIZZepPqMd+INNU5D+Db9hhGRIeu4ASt
         PlYdTlOKSO3UlWwOS7o5b2FGhouJ9gnXYbS5uGUJ7kYY37xr3f61Whi96gT4ZBeElA
         rDrwaXp1mpcZwD0BcNOfPolDxTgQoaaNbZAi8dsAa3i8I+tVDDp
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 17/44] transport-helper: implement object-format extensions
Date:   Wed, 13 May 2020 00:53:57 +0000
Message-Id: <20200513005424.81369-18-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be
In-Reply-To: <20200513005424.81369-1-sandals@crustytoothpaste.net>
References: <20200513005424.81369-1-sandals@crustytoothpaste.net>
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
