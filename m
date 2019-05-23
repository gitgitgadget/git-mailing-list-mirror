Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 187D71F462
	for <e@80x24.org>; Thu, 23 May 2019 00:38:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728511AbfEWAie (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 May 2019 20:38:34 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:59451 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727790AbfEWAid (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 May 2019 20:38:33 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hTbke-0003mF-D1; Wed, 22 May 2019 18:38:32 -0600
Received: from ip72-206-97-68.om.om.cox.net ([72.206.97.68] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hTbkc-0005Ur-Gw; Wed, 22 May 2019 18:38:32 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
Date:   Wed, 22 May 2019 19:38:24 -0500
Message-ID: <87d0kaj98f.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1hTbkc-0005Ur-Gw;;;mid=<87d0kaj98f.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=72.206.97.68;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/xPpo27zNqRfE4XeNZV4MswZeNetpRPXY=
X-SA-Exim-Connect-IP: 72.206.97.68
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH] send-email: Add an option to suppress adding a specific email address
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Make it easy to suppress stable@vger.kernel.org.  Long story short it
is desirable to have ``Cc: stable@vger.kernel.org'' on many bug fixes
sent to the linux kernel.  It is not always desirable to actually the
stable maintainer immediately as the patches are still being reviewed
etc.  Actually cc'd the stable maintainers in the linux kernel is not
even really necessary as they will always find the tag after the patch
has been merged in the commit body.

So I am adding yet another suppress command "suppress-addr" that will
take an email address keep that email address from being automatically
added to a destination the email will be sent to.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 Documentation/git-send-email.txt |  5 +++++
 git-send-email.perl              | 20 +++++++++++++++++++-
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 1afe9fc858ea..9833d4dbd9f4 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -346,6 +346,11 @@ Default is the value of `sendemail.suppresscc` configuration value; if
 that is unspecified, default to 'self' if --suppress-from is
 specified, as well as 'body' if --no-signed-off-cc is specified.
 
+--suppress-addr=<address>::
+	Specify an address that should not be automatically copied
+	on any email.
+	Default is the value of `sendemail.suppressaddr`.
+
 --[no-]suppress-from::
 	If this is set, do not add the From: address to the cc: list.
 	Default is the value of `sendemail.suppressFrom` configuration
diff --git a/git-send-email.perl b/git-send-email.perl
index 8eb63b5a2f8d..2ac0985f3f00 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -98,6 +98,7 @@ sub usage {
     --to-cmd                <str>  * Email To: via `<str> \$patch_path`
     --cc-cmd                <str>  * Email Cc: via `<str> \$patch_path`
     --suppress-cc           <str>  * author, self, sob, cc, cccmd, body, bodycc, misc-by, all.
+    --suppress-addr         <str>  * Don't automatically add the specified address
     --[no-]cc-cover                * Email Cc: addresses in the cover letter.
     --[no-]to-cover                * Email To: addresses in the cover letter.
     --[no-]signed-off-by-cc        * Send to Signed-off-by: addresses. Default on.
@@ -237,6 +238,7 @@ sub do_edit {
 my ($identity, $aliasfiletype, @alias_files, $smtp_domain, $smtp_auth);
 my ($validate, $confirm);
 my (@suppress_cc);
+my (@suppress_addr);
 my ($auto_8bit_encoding);
 my ($compose_encoding);
 my $target_xfer_encoding = 'auto';
@@ -274,6 +276,7 @@ sub do_edit {
     "aliasfiletype" => \$aliasfiletype,
     "bcc" => \@bcclist,
     "suppresscc" => \@suppress_cc,
+    "suppressaddr" => \@suppress_addr,
     "envelopesender" => \$envelope_sender,
     "confirm"   => \$confirm,
     "from" => \$sender,
@@ -360,6 +363,7 @@ sub signal_handler {
 		    "suppress-from!" => \$suppress_from,
 		    "no-suppress-from" => sub {$suppress_from = 0},
 		    "suppress-cc=s" => \@suppress_cc,
+		    "suppress-addr=s" => \@suppress_addr,
 		    "signed-off-cc|signed-off-by-cc!" => \$signed_off_by_cc,
 		    "no-signed-off-cc|no-signed-off-by-cc" => sub {$signed_off_by_cc = 0},
 		    "cc-cover|cc-cover!" => \$cover_cc,
@@ -489,6 +493,16 @@ sub read_config {
 	delete $suppress_cc{'body'};
 }
 
+# Set specific suppress addresses
+my (%suppress_addr);
+if (@suppress_addr) {
+	foreach my $addr (@suppress_addr) {
+		my $qaddr = unquote_rfc2047($addr);
+		my $saddr = sanitize_address($qaddr);
+		$suppress_addr{$saddr} = 1;
+	}
+}
+
 # Set confirm's default value
 my $confirm_unconfigured = !defined $confirm;
 if ($confirm_unconfigured) {
@@ -1623,6 +1637,7 @@ sub process_file {
 				$sauthor = sanitize_address($author);
 				next if $suppress_cc{'author'};
 				next if $suppress_cc{'self'} and $sauthor eq $sender;
+				next if ($suppress_addr{$sauthor});
 				printf(__("(mbox) Adding cc: %s from line '%s'\n"),
 					$1, $_) unless $quiet;
 				push @cc, $1;
@@ -1642,6 +1657,7 @@ sub process_file {
 						next if ($suppress_cc{'self'});
 					} else {
 						next if ($suppress_cc{'cc'});
+						next if ($suppress_addr{$saddr});
 					}
 					printf(__("(mbox) Adding cc: %s from line '%s'\n"),
 						$addr, $_) unless $quiet;
@@ -1681,7 +1697,7 @@ sub process_file {
 			# line 2 = subject
 			# So let's support that, too.
 			$input_format = 'lots';
-			if (@cc == 0 && !$suppress_cc{'cc'}) {
+			if (@cc == 0 && !$suppress_cc{'cc'} && !$suppress_addr{$_}) {
 				printf(__("(non-mbox) Adding cc: %s from line '%s'\n"),
 					$_, $_) unless $quiet;
 				push @cc, $_;
@@ -1700,6 +1716,7 @@ sub process_file {
 			$c = strip_garbage_one_address($c);
 			# sanitize a bit more to decide whether to suppress the address:
 			my $sc = sanitize_address($c);
+			next if ($suppress_addr{$sc});
 			if ($sc eq $sender) {
 				next if ($suppress_cc{'self'});
 			} else {
@@ -1833,6 +1850,7 @@ sub recipients_cmd {
 		$address =~ s/^\s*//g;
 		$address =~ s/\s*$//g;
 		$address = sanitize_address($address);
+		next if ($suppress_addr{$address});
 		next if ($address eq $sender and $suppress_cc{'self'});
 		push @addresses, $address;
 		printf(__("(%s) Adding %s: %s from: '%s'\n"),
-- 
2.21.0.dirty

