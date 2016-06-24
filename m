Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E89591FEAA
	for <e@80x24.org>; Fri, 24 Jun 2016 23:10:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751566AbcFXXJy (ORCPT <rfc822;e@80x24.org>);
	Fri, 24 Jun 2016 19:09:54 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:52648 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751527AbcFXXJr (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Jun 2016 19:09:47 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [107.18.82.227])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 352DE2809F;
	Fri, 24 Jun 2016 23:09:45 +0000 (UTC)
DKIM-Signature:	v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1466809785;
	bh=cQwps8QUNH9tyRtxkXMd+QEu87AE3JoDe1bTMMqwseI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YunIT81pz+Brp/3/DpR0YjFUMwE9zoyrjigt9/AJHiTMMOK8iuL+WSZpN1/eHfqcd
	 pw5YB8MActtM/h0CheHRVvRajnT8LVoRDnGQseORmmFOxC5SLf8skCjBbPAZBK3M9O
	 6/uS1aOkHbSOTiCegiwDsABlEFJwuQgM059kitQeCveXqkGdr/ABPERj66YPcCtSqA
	 YGdy2lTQjuwwTN4Dd38tkgUQvN/TDiDeMFcFu2w01ba3TJj4YP0DmkwQaB8mc+4vEL
	 6D7qGefpvNWRAfu97cV6xSG6FdGnmlw0C9VMarC14eVgka1g6rg+KJ+kYqUbZMNJ2R
	 zJg2NoqKDbI3hKRRImzLD/Cj/Da8a9vzj1MY/AFcAmWfuPX9j3Q9DfmwIffk1sjyWM
	 Zp4P/l7Odp2b/Mg+NUJO1Yr6RlmjUcgNtC5w/be04HeqeiMMnL6AF5kRukuf+jlpEG
	 3XRLdl5UTwRoaEVBcqTJ/a0fTbFfgb6puu6ceihZ27DAxSdZSSL
From:	"brian m. carlson" <sandals@crustytoothpaste.net>
To:	git@vger.kernel.org
Cc:	Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v3 11/11] diff: convert prep_temp_blob to struct object_id.
Date:	Fri, 24 Jun 2016 23:09:29 +0000
Message-Id: <20160624230929.82222-12-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20160624230929.82222-1-sandals@crustytoothpaste.net>
References: <20160624230929.82222-1-sandals@crustytoothpaste.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

All of the callers of this function use struct object_id, so convert it
to use struct object_id in its arguments and internally.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 diff.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/diff.c b/diff.c
index 9abb54ad..8cdfdf32 100644
--- a/diff.c
+++ b/diff.c
@@ -2866,7 +2866,7 @@ void diff_free_filespec_data(struct diff_filespec *s)
 static void prep_temp_blob(const char *path, struct diff_tempfile *temp,
 			   void *blob,
 			   unsigned long size,
-			   const unsigned char *sha1,
+			   const struct object_id *oid,
 			   int mode)
 {
 	int fd;
@@ -2891,7 +2891,7 @@ static void prep_temp_blob(const char *path, struct diff_tempfile *temp,
 		die_errno("unable to write temp-file");
 	close_tempfile(&temp->tempfile);
 	temp->name = get_tempfile_path(&temp->tempfile);
-	sha1_to_hex_r(temp->hex, sha1);
+	oid_to_hex_r(temp->hex, oid);
 	xsnprintf(temp->mode, sizeof(temp->mode), "%06o", mode);
 	strbuf_release(&buf);
 	strbuf_release(&template);
@@ -2929,7 +2929,7 @@ static struct diff_tempfile *prepare_temp_file(const char *name,
 				die_errno("readlink(%s)", name);
 			prep_temp_blob(name, temp, sb.buf, sb.len,
 				       (one->oid_valid ?
-					one->oid.hash : null_sha1),
+					&one->oid : &null_oid),
 				       (one->oid_valid ?
 					one->mode : S_IFLNK));
 			strbuf_release(&sb);
@@ -2955,7 +2955,7 @@ static struct diff_tempfile *prepare_temp_file(const char *name,
 		if (diff_populate_filespec(one, 0))
 			die("cannot read data blob for %s", one->path);
 		prep_temp_blob(name, temp, one->data, one->size,
-			       one->oid.hash, one->mode);
+			       &one->oid, one->mode);
 	}
 	return temp;
 }
