Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E52ADC433B4
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 21:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFE41613DA
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 21:18:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239362AbhD0VTc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Apr 2021 17:19:32 -0400
Received: from mav.lukeshu.com ([104.207.138.63]:41696 "EHLO mav.lukeshu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239274AbhD0VTU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Apr 2021 17:19:20 -0400
Received: from lukeshu-dw-thinkpad (unknown [IPv6:2601:281:8200:26:4e34:88ff:fe48:5521])
        by mav.lukeshu.com (Postfix) with ESMTPSA id 40BE780592;
        Tue, 27 Apr 2021 17:18:35 -0400 (EDT)
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
Subject: [PATCH v3 18/30] subtree: use "$*" instead of "$@" as appropriate
Date:   Tue, 27 Apr 2021 15:17:36 -0600
Message-Id: <20210427211748.2607474-19-lukeshu@lukeshu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210427211748.2607474-1-lukeshu@lukeshu.com>
References: <20210426174525.3937858-1-lukeshu@lukeshu.com>
 <20210427211748.2607474-1-lukeshu@lukeshu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Luke Shumaker <lukeshu@datawire.io>

"$*" is for when you want to concatenate the args together,
whitespace-separated; and "$@" is for when you want them to be separate
strings.

There are several places in subtree that erroneously use $@ when
concatenating args together into an error message.

For instance, if the args are argv[1]="dead" and argv[2]="beef", then
the line

    die "You must provide exactly one revision.  Got: '$@'"

surely intends to call 'die' with the argument

    argv[1]="You must provide exactly one revision.  Got: 'dead beef'"

however, because the line used $@ instead of $*, it will actually call
'die' with the arguments

    argv[1]="You must provide exactly one revision.  Got: 'dead"
    argv[2]="beef'"

This isn't a big deal, because 'die' concatenates its arguments together
anyway (using "$*").  But that doesn't change the fact that it was a
mistake to use $@ instead of $*, even though in the end $@ still ended
up doing the right thing.

Signed-off-by: Luke Shumaker <lukeshu@datawire.io>
---
v2:
 - Improve the commit message with quoting and clearer
   explanation.

 contrib/subtree/git-subtree.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index d7de4b0653..3105eb8033 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -58,14 +58,14 @@ progress () {
 assert () {
 	if ! "$@"
 	then
-		die "assertion failed: " "$@"
+		die "assertion failed: $*"
 	fi
 }
 
 ensure_single_rev () {
 	if test $# -ne 1
 	then
-		die "You must provide exactly one revision.  Got: '$@'"
+		die "You must provide exactly one revision.  Got: '$*'"
 	fi
 }
 
@@ -690,7 +690,7 @@ cmd_add () {
 
 		cmd_add_repository "$@"
 	else
-		say >&2 "error: parameters were '$@'"
+		say >&2 "error: parameters were '$*'"
 		die "Provide either a commit or a repository and commit."
 	fi
 }
-- 
2.31.1

