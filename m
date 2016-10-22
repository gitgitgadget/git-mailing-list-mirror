Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0612820986
	for <e@80x24.org>; Sat, 22 Oct 2016 23:33:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964984AbcJVXdH (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Oct 2016 19:33:07 -0400
Received: from mail-it0-f43.google.com ([209.85.214.43]:35958 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935666AbcJVXdD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Oct 2016 19:33:03 -0400
Received: by mail-it0-f43.google.com with SMTP id e187so74369895itc.1
        for <git@vger.kernel.org>; Sat, 22 Oct 2016 16:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=R6uQ7A5oiJGISMtq0y4wMBIe4oTldEHkBmjgeg+HVBs=;
        b=D9o0HA5EdEKmbWiSleM4XV4TNyfj4xY7LqRLZbY6InSvBuuR6mQ3UKPXRHUY8JgJLx
         nbIh7Fr+EH3hHIlTdkOs23xpwjbb4+Yd5de7AO4e2zxUHfM5f+VvfK6Dw/86I8fhTUmV
         czpTfE3/o0lJA5cBmTOoqSHYKobRSXGC0LBQsR8KpIDz9B7J3Z+51c8HnHHCTjWIDqed
         Xn+QiXN1k2KW1c0JyUJdOTG1FJCYLa8+JcBSQ4TLG2hXJVNN4EQut7wza93KocGDHp31
         XmJ4FYCfjclDgDFB++LIYedANA4KJOSvTEa2VHvVL0Qq77bmUQ9maW8QcIdiH01szuMh
         6Mow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=R6uQ7A5oiJGISMtq0y4wMBIe4oTldEHkBmjgeg+HVBs=;
        b=XnicsicHp1XKzZvL7y4sLqWaDepa6Aj4tiO2bAFHg1N8k64TNHPoRLGg39GmRRnfiL
         0/SPJD5y4mrDjreEBkDf9aZsW9w1AyKgEOXnIvbsipIbpVf8kg1lVzDc2WP/1YMbBUAW
         7USX3MtyvzVrTFyXKu41meqY2bXMijuT2kYf7wpSv6LnDY72m15rMaCLU87tjUzGN0OV
         C/3nhwoWTJROzfmQpKeT1pDfyzFMgYOq6B7r4eHC4Goak5vF5lQ3Cz1EESlOxTUK+TG4
         RDdEXgOe/5YLBgk0ZOEmScedDYAqO7xJXRj4I6/uySZTiI4FLd4F8s7aYxUotoc4eL0q
         d1Sg==
X-Gm-Message-State: ABUngvdbo7nwCsDhHCH00T7XzcWez4P0RMPtVlUN4+n6uO24cbtjd4PV0JdO9vPM9sCYaV/u
X-Received: by 10.107.51.82 with SMTP id z79mr7027899ioz.225.1477179182924;
        Sat, 22 Oct 2016 16:33:02 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:4ca0:b1d9:cc22:1c7b])
        by smtp.gmail.com with ESMTPSA id 138sm1971045ith.7.2016.10.22.16.33.02
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 22 Oct 2016 16:33:02 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, pclouds@gmail.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 16/36] attr: add counted string version of git_attr()
Date:   Sat, 22 Oct 2016 16:32:05 -0700
Message-Id: <20161022233225.8883-17-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.508.g6572022
In-Reply-To: <20161022233225.8883-1-sbeller@google.com>
References: <20161022233225.8883-1-sbeller@google.com>
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
2.10.1.508.g6572022

