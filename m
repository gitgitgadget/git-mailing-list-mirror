Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADFC02070D
	for <e@80x24.org>; Thu,  7 Jul 2016 20:08:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751442AbcGGUIr (ORCPT <rfc822;e@80x24.org>);
	Thu, 7 Jul 2016 16:08:47 -0400
Received: from mout.web.de ([212.227.17.11]:56658 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751193AbcGGUIq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2016 16:08:46 -0400
Received: from [192.168.178.36] ([79.237.54.245]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0LgpJ4-1bfP4i2ByI-00oIjj; Thu, 07 Jul 2016 22:08:38
 +0200
X-Mozilla-News-Host: news://news.gmane.org:119
To:	Git List <git@vger.kernel.org>
Cc:	Junio C Hamano <gitster@pobox.com>
From:	=?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] notes-merge: use O_EXCL to avoid overwriting existing files
Message-ID: <577EB6BE.6090504@web.de>
Date:	Thu, 7 Jul 2016 22:08:30 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:dCqyxAlMFfdI/xpFRznGl+3NpaOVBzQh8luPB7aYqJ0ppQqQtQJ
 9QQBD7NLCJkc0lfvl99/fUPed2ayPCcPxJ98ZzqHFunEETU4st38WGBvA0DuM4Zo7PVbXrh
 9Cg6CK1LO3IZUqXwIWrOY7exTyOFligd5qD/hI3L2Xd258XBPh+IsRnHgUetsGQmVxPCBcQ
 jZ3bYzgrwQGhYHS2W57zw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:a4VEO0qlamg=:MLjxlGRSxy0tUjqNGbnACH
 a+3o/39Mu6Y8f5wuL8jCUyvyHXURn/EHsmPoO6i83sn62TJJQnhEbdOzMD1BsGXkRWXHo6rAT
 E90jX4VJchXdf3gyvZXifu4diPGJeS+Bazc3399zXoyAxw89XDQEIt21upKI6w7u4kIoNwiRJ
 abj3cDMjmZFWxfT6YWKM6U6X8whEdTOZjStdKA1wrEnrfrKoBZb5IJNhVVtjyAk3ka7hLux9e
 tHBUsPFvUsz9YJJcI3A+Cp4K7s8EdvInJqt9IP9EyPgS+LZ5cwpGhUw8mARXrpTDyqENpOrMF
 rbZu603+1uPvw7szJhlptuyUgdRbGlHIL/MWO4Yl8NAv3+bZ86HkHMnwZ2pBp1JAyJqNSVYoM
 qNLECMsy3SXC+43B5n3R2U0xM7vHfcZZJYWF/sBZ2rfmI8TVV/XoXb15fxtkkE9PTgwZ54ng5
 NAOjBHG30c9jgWeIsbfh+BDsDEfgx0u4X7703aKBs4L4WPAgo/qWZODXS1fblBHPh3FbKvvRP
 jXOh6adcMhRgE7H8zi0jYLktPYibS0BRB0KAxY9iBEF6y2QAaUxbleehfVHo2oVF40pIIzjc4
 MKnMeyIdFFuM6+uGO40du/IbZh45kFKxdr0y+KP0bLUzUwB6xrp340Jdcd58lGbONXhmm/OB7
 /vsLDiF6lypoZDjMhz4+kno8ybxV8+kIC1/xRxye/SbyaBtSFgry4cceBiOuSi73L7+505ZE4
 doQv5sS7ycWzOmzuRLomfAktKTP+JohfGzSizLpEyWDBHGLDenpKh9UhPZugXX3M3j9UPZDB1
 xx2ewii
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Use the open(2) flag O_EXCL to ensure the file doesn't already exist
instead of (racily) calling stat(2) through file_exists().  While at it
switch to xopen() to reduce code duplication and get more consistent
error messages.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 notes-merge.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/notes-merge.c b/notes-merge.c
index b7814c9..2b29fc4 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -298,12 +298,8 @@ static void write_buf_to_worktree(const unsigned char *obj,
 	char *path = git_pathdup(NOTES_MERGE_WORKTREE "/%s", sha1_to_hex(obj));
 	if (safe_create_leading_directories_const(path))
 		die_errno("unable to create directory for '%s'", path);
-	if (file_exists(path))
-		die("found existing file at '%s'", path);
 
-	fd = open(path, O_WRONLY | O_TRUNC | O_CREAT, 0666);
-	if (fd < 0)
-		die_errno("failed to open '%s'", path);
+	fd = xopen(path, O_WRONLY | O_EXCL | O_CREAT, 0666);
 
 	while (size > 0) {
 		long ret = write_in_full(fd, buf, size);
-- 
2.9.0

