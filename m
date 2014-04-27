From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v3 1/2] git-send-email: two new options: to-cover, cc-cover
Date: Sun, 27 Apr 2014 21:25:51 +0300
Message-ID: <1398623142-28501-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 27 20:31:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WeTqt-0001Vm-VL
	for gcvg-git-2@plane.gmane.org; Sun, 27 Apr 2014 20:31:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753742AbaD0Say (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Apr 2014 14:30:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:4804 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753683AbaD0Sax (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Apr 2014 14:30:53 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s3RIUkmd022147
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 27 Apr 2014 14:30:47 -0400
Received: from redhat.com (ovpn-116-40.ams2.redhat.com [10.36.116.40])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id s3RIP1om026711;
	Sun, 27 Apr 2014 14:25:02 -0400
Content-Disposition: inline
X-Mutt-Fcc: =sent
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.24
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247219>

Allow extracting To/Cc addresses from cover letter.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 Documentation/git-send-email.txt | 12 ++++++++++++
 git-send-email.perl              | 16 ++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index f0e57a5..1733664 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -248,6 +248,18 @@ Automating
 	cc list. Default is the value of 'sendemail.signedoffbycc' configuration
 	value; if that is unspecified, default to --signed-off-by-cc.
 
+--[no-]cc-cover::
+	If this is set, emails found in Cc: headers in the cover letter are
+	added to the cc list for each email set. Default is the value of
+	'sendemail.cccover' configuration value; if that is unspecified,
+	default to --no-cc-cover.
+
+--[no-]to-cover::
+	If this is set, emails found in To: headers in the cover letter are
+	added to the to list for each email set. Default is the value of
+	'sendemail.tocover' configuration value; if that is unspecified,
+	default to --no-to-cover.
+
 --suppress-cc=<category>::
 	Specify an additional category of recipients to suppress the
 	auto-cc of:
diff --git a/git-send-email.perl b/git-send-email.perl
index 4c138a2..0084cf4 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -80,6 +80,8 @@ git send-email [options] <file | directory | rev-list options >
     --to-cmd                <str>  * Email To: via `<str> \$patch_path`
     --cc-cmd                <str>  * Email Cc: via `<str> \$patch_path`
     --suppress-cc           <str>  * author, self, sob, cc, cccmd, body, bodycc, all.
+    --[no-]cc-cover                * Email Cc: addresses in the cover letter.
+    --[no-]to-cover                * Email To: addresses in the cover letter.
     --[no-]signed-off-by-cc        * Send to Signed-off-by: addresses. Default on.
     --[no-]suppress-from           * Send to self. Default off.
     --[no-]chain-reply-to          * Chain In-Reply-To: fields. Default off.
@@ -195,6 +197,7 @@ sub do_edit {
 
 # Variables with corresponding config settings
 my ($thread, $chain_reply_to, $suppress_from, $signed_off_by_cc);
+my ($cover_cc, $cover_to);
 my ($to_cmd, $cc_cmd);
 my ($smtp_server, $smtp_server_port, @smtp_server_options);
 my ($smtp_authuser, $smtp_encryption, $smtp_ssl_cert_path);
@@ -211,6 +214,8 @@ my %config_bool_settings = (
     "chainreplyto" => [\$chain_reply_to, 0],
     "suppressfrom" => [\$suppress_from, undef],
     "signedoffbycc" => [\$signed_off_by_cc, undef],
+    "cccover" => [\$cover_cc, undef],
+    "tocover" => [\$cover_to, undef],
     "signedoffcc" => [\$signed_off_by_cc, undef],      # Deprecated
     "validate" => [\$validate, 1],
     "multiedit" => [\$multiedit, undef],
@@ -302,6 +307,8 @@ my $rc = GetOptions("h" => \$help,
 		    "suppress-from!" => \$suppress_from,
 		    "suppress-cc=s" => \@suppress_cc,
 		    "signed-off-cc|signed-off-by-cc!" => \$signed_off_by_cc,
+		    "cc-cover|cc-cover!" => \$cover_cc,
+		    "to-cover|to-cover!" => \$cover_to,
 		    "confirm=s" => \$confirm,
 		    "dry-run" => \$dry_run,
 		    "envelope-sender=s" => \$envelope_sender,
@@ -1469,6 +1476,15 @@ foreach my $t (@files) {
 	@to = (@initial_to, @to);
 	@cc = (@initial_cc, @cc);
 
+	if ($message_num == 1) {
+		if (defined $cover_cc and $cover_cc) {
+			@initial_cc = @cc;
+		}
+		if (defined $cover_to and $cover_to) {
+			@initial_to = @to;
+		}
+	}
+
 	my $message_was_sent = send_message();
 
 	# set up for the next message
-- 
MST
