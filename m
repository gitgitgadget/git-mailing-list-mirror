From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] send-email: make annotate configurable
Date: Sat,  7 Apr 2012 03:29:09 +0300
Message-ID: <1333758550-9187-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	"Yann Dirson" <ydirson@altern.org>,
	"Michael Witten" <mfwitten@MIT.EDU>,
	"Ryan Anderson" <ryan@michonline.com>,
	"Michael Witten" <mfwitten@gmail.com>,
	"Matthieu Moy" <Matthieu.Moy@imag.fr>,
	"Adam Roben" <aroben@apple.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 07 02:29:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGJX3-0008B3-1Q
	for gcvg-git-2@plane.gmane.org; Sat, 07 Apr 2012 02:29:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754270Ab2DGA32 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Apr 2012 20:29:28 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:54427 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752446Ab2DGA32 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Apr 2012 20:29:28 -0400
Received: by lbbgg6 with SMTP id gg6so945133lbb.19
        for <git@vger.kernel.org>; Fri, 06 Apr 2012 17:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=Qop3w3XfVTu/Hw0NCwrhrhvoKRRM/jILxpO4Oo6UseQ=;
        b=Q3cR05vWvOQ1bdfPRdQQaM3aA17CW4dJ+c5uXIsXhIbnWkwuqpFlqt1gI5JqDDrRoq
         Jr1l4TmCGAQN9kTymE8RCSLDdvasAQXbx/yRUs32tojqMeMiVw/WvVG6eBvgr6ew1hDH
         rymifs0w2pAceCaTeG4mOlfukE+odDFxuzP2M/vjA8xPSuHUT4K8Ci2v966QfLXsiRcK
         sanCafrWgVRCWqDIswFfzAWZHBl6iGOAhDQm1GbA+3DoXQGwoVUf4OlI5lVg1KOaJC0j
         aR2MYpUnTxeZygKV2ek8rGdKhsnuIra/YHWiW1kEtzuv7K80hHBfh+By2qwZnYse1y1p
         b+0w==
Received: by 10.152.127.136 with SMTP id ng8mr11230312lab.16.1333758566438;
        Fri, 06 Apr 2012 17:29:26 -0700 (PDT)
Received: from localhost (80-186-93-53.elisa-mobile.fi. [80.186.93.53])
        by mx.google.com with ESMTPS id u4sm7859137lad.5.2012.04.06.17.29.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 06 Apr 2012 17:29:25 -0700 (PDT)
X-Mailer: git-send-email 1.7.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194928>

Some people always do --annotate, lets not force them to always type
that.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/config.txt         |    1 +
 Documentation/git-send-email.txt |    5 +++--
 git-send-email.perl              |    3 ++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index c081657..90c9e1b 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1828,6 +1828,7 @@ sendemail.<identity>.*::
 
 sendemail.aliasesfile::
 sendemail.aliasfiletype::
+sendemail.annotate::
 sendemail.bcc::
 sendemail.cc::
 sendemail.cccmd::
diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 3241170..2106fea 100644
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
index ef30c55..6ef2d34 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -210,7 +210,8 @@ my %config_bool_settings = (
     "signedoffbycc" => [\$signed_off_by_cc, undef],
     "signedoffcc" => [\$signed_off_by_cc, undef],      # Deprecated
     "validate" => [\$validate, 1],
-    "multiedit" => [\$multiedit, undef]
+    "multiedit" => [\$multiedit, undef],
+    "annotate" => [\$annotate, undef]
 );
 
 my %config_settings = (
-- 
1.7.10
