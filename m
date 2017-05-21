Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5526201CF
	for <e@80x24.org>; Sun, 21 May 2017 13:00:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752919AbdEUNAa (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 May 2017 09:00:30 -0400
Received: from m12-17.163.com ([220.181.12.17]:56478 "EHLO m12-17.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752440AbdEUNA3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 May 2017 09:00:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=bz9ynsuVOCoYYlu1N0
        wvY0Ak3/vS5GVlmWoQ02hGSQA=; b=FjmaxYWpzVacDuSiax6aHsxYf2aKu21cqX
        P2Jc5YP+51GWV5DZIkeYTh1UjM+9JJIhYaWpoKukKrzLBl6FnipFPl8M75dZbC+R
        zhHL2I340+C0oETuwEcHF+Ap6NazqByyMffOPGOaqut6Jb3T6usB2FE1D6GXS3cB
        gSSnxeGrk=
Received: from localhost.localdomain (unknown [1.203.183.150])
        by smtp13 (Coremail) with SMTP id EcCowADHBA5HjyFZ9kU3Fw--.7457S2;
        Sun, 21 May 2017 20:59:52 +0800 (CST)
From:   xiaoqiang zhao <zxq_yx_007@163.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, viktorin@rehivetech.com, mst@kernel.org,
        pbonzini@redhat.com, mina86@mina86.com, artagnon@gmail.com,
        avarab@gmail.com
Subject: [PATCH v5] send-email: --batch-size to work around some SMTP server limit
Date:   Sun, 21 May 2017 20:59:50 +0800
Message-Id: <20170521125950.5524-1-zxq_yx_007@163.com>
X-Mailer: git-send-email 2.13.0.rc2.116.g565bdd0fc.dirty
X-CM-TRANSID: EcCowADHBA5HjyFZ9kU3Fw--.7457S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3XFyfur45JryruFyftF48Crg_yoW7Ww1rpa
        s8Wr4SgFyktF13u3WIyr1xWF9I9rZ5JFnFqa18Kr1UtFn8AF9IyF43tr95CFyfGr1v9rWY
        vryjqFyfuF4qyrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jgEfrUUUUU=
X-Originating-IP: [1.203.183.150]
X-CM-SenderInfo: 520ts5t0bqili6rwjhhfrp/1tbiqAjexlc68+Id-AAAsl
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

Also add this two configuration option.

Note:
   Re-authentication will happen every $<batch-size> messages, so it
will be much more acceptable if you use some form of credential helper
(e.g. the 'sendemail.smtppass' config option), otherwise you will have
to retype password every time when asked.

Signed-off-by: xiaoqiang zhao <zxq_yx_007@163.com>
---
 Documentation/config.txt               |  8 ++++++++
 Documentation/git-send-email.txt       | 11 +++++++++++
 contrib/completion/git-completion.bash |  2 ++
 git-send-email.perl                    | 18 ++++++++++++++++++
 4 files changed, 39 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 96e9cf8b7..173ed63f6 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2917,6 +2917,14 @@ sendemail.xmailer::
 sendemail.signedoffcc (deprecated)::
 	Deprecated alias for `sendemail.signedoffbycc`.
 
+sendemail.smtpbatchsize::
+	Number of messages to be sent per connection, after that a relogin
+	will happen. if the value is 0 or undefined, send all messages in
+	one connection.
+
+sendemail.smtprelogindelay::
+	Seconds wait before reconnecting to smtp server.
+
 showbranch.default::
 	The default set of branches for linkgit:git-show-branch[1].
 	See linkgit:git-show-branch[1].
diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 9d66166f6..5380d8c95 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -248,6 +248,17 @@ must be used for each option.
 	commands and replies will be printed. Useful to debug TLS
 	connection and authentication problems.
 
+--batch-size=<num>::
+	Some email servers (e.g. smtp.163.com) limit the number emails to be
+	sent per session(connection) and this will lead to a faliure when
+	sending many messages.  With this option, send-email will disconnect after
+	sending $<num> messages and wait for a few seconds (see --relogin-delay)
+	and reconnect, to work around such a limit.
+
+--relogin-delay=<int>::
+	Waiting $<int> seconds before reconnecting to smtp server. Used together
+	with --batch-size option.
+
 Automating
 ~~~~~~~~~~
 
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 1ed0a09fe..933e7badf 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2611,6 +2611,8 @@ _git_config ()
 		sendemail.thread
 		sendemail.to
 		sendemail.validate
+		sendemail.smtpbatchsize
+		sendemail.smtprelogindelay
 		showbranch.default
 		status.relativePaths
 		status.showUntrackedFiles
diff --git a/git-send-email.perl b/git-send-email.perl
index eea0a517f..8a1ee0f0d 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -81,6 +81,10 @@ git send-email --dump-aliases
                                      This setting forces to use one of the listed mechanisms.
     --smtp-debug            <0|1>  * Disable, enable Net::SMTP debug.
 
+    --batch-size            <int>  * send max <int> message per connection.
+    --relogin-delay         <int>  * delay <int> seconds between two successive login.
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
+	if (defined $batch_size && $num_sent == $batch_size) {
+		$num_sent = 0;
+		$smtp->quit if defined $smtp;
+		undef $smtp;
+		undef $auth;
+		sleep($relogin_delay) if defined $relogin_delay;
+	}
 }
 
 # Execute a command (e.g. $to_cmd) to get a list of email addresses
-- 
2.13.0.rc2.116.g565bdd0fc.dirty


