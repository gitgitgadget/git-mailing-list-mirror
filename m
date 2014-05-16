From: Alexey Shumkin <alex.crezoff@gmail.com>
Subject: [PATCH 2/2] pretty.c: format string with truncate respects logOutputEncoding
Date: Fri, 16 May 2014 17:06:31 +0400
Message-ID: <b8aa002298a5e96be3a79406b0d120f001364851.1400242108.git.Alex.Crezoff@gmail.com>
References: <cover.1400242108.git.Alex.Crezoff@gmail.com>
Cc: Alexey Shumkin <Alex.Crezoff@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 16 15:07:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlHrS-0001sQ-NN
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 15:07:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755567AbaEPNHi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 09:07:38 -0400
Received: from mail-la0-f48.google.com ([209.85.215.48]:39447 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751882AbaEPNHh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 09:07:37 -0400
Received: by mail-la0-f48.google.com with SMTP id mc6so1929026lab.35
        for <git@vger.kernel.org>; Fri, 16 May 2014 06:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=k8CLBXzVhKF4K6Nj7sz8OITc7eGpXBHH/h8b6I7fZHw=;
        b=W/1qwlGhjrF247/WJyFTH2DjtdaLUPubmomKpo0VkOAu6ZjZGJD5jhnV2WaGd9uybA
         ny0fqhrP/KIgh16Qxi4M3gF0Ywzza0cx+m22Bnn+OMhFzXIL5ranQdvg507TNmtclTZc
         2XwZlD1SBpVVw+fzLC+0b84vEqV+3jzUuDX9JLr1HhLcR+mtrQRYEfXWmFi5QULMqPXj
         acBelL/PvXFuIWs6nvMBmUA1QxxUCjG4nje0nspkYHavb0RpXdVn7m/ezEwP/HBGBA/4
         xmlQDLK50v+PWigx1HdUrer703vq38RHsXFPAGqnw6WK+K7GZTsVyAkU/1EVNcHjQ6rM
         i45g==
X-Received: by 10.152.23.6 with SMTP id i6mr12134097laf.24.1400245656256;
        Fri, 16 May 2014 06:07:36 -0700 (PDT)
Received: from localhost ([193.9.244.4])
        by mx.google.com with ESMTPSA id w5sm9518636law.14.2014.05.16.06.07.34
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 May 2014 06:07:34 -0700 (PDT)
X-Google-Original-From: Alexey Shumkin <Alex.Crezoff@gmail.com>
X-Mailer: git-send-email 1.9.2-17
In-Reply-To: <cover.1400242108.git.Alex.Crezoff@gmail.com>
In-Reply-To: <cover.1400242108.git.Alex.Crezoff@gmail.com>
References: <cover.1400242108.git.Alex.Crezoff@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249302>

Pretty format string %<(N,[ml]trunc)>%s truncates subject to a given
length with an appropriate padding. This works for non-ASCII texts when
i18n.logOutputEncoding is UTF-8 only (independently of a printed commit
message encoding) but does not work when i18n.logOutputEncoding is NOT
UTF-8.

In 7e77df3 (pretty: two phase conversion for non utf-8 commits, 2013-04-19)
'format_commit_item' function assumes commit message to be in UTF-8.
And that was so until ecaee80 (pretty: --format output should honor
logOutputEncoding, 2013-06-26) where conversion to logOutputEncoding was
added before calling 'format_commit_message'.

Correct this by converting a commit message to UTF-8 first (as it
assumed in 7e77df3 (pretty: two phase conversion for non utf-8 commits,
2013-04-19)). Only after that set 'output_enc' variable to an actual
logOutputEncoding.

Signed-off-by: Alexey Shumkin <Alex.Crezoff@gmail.com>
---
 pretty.c                      | 7 +++++--
 t/t4205-log-pretty-formats.sh | 8 ++++----
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/pretty.c b/pretty.c
index 6e266dd..7eb43c1 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1500,16 +1500,19 @@ void format_commit_message(const struct commit *commit,
 			   const struct pretty_print_context *pretty_ctx)
 {
 	struct format_commit_context context;
-	const char *output_enc = pretty_ctx->output_encoding;
 	const char *utf8 = "UTF-8";
 
 	memset(&context, 0, sizeof(context));
 	context.commit = commit;
 	context.pretty_ctx = pretty_ctx;
 	context.wrap_start = sb->len;
+	// convert a commit message to UTF-8 first
+	// as far as 'format_commit_item' assumes it in UTF-8
 	context.message = logmsg_reencode(commit,
 					  &context.commit_encoding,
-					  output_enc);
+					  utf8);
+	// then convert to an actual output encoding
+	const char *output_enc = pretty_ctx->output_encoding;
 
 	strbuf_expand(sb, format, format_commit_item, &context);
 	rewrap_message_tail(sb, &context, 0, 0, 0);
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index 6791e0d..7426fe2 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -231,7 +231,7 @@ EOF
 	test_cmp expected actual
 '
 
-test_expect_failure 'left alignment formatting with trunc. i18n.logOutputEncoding' '
+test_expect_success 'left alignment formatting with trunc. i18n.logOutputEncoding' '
 	git -c i18n.logOutputEncoding=iso8859-1 log --pretty="format:%<(10,trunc)%s" >actual &&
 	# complete the incomplete line at the end
 	echo >>actual &&
@@ -257,7 +257,7 @@ EOF
 	test_cmp expected actual
 '
 
-test_expect_failure 'left alignment formatting with ltrunc. i18n.logOutputEncoding' '
+test_expect_success 'left alignment formatting with ltrunc. i18n.logOutputEncoding' '
 	git -c i18n.logOutputEncoding=iso8859-1 log --pretty="format:%<(10,ltrunc)%s" >actual &&
 	# complete the incomplete line at the end
 	echo >>actual &&
@@ -283,7 +283,7 @@ EOF
 	test_cmp expected actual
 '
 
-test_expect_failure 'left alignment formatting with mtrunc. i18n.logOutputEncoding' '
+test_expect_success 'left alignment formatting with mtrunc. i18n.logOutputEncoding' '
 	git -c i18n.logOutputEncoding=iso8859-1 log --pretty="format:%<(10,mtrunc)%s" >actual &&
 	# complete the incomplete line at the end
 	echo >>actual &&
@@ -465,7 +465,7 @@ EOF
 	test_cmp expected actual
 '
 
-test_expect_failure 'left/right alignment formatting with stealing. i18n.logOutputEncoding' '
+test_expect_success 'left/right alignment formatting with stealing. i18n.logOutputEncoding' '
 	git commit --amend -m short --author "long long long <long@me.com>" &&
 	git -c i18n.logOutputEncoding=iso8859-1 log --pretty="format:%<(10,trunc)%s%>>(10,ltrunc)% an" >actual &&
 	# complete the incomplete line at the end
-- 
1.9.2-15
