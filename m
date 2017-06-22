Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 500E320282
	for <e@80x24.org>; Thu, 22 Jun 2017 10:27:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753161AbdFVK1B (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 06:27:01 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:51188 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752959AbdFVK07 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 06:26:59 -0400
Received: from lindisfarne.localdomain ([92.22.42.39])
        by smtp.talktalk.net with SMTP
        id NzK5dhmIPxR4bNzKDdWEVJ; Thu, 22 Jun 2017 11:26:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net; s=1605;
        t=1498127218; bh=L8QDgqZTRPLriWq++ltDVEXJhlc84fCcSTOyKd/b52A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=AzflMcx9B8tDHmB0Sb02wft/0UchxgUH1qCgLB4ZlClPs9MWqFM+76Tzb0S58/bAN
         Jk0RP9H5nlo4puw6KylCSFGhtuGP7QKa+EIFUhm5Jqw3fbf0LDVeBqG912Yi+Vt71p
         dsujNy2oc2GMnti+ExY+6lrP8vNZ28PbQSOMT+gQ=
X-Originating-IP: [92.22.42.39]
X-Spam: 0
X-OAuthority: v=2.2 cv=JNN5iICb c=1 sm=1 tr=0 a=0UCMmuyk8Ln1ykD6Z38Clg==:117
 a=0UCMmuyk8Ln1ykD6Z38Clg==:17 a=evINK-nbAAAA:8 a=8T3UGDEMF0FBKUu0cWcA:9
 a=0kgvYVs3qv7TFiQn:21 a=PV-xaJP8wqvdVH_d:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 1/5] Git.pm Add unquote_path()
Date:   Thu, 22 Jun 2017 11:26:18 +0100
Message-Id: <20170622102622.26147-2-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170622102622.26147-1-phillip.wood@talktalk.net>
References: <20170622102622.26147-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfKNYu7KyeyZLH+iB14yhrlwTll0RXVMyy2NM6YQF5MJLQ9Dez2qXsDjY70c9FtTJs/2scuoW01vjpBeCqlN4bCqpJCPChyrQOJmIP5M8qoY/XYoSsgyP
 GODX6g3IYloPime6EBH3XC5yU41Ntazgwp5YA+IpmEg1f2IWtNiVKJBr6je7EYo9YdTEFyWnbFxuX9MwS1qOKx+h1WR/g0Me2RfDE1IRY5WkH8ttgr7YG8bC
 5SoT3+GldwqiGlE6VxR9Pg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Add unquote_path() from git-add--interactive so it can be used by
other scripts. Note this is a straight copy, it does not handle
'\a'. That will be fixed in the next commit

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 perl/Git.pm | 53 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 52 insertions(+), 1 deletion(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index bfce1f795dfa5fea05f4f96637a1ae2333038735..8afde87fc8162271ba178e0fff3e921f070ac621 100644
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
+when not using -z
+
+=cut
+
+{
+	my %unquote_map = (
+		"b" => chr(8),
+		"t" => chr(9),
+		"n" => chr(10),
+		"v" => chr(11),
+		"f" => chr(12),
+		"r" => chr(13),
+		"\\" => "\\",
+		"\"" => "\""
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
+					$retval .= $unquote_map{$1};
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
2.13.0

