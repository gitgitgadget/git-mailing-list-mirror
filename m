Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C046D203EB
	for <e@80x24.org>; Wed, 27 Jul 2016 08:23:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753285AbcG0IXH (ORCPT <rfc822;e@80x24.org>);
	Wed, 27 Jul 2016 04:23:07 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:35329 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752905AbcG0IXD (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Jul 2016 04:23:03 -0400
X-Greylist: delayed 525 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Jul 2016 04:23:03 EDT
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id C47FA206DE;
	Wed, 27 Jul 2016 04:14:16 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute1.internal (MEProxy); Wed, 27 Jul 2016 04:14:16 -0400
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed/relaxed; d=pennock-tech.com;
	 h=cc:content-type:date:from:message-id:mime-version:subject:to
	:x-sasl-enc:x-sasl-enc; s=mesmtp; bh=70EQtS7Sqst9Qn8w+BqPpXlMBBY
	=; b=GZM6dJ9IisFBFMatRQ88HIPmSOcya/2c24nlxP15S+q6dxekGxwWhGQ54eF
	OMoWA4j+h8+ySOJfAIENJ+yLWbTX++fBNPPBuAIIQJSkhWsnHs+LnMq7b4Ctxa2T
	e2CxmA6IOE76yO7aSow5WgdzsOCrgFuptzQlXq5qhV+WlblI=
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:date:from:message-id
	:mime-version:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=70
	EQtS7Sqst9Qn8w+BqPpXlMBBY=; b=Drc/lDpQY/o6U73EeRiZgixDA7mcUYg4aB
	F9Wt6MWO6mCaq9UwYZJ4s1XTrHm8vGvEeaSIUWPkbhUJ0CdZ9LwxV+lV5sPfJL1a
	pgsX2zAywyNIGmKvpc0JEbuzDFNIx6SqNafCyB59knLKd0XZ+8b8EVqPcgs8PAvP
	oNbUeakxM=
X-Sasl-enc: yNmYlm/aGVXJmX/UomQYj70+IOMla3vVlU35q2ePcE57 1469607256
Received: from breadbox (pool-72-95-220-245.pitbpa.fios.verizon.net [72.95.220.245])
	by mail.messagingengine.com (Postfix) with ESMTPA id 66578CC07A;
	Wed, 27 Jul 2016 04:14:16 -0400 (EDT)
Date:	Wed, 27 Jul 2016 04:14:14 -0400
From:	Phil Pennock <phil@pennock-tech.com>
To:	git@vger.kernel.org
Cc:	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Jeff King <peff@peff.net>
Subject: [PATCH] pretty format string support for reflog times
Message-ID: <20160727081414.GA21451@breadbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
OpenPGP: url=https://www.security.spodhuis.org/PGP/keys/0x4D1E900E14C1CC04.asc
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

The reflog contains timestamp information, but these were not exposed to
`--pretty`.  Four of the six author/committer format string
second-letters were still available and copied, but `d`/`D` are taken
for reflog selector formatting.  So use `%gT` for "time" instead of
"date" mnemonic for using `--date=...` formatting.

Implementation trade-off: could use `format_person_part()` if bounce
information out of the reflog as a buffer-constructed string, then parse
it back again, _and_ then use a hacky letter override for 'T' becoming
'd'.  That would avoid reimplementing the specification of the five
added timestamp rendering cases.  Instead, we allow exporting the
timestamp information from the reflog, and if we get it, we add the same
data.  No memory alloc and string construction/parsing, a small amount
of duplication of meaning.

Signed-off-by: Phil Pennock <phil@pennock-tech.com>
---
 pretty.c                      | 36 ++++++++++++++++++++++++++++++++++++
 reflog-walk.c                 | 16 ++++++++++++++++
 reflog-walk.h                 |  3 +++
 t/t4205-log-pretty-formats.sh | 26 ++++++++++++++++++++++++++
 4 files changed, 81 insertions(+)

diff --git a/pretty.c b/pretty.c
index 9fa42c2..955baf1 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1066,6 +1066,8 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 	const char *msg = c->message;
 	struct commit_list *p;
 	int h1, h2;
+	unsigned long timestamp;
+	int tz;
 
 	/* these are independent of the commit */
 	switch (placeholder[0]) {
@@ -1212,6 +1214,40 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 						    placeholder[1],
 						    c->pretty_ctx->reflog_info,
 						    &c->pretty_ctx->date_mode);
+		/*
+		 * all the date options except those taken for other reflog handling
+		 * (so not 'd' or 'D').
+		 */
+		case 'r':
+			if (get_reflog_timeinfo(&timestamp, &tz, c->pretty_ctx->reflog_info)) {
+				strbuf_addstr(sb, show_date(timestamp, tz, DATE_MODE(RELATIVE)));
+			}
+			return 2;
+		case 't':
+			if (get_reflog_timeinfo(&timestamp, &tz, c->pretty_ctx->reflog_info)) {
+				strbuf_addf(sb, "%lu", timestamp);
+			}
+			return 2;
+		case 'i':
+			if (get_reflog_timeinfo(&timestamp, &tz, c->pretty_ctx->reflog_info)) {
+				strbuf_addstr(sb, show_date(timestamp, tz, DATE_MODE(ISO8601)));
+			}
+			return 2;
+		case 'I':
+			if (get_reflog_timeinfo(&timestamp, &tz, c->pretty_ctx->reflog_info)) {
+				strbuf_addstr(sb, show_date(timestamp, tz, DATE_MODE(ISO8601_STRICT)));
+			}
+			return 2;
+		/*
+		 * reflog d/D are taken, so we can't use those for dates
+		 * but we do want to support using --date= format overrides
+		 * so we steal 'T' for those ('time' instead of 'date')
+		 */
+		case 'T':
+			if (get_reflog_timeinfo(&timestamp, &tz, c->pretty_ctx->reflog_info)) {
+				strbuf_addstr(sb, show_date(timestamp, tz, &c->pretty_ctx->date_mode));
+			}
+			return 2;
 		}
 		return 0;	/* unknown %g placeholder */
 	case 'N':
diff --git a/reflog-walk.c b/reflog-walk.c
index a246af2..bb9cbf8 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -309,6 +309,22 @@ void get_reflog_message(struct strbuf *sb,
 	strbuf_add(sb, info->message, len);
 }
 
+int get_reflog_timeinfo(unsigned long *timestamp_out,
+			 int *tz_out,
+			 struct reflog_walk_info *reflog_info)
+{
+	struct commit_reflog *commit_reflog = reflog_info->last_commit_reflog;
+	struct reflog_info *info;
+
+	if (!commit_reflog)
+		return 0;
+
+	info = &commit_reflog->reflogs->items[commit_reflog->recno+1];
+	*timestamp_out = info->timestamp;
+	*tz_out = info->tz;
+	return 1;
+}
+
 const char *get_reflog_ident(struct reflog_walk_info *reflog_info)
 {
 	struct commit_reflog *commit_reflog = reflog_info->last_commit_reflog;
diff --git a/reflog-walk.h b/reflog-walk.h
index 27886f7..a368c72 100644
--- a/reflog-walk.h
+++ b/reflog-walk.h
@@ -19,5 +19,8 @@ extern void get_reflog_selector(struct strbuf *sb,
 		struct reflog_walk_info *reflog_info,
 		const struct date_mode *dmode, int force_date,
 		int shorten);
+extern int get_reflog_timeinfo(unsigned long *timestamp_out,
+		int *tz_out,
+		struct reflog_walk_info *reflog_info);
 
 #endif
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index d9f6242..9d211ab 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -533,4 +533,30 @@ EOF
 	test_cmp expected actual1
 '
 
+refhead1_short=$(git rev-parse --short --verify HEAD@{0}) &&
+refhead2_short=$(git rev-parse --short --verify HEAD@{1}) &&
+
+test_expect_success 'can access the reflog' '
+	git reflog -n 2 >actual &&
+	cat >expected <<EOF &&
+$refhead1_short HEAD@{0}: commit (amend): shorter
+$refhead2_short HEAD@{1}: commit (amend): short
+EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'reflog tformat timestamps work' '
+	git log -g -n 2 \
+		--pretty=tformat:"%h %gd / %gr %gt%n %gi %gI%n %gT : %gs" > actual &&
+	cat >expected <<EOF &&
+$refhead1_short HEAD@{0} / 11 years ago 1112912173
+ 2005-04-07 15:16:13 -0700 2005-04-07T15:16:13-07:00
+ Thu Apr 7 15:16:13 2005 -0700 : commit (amend): shorter
+$refhead2_short HEAD@{1} / 11 years ago 1112912173
+ 2005-04-07 15:16:13 -0700 2005-04-07T15:16:13-07:00
+ Thu Apr 7 15:16:13 2005 -0700 : commit (amend): short
+EOF
+	test_cmp expected actual
+'
+
 test_done
-- 
2.9.2.466.g8c6d1f9.dirty

