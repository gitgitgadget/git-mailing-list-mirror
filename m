Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24C9A2070F
	for <e@80x24.org>; Mon,  5 Sep 2016 20:09:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964923AbcIEUJt (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Sep 2016 16:09:49 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:43068 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S964903AbcIEUIa (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 5 Sep 2016 16:08:30 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 06B35280B6;
        Mon,  5 Sep 2016 20:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1473106110;
        bh=WXVwJQt11fF55oPqZKlZdQnBA7nzjcfLjS5Kyroel2U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UPF6DCkNp57h027NFRON92m59gG1MhCr5NB7xrIQlQwPYapaTc5GvDUVEK2nd3Pkb
         zcI2CgIoFZ2YU/aWyp8HNRX1rlliGZ/rbAAo1VyJou5oYebYMyTcM4w0Dk/5Q3Vb8o
         VcecQYcJ2MJmIjmIotk+j1DikKbolUz5imzw2P5tVWHD+mLZYqBKHl+XMvlCifdWOp
         CFzeGgUzQdi4CxVORzFMhsyR+cTLoXdsvuuL8vTufQT2GzVe7f1Z/QNptIeLX42rQ+
         1byed8HdnVYIMwGyvBCpCY5BUikmAiTeudYAIB6UUu2MJaGpbEVkB9lHFWDOvCcGYu
         rOj0JYpE33SyiBGlJWhyWTFOOfhkNFVBunwWOXI5UVhNKUoU4kKx+EdBFsRCPZ/yan
         RRHDlBKhh8WiBH2BYnu+BZXJgBNFh8xPVn6Lc7QJO1ysxm+IjntxyXj0cTiLXB1ULD
         TqKxFfgzqS7L7SU1mAFYIEn4KbuKSExDumRDKSbQ7cqgd0AcKHi
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Paul Tan <pyokagan@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>
Subject: [PATCH v2 17/20] refs: add an update_ref_oid function.
Date:   Mon,  5 Sep 2016 20:08:08 +0000
Message-Id: <20160905200811.697889-18-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20160905200811.697889-1-sandals@crustytoothpaste.net>
References: <20160905200811.697889-1-sandals@crustytoothpaste.net>
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
 
