Return-Path: <SRS0=ga/5=CR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A47DEC2BC11
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 20:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75FE42098B
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 20:52:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="NCJIa10H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbgIHUwp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Sep 2020 16:52:45 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64572 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730111AbgIHUwk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Sep 2020 16:52:40 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 462DF827ED;
        Tue,  8 Sep 2020 16:52:37 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=2j7UAr0wmr8cY4TrZcwJR/Jtr
        gk=; b=NCJIa10HU0Zqrm7kGPsjboy50QpclkYBCFCSROQPn5qM3rQj4EpwAJcJe
        Jb5kRSLJ5BA8s/uImCjOgl6qFGrFlrhPv/klRDWxiu3C0bYk+hAsGNYnVsTTGjib
        89krF46eiFJ6WiiohT+JHvz925VYrfHINPwOWq6Vi8HqEgnFxs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; q=dns; s=sasl; b=nKqaaffnytKKBn856tj
        HkQO7pKZUhy9pRw6jc5yEpuG0PDfJz2S289rtI6V8dYJgpGmk+FiILJ3YqyvhZZO
        rM9Nd86Z/Eb+YQXEntZvet9kOlgXVW+iG54REo22jPxXndcENohC82ckN5CJAttZ
        J1pbZZb/ku8HtQIBB4DrxCgg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3EC24827EC;
        Tue,  8 Sep 2020 16:52:37 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A47B0827EB;
        Tue,  8 Sep 2020 16:52:35 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH 6/6] quote: turn 'nodq' parameter into a set of flags
Date:   Tue,  8 Sep 2020 13:52:24 -0700
Message-Id: <20200908205224.4126551-7-gitster@pobox.com>
X-Mailer: git-send-email 2.28.0-539-g66371d8995
In-Reply-To: <20200908205224.4126551-1-gitster@pobox.com>
References: <20200908013013.1099937-1-sandals@crustytoothpaste.net>
 <20200908205224.4126551-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: 393E94B4-F215-11EA-80D0-01D9BED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

quote_c_style() and its friend quote_two_c_style() both take an
optional "please omit the double quotes around the quoted body"
parameter.  Turn it into a flag word, assign one bit out of it,
and call it CQUOTE_NODQ bit.

No behaviour change intended.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c  |  8 ++++----
 quote.c | 15 +++++++++------
 quote.h |  7 +++++--
 3 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/diff.c b/diff.c
index 0299a73079..e7d6e60b23 100644
--- a/diff.c
+++ b/diff.c
@@ -482,14 +482,14 @@ int git_diff_basic_config(const char *var, const ch=
ar *value, void *cb)
=20
 static char *quote_two(const char *one, const char *two)
 {
-	int need_one =3D quote_c_style(one, NULL, NULL, 1);
-	int need_two =3D quote_c_style(two, NULL, NULL, 1);
+	int need_one =3D quote_c_style(one, NULL, NULL, CQUOTE_NODQ);
+	int need_two =3D quote_c_style(two, NULL, NULL, CQUOTE_NODQ);
 	struct strbuf res =3D STRBUF_INIT;
=20
 	if (need_one + need_two) {
 		strbuf_addch(&res, '"');
-		quote_c_style(one, &res, NULL, 1);
-		quote_c_style(two, &res, NULL, 1);
+		quote_c_style(one, &res, NULL, CQUOTE_NODQ);
+		quote_c_style(two, &res, NULL, CQUOTE_NODQ);
 		strbuf_addch(&res, '"');
 	} else {
 		strbuf_addstr(&res, one);
diff --git a/quote.c b/quote.c
index 016ebf8873..b2f38d0e57 100644
--- a/quote.c
+++ b/quote.c
@@ -256,7 +256,7 @@ static size_t next_quote_pos(const char *s, ssize_t m=
axlen)
  *     Return value is the same as in (1).
  */
 static size_t quote_c_style_counted(const char *name, ssize_t maxlen,
-				    struct strbuf *sb, FILE *fp, int no_dq)
+				    struct strbuf *sb, FILE *fp, unsigned flags)
 {
 #undef EMIT
 #define EMIT(c)                                 \
@@ -272,6 +272,7 @@ static size_t quote_c_style_counted(const char *name,=
 ssize_t maxlen,
 		count +=3D (l);                           \
 	} while (0)
=20
+	int no_dq =3D !!(flags & CQUOTE_NODQ);
 	size_t len, count =3D 0;
 	const char *p =3D name;
=20
@@ -309,19 +310,21 @@ static size_t quote_c_style_counted(const char *nam=
e, ssize_t maxlen,
 	return count;
 }
=20
-size_t quote_c_style(const char *name, struct strbuf *sb, FILE *fp, int =
nodq)
+size_t quote_c_style(const char *name, struct strbuf *sb, FILE *fp, unsi=
gned flags)
 {
-	return quote_c_style_counted(name, -1, sb, fp, nodq);
+	return quote_c_style_counted(name, -1, sb, fp, flags);
 }
=20
-void quote_two_c_style(struct strbuf *sb, const char *prefix, const char=
 *path, int nodq)
+void quote_two_c_style(struct strbuf *sb, const char *prefix, const char=
 *path,
+		       unsigned flags)
 {
+	int nodq =3D !!(flags & CQUOTE_NODQ);
 	if (quote_c_style(prefix, NULL, NULL, 0) ||
 	    quote_c_style(path, NULL, NULL, 0)) {
 		if (!nodq)
 			strbuf_addch(sb, '"');
-		quote_c_style(prefix, sb, NULL, 1);
-		quote_c_style(path, sb, NULL, 1);
+		quote_c_style(prefix, sb, NULL, CQUOTE_NODQ);
+		quote_c_style(path, sb, NULL, CQUOTE_NODQ);
 		if (!nodq)
 			strbuf_addch(sb, '"');
 	} else {
diff --git a/quote.h b/quote.h
index 823f56cb94..0e49c61144 100644
--- a/quote.h
+++ b/quote.h
@@ -64,8 +64,11 @@ struct strvec;
 int sq_dequote_to_strvec(char *arg, struct strvec *);
=20
 int unquote_c_style(struct strbuf *, const char *quoted, const char **en=
dp);
-size_t quote_c_style(const char *name, struct strbuf *, FILE *, int no_d=
q);
-void quote_two_c_style(struct strbuf *, const char *, const char *, int)=
;
+
+/* Bits in the flags parameter to quote_c_style() */
+#define CQUOTE_NODQ 01
+size_t quote_c_style(const char *name, struct strbuf *, FILE *, unsigned=
);
+void quote_two_c_style(struct strbuf *, const char *, const char *, unsi=
gned);
=20
 void write_name_quoted(const char *name, FILE *, int terminator);
 void write_name_quoted_relative(const char *name, const char *prefix,
--=20
2.28.0-539-g66371d8995

