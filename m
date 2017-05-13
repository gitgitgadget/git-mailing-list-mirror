Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=0.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 319ED201A7
	for <e@80x24.org>; Sat, 13 May 2017 01:58:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758134AbdEMB6D (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 May 2017 21:58:03 -0400
Received: from m12-17.163.com ([220.181.12.17]:53525 "EHLO m12-17.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751294AbdEMB6C (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2017 21:58:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=ZZj1ZHOaXgE5Z2vFbg
        rwwO2wazOm3vSiaYPlMIhhq7s=; b=GufWmvorbV8qjPswft/3nomuVJzpyB4st5
        GUDT7TVZPZ1c8OZJ1APZaWTZkbNR6xBQjMP5ynL7Bjwhz+45yvRt+FCVS7PepL3L
        ovIt4H4UZ3VtZOKDVtEzPN3JgnF9nkyzhcmA5OT2aKUia/HGlzTaGaM95Nq/MHd1
        bY6pIXzCI=
Received: from localhost.localdomain (unknown [219.143.190.219])
        by smtp13 (Coremail) with SMTP id EcCowAA3vg4IaBZZvPHCEQ--.42762S2;
        Sat, 13 May 2017 09:57:29 +0800 (CST)
From:   xiaoqiang zhao <zxq_yx_007@163.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, viktorin@rehivetech.com, mst@kernel.org,
        pbonzini@redhat.com, mina86@mina86.com, artagnon@gmail.com,
        avarab@gmail.com
Subject: [PATCH v4] send-email: --batch-size to work around some SMTP server limit
Date:   Sat, 13 May 2017 09:57:26 +0800
Message-Id: <20170513015726.20281-1-zxq_yx_007@163.com>
X-Mailer: git-send-email 2.13.0.rc2.49.g12cd49e6e
X-CM-TRANSID: EcCowAA3vg4IaBZZvPHCEQ--.42762S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXFWrGrWxAryUJF45tw1fJFb_yoW5KF15pF
        98WrWFgFyktF4aya1Iyw1xWryYgrZ5JFnFqa1rKr1UAF15AF9FyF13KFyFyFyfGFnFgryY
        vryqqF93uF4qyrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07bOAwsUUUUU=
X-Originating-IP: [219.143.190.219]
X-CM-SenderInfo: 520ts5t0bqili6rwjhhfrp/1tbiFgjWxlWBV5aQWgAAsR
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

Note:
   Re-authentication will happen every $<batch-size> messages, so it
will be much more acceptable if you use some form of credential helper
(e.g. the 'sendemail.smtppass' config option), otherwise you will have
to retype password every time when asked.

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
index eea0a517f..071d1ab9d 100755
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
+my ($batch_size, $relogin_delay);
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
+		$smtp->quit if defined $smtp;
+		undef $smtp;
+		undef $auth;
+		sleep($relogin_delay);
+	}
 }
 
 # Execute a command (e.g. $to_cmd) to get a list of email addresses
-- 
2.13.0.rc2.49.g12cd49e6e


