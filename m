From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH] git-send-email: two new options: to-cover, cc-cover
Date: Wed, 2 Oct 2013 09:08:52 +0300
Message-ID: <20131002060852.GA29574@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 02 08:06:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VRFZy-0000uN-T9
	for gcvg-git-2@plane.gmane.org; Wed, 02 Oct 2013 08:06:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753216Ab3JBGGb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Oct 2013 02:06:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:23083 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752995Ab3JBGGa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Oct 2013 02:06:30 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r9266U1d027580
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <git@vger.kernel.org>; Wed, 2 Oct 2013 02:06:30 -0400
Received: from redhat.com (vpn1-4-190.ams2.redhat.com [10.36.4.190])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id r9266SZu005134
	for <git@vger.kernel.org>; Wed, 2 Oct 2013 02:06:29 -0400
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.24
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235663>

Allow extracting To/Cc addresses from cover letter.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

Is there interest in this kind of feature?
I find it easier than adding --cc to send-email command line.

 git-send-email.perl | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/git-send-email.perl b/git-send-email.perl
index faf93fc..9c6ed29 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -80,6 +80,8 @@ git send-email [options] <file | directory | rev-list options >
     --to-cmd                <str>  * Email To: via `<str> \$patch_path`
     --cc-cmd                <str>  * Email Cc: via `<str> \$patch_path`
     --suppress-cc           <str>  * author, self, sob, cc, cccmd, body, bodycc, all.
+    --[no-]cc-cover                * Email Cc: addresses in the cover letter.
+    --[no-]to-cover                * Email To: addresses in the cover letter. Default on.
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
@@ -1464,6 +1471,15 @@ foreach my $t (@files) {
 	@to = (@initial_to, @to);
 	@cc = (@initial_cc, @cc);
 
+	if ($message_num == 1) {
+		if (defined $cover_cc and $cover_cc) {
+			@initial_cc = @cc;
+		}
+		if (not defined $cover_to or $cover_to) {
+			@initial_to = @to;
+		}
+	}
+
 	my $message_was_sent = send_message();
 
 	# set up for the next message
-- 
MST
