Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=1.3 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_12_24,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF5C420137
	for <e@80x24.org>; Sun,  7 May 2017 22:08:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755919AbdEGWIk (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 May 2017 18:08:40 -0400
Received: from m12-17.163.com ([220.181.12.17]:33993 "EHLO m12-17.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755666AbdEGWIi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 May 2017 18:08:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=t0kk030qxxpgBEFhEx
        prTWo0X2HVN3AY4x8O99J0UgQ=; b=aT/U5qgvT1ibzXgZh33CsCwufcWuqr8isp
        kXcwn+rzyzhAviMRplQM9DpD/LRGaJIX/PkehJVWlyvcYri0i48VKCdj5gMLtkFf
        UEkUQImbnQ/miA2LrumQDHH0mukMBom6F1EMHl3zpI4UvSPrx/teLxI0HTCZXKNf
        zo3WZjWDI=
Received: from localhost.localdomain (unknown [219.143.190.219])
        by smtp13 (Coremail) with SMTP id EcCowAB3r2dgpA5Z_pLSDg--.44959S2;
        Sun, 07 May 2017 12:36:48 +0800 (CST)
From:   xiaoqiang zhao <zxq_yx_007@163.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, viktorin@rehivetech.com, mst@kernel.org,
        pbonzini@redhat.com, mina86@mina86.com, artagnon@gmail.com,
        avarab@gmail.com
Subject: [PATCH v3] send-email: --batch-size to work around some SMTP server limit
Date:   Sun,  7 May 2017 12:36:48 +0800
Message-Id: <20170507043648.24143-1-zxq_yx_007@163.com>
X-Mailer: git-send-email 2.13.0.rc2.1.gd46ef338b.dirty
X-CM-TRANSID: EcCowAB3r2dgpA5Z_pLSDg--.44959S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXFW7CF13Zr4UJrW8KFy7GFg_yoW5ur4kpF
        98WrWSgFyktFs0ya1Iyr1xWF90grZ5JFnIqa1rKr1UAF15AF9FyF13KFyrAryfJF9FgrWa
        vryqqFZxuF4jyrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07bY89NUUUUU=
X-Originating-IP: [219.143.190.219]
X-CM-SenderInfo: 520ts5t0bqili6rwjhhfrp/1tbiqAHQxlc68x10AAAAsI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some email servers (e.g. smtp.163.com) limit the number emails to be
sent per session(connection) and this will lead to a faliure when
sending many messages.

Teach send-email to disconnect after sending a number of messages
(configurable via the --batch-size=<num> option), wait for a few
seconds (configurable via the --relogin-delay=<seconds> option) and
reconnect, to work around such a limit.

Also add this two configure option for git config command.

Signed-off-by: xiaoqiang zhao <zxq_yx_007@163.com>
---
 contrib/completion/git-completion.bash |  2 ++
 git-send-email.perl                    | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index af658995d..29496353a 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2608,6 +2608,8 @@ _git_config ()
 		sendemail.thread
 		sendemail.to
 		sendemail.validate
+		sendemail.smtpbatchsize
+		sendemail.smtprelogindelay
 		showbranch.default
 		status.relativePaths
 		status.showUntrackedFiles
diff --git a/git-send-email.perl b/git-send-email.perl
index eea0a517f..5cbe97898 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -81,6 +81,10 @@ git send-email --dump-aliases
                                      This setting forces to use one of the listed mechanisms.
     --smtp-debug            <0|1>  * Disable, enable Net::SMTP debug.
 
+    --batch-size            <int>  * send max <int> message per connection.
+    --relogin-delay         <int>  * delay <int> seconds between two successive login, default to 1,
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
@@ -216,6 +221,7 @@ my ($cover_cc, $cover_to);
 my ($to_cmd, $cc_cmd);
 my ($smtp_server, $smtp_server_port, @smtp_server_options);
 my ($smtp_authuser, $smtp_encryption, $smtp_ssl_cert_path);
+my ($batch_size, $relogin_delay) = (0, 0);
 my ($identity, $aliasfiletype, @alias_files, $smtp_domain, $smtp_auth);
 my ($validate, $confirm);
 my (@suppress_cc);
@@ -247,6 +253,8 @@ my %config_settings = (
     "smtppass" => \$smtp_authpass,
     "smtpdomain" => \$smtp_domain,
     "smtpauth" => \$smtp_auth,
+    "smtpbatchsize" => \$batch_size,
+    "smtprelogindelay" => \$relogin_delay,
     "to" => \@initial_to,
     "tocmd" => \$to_cmd,
     "cc" => \@initial_cc,
@@ -358,6 +366,8 @@ $rc = GetOptions(
 		    "force" => \$force,
 		    "xmailer!" => \$use_xmailer,
 		    "no-xmailer" => sub {$use_xmailer = 0},
+		    "batch-size=i" => \$batch_size,
+		    "relogin-delay=i" => \$relogin_delay,
 	 );
 
 usage() if $help;
@@ -1664,6 +1674,14 @@ foreach my $t (@files) {
 		}
 	}
 	$message_id = undef;
+	$num_sent++;
+	if ($num_sent == $batch_size) {
+		$num_sent = 0;
+		$smtp->quit;
+		$smtp = undef;
+		$auth = 0;
+		sleep($relogin_delay);
+	}
 }
 
 # Execute a command (e.g. $to_cmd) to get a list of email addresses
-- 
2.13.0.rc2.1.gd46ef338b.dirty


