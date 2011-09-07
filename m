From: Georgi Chorbadzhiyski <gf@unixsol.org>
Subject: [PATCH] send-mail: Add option to sleep between sending each email.
Date: Wed,  7 Sep 2011 23:43:11 +0300
Message-ID: <1315428191-9769-1-git-send-email-gf@unixsol.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 07 23:02:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1PGf-0005uB-8v
	for gcvg-git-2@lo.gmane.org; Wed, 07 Sep 2011 23:02:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756939Ab1IGVCk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Sep 2011 17:02:40 -0400
Received: from ns.unixsol.org ([193.110.159.2]:37995 "EHLO ns.unixsol.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754442Ab1IGVCj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Sep 2011 17:02:39 -0400
X-Greylist: delayed 1158 seconds by postgrey-1.27 at vger.kernel.org; Wed, 07 Sep 2011 17:02:39 EDT
Received: (qmail 18435 invoked by uid 0); 7 Sep 2011 23:43:20 +0300
Received: from gf.unixsol.bg (10.0.1.78)
  by ns.unixsol.org with SMTP; 7 Sep 2011 23:43:20 +0300
X-Mailer: git-send-email 1.7.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180909>

Sometimes when sending lots of changes it is not nice
to send emails as fast as possible. Of course you can
confirm each email after waiting couple of seconds but
this is not optimal. This patch adds --sleep option
to git-send-mail and corresponding sendmail.sleep config
variable to control how much seconds to wait between
sending each email. The default is 0 (not wait at all).

Signed-off-by: Georgi Chorbadzhiyski <gf@unixsol.org>
---
 Documentation/git-send-email.txt |    6 ++++++
 git-send-email.perl              |   13 ++++++++++++-
 2 files changed, 18 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 327233c..2ceb69f 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -298,6 +298,9 @@ Default is the value of 'sendemail.confirm' configuration value; if that
 is unspecified, default to 'auto' unless any of the suppress options
 have been specified, in which case default to 'compose'.
 
+--sleep=<seconds>::
+	How many seconds to wait between sending each email.
+
 --dry-run::
 	Do everything except actually send the emails.
 
@@ -349,6 +352,9 @@ sendemail.confirm::
 	one of 'always', 'never', 'cc', 'compose', or 'auto'. See '--confirm'
 	in the previous section for the meaning of these values.
 
+sendemail.sleep::
+	Sets how many seconds to wait between sending each email.
+
 EXAMPLE
 -------
 Use gmail as the smtp server
diff --git a/git-send-email.perl b/git-send-email.perl
index 98ab33a..7239fd4 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -84,6 +84,7 @@ git send-email [options] <file | directory | rev-list options >
   Administering:
     --confirm               <str>  * Confirm recipients before sending;
                                      auto, cc, compose, always, or never.
+    --sleep                 <int>  * Sleep <int> seconds between sending mails.
     --quiet                        * Output one line of info per email.
     --dry-run                      * Don't actually send the emails.
     --[no-]validate                * Perform patch sanity checks. Default on.
@@ -195,7 +196,7 @@ my ($to_cmd, $cc_cmd);
 my ($smtp_server, $smtp_server_port, @smtp_server_options);
 my ($smtp_authuser, $smtp_encryption);
 my ($identity, $aliasfiletype, @alias_files, $smtp_domain);
-my ($validate, $confirm);
+my ($validate, $confirm, $sleep);
 my (@suppress_cc);
 my ($auto_8bit_encoding);
 
@@ -230,6 +231,7 @@ my %config_settings = (
     "envelopesender" => \$envelope_sender,
     "multiedit" => \$multiedit,
     "confirm"   => \$confirm,
+    "sleep" => \$sleep,
     "from" => \$sender,
     "assume8bitencoding" => \$auto_8bit_encoding,
 );
@@ -304,6 +306,7 @@ my $rc = GetOptions("sender|from=s" => \$sender,
 		    "suppress-cc=s" => \@suppress_cc,
 		    "signed-off-cc|signed-off-by-cc!" => \$signed_off_by_cc,
 		    "confirm=s" => \$confirm,
+		    "sleep:i" => \$sleep,
 		    "dry-run" => \$dry_run,
 		    "envelope-sender=s" => \$envelope_sender,
 		    "thread!" => \$thread,
@@ -405,6 +408,9 @@ if ($confirm_unconfigured) {
 die "Unknown --confirm setting: '$confirm'\n"
 	unless $confirm =~ /^(?:auto|cc|compose|always|never)/;
 
+# Set sleep's default value
+$sleep = 0 if (!defined $sleep);
+
 # Debugging, print out the suppressions.
 if (0) {
 	print "suppressions:\n";
@@ -1143,6 +1149,11 @@ X-Mailer: git-send-email $gitversion
 		}
 	}
 
+	if (!$dry_run && $sleep) {
+		print "Sleeping: $sleep second(s).\n" if (!$quiet);
+		sleep($sleep);
+	};
+
 	return 1;
 }
 
-- 
1.7.5.1
