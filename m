From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 1/4] send-email: make annotate configurable
Date: Sun,  7 Apr 2013 01:10:27 -0600
Message-ID: <1365318630-11882-2-git-send-email-felipe.contreras@gmail.com>
References: <1365318630-11882-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Thomas Rast <trast@student.ethz.ch>,
	Stephen Boyd <bebarino@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 07 09:11:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOjlN-0000Ky-Vm
	for gcvg-git-2@plane.gmane.org; Sun, 07 Apr 2013 09:11:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756972Ab3DGHLd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Apr 2013 03:11:33 -0400
Received: from mail-oa0-f53.google.com ([209.85.219.53]:35993 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756115Ab3DGHLc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Apr 2013 03:11:32 -0400
Received: by mail-oa0-f53.google.com with SMTP id m17so5222930oag.26
        for <git@vger.kernel.org>; Sun, 07 Apr 2013 00:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=5SJs78H4+VfuOsGU4fONKy4KJBwV/4zjDizuQnfCMV4=;
        b=IKwwS42n8HpJLgjNz2X2KW+97GWPmkRxYR8iLXJbFsedT9qGGJetejb7URedlVWlJj
         AH2/mi53xA2aV+v1e2H2qp6er5EYu92GukUOlgULcXTi80qRuPOrh89A+Y6Pfmt3rTXE
         lNZNMcRbNDz31uNx2J6cE+yUUT0XjOuWg+wn15Fh+w1FDxVeYSi2oqz5FhyoAvqiqFvH
         mQbhPVTIOmD6M3ziD/QoBf1m0cem5DlUsFTAYqoUP1v98vDqp3rS/Z7KRsM+dd5SyyvG
         H/FsevY2rRGRZGOx662bDQTyvApdt6nGUt/Cmmk9kdM3MKaTZVgarFS/D4QrG6FGQdu4
         jYSA==
X-Received: by 10.182.190.19 with SMTP id gm19mr12026651obc.34.1365318691800;
        Sun, 07 Apr 2013 00:11:31 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id n1sm19154417obc.10.2013.04.07.00.11.30
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 07 Apr 2013 00:11:30 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <1365318630-11882-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220283>

Some people always do --annotate, lets not force them to always type
that.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/config.txt         | 1 +
 Documentation/git-send-email.txt | 5 +++--
 git-send-email.perl              | 7 ++++---
 3 files changed, 8 insertions(+), 5 deletions(-)

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
index be809e5..e187b12 100755
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
@@ -212,7 +212,8 @@ my %config_bool_settings = (
     "signedoffbycc" => [\$signed_off_by_cc, undef],
     "signedoffcc" => [\$signed_off_by_cc, undef],      # Deprecated
     "validate" => [\$validate, 1],
-    "multiedit" => [\$multiedit, undef]
+    "multiedit" => [\$multiedit, undef],
+    "annotate" => [\$annotate, undef]
 );
 
 my %config_settings = (
@@ -304,7 +305,7 @@ my $rc = GetOptions("h" => \$help,
 		    "smtp-debug:i" => \$debug_net_smtp,
 		    "smtp-domain:s" => \$smtp_domain,
 		    "identity=s" => \$identity,
-		    "annotate" => \$annotate,
+		    "annotate!" => \$annotate,
 		    "compose" => \$compose,
 		    "quiet" => \$quiet,
 		    "cc-cmd=s" => \$cc_cmd,
-- 
1.8.2
