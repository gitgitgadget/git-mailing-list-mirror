Return-Path: <SRS0=4khD=CT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45EA8C433E2
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 17:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0992720719
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 17:03:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="p7yERWeq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbgIJRDQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Sep 2020 13:03:16 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54766 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbgIJRCc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Sep 2020 13:02:32 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 954286BA5E;
        Thu, 10 Sep 2020 13:02:09 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=1vAYWvGtmBlbX0o9EGT2oVEu3
        Js=; b=p7yERWeqZf2AIwWeY68Onz6IlEij5iVjkuOYlVAT7urzj+l/hPQcMBrTr
        xrx8QBAXP0/vJEJW4z1WCtp8jM2HexIugV8NOL7PVylc7rUGWPDBBuTuRJjzu4ty
        fNClEUe/K0L+axnW+7wpYAFNqBrfpdL6s+K8Q5mexAGutZnZj4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; q=dns; s=sasl; b=pi4lwfymafzaaT5Bvnp
        kytUomk7rmu1f2a4WAET2Yyy1Ah0d5W4VWaTuaHZDVieOlSpZyCVEtT/yvLmHmNQ
        +hRSVCY498n0PO4fd5w8qe2LphSN1JYhndW+tHM5T4XwxbotuXGn9oqXOJYThbRu
        Nq+vZHGbRVEWY0rDqXLHQ1PU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 872176BA5D;
        Thu, 10 Sep 2020 13:02:09 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [35.190.152.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DC5956BA5C;
        Thu, 10 Sep 2020 13:02:08 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH v2 3/7] quote_path: optionally allow quoting a path with SP in it
Date:   Thu, 10 Sep 2020 10:01:55 -0700
Message-Id: <20200910170159.1278781-4-gitster@pobox.com>
X-Mailer: git-send-email 2.28.0-603-ga98dad7d4d
In-Reply-To: <20200910170159.1278781-1-gitster@pobox.com>
References: <20200908205224.4126551-1-gitster@pobox.com>
 <20200910170159.1278781-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: 5CACEED2-F387-11EA-98EF-01D9BED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some code in wt-status.c special case a path with SP in it, which
usually does not have to be c-quoted, and ensure that such a path
does get quoted.  Move the logic to quote_path() and give it a bit
in the flags word, QUOTE_PATH_QUOTE_SP.

No behaviour change intended.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 quote.c     |  7 +++++++
 quote.h     |  1 +
 wt-status.c | 15 +++------------
 3 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/quote.c b/quote.c
index a86f9f22a2..aa9a37b1b1 100644
--- a/quote.c
+++ b/quote.c
@@ -360,6 +360,13 @@ char *quote_path(const char *in, const char *prefix,=
 struct strbuf *out, unsigne
 	quote_c_style_counted(rel, strlen(rel), out, NULL, 0);
 	strbuf_release(&sb);
=20
+	if ((flags & QUOTE_PATH_QUOTE_SP) &&
+	    (out->buf[0] !=3D '"' && strchr(out->buf, ' '))) {
+		/* Ensure the whole thing is quoted if the path has SP in it */
+		strbuf_insertstr(out, 0, "\"");
+		strbuf_addch(out, '"');
+	}
+
 	return out->buf;
 }
=20
diff --git a/quote.h b/quote.h
index 4687b5daf4..1918d1e00e 100644
--- a/quote.h
+++ b/quote.h
@@ -73,6 +73,7 @@ void write_name_quoted_relative(const char *name, const=
 char *prefix,
=20
 /* quote path as relative to the given prefix */
 char *quote_path(const char *in, const char *prefix, struct strbuf *out,=
 unsigned flags);
+#define QUOTE_PATH_QUOTE_SP 01
=20
 /* quoting as a string literal for other languages */
 void perl_quote_buf(struct strbuf *sb, const char *src);
diff --git a/wt-status.c b/wt-status.c
index d6ca7bd52c..adbf6958bd 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1877,21 +1877,12 @@ static void wt_shortstatus_status(struct string_l=
ist_item *it,
 		const char *one;
=20
 		if (d->rename_source) {
-			one =3D quote_path(d->rename_source, s->prefix, &onebuf, 0);
-			if (*one !=3D '"' && strchr(one, ' ') !=3D NULL) {
-				putchar('"');
-				strbuf_addch(&onebuf, '"');
-				one =3D onebuf.buf;
-			}
+			one =3D quote_path(d->rename_source, s->prefix, &onebuf,
+					 QUOTE_PATH_QUOTE_SP);
 			printf("%s -> ", one);
 			strbuf_release(&onebuf);
 		}
-		one =3D quote_path(it->string, s->prefix, &onebuf, 0);
-		if (*one !=3D '"' && strchr(one, ' ') !=3D NULL) {
-			putchar('"');
-			strbuf_addch(&onebuf, '"');
-			one =3D onebuf.buf;
-		}
+		one =3D quote_path(it->string, s->prefix, &onebuf, QUOTE_PATH_QUOTE_SP=
);
 		printf("%s\n", one);
 		strbuf_release(&onebuf);
 	}
--=20
2.28.0-603-ga98dad7d4d

