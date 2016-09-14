Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B03791FCA9
	for <e@80x24.org>; Thu, 15 Sep 2016 00:00:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1764231AbcIOAAd (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Sep 2016 20:00:33 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:35307 "EHLO
        mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1763763AbcIOAAc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Sep 2016 20:00:32 -0400
Received: by mail-pa0-f48.google.com with SMTP id oz2so5485151pac.2
        for <git@vger.kernel.org>; Wed, 14 Sep 2016 17:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2SByAs8Q5Y2w8RC7vRWz42+uSfZgRMAWpEA1N6vmrRE=;
        b=YjcsIqaRo9w7Q6vQYWG9ulu2DBIGFuOtcWPqXk9ljoxr6xb1dTbywzPV8HOuoqPVYG
         6rhcAjIv9vUB1JIjl7xlSnRW/UZnjCWeMJAH2Vb/QVaOngSN1GO0caZQ1FBcxsNaJRH/
         I7yVZN4PcSKyZe0btR8oeTd4HXXrACD+4YrZpxLWPkCrpkhkLbv3Z+IaPE/vdbaSKVwp
         ZPtNiFYTTL3d6w+F0wcEiIzYrCXToDQgrbughKWzBx1x3Q1Y3uOSvZHCDg/2noXAFIeP
         BjR9o6NwqxCsd5hvEbG0RzRYGfBRT5Ql5W8rRY7sWUlprarw4s+iA3I87J05nTmO9yjG
         SZ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2SByAs8Q5Y2w8RC7vRWz42+uSfZgRMAWpEA1N6vmrRE=;
        b=hvJcDwQFrP+8CGMpUiZ2WLP7A7wcfTnOWnFcYnY31PrlLzHCHWFatxkPh/bV5dhBYd
         rPr/NmI+I0D7yDB8NV/E7bM1icGV2Bvu5tUNQsXl6OMPrnes7crOIowPJUv/JbZR4bKY
         oPkz+R63vkKCj0HemtbiyOrzxkBIZNjD5uuDdjOmgZ+BIMslMERY3ei089aS85g2lGzy
         AErw76l+zb3vFtWSkYNBLWONwQqOjxeteql5N3vJbKi0y8ZaabpA2AL7yTJ3SPL7ub9g
         2/2H5WpO4lBMBmxgwZNrsqPu5/ApjgtUj39LKBTtmMPL1I4LiJWyBcjFrxDGGinK/L0W
         a+LQ==
X-Gm-Message-State: AE9vXwNZgZB44Ta4ZOTQ6YI3z2u+5tV94QoyGTNgkjyYxYR7ZgYAKqZdD1GWYaNQT1k7H+Ms
X-Received: by 10.66.127.14 with SMTP id nc14mr9394354pab.18.1473897626510;
        Wed, 14 Sep 2016 17:00:26 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:9d02:b75:eb8f:7e1])
        by smtp.gmail.com with ESMTPSA id t21sm40463597pfa.71.2016.09.14.17.00.25
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 14 Sep 2016 17:00:25 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org, pclouds@gmail.com
Cc:     Brandon Williams <bmwill@google.com>
Subject: [RFC] extending pathspec support to submodules
Date:   Wed, 14 Sep 2016 16:57:53 -0700
Message-Id: <1473897473-154528-1-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---
I've been trying to think through how we could potentially add pathspec support
for --recurse-submodule options (for builtins like ls-files or grep down the
line).  This is something that could be useful if the user supply's a pathspec
that could match to a file in a submodule.  We could match the submodule to the
pathspec and then fork the process to recursively run the command on the
submodule which can be passed a modified pathspec.

For example with a pathspec 'sub/dir/a', where sub is a submodule in the root
directory of the supermodule's repo, we could match 'sub' to that spec and then
recursively call the git command with a pathspec of 'dir/a'.  The child process
would then have the responsibility of matching 'dir/a' to files in its repo.

Does this seem like a reasonable feature to add? And if so are how is my
initial approach at solving the problem?

One idea I had was to add a submodule match flag in order to perform special
matching just in the --recurse-submodules cases since we'll want somethings to
match here that wouldn't normally match.

@@ -283,6 +284,29 @@ static int match_pathspec_item(const struct pathspec_item *item, int prefix,
 			 item->nowildcard_len - prefix))
 		return MATCHED_FNMATCH;
 
+	/*
+	 * Preform some checks to see if "name" is a super set of the pathspec
+	 */
+	if (flags & DO_MATCH_SUBMODULE) {
+		struct strbuf buf = STRBUF_INIT;
+		strbuf_addstr(&buf, name);
+		strbuf_addch(&buf, '/');
+		/*
+		 * Check if the name is a prefix of the pathspec
+		 */
+		if ((item->match[namelen] == '/') &&
+		    !ps_strncmp(item, match, name, namelen))
+			return MATCHED_RECURSIVELY;
+		/*
+		 * Check if the name wildmatches to the pathspec
+		 */
+		if (!wildmatch(item->match, buf.buf,
+			       WM_PREFIX |
+			       (item->magic & PATHSPEC_ICASE ? WM_CASEFOLD : 0),
+			       NULL));
+		    return MATCHED_FNMATCH;
+	}
+
 	return 0;
 }
 
One of the main difficulties I was having is figuring out how wildmatching
should be applied in this case.  What I believe we want is the ability for the
whole name of the submodule to match a prefix of the pathspec pattern.  To do
this I was thinking of adding a flag to do prefix matching to the wildmatch
function like so: 


diff --git a/wildmatch.c b/wildmatch.c
index 57c8765..f1e1725 100644
--- a/wildmatch.c
+++ b/wildmatch.c
@@ -60,8 +60,12 @@ static int dowild(const uchar *p, const uchar *text, unsigned int flags)
 	for ( ; (p_ch = *p) != '\0'; text++, p++) {
 		int matched, match_slash, negated;
 		uchar t_ch, prev_ch;
-		if ((t_ch = *text) == '\0' && p_ch != '*')
-			return WM_ABORT_ALL;
+		if ((t_ch = *text) == '\0' && p_ch != '*') {
+			if ((flags & WM_PREFIX) && (*(p-1) == '/'))
+				return WM_MATCH;
+			else
+				return WM_ABORT_ALL;
+		}
 		if ((flags & WM_CASEFOLD) && ISUPPER(t_ch))
 			t_ch = tolower(t_ch);
 		if ((flags & WM_CASEFOLD) && ISUPPER(p_ch))
diff --git a/wildmatch.h b/wildmatch.h
index 4090c8f..490db51 100644
--- a/wildmatch.h
+++ b/wildmatch.h
@@ -3,6 +3,7 @@
 
 #define WM_CASEFOLD 1
 #define WM_PATHNAME 2
+#define WM_PREFIX 4
 
 #define WM_ABORT_MALFORMED 2
 #define WM_NOMATCH 1
-- 

Any comments or thoughts on this would be appreciated.

Thanks,
Brandon
