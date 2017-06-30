Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F23220209
	for <e@80x24.org>; Fri, 30 Jun 2017 09:49:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751716AbdF3Jtl (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Jun 2017 05:49:41 -0400
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:17148 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751605AbdF3Jtj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2017 05:49:39 -0400
Received: from lindisfarne.localdomain ([92.22.42.39])
        by smtp.talktalk.net with SMTP
        id QsYKdOu0hQ527QsYTdIMsg; Fri, 30 Jun 2017 10:49:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net; s=1605;
        t=1498816178; bh=H2ipcyuoYeqjqzrmO9WI58XO99TLXOHPosAsVHm22Nk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=XCgunZV6zWSJPvMkecN3pCLyW7bsAjxVv8ccMYp3Sjo6WwAt1vSA8Av3IvYyNv14k
         cNtUCbQ2+P+DZX1DI0Q8UJd0Mh6vH3zouirnf6LDIbbKUm/5N8hokFJCHWtJKCzvM6
         O/25JKA0/ZofJaUr/8CbVkcvvg78ag2XtGRs/H6g=
X-Originating-IP: [92.22.42.39]
X-Spam: 0
X-OAuthority: v=2.2 cv=MI8io4Rl c=1 sm=1 tr=0 a=0UCMmuyk8Ln1ykD6Z38Clg==:117
 a=0UCMmuyk8Ln1ykD6Z38Clg==:17 a=evINK-nbAAAA:8 a=j65Dv8dDcRgtQwonnycA:9
 a=fL2gd8kDSUsi13WG:21 a=5jaYik_Jwr-OXVr9:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 1/4] add -i move unquote_path() to Git.pm
Date:   Fri, 30 Jun 2017 10:49:09 +0100
Message-Id: <20170630094912.8653-2-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.13.1
In-Reply-To: <20170630094912.8653-1-phillip.wood@talktalk.net>
References: <20170622102622.26147-1-phillip.wood@talktalk.net>
 <20170630094912.8653-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfLhEq/Bb6X6SAINUTOJUpshm65L+1VYks6ohScTEfKR8Y8Di4PJZ/5JLC5HV9q2OI+JI4IvZisy4t2qp3CLSdT9VfZ6m9bRRZlRxEbVMRRvvr8Bh/ulj
 ZTF2oRcQW9faWzYVyxdTv+MYTMQrpsQhs06K5K5fbcHTeMdrnQU6ujp+qjxqPDJAo/iFt0vCpkvGcp+CRBNZkKKoDTv7DwEriTDFhg14eFtQVjLE+ZfLUFhV
 TGCM0DiINysm8DIg9VDdoVLa5Uu8XrR2y5+N6NONgSE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Move unquote_path() from git-add--interactive to Git.pm so it can be
used by other scripts. Note this is a straight copy, it does not
handle '\a'. That will be fixed in the next commit.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 git-add--interactive.perl | 43 +-------------------------------------
 perl/Git.pm               | 53 ++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 53 insertions(+), 43 deletions(-)

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
diff --git a/perl/Git.pm b/perl/Git.pm
index bfce1f795dfa5fea05f4f96637a1ae2333038735..35188842ef82c67f83f6d72fd37e38edb895328b 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -61,7 +61,8 @@ require Exporter;
                 remote_refs prompt
                 get_tz_offset get_record
                 credential credential_read credential_write
-                temp_acquire temp_is_locked temp_release temp_reset temp_path);
+                temp_acquire temp_is_locked temp_release temp_reset temp_path
+                unquote_path);
 
 
 =head1 DESCRIPTION
@@ -1451,6 +1452,56 @@ sub prefix_lines {
 	return $string;
 }
 
+=item unquote_path ( PATH )
+
+Unquote a quoted path containing c-escapes as returned by ls-files etc.
+when not using -z or when parsing the output of diff -u.
+
+=cut
+
+{
+	my %cquote_map = (
+		"b" => chr(8),
+		"t" => chr(9),
+		"n" => chr(10),
+		"v" => chr(11),
+		"f" => chr(12),
+		"r" => chr(13),
+		"\\" => "\\",
+		"\"" => "\042"
+	);
+
+	sub unquote_path {
+		local ($_) = @_;
+		my ($retval, $remainder);
+		if (!/^\042(.*)\042$/) {
+			return $_;
+		}
+		($_, $retval) = ($1, "");
+		while (/^([^\\]*)\\(.*)$/) {
+			$remainder = $2;
+			$retval .= $1;
+			for ($remainder) {
+				if (/^([0-3][0-7][0-7])(.*)$/) {
+					$retval .= chr(oct($1));
+					$_ = $2;
+					last;
+				}
+				if (/^([\\\042btnvfr])(.*)$/) {
+					$retval .= $cquote_map{$1};
+					$_ = $2;
+					last;
+				}
+				# This is malformed -- just return it as-is for now.
+				return $_[0];
+			}
+			$_ = $remainder;
+		}
+		$retval .= $_;
+		return $retval;
+	}
+}
+
 =item get_comment_line_char ( )
 
 Gets the core.commentchar configuration value.
-- 
2.13.1

