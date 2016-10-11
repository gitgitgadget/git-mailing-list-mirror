Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1AEB820989
	for <e@80x24.org>; Tue, 11 Oct 2016 00:22:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752812AbcJKAVy (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 20:21:54 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:35488 "EHLO
        mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752690AbcJKAVw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 20:21:52 -0400
Received: by mail-pa0-f48.google.com with SMTP id qn10so3906287pac.2
        for <git@vger.kernel.org>; Mon, 10 Oct 2016 17:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vrMZxc3OoB+Ye34JAMBdF4fsyAtTpZUf1C9QUH4+C1c=;
        b=Hc2SzzBYQtcmf7Kw4MK8/6Z4WHQdCvuTEpelVoo9xRp+K6TztKjONp1CZwH99CNp0J
         DtDBh1Z9xLw0MwO3EBakGhgwPifSuc570SakmjhtKbOcKZ/PzNjzCJ6PpIxBZcg4z9A8
         O5vtjcioXv8Fbn7Zlj4XQtSvAf+CBt7WbJvXIdAuqy607fUm/OY0tYnu4mdHeDzafeYc
         h78qvWhuZFA+ex/v2w6MMxmsoCj32+T5VUU/kJAijDv/HFH3uJA8/SPhCyw+2E9Qgz4u
         gwvN5QbiznLlqgNuFdqB/HmIzWnyQijoZU9X3/vcRIDsLdS0X4Ng1n8ciTVaHGfC5ONZ
         hWTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vrMZxc3OoB+Ye34JAMBdF4fsyAtTpZUf1C9QUH4+C1c=;
        b=S4Iwntxpz0hX13j6CcbYsNpvNS6qH5Z4SZ/0UA3YDmChrfHmGKldqR0btvE/h9hzBg
         gnZYnDjyPXNvHlgzrsW/REDmOoIBb8oGCw8piKfAE1neGA4yo/jQpg+EE2wINgKsEhW7
         OrPS6YNEHCH8cDtyHfFkHBMsOBDN9mewZW3pd6qYbzYpxFKSssUrBhkhXQd2CII/pbmx
         DVhuYKg+mGapxoxEXI9v/r0M01jX7vkiRAQR9yw15oqXBdRiF5S/W/jHWQ8RNHZFx+GF
         +8h1AoAwx8H0oswqTuOQffKV7MJ0czayoUARDzf9TrCfBTCjwzmBw8IkKxWijQdab7ga
         2Ufw==
X-Gm-Message-State: AA6/9Rn1MuM6HmYyBHn/zdPlZwxktJsiB9eqzwH+85G1A7BhRUrlnvQeIiofEhWN4PZnJKtm
X-Received: by 10.66.10.102 with SMTP id h6mr1773900pab.112.1476145311304;
        Mon, 10 Oct 2016 17:21:51 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:b8ee:61f5:e989:77a7])
        by smtp.gmail.com with ESMTPSA id f1sm528143pff.34.2016.10.10.17.21.50
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 10 Oct 2016 17:21:50 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, pclouds@gmail.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 16/28] attr: add counted string version of git_attr()
Date:   Mon, 10 Oct 2016 17:21:03 -0700
Message-Id: <20161011002115.23312-17-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.382.ga23ca1b.dirty
In-Reply-To: <20161011002115.23312-1-sbeller@google.com>
References: <20161011002115.23312-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

Often a potential caller has <name, namelen> pair that
represents the name it wants to create an attribute out of.

When name[namelen] is not NUL, the caller has to xmemdupz()
only to call git_attr().

Add git_attr_counted() that takes such a counted string instead of
"const char *name".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 attr.c | 8 ++++----
 attr.h | 5 ++++-
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/attr.c b/attr.c
index 9bec243..90dbacd 100644
--- a/attr.c
+++ b/attr.c
@@ -78,7 +78,7 @@ static int invalid_attr_name(const char *name, int namelen)
 	return 0;
 }
 
-static struct git_attr *git_attr_internal(const char *name, int len)
+struct git_attr *git_attr_counted(const char *name, size_t len)
 {
 	unsigned hval = hash_name(name, len);
 	unsigned pos = hval % HASHSIZE;
@@ -109,7 +109,7 @@ static struct git_attr *git_attr_internal(const char *name, int len)
 
 struct git_attr *git_attr(const char *name)
 {
-	return git_attr_internal(name, strlen(name));
+	return git_attr_counted(name, strlen(name));
 }
 
 /* What does a matched pattern decide? */
@@ -199,7 +199,7 @@ static const char *parse_attr(const char *src, int lineno, const char *cp,
 		else {
 			e->setto = xmemdupz(equals + 1, ep - equals - 1);
 		}
-		e->attr = git_attr_internal(cp, len);
+		e->attr = git_attr_counted(cp, len);
 	}
 	return ep + strspn(ep, blank);
 }
@@ -254,7 +254,7 @@ static struct match_attr *parse_attr_line(const char *line, const char *src,
 		      sizeof(struct attr_state) * num_attr +
 		      (is_macro ? 0 : namelen + 1));
 	if (is_macro) {
-		res->u.attr = git_attr_internal(name, namelen);
+		res->u.attr = git_attr_counted(name, namelen);
 		res->u.attr->maybe_macro = 1;
 	} else {
 		char *p = (char *)&(res->state[num_attr]);
diff --git a/attr.h b/attr.h
index c84f164..bcedf92 100644
--- a/attr.h
+++ b/attr.h
@@ -8,7 +8,10 @@ struct git_attr;
  * Given a string, return the gitattribute object that
  * corresponds to it.
  */
-struct git_attr *git_attr(const char *);
+extern struct git_attr *git_attr(const char *);
+
+/* The same, but with counted string */
+extern struct git_attr *git_attr_counted(const char *, size_t);
 
 /* Internal use */
 extern const char git_attr__true[];
-- 
2.10.1.382.ga23ca1b.dirty

