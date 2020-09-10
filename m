Return-Path: <SRS0=4khD=CT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 069F4C433E2
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 17:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA94F20C09
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 17:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TTHbfdmq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbgIJRDK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Sep 2020 13:03:10 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57588 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727099AbgIJRCg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Sep 2020 13:02:36 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 21B2F6BA64;
        Thu, 10 Sep 2020 13:02:18 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=gi/0O/860iMuLPQHGXZ+SO4iR
        0c=; b=TTHbfdmqjXuJz7VYC3/nE1PkGn4gKhUyh4RzNT4Tv5e8Dtnx3y4rA6pxr
        8jokejc3fXcGQH12t1IWO0+P5UodYT6PQVkttLfopdxhyaQvNlVz4ZGRV2E08fFT
        tqPqE7UrfLTorZeIleqUqjU3IxHYJpvySahxc7dGY1ajX2zWVY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; q=dns; s=sasl; b=cgAn7sX+e3T93naQ6pe
        ur3hQEBS5iHJNgOscqSkqs18rg9thPK5W/o1GZWpyhBnLgxVAiqS0ZIhVojiyRBd
        rh5ozBkRUF7Y5HQeWp7JxdJEARQ6jO/NJhWay7oL3SEkNZSwej4RcpbDKj61j8x1
        kKTqn1uc//VctZG6tPtzPFj0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1993C6BA63;
        Thu, 10 Sep 2020 13:02:18 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [35.190.152.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 993FC6BA60;
        Thu, 10 Sep 2020 13:02:17 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH v2 7/7] quote: turn 'nodq' parameter into a set of flags
Date:   Thu, 10 Sep 2020 10:01:59 -0700
Message-Id: <20200910170159.1278781-8-gitster@pobox.com>
X-Mailer: git-send-email 2.28.0-603-ga98dad7d4d
In-Reply-To: <20200910170159.1278781-1-gitster@pobox.com>
References: <20200908205224.4126551-1-gitster@pobox.com>
 <20200910170159.1278781-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: 61E043A4-F387-11EA-B898-01D9BED8090B-77302942!pb-smtp1.pobox.com
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
 quote.c | 18 +++++++++++-------
 quote.h |  7 +++++--
 3 files changed, 20 insertions(+), 13 deletions(-)

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
index 9a6e0e7dea..69f4ca45da 100644
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
@@ -367,7 +370,8 @@ char *quote_path(const char *in, const char *prefix, =
struct strbuf *out, unsigne
 	 */
 	if (force_dq)
 		strbuf_addch(out, '"');
-	quote_c_style_counted(rel, strlen(rel), out, NULL, !!force_dq);
+	quote_c_style_counted(rel, strlen(rel), out, NULL,
+			      force_dq ? CQUOTE_NODQ : 0);
 	if (force_dq)
 		strbuf_addch(out, '"');
 	strbuf_release(&sb);
diff --git a/quote.h b/quote.h
index 1918d1e00e..4b72a583cf 100644
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
2.28.0-603-ga98dad7d4d

