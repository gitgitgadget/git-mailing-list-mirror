Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C7211FC3E
	for <e@80x24.org>; Sat, 29 Apr 2017 12:28:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1166724AbdD2M1H (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Apr 2017 08:27:07 -0400
Received: from m12-16.163.com ([220.181.12.16]:37046 "EHLO m12-16.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1166721AbdD2M1F (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Apr 2017 08:27:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=2CvTy5vkt4jAKQdnD5
        RkIHzFUc3VzCRbqqLNbR8f1GA=; b=JmB0IUlVRyQ/fOxzvv3HME3ksaf1JGiGIX
        CMmNSfxyL5zZwA1fTh2tQ6a75Ek30SqqaAFmStj0Qk/Z76dj9jwD6L+FBBSuKKjk
        dkxrBhuA/ILZpOcCGkEc6ogyhOD60YYklGpNQeVdwEQnr5aKC6gvCVEp91RGJ/J8
        99TJR9+PY=
Received: from localhost.localdomain (unknown [1.203.183.82])
        by smtp12 (Coremail) with SMTP id EMCowAC33fJ4hgRZin5bBQ--.9167S2;
        Sat, 29 Apr 2017 20:26:39 +0800 (CST)
From:   xiaoqiang zhao <zxq_yx_007@163.com>
To:     git@vger.kernel.org
Cc:     viktorin@rehivetech.com, mst@kernel.org, pbonzini@redhat.com,
        mina86@mina86.com, artagnon@gmail.com
Subject: [PATCH] send-email: new option to walkaround email server limits
Date:   Sat, 29 Apr 2017 20:26:32 +0800
Message-Id: <20170429122632.7122-1-zxq_yx_007@163.com>
X-Mailer: git-send-email 2.11.0
X-CM-TRANSID: EMCowAC33fJ4hgRZin5bBQ--.9167S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7try7tr4UGF1xXr1kCryUZFb_yoW8Kw1xpw
        sF9FZxWryxJFZF9wn2y3Wayr909rykGF9xt3yDtr1UAF45Xr9FyrnIyw1vyw18Krn293yU
        ZwnFgr48uF40ywUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jmuWdUUUUU=
X-Originating-IP: [1.203.183.82]
X-CM-SenderInfo: 520ts5t0bqili6rwjhhfrp/xtbBEh-IxlZX2sB6JgAAsE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some email server(e.g. smtp.163.com) limits a fixed number emails to be send per
session(connection) and this will lead to a send faliure.
With --split <num> option, a auto reconnection will occur when number of sended
email reaches <num> and the problem is solved.

Signed-off-by: xiaoqiang zhao <zxq_yx_007@163.com>
---
 git-send-email.perl | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index eea0a517f..0de9b7058 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -81,6 +81,8 @@ git send-email --dump-aliases
                                      This setting forces to use one of the listed mechanisms.
     --smtp-debug            <0|1>  * Disable, enable Net::SMTP debug.
 
+    --split                 <int>  * send \$num message per connection.
+
   Automating:
     --identity              <str>  * Use the sendemail.<id> options.
     --to-cmd                <str>  * Email To: via `<str> \$patch_path`
@@ -153,6 +155,7 @@ my $have_email_valid = eval { require Email::Valid; 1 };
 my $have_mail_address = eval { require Mail::Address; 1 };
 my $smtp;
 my $auth;
+my $send_count = 0;
 
 # Regexes for RFC 2047 productions.
 my $re_token = qr/[^][()<>@,;:\\"\/?.= \000-\037\177-\377]+/;
@@ -186,6 +189,7 @@ my $format_patch;
 my $compose_filename;
 my $force = 0;
 my $dump_aliases = 0;
+my $split = 0;
 
 # Handle interactive edition of files.
 my $multiedit;
@@ -358,6 +362,7 @@ $rc = GetOptions(
 		    "force" => \$force,
 		    "xmailer!" => \$use_xmailer,
 		    "no-xmailer" => sub {$use_xmailer = 0},
+		    "split=i" => \$split,
 	 );
 
 usage() if $help;
@@ -1158,10 +1163,15 @@ sub smtp_host_string {
 # (smtp_user was not specified), and 0 otherwise.
 
 sub smtp_auth_maybe {
-	if (!defined $smtp_authuser || $auth) {
+	if (!defined $smtp_authuser || $send_count != 0) {
 		return 1;
 	}
 
+	if ($auth && $send_count == 0) {
+		print "Auth use saved password. \n";
+		return !!$smtp->auth($smtp_authuser, $smtp_authpass);
+	}
+
 	# Workaround AUTH PLAIN/LOGIN interaction defect
 	# with Authen::SASL::Cyrus
 	eval {
@@ -1187,6 +1197,7 @@ sub smtp_auth_maybe {
 		'password' => $smtp_authpass
 	}, sub {
 		my $cred = shift;
+		$smtp_authpass = $cred->{'password'};
 
 		if ($smtp_auth) {
 			my $sasl = Authen::SASL->new(
@@ -1442,6 +1453,15 @@ EOF
 		}
 	}
 
+	$send_count++;
+	if ($send_count == $split) {
+		$smtp->quit;
+		$smtp = undef;
+		$send_count = 0;
+		print "Reconnect SMTP server required. \n";
+
+	}
+
 	return 1;
 }
 
-- 
2.11.0


