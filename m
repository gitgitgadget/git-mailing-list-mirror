Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0643C433DF
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 17:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD8B020DD4
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 17:57:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="nON9jFYG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404868AbgFSR50 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 13:57:26 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39572 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404667AbgFSR4p (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 19 Jun 2020 13:56:45 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:7d4e:cde:7c41:71c2])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 2908360A7F;
        Fri, 19 Jun 2020 17:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1592589395;
        bh=n4cOXLIJFJySsqXcnB6iIuq2selM+4nlbmqMC5jy41g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=nON9jFYGQFy2ptGg6hEj1zKlQhDDpIOq45e1o/LB5tfRWlPydPCLHDwi4wx8BYZB2
         fNLjGfH6li6S5VulqM6QXfc7lbSHNPc+vWdWb5vaQaPY1sYe+3sD/cYpJUO4g6jyUA
         1wpph0PVfuD4OmUa4oTQAqlfdVBV3B16BYSF8sqV6J5nXrspiTK2Qm46wCe6zfiGU+
         Nwr3J+h0E7vCY+cWu2zIx9heNuEYdHughfAwOxRwuwTgGQwXmfz7SYUAVeEoCIrhia
         fN7/E4YMbsIq9ECgpo8fAdvPF4FaIul36VBr3y/8P2HI+LRNwnd0a2R+40+SyRUx6g
         11a/W7iPkexCmm59/33DldZTRpG4IycP6/bGRvDHWpUp69KXHSpZSpt/HP4BcbNKtZ
         EfUYdruvfrCICxmH4c4iKX2ktDe8VLyuCFkMxFo+v5cMzn1u3sSPNmASwmiGN/ihsI
         IDFtP19m5kEBm/Oqrs8rbu4Imz6SYlqX1c+aC6EPNS/EgZ0iePG
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v3 43/44] bundle: detect hash algorithm when reading refs
Date:   Fri, 19 Jun 2020 17:56:00 +0000
Message-Id: <20200619175601.569856-44-sandals@crustytoothpaste.net>
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

Much like with the dumb HTTP transport, there isn't a way to explicitly
specify the hash algorithm when dealing with a bundle, so detect the
algorithm based on the length of the object IDs in the prerequisites and
ref advertisements.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 bundle.c    | 22 +++++++++++++++++++++-
 bundle.h    |  1 +
 transport.c | 10 ++++++++--
 3 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/bundle.c b/bundle.c
index 99439e07a1..2a0d744d3f 100644
--- a/bundle.c
+++ b/bundle.c
@@ -23,6 +23,17 @@ static void add_to_ref_list(const struct object_id *oid, const char *name,
 	list->nr++;
 }
 
+static const struct git_hash_algo *detect_hash_algo(struct strbuf *buf)
+{
+	size_t len = strcspn(buf->buf, " \n");
+	int algo;
+
+	algo = hash_algo_by_length(len / 2);
+	if (algo == GIT_HASH_UNKNOWN)
+		return NULL;
+	return &hash_algos[algo];
+}
+
 static int parse_bundle_header(int fd, struct bundle_header *header,
 			       const char *report_path)
 {
@@ -52,12 +63,21 @@ static int parse_bundle_header(int fd, struct bundle_header *header,
 		}
 		strbuf_rtrim(&buf);
 
+		if (!header->hash_algo) {
+			header->hash_algo = detect_hash_algo(&buf);
+			if (!header->hash_algo) {
+				error(_("unknown hash algorithm length"));
+				status = -1;
+				break;
+			}
+		}
+
 		/*
 		 * Tip lines have object name, SP, and refname.
 		 * Prerequisites have object name that is optionally
 		 * followed by SP and subject line.
 		 */
-		if (parse_oid_hex(buf.buf, &oid, &p) ||
+		if (parse_oid_hex_algop(buf.buf, &oid, &p, header->hash_algo) ||
 		    (*p && !isspace(*p)) ||
 		    (!is_prereq && !*p)) {
 			if (report_path)
diff --git a/bundle.h b/bundle.h
index ceab0c7475..2dc9442024 100644
--- a/bundle.h
+++ b/bundle.h
@@ -15,6 +15,7 @@ struct ref_list {
 struct bundle_header {
 	struct ref_list prerequisites;
 	struct ref_list references;
+	const struct git_hash_algo *hash_algo;
 };
 
 int is_bundle(const char *path, int quiet);
diff --git a/transport.c b/transport.c
index a016f41702..b255f123c0 100644
--- a/transport.c
+++ b/transport.c
@@ -143,6 +143,9 @@ static struct ref *get_refs_from_bundle(struct transport *transport,
 	data->fd = read_bundle_header(transport->url, &data->header);
 	if (data->fd < 0)
 		die(_("could not read bundle '%s'"), transport->url);
+
+	transport->hash_algo = data->header.hash_algo;
+
 	for (i = 0; i < data->header.references.nr; i++) {
 		struct ref_list_entry *e = data->header.references.list + i;
 		struct ref *ref = alloc_ref(e->name);
@@ -157,11 +160,14 @@ static int fetch_refs_from_bundle(struct transport *transport,
 			       int nr_heads, struct ref **to_fetch)
 {
 	struct bundle_transport_data *data = transport->data;
+	int ret;
 
 	if (!data->get_refs_from_bundle_called)
 		get_refs_from_bundle(transport, 0, NULL);
-	return unbundle(the_repository, &data->header, data->fd,
-			transport->progress ? BUNDLE_VERBOSE : 0);
+	ret = unbundle(the_repository, &data->header, data->fd,
+			   transport->progress ? BUNDLE_VERBOSE : 0);
+	transport->hash_algo = data->header.hash_algo;
+	return ret;
 }
 
 static int close_bundle(struct transport *transport)
