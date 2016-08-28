Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CEA22018E
	for <e@80x24.org>; Sun, 28 Aug 2016 23:28:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756216AbcH1X2R (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Aug 2016 19:28:17 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:41004 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932506AbcH1X2N (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 28 Aug 2016 19:28:13 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 75537280B6;
        Sun, 28 Aug 2016 23:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1472426886;
        bh=WXVwJQt11fF55oPqZKlZdQnBA7nzjcfLjS5Kyroel2U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y7/5YAj9fRgJWWryT8Zl+urM4p1V+uxhSGwy6C75FomP1lPcunwcu0sUEG6R/cCTM
         yNS4kkjjBAfOkWfzjir4i8xvCmmh1lkhEcBRftJ+F7xX1Pgg6XyS2xDkdBBUDB2QTT
         5KlDsVT0MhtySArxKpTvUoAxX6XhuIc0G4hoV/xiolcKqV4okIDTw3PzLKKw+JKknk
         OuyfL34TPqj5AIjHYapnMPZ9N3NHLH2iFO/rXTndePEJ72xUfrTIF/P4J3aIlrI3Ga
         wbteMADCzYlSsOgr5h9ESgDvq8jbJxdwudmyMqOXP6WIBJHzCXGYXGAsK1YsjBikX+
         BjlNGctZ6lgQne3ZwwCPiOONGR0Fn6uisnaBWtkpDsYcGdkGj79zFGfJ7T5sU89l1K
         S4PlWWfeDCosepsBUh2P7B46hR+UScOUThfPiN6t0HmPvl/M05xjz0jUD39uu3IqCz
         eU/ptv3mZlTj5jHbiUHVgOhMLAq9WS+SxGij9vOYSDeAlKiik7e
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Paul Tan <pyokagan@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>
Subject: [PATCH 17/20] refs: add an update_ref_oid function.
Date:   Sun, 28 Aug 2016 23:27:54 +0000
Message-Id: <20160828232757.373278-18-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20160828232757.373278-1-sandals@crustytoothpaste.net>
References: <20160828232757.373278-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Several places around the codebase want to pass update_ref data from
struct object_id, but update_ref may also be passed NULL pointers.
Instead of checking and dereferencing in every caller, create an
update_ref_oid which wraps update_ref and provides this functionality.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 refs.c | 8 ++++++++
 refs.h | 3 +++
 2 files changed, 11 insertions(+)

diff --git a/refs.c b/refs.c
index b4e7cac7..f567a78e 100644
--- a/refs.c
+++ b/refs.c
@@ -858,6 +858,14 @@ int ref_transaction_verify(struct ref_transaction *transaction,
 				      flags, NULL, err);
 }
 
+int update_ref_oid(const char *msg, const char *refname,
+	       const struct object_id *new_oid, const struct object_id *old_oid,
+	       unsigned int flags, enum action_on_err onerr)
+{
+	return update_ref(msg, refname, new_oid ? new_oid->hash : NULL,
+		old_oid ? old_oid->hash : NULL, flags, onerr);
+}
+
 int update_ref(const char *msg, const char *refname,
 	       const unsigned char *new_sha1, const unsigned char *old_sha1,
 	       unsigned int flags, enum action_on_err onerr)
diff --git a/refs.h b/refs.h
index 1b020437..7a77f3ef 100644
--- a/refs.h
+++ b/refs.h
@@ -477,6 +477,9 @@ void ref_transaction_free(struct ref_transaction *transaction);
 int update_ref(const char *msg, const char *refname,
 	       const unsigned char *new_sha1, const unsigned char *old_sha1,
 	       unsigned int flags, enum action_on_err onerr);
+int update_ref_oid(const char *msg, const char *refname,
+	       const struct object_id *new_oid, const struct object_id *old_oid,
+	       unsigned int flags, enum action_on_err onerr);
 
 int parse_hide_refs_config(const char *var, const char *value, const char *);
 
