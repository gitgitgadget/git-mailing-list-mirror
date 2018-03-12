Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3E571F404
	for <e@80x24.org>; Mon, 12 Mar 2018 02:28:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932570AbeCLC22 (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Mar 2018 22:28:28 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34304 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932420AbeCLC2V (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 11 Mar 2018 22:28:21 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 5716A60998;
        Mon, 12 Mar 2018 02:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1520821700;
        bh=dO+7MrnS+4YFt5SPcGs79SiY8BXBACMWl+JE4SYw44I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=HmYmEwq+qD3OIYW8+Dz5jtdszELnl7DwB2qBOWdHCQt7CiU5Ides1PsY3FQtUb2OH
         77g8TjgJ019/gc9e/OCpt0/WVgkN9NYy8cb3tOUB9Xeu7DT1aImrgYgnSeQVvDNsrv
         PGVj1cQxndLcUN9qYgyHmQxPfZuZ2O57WDf1fExuCmtcdgfQC5SRNAlSwNtxfwEUXQ
         t9wxCQFaKWH9cC4Pq3znL5PuSfL98VMeLQaHz0LMkzdeV6Ty1hiEKotJnG2Sg2hRl9
         WJQuM7Y/2+fuh0x9Y17yyVPWTNr8BFo7OkVjRgHDWHou/PwshD17z+2qz76lkLgt2Z
         PzdAvs0DOK7NjFKxE6lFDoynyCvCpFcSrKZQkW2iZv/fCfvMJZwKMenmE8gIgtNBBW
         WFCZDZ9xtJcNG3wz0nTANV+epCMyFiTo3hl/H8bHKIfwVCGl8RvZuHX8z0P/pbDZhk
         pHiQMXtVwIS8u5jyZNpPTIyAhLXFFvsOEHb18d5ojQs2S6XQu69
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Patryk Obara <patryk.obara@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 07/36] ref-filter: convert grab_objectname to struct object_id
Date:   Mon, 12 Mar 2018 02:27:27 +0000
Message-Id: <20180312022756.483934-8-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.16.2.660.g709887971b
In-Reply-To: <20180312022756.483934-1-sandals@crustytoothpaste.net>
References: <20180312022756.483934-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is necessary in order to convert find_unique_abbrev.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 ref-filter.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 45fc56216a..dbe554dffa 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -737,18 +737,18 @@ static void *get_obj(const struct object_id *oid, struct object **obj, unsigned
 	return buf;
 }
 
-static int grab_objectname(const char *name, const unsigned char *sha1,
+static int grab_objectname(const char *name, const struct object_id *oid,
 			   struct atom_value *v, struct used_atom *atom)
 {
 	if (starts_with(name, "objectname")) {
 		if (atom->u.objectname.option == O_SHORT) {
-			v->s = xstrdup(find_unique_abbrev(sha1, DEFAULT_ABBREV));
+			v->s = xstrdup(find_unique_abbrev(oid->hash, DEFAULT_ABBREV));
 			return 1;
 		} else if (atom->u.objectname.option == O_FULL) {
-			v->s = xstrdup(sha1_to_hex(sha1));
+			v->s = xstrdup(oid_to_hex(oid));
 			return 1;
 		} else if (atom->u.objectname.option == O_LENGTH) {
-			v->s = xstrdup(find_unique_abbrev(sha1, atom->u.objectname.length));
+			v->s = xstrdup(find_unique_abbrev(oid->hash, atom->u.objectname.length));
 			return 1;
 		} else
 			die("BUG: unknown %%(objectname) option");
@@ -775,7 +775,7 @@ static void grab_common_values(struct atom_value *val, int deref, struct object
 			v->s = xstrfmt("%lu", sz);
 		}
 		else if (deref)
-			grab_objectname(name, obj->oid.hash, v, &used_atom[i]);
+			grab_objectname(name, &obj->oid, v, &used_atom[i]);
 	}
 }
 
@@ -1455,7 +1455,7 @@ static void populate_value(struct ref_array_item *ref)
 				v->s = xstrdup(buf + 1);
 			}
 			continue;
-		} else if (!deref && grab_objectname(name, ref->objectname.hash, v, atom)) {
+		} else if (!deref && grab_objectname(name, &ref->objectname, v, atom)) {
 			continue;
 		} else if (!strcmp(name, "HEAD")) {
 			if (atom->u.head && !strcmp(ref->refname, atom->u.head))
