Return-Path: <SRS0=ga/5=CR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C0CC433E2
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 20:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9CB32098B
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 20:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FunchI+V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729941AbgIHUwn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Sep 2020 16:52:43 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54925 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbgIHUwh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Sep 2020 16:52:37 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id ED103E7281;
        Tue,  8 Sep 2020 16:52:32 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=K2Arzo50AUATfduxGXC7J0z5S
        s0=; b=FunchI+VYn+Io9qviY1jCc8S9R+onmZaDCMrkCRmBVl9jeuvPrSu7PV9c
        4gCJlsxly0yQd4Tyji0ptzOK+am4h/XaojTMFS4T5otrPcnQc+//dQ2SU6tw7a3L
        kXzGcN6A9wNx9NVmrzPtPWaAYMdltGiTjXMh5Yfw/ZGE4nKfVA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; q=dns; s=sasl; b=LGoX7Bi5FOLXQVtko4B
        9+qcdOl7VWHPAst9d41XdrWbwCj6mQFAKXjjdRP/ZUrL7fOnWjI/pH7nTe4XX3B8
        HQRnp1XzVeZP1okqLqRsN57Ij7eP9buQoyW78mANbu4t0zVjhKuLjs/lX4UBduhI
        C4zNLWowvWzdt0QEEUoKggKs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E413EE7280;
        Tue,  8 Sep 2020 16:52:32 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id BC10EE7279;
        Tue,  8 Sep 2020 16:52:28 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH 3/6] quote_path: optionally allow quoting a path with SP in it
Date:   Tue,  8 Sep 2020 13:52:21 -0700
Message-Id: <20200908205224.4126551-4-gitster@pobox.com>
X-Mailer: git-send-email 2.28.0-539-g66371d8995
In-Reply-To: <20200908205224.4126551-1-gitster@pobox.com>
References: <20200908013013.1099937-1-sandals@crustytoothpaste.net>
 <20200908205224.4126551-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: 3521BEB0-F215-11EA-A98D-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
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
 quote.c     |  9 ++++++++-
 quote.h     |  1 +
 wt-status.c | 15 +++------------
 3 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/quote.c b/quote.c
index 03ca85afb0..aa9a37b1b1 100644
--- a/quote.c
+++ b/quote.c
@@ -357,9 +357,16 @@ char *quote_path(const char *in, const char *prefix,=
 struct strbuf *out, unsigne
 	struct strbuf sb =3D STRBUF_INIT;
 	const char *rel =3D relative_path(in, prefix, &sb);
 	strbuf_reset(out);
-	quote_c_style_counted(rel, strlen(rel), out, NULL, flags);
+	quote_c_style_counted(rel, strlen(rel), out, NULL, 0);
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
index db7140b3c7..823f56cb94 100644
--- a/quote.h
+++ b/quote.h
@@ -73,6 +73,7 @@ void write_name_quoted_relative(const char *name, const=
 char *prefix,
=20
 /* quote path as relative to the given prefix */
 char *quote_path(const char *in, const char *prefix, struct strbuf *out,=
 unsigned);
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
2.28.0-539-g66371d8995

