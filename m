From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 1/6] send-email: make annotate configurable
Date: Sun,  7 Apr 2013 12:46:19 -0500
Message-ID: <1365356784-24872-2-git-send-email-felipe.contreras@gmail.com>
References: <1365356784-24872-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Thomas Rast <trast@student.ethz.ch>,
	Stephen Boyd <bebarino@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 07 19:47:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOtgt-00030a-UC
	for gcvg-git-2@plane.gmane.org; Sun, 07 Apr 2013 19:47:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934196Ab3DGRrl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Apr 2013 13:47:41 -0400
Received: from mail-oa0-f48.google.com ([209.85.219.48]:39120 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934159Ab3DGRrl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Apr 2013 13:47:41 -0400
Received: by mail-oa0-f48.google.com with SMTP id j1so5349003oag.7
        for <git@vger.kernel.org>; Sun, 07 Apr 2013 10:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=5SJs78H4+VfuOsGU4fONKy4KJBwV/4zjDizuQnfCMV4=;
        b=J1j5Gwco1sqEKjpz9Lx4xQnihWuhv159TAlLBvHoNOgEWJMVvjXBQcg1AKV0dc1/oG
         kaUeT1g+Y1/FHlpJcybR+0wElEm5OAGPkhIwAyAZCMQfXJanWHAZxUWPkoHmlAmvKaj7
         3t8B+h1ehXChaLTAdIqSRzKwFJlhwlDdUwBT1vzRb/nigxz9L9Yf6X2FCbWHDKeRZjvb
         iLnqcR0rybXjpdZ2NSGtQvx+ZPZ2lcoNGoRzkW65hxom76L93hregTgutEiuqqMSD6/L
         chovE5IPocUilfsgDa9hfCU87mqEtBz0CMWeA9yb54z1TSH0n4an6tDBzXpMl2i46kS4
         7Uig==
X-Received: by 10.60.117.233 with SMTP id kh9mr5418380oeb.50.1365356859518;
        Sun, 07 Apr 2013 10:47:39 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id xz9sm21540048oeb.5.2013.04.07.10.47.35
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 07 Apr 2013 10:47:38 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <1365356784-24872-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220340>

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
