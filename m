Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 592B520984
	for <e@80x24.org>; Sun, 11 Sep 2016 05:42:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755447AbcIKFmk (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Sep 2016 01:42:40 -0400
Received: from mail-pa0-f67.google.com ([209.85.220.67]:33516 "EHLO
        mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755402AbcIKFmf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Sep 2016 01:42:35 -0400
Received: by mail-pa0-f67.google.com with SMTP id h5so6030603pao.0
        for <git@vger.kernel.org>; Sat, 10 Sep 2016 22:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VS1Ce4Bhxe3LasbrxS70wh1Nt3rhZlo+PGCkYqdNuSY=;
        b=whNsbRYUYSYKwdqAlW0TrlX2ArtOmuPsWbVQf+NzjxFcJE+P7BHxac+Bdt4qgeAjuv
         MvXp42Cgr84ASOT0Qv3FYraAG7xJpC4r8210xax3coUApW1S28rzR3msHmXfuPVAFr48
         fU/WzML+kt9nIkuGqqpFUPGM7tmV8L8V+1ZR4W71X3+I6uwEnI3xVjnLjWGz0ZvBXRbS
         elGHiZgNOcLldAUOODOwL2NWH7rORPjG/H5FLvBJLSMi2BXUjmC5L5ogL2ijhiKpv1fg
         jWtnvdgofzwyyx/p4VDyKKIIMza9me8/2OEeYQ/2sHKW7k8Io4uOd+vpywQQr2i2PK+P
         aZVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VS1Ce4Bhxe3LasbrxS70wh1Nt3rhZlo+PGCkYqdNuSY=;
        b=lmvlEcZidVmnLT9nIula7+TO35KUhS4BzQloqrOo9qxtmCVOf1PiVDsSNuIQ3W5VR1
         G943I/ERDlSEAxTSo7sXE6+aVOnPzcr5PCCJ2h+2AeBkcXxW5xbEVNWVWYEW5kgIfZgO
         2QJk+Ksbjm/8ijId1d4a5bM8uqgpaXsV/aY+Xx5za3PZpvoqH1hpdJaiTHbUPOISYH20
         1Lg0szD8UiRfA3sjG7wY6G4ZS1ICIdJlnc3wWLEHFWfc9/nJDeCNEH11P+rhu0DXBDfF
         ZXcdA7Or5GAQUvvAenQAxrn0b4d3lE0R82V52VQq18J6toAX4zPusuSrgdp6ZR/eeOma
         G+4w==
X-Gm-Message-State: AE9vXwMoC+RCubiq2PnuLRgM9htvma8YE++z26lWq6JzqlP2EbzmNc+f5FjAhOAKDvA0dw==
X-Received: by 10.66.85.196 with SMTP id j4mr21528546paz.40.1473572555115;
        Sat, 10 Sep 2016 22:42:35 -0700 (PDT)
Received: from localhost (c-67-188-214-183.hsd1.ca.comcast.net. [67.188.214.183])
        by smtp.gmail.com with ESMTPSA id w64sm15454288pfb.93.2016.09.10.22.42.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 10 Sep 2016 22:42:34 -0700 (PDT)
From:   Stefan Beller <stefanbeller@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 03/10] diff.c: drop tautologous condition in emit_line_0
Date:   Sat, 10 Sep 2016 22:42:03 -0700
Message-Id: <1473572530-25764-4-git-send-email-stefanbeller@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1473572530-25764-1-git-send-email-stefanbeller@gmail.com>
References: <1473572530-25764-1-git-send-email-stefanbeller@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Stefan Beller <sbeller@google.com>

When `first` equals '\r', then it cannot equal '\n', which makes
`!has_trailing_newline` always true if `first` is '\r'.
Drop that check.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index 156c2aa..9d2e704 100644
--- a/diff.c
+++ b/diff.c
@@ -460,8 +460,7 @@ static void emit_line_0(struct diff_options *o, const char *set, const char *res
 
 	if (len == 0) {
 		has_trailing_newline = (first == '\n');
-		has_trailing_carriage_return = (!has_trailing_newline &&
-						(first == '\r'));
+		has_trailing_carriage_return = (first == '\r');
 		nofirst = has_trailing_newline || has_trailing_carriage_return;
 	} else {
 		has_trailing_newline = (len > 0 && line[len-1] == '\n');
-- 
2.7.4

