Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81F901F576
	for <e@80x24.org>; Tue, 13 Feb 2018 10:33:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934167AbeBMKdA (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Feb 2018 05:33:00 -0500
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:28590 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934008AbeBMKc6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Feb 2018 05:32:58 -0500
Received: from lindisfarne.localdomain ([92.22.21.220])
        by smtp.talktalk.net with SMTP
        id lXtIeSz2sr5N9lXtPeMEfE; Tue, 13 Feb 2018 10:32:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1518517975;
        bh=7U9MrrW2QsFdvS3/n+2J0WELEyj8KNAAkaOHAJu5HsU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=EolBPdWIWtMO4qUp0PqDiF0Lv0TB3XuGf3ZsQZbciSQ+yh5ivzV8q+2sohuHbd7OR
         j3xCstnl6n7KRCIn6Ll9kmafJ6nXEu/HjzYe4Js4v2YV1jB4ObyvLmEuXnJdBzb3+b
         eIjmMthnsKisAsnNs9cMZa6RI69pyvE6l8R8M20I=
X-Originating-IP: [92.22.21.220]
X-Spam: 0
X-OAuthority: v=2.2 cv=M9M9E24s c=1 sm=1 tr=0 a=VSxTZYxioCnvaH7igEU67w==:117
 a=VSxTZYxioCnvaH7igEU67w==:17 a=evINK-nbAAAA:8 a=a613HgjF-wkWfHkCkmsA:9
 a=A7_Vu5NaRHp72xNY:21 a=uwE5Skv4SUVzmiDU:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 1/3] add -p: only display help for active keys
Date:   Tue, 13 Feb 2018 10:32:39 +0000
Message-Id: <20180213103241.6789-2-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180213103241.6789-1-phillip.wood@talktalk.net>
References: <20180213103241.6789-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfBgUUCYateR1eBo11nXP4ysQXF6Xam17Xo7WSz+NYCB6p/cZQ6Z6exk2Pd63NAigVp9kGHxkEp7BaBYpNkZhVq/dpjYT/pS5gzUjb5XrM/CI+c024Apl
 WylB7jEaBBAyGakPSLBekXJ5CsZf2w+fAPbXqINVh44vlgyE57f/NsjyaYT2Afi0DjaC84B8qz+kbFw4yqzMO4vEHAqdncqD9PhhwX5nEfVIwrz3ToQrklSy
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

If the user presses a key that add -p wasn't expecting then it prints
a list of key bindings. Although the prompt only lists the active
bindings the help was printed for all bindings.  Fix this by using the
list of keys in the prompt to filter the help. Note that the list of
keys was already passed to help_patch_cmd() by the caller so there is
no change needed to the call site.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 git-add--interactive.perl | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 964c3a75420db4751cf11125b68b6904112632f1..76b941f8f0071b7bfa9d515af25b69997ef4581a 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -1184,7 +1184,13 @@ d - do not apply this hunk or any of the later hunks in the file"),
 );
 
 sub help_patch_cmd {
-	print colored $help_color, __($help_patch_modes{$patch_mode}), "\n", __ <<EOF ;
+	local $_;
+	my $other = $_[0] . ",/,?";
+	print colored $help_color, __($help_patch_modes{$patch_mode}), "\n",
+		map { "$_\n" } grep {
+			my $c = quotemeta(substr($_, 0, 1));
+			$other =~ /,$c/
+		} split "\n", __ <<EOF ;
 g - select a hunk to go to
 / - search for a hunk matching the given regex
 j - leave this hunk undecided, see next undecided hunk
-- 
2.16.1

