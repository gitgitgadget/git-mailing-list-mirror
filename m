Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75BAF1FBB0
	for <e@80x24.org>; Fri,  2 Sep 2016 19:58:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932565AbcIBT6v (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Sep 2016 15:58:51 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:33903 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932403AbcIBT6u (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2016 15:58:50 -0400
Received: by mail-pf0-f175.google.com with SMTP id p64so45340019pfb.1
        for <git@vger.kernel.org>; Fri, 02 Sep 2016 12:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=jwCWzFl0sFCmHoOiW1a4J+pogG1mrs/EfZ5LUQRmVJI=;
        b=cWJjxsmvxfdCXL4+alZ9dbrGzW39y5Z/vhVLhRPm5oarIONKatLkwi3TOTeZePJ1Oy
         tZ47Gv/oh2Qj7YcWMOu/s/pNLIOVTLRqcDoBMfVYFyKKZI/wvOdRH6Y9FbZy/XsoJv+A
         tUnmVUkgm2ycKABGMAMXYtnB3kRP4lVNluklLvMb0f3gU4vV9RMDIzGwgXS0iNqJq/Pq
         LBXf32aKkxBL+DPSrHa4rSXOr95BYyKXnrp+y1hof9yzJlXueNFRXh5DOOJMs25hRMwn
         7+1a83Q5QWdZRfzhcWeoXb+8s3KSajcuxCbZ50d2ji66Gc2no9bN5fCHVe9aOgscUXHy
         79Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jwCWzFl0sFCmHoOiW1a4J+pogG1mrs/EfZ5LUQRmVJI=;
        b=Ldrgl6cpf6zJ9FycK6kOOSH5KhyFzD7LoZCRFU+FMl09yPn8o57BKKoShcMalFLIIe
         cXQ02OS30mULyqcPb5tDZcM+W9ZhTxvaE9W3H4ePyLabD4nCum+9DxR8LeASlgCKZPf3
         mDVrNbqtyEPholkwtsKLhpZyd5NJwOgjJ2cNGSGBuyo/ATPtsxKcPRsSD8umrmdqlWsF
         +gV9FiX+GlIF6LJhno0EM33GXTfMbjeOto3001b6NijzUK+7C7DFZMeMkoyz2kBpdq3z
         DuLFeeQ6tejEffJu1JkmtAAGac6u2pQdBYBB3Dc5r7J9qlK3wLxH40RKXeC9tCAgLK31
         jHlg==
X-Gm-Message-State: AE9vXwMqGn+6xoeXRs0pzREkdX8AHCtcDgYbjV7LQ1QMYJk8I8cdIuWpjqUqbjz3Nnq5GIcc
X-Received: by 10.98.144.21 with SMTP id a21mr10532082pfe.24.1472846329629;
        Fri, 02 Sep 2016 12:58:49 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([100.96.238.21])
        by smtp.gmail.com with ESMTPSA id 84sm16693505pfp.59.2016.09.02.12.58.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 02 Sep 2016 12:58:48 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH] sequencer: support folding in rfc2822 footer
Date:   Fri,  2 Sep 2016 12:58:42 -0700
Message-Id: <1472846322-5592-1-git-send-email-jonathantanmy@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When running `git cherry-pick -x`, a blank line would be inserted if a line in
the footer was broken into multiple lines (which is inconsistent with its
behavior if no lines were broken). For example, this command would produce:

---
Sample-field: no blank line below
(cherry picked from commit ...)
---

but would also produce:

---
Sample-field: multiple-line field body
 that causes a blank line below

(cherry picked from commit ...)
---

This, among other things, trips up tools that look for the last paragraph
(including sequencer.c itself).

RFC 2822 allows field bodies to be split into multiple lines, especially (but
not only) to deal with the line-width limitations described in the
specification, referring to this as "folding".

Teach sequencer.c to treat split and unsplit field bodies in the same way (that
is, to not include the blank line).

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 sequencer.c              | 19 +++++++++++++++++--
 t/t3511-cherry-pick-x.sh | 19 +++++++++++++++++++
 2 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 3804fa9..411dd50 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -26,10 +26,20 @@ static GIT_PATH_FUNC(git_path_opts_file, SEQ_OPTS_FILE)
 static GIT_PATH_FUNC(git_path_seq_dir, SEQ_DIR)
 static GIT_PATH_FUNC(git_path_head_file, SEQ_HEAD_FILE)
 
-static int is_rfc2822_line(const char *buf, int len)
+static int is_rfc2822_line(const char *buf, int len,
+			   int allow_folding_continuation)
 {
 	int i;
 
+	/*
+	 * Section 2.2.3 of RFC 2822 allows field bodies to continue onto
+	 * multiple lines, referred to as "folding". Such continuation lines
+	 * start with whitespace.
+	 */
+	if (allow_folding_continuation)
+		if (len && (buf[0] == ' ' || buf[0] == '\t'))
+			return 1;
+
 	for (i = 0; i < len; i++) {
 		int ch = buf[i];
 		if (ch == ':')
@@ -64,6 +74,7 @@ static int has_conforming_footer(struct strbuf *sb, struct strbuf *sob,
 	int len = sb->len - ignore_footer;
 	const char *buf = sb->buf;
 	int found_sob = 0;
+	int allow_folding_continuation = 0;
 
 	/* footer must end with newline */
 	if (!len || buf[len - 1] != '\n')
@@ -92,7 +103,11 @@ static int has_conforming_footer(struct strbuf *sb, struct strbuf *sob,
 			; /* do nothing */
 		k++;
 
-		found_rfc2822 = is_rfc2822_line(buf + i, k - i - 1);
+		found_rfc2822 = is_rfc2822_line(buf + i,
+				                k - i - 1,
+				                allow_folding_continuation);
+		allow_folding_continuation = 1;
+
 		if (found_rfc2822 && sob &&
 		    !strncmp(buf + i, sob->buf, sob->len))
 			found_sob = k;
diff --git a/t/t3511-cherry-pick-x.sh b/t/t3511-cherry-pick-x.sh
index 9cce5ae..1a50339 100755
--- a/t/t3511-cherry-pick-x.sh
+++ b/t/t3511-cherry-pick-x.sh
@@ -36,6 +36,11 @@ mesg_with_cherry_footer="$mesg_with_footer_sob
 (cherry picked from commit da39a3ee5e6b4b0d3255bfef95601890afd80709)
 Tested-by: C.U. Thor <cuthor@example.com>"
 
+mesg_with_folding_footer="$mesg_no_footer
+
+Field: This is a very long field body
+ that is continued onto another line"
+
 mesg_unclean="$mesg_one_line
 
 
@@ -68,6 +73,8 @@ test_expect_success setup '
 	git reset --hard initial &&
 	test_commit "$mesg_with_cherry_footer" foo b mesg-with-cherry-footer &&
 	git reset --hard initial &&
+	test_commit "$mesg_with_folding_footer" foo b mesg-with-folding-footer &&
+	git reset --hard initial &&
 	test_config commit.cleanup verbatim &&
 	test_commit "$mesg_unclean" foo b mesg-unclean &&
 	test_unconfig commit.cleanup &&
@@ -234,6 +241,18 @@ test_expect_success 'cherry-pick -x -s treats "(cherry picked from..." line as p
 	test_cmp expect actual
 '
 
+test_expect_success 'cherry-pick -x does not insert blank line when folding footer is found' '
+	pristine_detach initial &&
+	sha1=$(git rev-parse mesg-with-folding-footer^0) &&
+	git cherry-pick -x mesg-with-folding-footer &&
+	cat <<-EOF >expect &&
+		$mesg_with_folding_footer
+		(cherry picked from commit $sha1)
+	EOF
+	git log -1 --pretty=format:%B >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'cherry-pick preserves commit message' '
 	pristine_detach initial &&
 	printf "$mesg_unclean" >expect &&
-- 
2.8.0.rc3.226.g39d4020

