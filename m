Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=1.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: (qmail 17499 invoked by uid 107); 11 Jan 2010 05:09:06 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.180.67)
    by peff.net (qpsmtpd/0.40) with ESMTP; Mon, 11 Jan 2010 00:09:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751246Ab0AKFEL (ORCPT <rfc822;peff@peff.net>);
	Mon, 11 Jan 2010 00:04:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751204Ab0AKFEK
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jan 2010 00:04:10 -0500
Received: from mail-fx0-f215.google.com ([209.85.220.215]:47087 "EHLO
	mail-fx0-f215.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750971Ab0AKFEJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2010 00:04:09 -0500
Received: by fxm7 with SMTP id 7so19384669fxm.29
        for <git@vger.kernel.org>; Sun, 10 Jan 2010 21:04:08 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:to;
        bh=1dA9jdfN1OKXjxZNv1pPktDlOC180eGGnjPgPPswP54=;
        b=LDgr2XR48KwaPtD7NBtqacOyokSGM+Czg8A/iTFTLyOAUjheQfue7f+9/ltYemI+Ko
         mBn2lLzSc6kf4RpDwxeg/qiHH+PJuchlwMOQyRkmZaCgjwyeRXDvOWs8LVr0epjYaBhB
         EfgreJVWeMKt7v7+IaqzKDCVefcNQbKIKiVtg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=nnYnx49/FzvIX8ZwDmcflW1D6gvnkxSBqA+WaxktBkoOesn/2isg27boaTTe3rzLl9
         QCqrPSXVTAxsuTylIBGt2DPmyv/wHUJsmgZD6YEFPOUzxLAqacUKYtFnPeZFObak8EiP
         FZSOHLgBx+7s5L8hS+qICNoHTg38rOTay6bbM=
Received: by 10.87.55.24 with SMTP id h24mr548121fgk.1.1263186247998;
        Sun, 10 Jan 2010 21:04:07 -0800 (PST)
Received: from localhost (ppp85-141-235-124.pppoe.mtu-net.ru [85.141.235.124])
        by mx.google.com with ESMTPS id e11sm56010944fga.4.2010.01.10.21.04.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 10 Jan 2010 21:04:06 -0800 (PST)
From:	Dmitry Potapov <dpotapov@gmail.com>
To:	git@vger.kernel.org
Cc:	Dmitry Potapov <dpotapov@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] fast-import: tag may point to any object type
Date:	Mon, 11 Jan 2010 08:02:45 +0300
Message-Id: <1263186165-23920-1-git-send-email-dpotapov@gmail.com>
X-Mailer: git-send-email 1.6.6.137.g63ae0
To:	git@vger.kernel.org
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

If you tried to export the official git repository, and then to import it
back then git-fast-import would die complaining that "Mark :1 not a commit".

Accordingly to a generated crash file, Mark 1 is not a commit but a blob,
which is pointed by junio-gpg-pub tag. Because git-tag allows to create such
tags, git-fast-import should import them.

Signed-off-by: Dmitry Potapov <dpotapov@gmail.com>
---
 fast-import.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index cd87049..e99990d 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2305,6 +2305,7 @@ static void parse_new_tag(void)
 	struct tag *t;
 	uintmax_t from_mark = 0;
 	unsigned char sha1[20];
+	enum object_type type = OBJ_COMMIT;
 
 	/* Obtain the new tag name from the rest of our command */
 	sp = strchr(command_buf.buf, ' ') + 1;
@@ -2329,8 +2330,7 @@ static void parse_new_tag(void)
 		struct object_entry *oe;
 		from_mark = strtoumax(from + 1, NULL, 10);
 		oe = find_mark(from_mark);
-		if (oe->type != OBJ_COMMIT)
-			die("Mark :%" PRIuMAX " not a commit", from_mark);
+		type = oe->type;
 		hashcpy(sha1, oe->sha1);
 	} else if (!get_sha1(from, sha1)) {
 		unsigned long size;
@@ -2362,7 +2362,7 @@ static void parse_new_tag(void)
 		    "object %s\n"
 		    "type %s\n"
 		    "tag %s\n",
-		    sha1_to_hex(sha1), commit_type, t->name);
+		    sha1_to_hex(sha1), typename(type), t->name);
 	if (tagger)
 		strbuf_addf(&new_data,
 			    "tagger %s\n", tagger);
-- 
1.6.6

