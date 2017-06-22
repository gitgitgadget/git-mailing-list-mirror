Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A734220282
	for <e@80x24.org>; Thu, 22 Jun 2017 10:27:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753214AbdFVK1H (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 06:27:07 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:11543 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753053AbdFVK1A (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 06:27:00 -0400
Received: from lindisfarne.localdomain ([92.22.42.39])
        by smtp.talktalk.net with SMTP
        id NzK5dhmIPxR4bNzKFdWEVZ; Thu, 22 Jun 2017 11:26:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net; s=1605;
        t=1498127219; bh=0EAdIlDL+Nd1+n6UbSleHE45i+fnTSU6m1BJjAJ8Krw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=fS51lQeD/RmIisheWERxgb183RQT0q2aiVwBZMeFCSbPg5E+maf5f46JjNKXSDS+k
         to3Si8VFiQ2rWsZVK7JESgkA8ZTgJkF+r9KctO7UaGa8CoGvGY56xIsf9pEoiC/0zY
         Tz9XvR9XP6X3su39o5C4jDO4sO5zAxBg+7aHfUzA=
X-Originating-IP: [92.22.42.39]
X-Spam: 0
X-OAuthority: v=2.2 cv=JNN5iICb c=1 sm=1 tr=0 a=0UCMmuyk8Ln1ykD6Z38Clg==:117
 a=0UCMmuyk8Ln1ykD6Z38Clg==:17 a=evINK-nbAAAA:8 a=UG735BuguSRqwlAqlAYA:9
 a=pv3IpXEy-lOKOs9J:21 a=FPYb03MqSEukdTGC:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 5/5] git-add--interactive.perl: Use unquote_path() from Git.pm
Date:   Thu, 22 Jun 2017 11:26:22 +0100
Message-Id: <20170622102622.26147-6-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170622102622.26147-1-phillip.wood@talktalk.net>
References: <20170622102622.26147-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfCW2A9KhDL6F1M1H/ziWIMMl7sCGTyJX283X9kmmG3E7WI++Tsd9sSocU8DeDnNz0riR/pjGJZcAVuE1kwkA7HdK2EYmpv283vCfwCYMc88TB5a4Vgp+
 12x2wUrePhzw/as1ZS4WlQ4sEHON3LdbjDDKMRtyXQWcHbcrn0UjOv71P+CqQB06wVCC9oGIZKT08CCstS85VJYo+4l8zdgrFS6LNsj8LB1Pk94zMinx30vg
 vx6HoSD0+VIbHPHJIdRj+Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Not that we've copied unquote_path() to Git.pm use that copy instead
of our own.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 git-add--interactive.perl | 43 +------------------------------------------
 1 file changed, 1 insertion(+), 42 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 709a5f6ce6fbdb2da14084e94ae9df1db1c3d0a6..7ea3591edc056d4405b1f18800ffd2d0b351f93c 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -3,7 +3,7 @@
 use 5.008;
 use strict;
 use warnings;
-use Git;
+use Git qw(unquote_path);
 use Git::I18N;
 
 binmode(STDOUT, ":raw");
@@ -175,47 +175,6 @@ if (!defined $GIT_DIR) {
 }
 chomp($GIT_DIR);
 
-my %cquote_map = (
- "b" => chr(8),
- "t" => chr(9),
- "n" => chr(10),
- "v" => chr(11),
- "f" => chr(12),
- "r" => chr(13),
- "\\" => "\\",
- "\042" => "\042",
-);
-
-sub unquote_path {
-	local ($_) = @_;
-	my ($retval, $remainder);
-	if (!/^\042(.*)\042$/) {
-		return $_;
-	}
-	($_, $retval) = ($1, "");
-	while (/^([^\\]*)\\(.*)$/) {
-		$remainder = $2;
-		$retval .= $1;
-		for ($remainder) {
-			if (/^([0-3][0-7][0-7])(.*)$/) {
-				$retval .= chr(oct($1));
-				$_ = $2;
-				last;
-			}
-			if (/^([\\\042btnvfr])(.*)$/) {
-				$retval .= $cquote_map{$1};
-				$_ = $2;
-				last;
-			}
-			# This is malformed -- just return it as-is for now.
-			return $_[0];
-		}
-		$_ = $remainder;
-	}
-	$retval .= $_;
-	return $retval;
-}
-
 sub refresh {
 	my $fh;
 	open $fh, 'git update-index --refresh |'
-- 
2.13.0

