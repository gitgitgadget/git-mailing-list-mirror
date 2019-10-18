Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F40DF1F4C4
	for <e@80x24.org>; Fri, 18 Oct 2019 05:00:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441655AbfJRFAG (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Oct 2019 01:00:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:51752 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726315AbfJRFAF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Oct 2019 01:00:05 -0400
Received: (qmail 9500 invoked by uid 109); 18 Oct 2019 05:00:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 18 Oct 2019 05:00:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14447 invoked by uid 111); 18 Oct 2019 05:03:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 18 Oct 2019 01:03:10 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 18 Oct 2019 01:00:04 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 18/23] fsck: don't require an object struct for fsck_ident()
Message-ID: <20191018050004.GR17879@sigill.intra.peff.net>
References: <20191018044103.GA17625@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191018044103.GA17625@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The only thing we do with the struct is pass its oid and type to
report(). We can just take those explicitly, which gives our callers
more flexibility.

Signed-off-by: Jeff King <peff@peff.net>
---
 fsck.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/fsck.c b/fsck.c
index 4ff0ceb4ac..e1d06fb210 100644
--- a/fsck.c
+++ b/fsck.c
@@ -717,7 +717,9 @@ static int verify_headers(const void *data, unsigned long size,
 		FSCK_MSG_UNTERMINATED_HEADER, "unterminated header");
 }
 
-static int fsck_ident(const char **ident, struct object *obj, struct fsck_options *options)
+static int fsck_ident(const char **ident,
+		      const struct object_id *oid, enum object_type type,
+		      struct fsck_options *options)
 {
 	const char *p = *ident;
 	char *end;
@@ -727,28 +729,28 @@ static int fsck_ident(const char **ident, struct object *obj, struct fsck_option
 		(*ident)++;
 
 	if (*p == '<')
-		return report(options, &obj->oid, obj->type, FSCK_MSG_MISSING_NAME_BEFORE_EMAIL, "invalid author/committer line - missing space before email");
+		return report(options, oid, type, FSCK_MSG_MISSING_NAME_BEFORE_EMAIL, "invalid author/committer line - missing space before email");
 	p += strcspn(p, "<>\n");
 	if (*p == '>')
-		return report(options, &obj->oid, obj->type, FSCK_MSG_BAD_NAME, "invalid author/committer line - bad name");
+		return report(options, oid, type, FSCK_MSG_BAD_NAME, "invalid author/committer line - bad name");
 	if (*p != '<')
-		return report(options, &obj->oid, obj->type, FSCK_MSG_MISSING_EMAIL, "invalid author/committer line - missing email");
+		return report(options, oid, type, FSCK_MSG_MISSING_EMAIL, "invalid author/committer line - missing email");
 	if (p[-1] != ' ')
-		return report(options, &obj->oid, obj->type, FSCK_MSG_MISSING_SPACE_BEFORE_EMAIL, "invalid author/committer line - missing space before email");
+		return report(options, oid, type, FSCK_MSG_MISSING_SPACE_BEFORE_EMAIL, "invalid author/committer line - missing space before email");
 	p++;
 	p += strcspn(p, "<>\n");
 	if (*p != '>')
-		return report(options, &obj->oid, obj->type, FSCK_MSG_BAD_EMAIL, "invalid author/committer line - bad email");
+		return report(options, oid, type, FSCK_MSG_BAD_EMAIL, "invalid author/committer line - bad email");
 	p++;
 	if (*p != ' ')
-		return report(options, &obj->oid, obj->type, FSCK_MSG_MISSING_SPACE_BEFORE_DATE, "invalid author/committer line - missing space before date");
+		return report(options, oid, type, FSCK_MSG_MISSING_SPACE_BEFORE_DATE, "invalid author/committer line - missing space before date");
 	p++;
 	if (*p == '0' && p[1] != ' ')
-		return report(options, &obj->oid, obj->type, FSCK_MSG_ZERO_PADDED_DATE, "invalid author/committer line - zero-padded date");
+		return report(options, oid, type, FSCK_MSG_ZERO_PADDED_DATE, "invalid author/committer line - zero-padded date");
 	if (date_overflows(parse_timestamp(p, &end, 10)))
-		return report(options, &obj->oid, obj->type, FSCK_MSG_BAD_DATE_OVERFLOW, "invalid author/committer line - date causes integer overflow");
+		return report(options, oid, type, FSCK_MSG_BAD_DATE_OVERFLOW, "invalid author/committer line - date causes integer overflow");
 	if ((end == p || *end != ' '))
-		return report(options, &obj->oid, obj->type, FSCK_MSG_BAD_DATE, "invalid author/committer line - bad date");
+		return report(options, oid, type, FSCK_MSG_BAD_DATE, "invalid author/committer line - bad date");
 	p = end + 1;
 	if ((*p != '+' && *p != '-') ||
 	    !isdigit(p[1]) ||
@@ -756,7 +758,7 @@ static int fsck_ident(const char **ident, struct object *obj, struct fsck_option
 	    !isdigit(p[3]) ||
 	    !isdigit(p[4]) ||
 	    (p[5] != '\n'))
-		return report(options, &obj->oid, obj->type, FSCK_MSG_BAD_TIMEZONE, "invalid author/committer line - bad time zone");
+		return report(options, oid, type, FSCK_MSG_BAD_TIMEZONE, "invalid author/committer line - bad time zone");
 	p += 6;
 	return 0;
 }
@@ -792,7 +794,7 @@ static int fsck_commit(struct commit *commit, const char *buffer,
 	author_count = 0;
 	while (skip_prefix(buffer, "author ", &buffer)) {
 		author_count++;
-		err = fsck_ident(&buffer, &commit->object, options);
+		err = fsck_ident(&buffer, &commit->object.oid, commit->object.type, options);
 		if (err)
 			return err;
 	}
@@ -804,7 +806,7 @@ static int fsck_commit(struct commit *commit, const char *buffer,
 		return err;
 	if (!skip_prefix(buffer, "committer ", &buffer))
 		return report(options, &commit->object.oid, commit->object.type, FSCK_MSG_MISSING_COMMITTER, "invalid format - expected 'committer' line");
-	err = fsck_ident(&buffer, &commit->object, options);
+	err = fsck_ident(&buffer, &commit->object.oid, commit->object.type, options);
 	if (err)
 		return err;
 	if (memchr(buffer_begin, '\0', size)) {
@@ -882,7 +884,7 @@ static int fsck_tag(struct tag *tag, const char *buffer,
 			goto done;
 	}
 	else
-		ret = fsck_ident(&buffer, &tag->object, options);
+		ret = fsck_ident(&buffer, &tag->object.oid, tag->object.type, options);
 
 done:
 	strbuf_release(&sb);
-- 
2.23.0.1228.gee29b05929

