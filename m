Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12FED1F78F
	for <e@80x24.org>; Mon,  1 May 2017 13:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752733AbdEANAb (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 May 2017 09:00:31 -0400
Received: from m12-13.163.com ([220.181.12.13]:40820 "EHLO m12-13.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1949290AbdEANAV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2017 09:00:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=AMtGZITom1K8iwukmz
        DRT1CBH87y7UzPxH4DGqfRyLg=; b=NcmvU471DTd6nEYVg0OHipTTzl95CHcPF/
        T2z/JrhK96KR6UNr38DzwVqNVcCyhzgIlMN8rMI9LlcMyPn9AlUUqjBcthFjdqnM
        PsxQNnf6V5pN+C1uc1v3qazI2hCeyT5wTx7CeOd2Ll1ijQJNHfAnDQSQug4W1RgG
        qzgoIuQcs=
Received: from localhost.localdomain (unknown [1.203.183.82])
        by smtp9 (Coremail) with SMTP id DcCowABXHlcwMQdZtzqABg--.37387S2;
        Mon, 01 May 2017 20:59:40 +0800 (CST)
From:   xiaoqiang zhao <zxq_yx_007@163.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, viktorin@rehivetech.com, mst@kernel.org,
        pbonzini@redhat.com, mina86@mina86.com, artagnon@gmail.com
Subject: [PATCH v2] send-email: new options to walkaround email server limits
Date:   Mon,  1 May 2017 20:59:28 +0800
Message-Id: <20170501125928.11291-1-zxq_yx_007@163.com>
X-Mailer: git-send-email 2.13.0.rc1.16.g49e904895
X-CM-TRANSID: DcCowABXHlcwMQdZtzqABg--.37387S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZF4xKw1DXFyDGr47XrykuFg_yoW5Xw4Dp3
        9IkFZxWrykJFW7Za4IyF1aqrn0kFyktFnrta97Kr1jyF45Ar9IyrnayF9Yya4rGrn293yF
        vw1qqF48uF1jyr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jdqXdUUUUU=
X-Originating-IP: [1.203.183.82]
X-CM-SenderInfo: 520ts5t0bqili6rwjhhfrp/1tbiOx3KxlXlYb9QkwAAsH
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some email server(e.g. smtp.163.com) limits a fixed number emails to
be send per session(connection) and this will lead to a send faliure.

With --batch-size=<num> option, an auto reconnection will occur when
number of sent email reaches <num> and the problem is solved.

--relogin-delay option will make some delay between two successive
email server login.

Signed-off-by: xiaoqiang zhao <zxq_yx_007@163.com>
---
 git-send-email.perl | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index eea0a517f..cd9981cc6 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -81,6 +81,10 @@ git send-email --dump-aliases
                                      This setting forces to use one of the listed mechanisms.
     --smtp-debug            <0|1>  * Disable, enable Net::SMTP debug.
 
+    --batch-size            <int>  * send max \$num message per connection.
+    --relogin-delay         <int>  * delay \$num seconds between two successive login, default to 1,
+                                     This option can only be used with --batch-size
+
   Automating:
     --identity              <str>  * Use the sendemail.<id> options.
     --to-cmd                <str>  * Email To: via `<str> \$patch_path`
@@ -153,6 +157,7 @@ my $have_email_valid = eval { require Email::Valid; 1 };
 my $have_mail_address = eval { require Mail::Address; 1 };
 my $smtp;
 my $auth;
+my $num_sent = 0;
 
 # Regexes for RFC 2047 productions.
 my $re_token = qr/[^][()<>@,;:\\"\/?.= \000-\037\177-\377]+/;
@@ -186,6 +191,8 @@ my $format_patch;
 my $compose_filename;
 my $force = 0;
 my $dump_aliases = 0;
+my $batch_size = 0;
+my $relogin_delay = 1;
 
 # Handle interactive edition of files.
 my $multiedit;
@@ -358,6 +365,8 @@ $rc = GetOptions(
 		    "force" => \$force,
 		    "xmailer!" => \$use_xmailer,
 		    "no-xmailer" => sub {$use_xmailer = 0},
+		    "batch-size=i" => \$batch_size,
+		    "relogin-delay=i" => \$relogin_delay,
 	 );
 
 usage() if $help;
@@ -1158,10 +1167,15 @@ sub smtp_host_string {
 # (smtp_user was not specified), and 0 otherwise.
 
 sub smtp_auth_maybe {
-	if (!defined $smtp_authuser || $auth) {
+	if (!defined $smtp_authuser || $num_sent != 0) {
 		return 1;
 	}
 
+	if ($auth && $num_sent == 0) {
+		print "Auth use saved password. \n";
+		return !!$smtp->auth($smtp_authuser, $smtp_authpass);
+	}
+
 	# Workaround AUTH PLAIN/LOGIN interaction defect
 	# with Authen::SASL::Cyrus
 	eval {
@@ -1187,6 +1201,7 @@ sub smtp_auth_maybe {
 		'password' => $smtp_authpass
 	}, sub {
 		my $cred = shift;
+		$smtp_authpass = $cred->{'password'};
 
 		if ($smtp_auth) {
 			my $sasl = Authen::SASL->new(
@@ -1442,6 +1457,15 @@ EOF
 		}
 	}
 
+	$num_sent++;
+	if ($num_sent == $batch_size) {
+		$smtp->quit;
+		$smtp = undef;
+		$num_sent = 0;
+		print "Reconnect SMTP server required. \n";
+		sleep($relogin_delay);
+	}
+
 	return 1;
 }
 
-- 
2.13.0.rc1.16.g49e904895


