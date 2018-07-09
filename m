Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C87A31F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 19:25:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754535AbeGITZv (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 15:25:51 -0400
Received: from s019.cyon.net ([149.126.4.28]:33754 "EHLO s019.cyon.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754517AbeGITZv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 15:25:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=drbeat.li;
         s=default; h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=PfPGIij7t9vYiPueWxzkCQDAJGmAOS9LCe4dP5iofF4=; b=Jlak6ka7lbDUd3uTRrIFtpr6Hf
        lXA5JSRpI08MOevw/iJjEHF6oZaSz1A47xsVXYAAHxfu2/9O+nEFFKsmLHXnYQ29K36dmR3fAii+v
        9ufMOIszXz8X2ZrkEDDIC+Y3LqDomn/p687dnSvfdbxqTOHgQnKNdevRtKY6BDCWl5cGURgkp0gZf
        LzAmKREEOzg4y/96Hhlytrs5Ue2TYBRghPoowqYrh0oljDZfHuxM0ZAgj9MSfEs4c9kQZzrTAqs4B
        galHWCRpWGgQq5yt1ZmGb+dILOdyCHa3hOjH3UmfwaSWUeW7r3s8UxqunwZab4sUFnCD+O/Ymrzp3
        25GuYTig==;
Received: from [10.20.10.230] (port=57726 helo=mail.cyon.ch)
        by s019.cyon.net with esmtpa (Exim 4.91)
        (envelope-from <bb@drbeat.li>)
        id 1fcbn8-00Ck0S-Ot; Mon, 09 Jul 2018 21:25:49 +0200
Received: by drbeat.li (Postfix, from userid 1000)
        id 5A7EC22F27; Mon,  9 Jul 2018 21:25:46 +0200 (CEST)
From:   Beat Bolli <dev+git@drbeat.li>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH 0/6] Compile cleanly in pedantic mode
Date:   Mon,  9 Jul 2018 21:25:31 +0200
Message-Id: <20180709192537.18564-1-dev+git@drbeat.li>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9
In-Reply-To: <20180708144342.11922-1-dev+git@drbeat.li>
References: <20180708144342.11922-1-dev+git@drbeat.li>
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s019.cyon.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - drbeat.li
X-Get-Message-Sender-Via: s019.cyon.net: authenticated_id: ig@drbeat.li
X-Authenticated-Sender: s019.cyon.net: ig@drbeat.li
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While developing 6aaded550 ("builtin/config: work around an unsized
array forward declaration", 2018-07-05), I have compiled Git with
CFLAGS="-std=c99 -pedantic".

This series fixes a few compiler warnings when compiling with these
options.

Note that all warnings were produced by -pedantic; the C99 standard
option by itself didn't cause any of them.

The warnings were:

1) Char arrays initialized from a parenthesized string.

        Suppressed by defining USE_PARENS_AROUND_GETTEXT_N to 0
        globally. This was done just to keep the amount of warnings
        manageable; this series leaves that knob alone. The advantage of
        not mistakenly concatenating two translated strings is greater.

2) connect.h, refs/refs-internal.h: Forward reference to an enum.

        Added two #includes that define the enums. This was already
        (inconclusively) talked about in [0].

3) convert.c: Invalid escape sequence "\e".

        Replaced with "\033".

4) sequencer.c: Empty statements at top level.

        Removed the extra semicolons.

5) string-list.c: Forbidden to cast from void * to a function pointer and
   vice versa.

        Encapsulated the function pointer in a context struct. This is
        controversial because it has a performance impact, namely one
        additional pointer dereference per string comparison. An
        alternative might be to use multiple casts via intptr_t. But
        I'm not sure if this is worth the trouble.

6) utf8.c: overflow of char values.

        Used proper char literals for the BOM constants.

This series has patches for 2) to 6).

Regards,
Beat

[0] https://public-inbox.org/git/53ab8626-f862-a732-b369-abeab69a468f@ramsayjones.plus.com/T/


Beat Bolli (6):
  connect.h: avoid forward declaration of an enum
  refs/refs-internal.h: avoid forward declaration of an enum
  convert.c: replace "\e" escapes with "\033".
  sequencer.c: avoid empty statements at top level
  string-list.c: avoid conversion from void * to function pointer
  utf8.c: avoid char overflow

 connect.h            |  2 ++
 convert.c            |  2 +-
 path.h               |  2 +-
 refs/refs-internal.h |  2 ++
 sequencer.c          |  4 ++--
 string-list.c        | 18 ++++++++++++++----
 utf8.c               |  8 ++++----
 7 files changed, 26 insertions(+), 12 deletions(-)


Interdiff from the RFC series:

diff --git a/path.h b/path.h
index 1ccd0373c9..fc9d3487a0 100644
--- a/path.h
+++ b/path.h
@@ -147,7 +147,7 @@ extern void report_linked_checkout_garbage(void);
 /*
  * You can define a static memoized git path like:
  *
- *    static GIT_PATH_FUNC(git_path_foo, "FOO");
+ *    static GIT_PATH_FUNC(git_path_foo, "FOO")
  *
  * or use one of the global ones below.
  */
diff --git a/utf8.c b/utf8.c
index 833ce00617..982217eec9 100644
--- a/utf8.c
+++ b/utf8.c
@@ -561,15 +561,15 @@ char *reencode_string_len(const char *in, int insz,
 #endif

 static int has_bom_prefix(const char *data, size_t len,
-                         const unsigned char *bom, size_t bom_len)
+                         const char *bom, size_t bom_len)
 {
        return data && bom && (len >= bom_len) && !memcmp(data, bom, bom_len);
 }

-static const unsigned char utf16_be_bom[] = {0xFE, 0xFF};
-static const unsigned char utf16_le_bom[] = {0xFF, 0xFE};
-static const unsigned char utf32_be_bom[] = {0x00, 0x00, 0xFE, 0xFF};
-static const unsigned char utf32_le_bom[] = {0xFF, 0xFE, 0x00, 0x00};
+static const char utf16_be_bom[] = {'\xFE', '\xFF'};
+static const char utf16_le_bom[] = {'\xFF', '\xFE'};
+static const char utf32_be_bom[] = {'\0', '\0', '\xFE', '\xFF'};
+static const char utf32_le_bom[] = {'\xFF', '\xFE', '\0', '\0'};

 int has_prohibited_utf_bom(const char *enc, const char *data, size_t len)
 {

-- 
2.18.0.203.gfac676dfb9
