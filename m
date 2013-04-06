From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 1/2] send-email: make annotate configurable
Date: Sat,  6 Apr 2013 03:03:31 -0600
Message-ID: <1365239012-15079-2-git-send-email-felipe.contreras@gmail.com>
References: <1365239012-15079-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Thomas Rast <trast@student.ethz.ch>,
	Stephen Boyd <bebarino@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 06 19:46:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOWTF-0001b9-Sz
	for gcvg-git-2@plane.gmane.org; Sat, 06 Apr 2013 19:00:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932840Ab3DFJEl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Apr 2013 05:04:41 -0400
Received: from mail-ob0-f180.google.com ([209.85.214.180]:41580 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932834Ab3DFJEj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Apr 2013 05:04:39 -0400
Received: by mail-ob0-f180.google.com with SMTP id un3so189124obb.25
        for <git@vger.kernel.org>; Sat, 06 Apr 2013 02:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=+6/0q6mi2hlJBEC54owzoYjcUuslMuGiDZ4TAe+7OFQ=;
        b=sKdh+z/QNpLx5Hz80oMS1pUBjFQkapeu2N1evyHpl7oN1KD6PLyn0H68EHa6MjoSNg
         QGfNe6oLgMBSF/ZMpIa4AlCkvmPVe90HZjymscBtf1aoS+iFzH8CfgkPZqF8G9WkhTqb
         JMjoOTyVZJ0eZSuslQ68TfzwtkjFp0W6TlyTW3DE7jdmEwInq7GYNrdQVE0ySvKz47Ux
         cz5YFPs7VoTCVViFb/zJTL2eew5J/8j9NvONub8Hwf2rdfvi/aKxB2gYugpp4oNPOAk6
         DmXVvKj7ikGRT1UJjHzKICZtV8R9ML1GdCS2aV4YAvqlZMpGcaQ6MmjnCHpE2u6EBuY6
         yXWA==
X-Received: by 10.60.85.35 with SMTP id e3mr10647027oez.117.1365239079352;
        Sat, 06 Apr 2013 02:04:39 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id c4sm15241130obo.9.2013.04.06.02.04.36
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 06 Apr 2013 02:04:38 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <1365239012-15079-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220232>

Some people always do --annotate, lets not force them to always type
that.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/config.txt         |  1 +
 Documentation/git-send-email.txt |  5 +++--
 git-send-email.perl              | 12 +++++++++---
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index bbba728..c8e2178 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1994,6 +1994,7 @@ sendemail.<identity>.*::
 
 sendemail.aliasesfile::
 sendemail.aliasfiletype::
+sendemail.annotate::
 sendemail.bcc::
 sendemail.cc::
 sendemail.cccmd::
diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 44a1f7c..2facc18 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -45,8 +45,9 @@ Composing
 ~~~~~~~~~
 
 --annotate::
-	Review and edit each patch you're about to send. See the
-	CONFIGURATION section for 'sendemail.multiedit'.
+	Review and edit each patch you're about to send. Default is the value
+	of 'sendemail.annotate'. See the CONFIGURATION section for
+	'sendemail.multiedit'.
 
 --bcc=<address>::
 	Specify a "Bcc:" value for each email. Default is the value of
diff --git a/git-send-email.perl b/git-send-email.perl
index be809e5..e7fe9fb 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -54,7 +54,7 @@ git send-email [options] <file | directory | rev-list options >
     --[no-]bcc              <str>  * Email Bcc:
     --subject               <str>  * Email "Subject:"
     --in-reply-to           <str>  * Email "In-Reply-To:"
-    --annotate                     * Review each patch that will be sent in an editor.
+    --[no-]annotate                * Review each patch that will be sent in an editor.
     --compose                      * Open an editor for introduction.
     --compose-encoding      <str>  * Encoding to assume for introduction.
     --8bit-encoding         <str>  * Encoding to assume 8bit mails if undeclared
@@ -143,7 +143,7 @@ my $auth;
 # Variables we fill in automatically, or via prompting:
 my (@to,$no_to,@initial_to,@cc,$no_cc,@initial_cc,@bcclist,$no_bcc,@xh,
 	$initial_reply_to,$initial_subject,@files,
-	$author,$sender,$smtp_authpass,$annotate,$compose,$time);
+	$author,$sender,$smtp_authpass,$annotate,$no_annotate,$compose,$time);
 
 my $envelope_sender;
 
@@ -212,7 +212,8 @@ my %config_bool_settings = (
     "signedoffbycc" => [\$signed_off_by_cc, undef],
     "signedoffcc" => [\$signed_off_by_cc, undef],      # Deprecated
     "validate" => [\$validate, 1],
-    "multiedit" => [\$multiedit, undef]
+    "multiedit" => [\$multiedit, undef],
+    "annotate" => [\$annotate, undef]
 );
 
 my %config_settings = (
@@ -305,6 +306,7 @@ my $rc = GetOptions("h" => \$help,
 		    "smtp-domain:s" => \$smtp_domain,
 		    "identity=s" => \$identity,
 		    "annotate" => \$annotate,
+		    "no-annotate" => \$no_annotate,
 		    "compose" => \$compose,
 		    "quiet" => \$quiet,
 		    "cc-cmd=s" => \$cc_cmd,
@@ -389,6 +391,10 @@ foreach my $setting (values %config_bool_settings) {
 	${$setting->[0]} = $setting->[1] unless (defined (${$setting->[0]}));
 }
 
+if ($no_annotate) {
+	$annotate = 0;
+}
+
 # 'default' encryption is none -- this only prevents a warning
 $smtp_encryption = '' unless (defined $smtp_encryption);
 
-- 
1.8.2
