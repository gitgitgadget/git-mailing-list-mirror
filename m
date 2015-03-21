From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 05/15] builtin/apply.c: fix a memleak
Date: Fri, 20 Mar 2015 17:28:02 -0700
Message-ID: <1426897692-18322-6-git-send-email-sbeller@google.com>
References: <1426897692-18322-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Mar 21 01:28:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZ7HD-0001gw-LV
	for gcvg-git-2@plane.gmane.org; Sat, 21 Mar 2015 01:28:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752298AbbCUA20 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 20:28:26 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:34900 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752284AbbCUA2X (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2015 20:28:23 -0400
Received: by igcau2 with SMTP id au2so1634648igc.0
        for <git@vger.kernel.org>; Fri, 20 Mar 2015 17:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dBftwcjofDXeH0mhYtoiAR1VsnB0g/WGKJTjx5hKMdM=;
        b=o572Pj6l87loO4F39cYqztjAsCCPm/THu0ghDVvbRR/5nfm8ZtnLDsbUywqpD+pcGk
         WlRRTEEb9jRZDg2aCeCQzsym3PRlCRLKhwORce0JYh5TCTm1W8CwLyHv76MbQ25jK3VY
         FIuzUSCc/YP6mIWNP6pH+VPm4Y4kiF5LvrFM0gz6DQuSiu2U1cZPzITTZEHfGlamf8Pc
         sj3N8Bs7Y6sAkj4sJZ5SoLlpQ0mId0bsRd5z9fHTxUTihGTNWDeMzeZwMM15Mkrg4Uul
         LTfKvgn0eW3NX/09tTx6U2Mb5v4nunRKrQ1+KwBCBe38Y78VIWp+OJ7u9PZGAV8QJTYH
         6wOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dBftwcjofDXeH0mhYtoiAR1VsnB0g/WGKJTjx5hKMdM=;
        b=SrOJeTASa4rudwDiTgORgXvfcSWk0WFF3Y3QzxxhimBevLgoYV3SXzmT2v/0zWVSMb
         BkaeLXki5AHNiFbd6/7RjuZ5CO8Bi+7k89FYbFUShkhF4s3R1RbcM+Gtixpgw1Pa2QeS
         6ZaTvjNNM8oFEE8cfjrGfW8OoF+QFLCQnVRtYt7uRSIYtTdYO/jukS0p3nVzWUA7O4v/
         X0GWQ1T2m2PQ/PMun9honExQZ4MUbwvaSzVseZ1P3vOjs6Yil/iuOgE7hZwrhg5Lv99W
         MhLk1XCrIvT6W9DbxHQ6oh5NX0lchj1quY0ioO+Pf3drv92LjorAaZwB7bDPHpsC9nne
         Vihg==
X-Gm-Message-State: ALoCoQl2AeQbq8YFIYlxMJnewxFIhmExyVAAQOuuAAXn8HGU4m8vj9vM0mMKRt5YQktQfROIt1yo
X-Received: by 10.50.136.226 with SMTP id qd2mr493144igb.26.1426897703168;
        Fri, 20 Mar 2015 17:28:23 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:c4ad:7c66:d5e8:7112])
        by mx.google.com with ESMTPSA id e3sm165160igg.16.2015.03.20.17.28.22
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 20 Mar 2015 17:28:22 -0700 (PDT)
X-Mailer: git-send-email 2.3.0.81.gc37f363
In-Reply-To: <1426897692-18322-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265982>

oldlines is allocated earlier in the function and also freed on the
successful code path.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/apply.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/apply.c b/builtin/apply.c
index 65b97ee..e152c4d 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -2776,6 +2776,7 @@ static int apply_one_fragment(struct image *img, struct fragment *frag,
 		default:
 			if (apply_verbosely)
 				error(_("invalid start of line: '%c'"), first);
+			free(oldlines);
 			return -1;
 		}
 		if (added_blank_line) {
-- 
2.3.0.81.gc37f363
