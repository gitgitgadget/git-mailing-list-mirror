Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E52E207F8
	for <e@80x24.org>; Sat,  6 May 2017 22:12:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754754AbdEFWMC (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 May 2017 18:12:02 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:37610 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754284AbdEFWLR (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 6 May 2017 18:11:17 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 6842F280AE;
        Sat,  6 May 2017 22:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1494108671;
        bh=b3USGTlvB469PdckXjZWnLHPkdf9l3qdhtKJrNM/Cco=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uzkJVAcV/seSAx4m9/QOUx+Bm0KBXXXEgp85ooKUFz0svJvrSTAsE3gFcz+xiPPjM
         wYAOvK2bzcs32t02r+B+yuNh5n5ga+qhF3l6QdUzSO2qaOZHbk0nCys3xRHHmm4ELI
         gJqillQcv0NrFiy+jJ11iW3IyhVucpc+vZL9N4jWKZQHNAzA7wDvCUsV9skXV4LtVc
         deQjwsHYoIRoQqlE3+bDdlcWn3kAzZzcgw/0+Yrevl0PjTof1ClI6VIZfVy0DFqjAN
         TkwBxrRwtdis1pq9sj3nqdR71t3pIb/Z/roIDoy0WwYNgp0RRdK3r/vJqQkJe0lb1x
         OTAl1MWIlGDC3lAvLdjBYijf77jgCtplgTllxyr8IqRvKQlFaLdF4H9k3eEdOQNBIM
         Ir0bo8w0EiNCab2zkr9LviwElTkOfoUWtMaOZded/ohRgqhWBmO6f4gb6SrM9C4MNc
         WFL/VqVLyQjrColeaAb1FjR9VdM59Zf2kcm9cbmPbh4sMPSQ+nF
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Brandon Williams <bmwill@google.com>
Subject: [PATCH v3 22/53] sequencer: convert some functions to struct object_id
Date:   Sat,  6 May 2017 22:10:07 +0000
Message-Id: <20170506221038.296722-23-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.13.0.rc1.294.g07d810a77f
In-Reply-To: <20170506221038.296722-1-sandals@crustytoothpaste.net>
References: <20170506221038.296722-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert update_squash_messages and is_index_unchanged to struct
object_id.  These are callers of lookup_commit and
lookup_commit_reference, which we want to convert.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 sequencer.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index b0f862b7b..b94830cf9 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -482,13 +482,13 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
 
 static int is_index_unchanged(void)
 {
-	unsigned char head_sha1[20];
+	struct object_id head_oid;
 	struct commit *head_commit;
 
-	if (!resolve_ref_unsafe("HEAD", RESOLVE_REF_READING, head_sha1, NULL))
+	if (!resolve_ref_unsafe("HEAD", RESOLVE_REF_READING, head_oid.hash, NULL))
 		return error(_("could not resolve HEAD commit\n"));
 
-	head_commit = lookup_commit(head_sha1);
+	head_commit = lookup_commit(head_oid.hash);
 
 	/*
 	 * If head_commit is NULL, check_commit, called from
@@ -835,13 +835,13 @@ static int update_squash_messages(enum todo_command command,
 		strbuf_splice(&buf, 0, eol - buf.buf, header.buf, header.len);
 		strbuf_release(&header);
 	} else {
-		unsigned char head[20];
+		struct object_id head;
 		struct commit *head_commit;
 		const char *head_message, *body;
 
-		if (get_sha1("HEAD", head))
+		if (get_oid("HEAD", &head))
 			return error(_("need a HEAD to fixup"));
-		if (!(head_commit = lookup_commit_reference(head)))
+		if (!(head_commit = lookup_commit_reference(head.hash)))
 			return error(_("could not read HEAD"));
 		if (!(head_message = get_commit_buffer(head_commit, NULL)))
 			return error(_("could not read HEAD's commit message"));
