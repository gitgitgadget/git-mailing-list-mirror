Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBD071FD99
	for <e@80x24.org>; Wed, 10 Aug 2016 22:52:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752342AbcHJWwn (ORCPT <rfc822;e@80x24.org>);
	Wed, 10 Aug 2016 18:52:43 -0400
Received: from a7-12.smtp-out.eu-west-1.amazonses.com ([54.240.7.12]:39215
	"EHLO a7-12.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751497AbcHJWwn convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2016 18:52:43 -0400
DKIM-Signature:	v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1470866239;
	h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
	bh=+X7IQ0ITBq+C6x2nClmwKqMO74ovBnjZXdgBQfF2mgc=;
	b=YL2cAARoxROBCgUU5BOz9ewiC1elEvpa2UcvH79swApWcK+aOGkDYwVcqu9HUa6A
	YHu0zthpq9L/DU6m5wnt8yHSLIMWFp0E8zYGGhp0nEZuonRm3jqBgYelTABA45wSsD0
	w5FX/RFscoj3l0OJr6aL+CFQEULL4eoCgfiS0hDE=
From:	Pranit Bauva <pranit.bauva@gmail.com>
To:	git@vger.kernel.org
Message-ID: <010201567675ae57-614652e4-7e6c-4451-a4cf-aa73922fe552-000000@eu-west-1.amazonses.com>
In-Reply-To: <010201567675adc1-17e27495-6b36-40d1-836d-814da029fcc4-000000@eu-west-1.amazonses.com>
References: <010201567675adc1-17e27495-6b36-40d1-836d-814da029fcc4-000000@eu-west-1.amazonses.com>
Subject: [PATCH v12 06/13] wrapper: move is_empty_file() and rename it as
 is_empty_or_missing_file()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Date:	Wed, 10 Aug 2016 21:57:19 +0000
X-SES-Outgoing:	2016.08.10-54.240.7.12
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

is_empty_file() can help to refactor a lot of code. This will be very
helpful in porting "git bisect" to C.

Suggested-by: Torsten Bögershausen <tboegi@web.de>
Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
---
 builtin/am.c | 20 ++------------------
 cache.h      |  3 +++
 wrapper.c    | 13 +++++++++++++
 3 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 3dfe70b..6ee158f 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -30,22 +30,6 @@
 #include "mailinfo.h"
 
 /**
- * Returns 1 if the file is empty or does not exist, 0 otherwise.
- */
-static int is_empty_file(const char *filename)
-{
-	struct stat st;
-
-	if (stat(filename, &st) < 0) {
-		if (errno == ENOENT)
-			return 1;
-		die_errno(_("could not stat %s"), filename);
-	}
-
-	return !st.st_size;
-}
-
-/**
  * Returns the length of the first line of msg.
  */
 static int linelen(const char *msg)
@@ -1323,7 +1307,7 @@ static int parse_mail(struct am_state *state, const char *mail)
 		goto finish;
 	}
 
-	if (is_empty_file(am_path(state, "patch"))) {
+	if (is_empty_or_missing_file(am_path(state, "patch"))) {
 		printf_ln(_("Patch is empty. Was it split wrong?"));
 		die_user_resolve(state);
 	}
@@ -1911,7 +1895,7 @@ static void am_run(struct am_state *state, int resume)
 		resume = 0;
 	}
 
-	if (!is_empty_file(am_path(state, "rewritten"))) {
+	if (!is_empty_or_missing_file(am_path(state, "rewritten"))) {
 		assert(state->rebasing);
 		copy_notes_for_rebase(state);
 		run_post_rewrite_hook(state);
diff --git a/cache.h b/cache.h
index 6049f86..91e2f81 100644
--- a/cache.h
+++ b/cache.h
@@ -1870,4 +1870,7 @@ void sleep_millisec(int millisec);
  */
 void safe_create_dir(const char *dir, int share);
 
+/* Return 1 if the file is empty or does not exists, 0 otherwise. */
+extern int is_empty_or_missing_file(const char *filename);
+
 #endif /* CACHE_H */
diff --git a/wrapper.c b/wrapper.c
index 5dc4e15..e70e4d1 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -696,3 +696,16 @@ void sleep_millisec(int millisec)
 {
 	poll(NULL, 0, millisec);
 }
+
+int is_empty_or_missing_file(const char *filename)
+{
+	struct stat st;
+
+	if (stat(filename, &st) < 0) {
+		if (errno == ENOENT)
+			return 1;
+		die_errno(_("could not stat %s"), filename);
+	}
+
+	return !st.st_size;
+}

--
https://github.com/git/git/pull/281
