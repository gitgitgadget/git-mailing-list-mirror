Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4908C43462
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 17:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74022611C1
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 17:48:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237718AbhDZRtA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Apr 2021 13:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237643AbhDZRsl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Apr 2021 13:48:41 -0400
Received: from mav.lukeshu.com (mav.lukeshu.com [IPv6:2001:19f0:5c00:8069:5400:ff:fe26:6a86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F9CC06138F
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 10:47:57 -0700 (PDT)
Received: from lukeshu-dw-thinkpad (unknown [IPv6:2601:281:8200:26:4e34:88ff:fe48:5521])
        by mav.lukeshu.com (Postfix) with ESMTPSA id E5ABF80599;
        Mon, 26 Apr 2021 13:47:56 -0400 (EDT)
From:   Luke Shumaker <lukeshu@lukeshu.com>
To:     git@vger.kernel.org
Cc:     Avery Pennarun <apenwarr@gmail.com>,
        Charles Bailey <cbailey32@bloomberg.net>,
        Danny Lin <danny0838@gmail.com>,
        "David A . Greene" <greened@obbligato.org>,
        David Aguilar <davvid@gmail.com>,
        Jakub Suder <jakub.suder@gmail.com>,
        James Denholm <nod.helm@gmail.com>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Roger L Strain <roger.strain@swri.org>,
        Techlive Zheng <techlivezheng@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Luke Shumaker <lukeshu@datawire.io>
Subject: [PATCH v2 24/30] subtree: don't let debug and progress output clash
Date:   Mon, 26 Apr 2021 11:45:19 -0600
Message-Id: <20210426174525.3937858-25-lukeshu@lukeshu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210426174525.3937858-1-lukeshu@lukeshu.com>
References: <20210423194230.1388945-1-lukeshu@lukeshu.com>
 <20210426174525.3937858-1-lukeshu@lukeshu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Luke Shumaker <lukeshu@datawire.io>

Currently, debug output (triggered by passing '-d') and progress output
stomp on each other.  The debug output is just streamed as lines to
stderr, and the progress output is sent to stderr as '%s\r'.  When
writing to a file, it is awkward to read and difficult to distinguish
between the debug output and a progress line.  When writing to a
terminal the debug lines hide progress lines.

So, when '-d' has been passed, spit out progress as 'progress: %s\n',
instead of as '%s\r', so that it can be detected, and so that the debug
lines don't overwrite the progress when written to a terminal.

Signed-off-by: Luke Shumaker <lukeshu@datawire.io>
---
v2:
 - Reword the commit message to be clearer.
 - Add comments to the code.
 - Flip the `if` and `else` cases around, so that the comments
   read better.

 contrib/subtree/git-subtree.sh | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 441571c85a..53a1a025f5 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -67,7 +67,27 @@ debug () {
 progress () {
 	if test -z "$GIT_QUIET"
 	then
-		printf "%s\r" "$*" >&2
+		if test -z "$arg_debug"
+		then
+			# Debug mode is off.
+			#
+			# Print one progress line that we keep updating (use
+			# "\r" to return to the beginning of the line, rather
+			# than "\n" to start a new line).  This only really
+			# works when stderr is a terminal.
+			printf "%s\r" "$*" >&2
+		else
+			# Debug mode is on.  The `debug` function is regularly
+			# printing to stderr.
+			#
+			# Don't do the one-line-with-"\r" thing, because on a
+			# terminal the debug output would overwrite and hide the
+			# progress output.  Add a "progress:" prefix to make the
+			# progress output and the debug output easy to
+			# distinguish.  This ensures maximum readability whether
+			# stderr is a terminal or a file.
+			printf "progress: %s\n" "$*" >&2
+		fi
 	fi
 }
 
-- 
2.31.1

