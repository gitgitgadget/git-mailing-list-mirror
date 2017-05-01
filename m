Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C59721F78F
	for <e@80x24.org>; Mon,  1 May 2017 13:49:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938907AbdEANt4 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 1 May 2017 09:49:56 -0400
Received: from wes1-so2.wedos.net ([46.28.106.16]:51321 "EHLO
        wes1-so2.wedos.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751879AbdEANty (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2017 09:49:54 -0400
X-Greylist: delayed 531 seconds by postgrey-1.27 at vger.kernel.org; Mon, 01 May 2017 09:49:54 EDT
Received: from [127.0.0.1] (cst-prg-140-252.cust.vodafone.cz [46.135.140.252])
        by wes1-so2.wedos.net (Postfix) with ESMTPSA id 3wGltf3RTvzhF;
        Mon,  1 May 2017 15:40:58 +0200 (CEST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-Mailer: BlackBerry Email (10.3.2.2876)
Message-ID: <20170501134057.5877840.92158.13927@rehivetech.com>
Date:   Mon, 01 May 2017 15:40:57 +0200
Subject: Re: [PATCH v2] send-email: new options to walkaround email server limits
From:   Jan Viktorin <viktorin@rehivetech.com>
In-Reply-To: <20170501125928.11291-1-zxq_yx_007@163.com>
References: <20170501125928.11291-1-zxq_yx_007@163.com>
To:     xiaoqiang zhao <zxq_yx_007@163.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, mst@kernel.org, pbonzini@redhat.com,
        mina86@mina86.com, artagnon@gmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello, thank you for posting this improvement. I've been missing such feature in git. I hope to test it soon.

Jan Viktorin
RehiveTech
Sent from a mobile device
  Původní zpráva  
Od: xiaoqiang zhao
Odesláno: pondělí, 1. května 2017 15:00
Komu: git@vger.kernel.org
Kopie: gitster@pobox.com; viktorin@rehivetech.com; mst@kernel.org; pbonzini@redhat.com; mina86@mina86.com; artagnon@gmail.com
Předmět: [PATCH v2] send-email: new options to walkaround email server limits

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
--smtp-debug <0|1> * Disable, enable Net::SMTP debug.

+ --batch-size <int> * send max \$num message per connection.
+ --relogin-delay <int> * delay \$num seconds between two successive login, default to 1,
+ This option can only be used with --batch-size
+
Automating:
--identity <str> * Use the sendemail.<id> options.
--to-cmd <str> * Email To: via `<str> \$patch_path`
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
+	 "batch-size=i" => \$batch_size,
+	 "relogin-delay=i" => \$relogin_delay,
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
+	 print "Auth use saved password. \n";
+	 return !!$smtp->auth($smtp_authuser, $smtp_authpass);
+	}
+
# Workaround AUTH PLAIN/LOGIN interaction defect
# with Authen::SASL::Cyrus
eval {
@@ -1187,6 +1201,7 @@ sub smtp_auth_maybe {
'password' => $smtp_authpass
}, sub {
my $cred = shift;
+	 $smtp_authpass = $cred->{'password'};

if ($smtp_auth) {
my $sasl = Authen::SASL->new(
@@ -1442,6 +1457,15 @@ EOF
}
}

+	$num_sent++;
+	if ($num_sent == $batch_size) {
+	 $smtp->quit;
+	 $smtp = undef;
+	 $num_sent = 0;
+	 print "Reconnect SMTP server required. \n";
+	 sleep($relogin_delay);
+	}
+
return 1;
}

-- 
2.13.0.rc1.16.g49e904895


