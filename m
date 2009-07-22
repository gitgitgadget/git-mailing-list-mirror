From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 2/2] Improve doc for format-patch threading options.
Date: Wed, 22 Jul 2009 23:39:31 +0200
Message-ID: <1248298771-21075-3-git-send-email-ydirson@altern.org>
References: <1248298771-21075-1-git-send-email-ydirson@altern.org>
 <1248298771-21075-2-git-send-email-ydirson@altern.org>
Cc: Yann Dirson <ydirson@altern.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 22 23:40:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTjXb-0000vv-8h
	for gcvg-git-2@gmane.org; Wed, 22 Jul 2009 23:39:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753106AbZGVVjr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jul 2009 17:39:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753400AbZGVVjr
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jul 2009 17:39:47 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:58188 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753049AbZGVVjp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jul 2009 17:39:45 -0400
Received: from smtp1-g21.free.fr (localhost [127.0.0.1])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 059819400E5;
	Wed, 22 Jul 2009 23:39:39 +0200 (CEST)
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp1-g21.free.fr (Postfix) with ESMTP id C296F94010B;
	Wed, 22 Jul 2009 23:39:36 +0200 (CEST)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 1E23CA005; Wed, 22 Jul 2009 23:39:51 +0200 (CEST)
X-Mailer: git-send-email 1.6.4.rc1.12.g05859c
In-Reply-To: <1248298771-21075-2-git-send-email-ydirson@altern.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123778>

This hopefully makes the relationship between threading options of
format-patch and send-email easier to grasp.

Signed-off-by: Yann Dirson <ydirson@altern.org>
---
 Documentation/git-format-patch.txt |   22 +++++++++++++++-------
 Documentation/git-send-email.txt   |   21 ++++++++++++++++-----
 2 files changed, 31 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 6f1fc80..687e667 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git format-patch' [-k] [(-o|--output-directory) <dir> | --stdout]
-		   [--thread[=<style>]]
+		   [--no-thread | --thread[=<style>]]
 		   [(--attach|--inline)[=<boundary>] | --no-attach]
 		   [-s | --signoff]
 		   [-n | --numbered | -N | --no-numbered]
@@ -124,17 +124,25 @@ include::diff-options.txt[]
 	second part, with "Content-Disposition: inline".
 
 --thread[=<style>]::
-	Add In-Reply-To and References headers to make the second and
-	subsequent mails appear as replies to the first.  Also generates
-	the Message-Id header to reference.
+--no-thread::
+	Controls addition of In-Reply-To and References headers to
+	make the second and subsequent mails appear as replies to the
+	first.  Also controls generation of the Message-Id header to
+	reference.
 +
 The optional <style> argument can be either `shallow` or `deep`.
 'shallow' threading makes every mail a reply to the head of the
 series, where the head is chosen from the cover letter, the
 `\--in-reply-to`, and the first patch mail, in this order.  'deep'
-threading makes every mail a reply to the previous one.  If not
-specified, defaults to the 'format.thread' configuration, or `shallow`
-if that is not set.
+threading makes every mail a reply to the previous one.
++
+The default is --no-thread, unless the 'format.thread' configuration
+is set.  If --thread is specified without a style, it defaults to the
+style specified by 'format.thread' if any, or else `shallow`.
++
+Beware that the default for 'git send-email' is to thread emails
+itself.  If you want 'git format-patch' to take care of hreading, you
+will want to ensure that threading is disabled for 'git send-email'.
 
 --in-reply-to=Message-Id::
 	Make the first mail (or all the mails with --no-thread) appear as a
diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index fbde2d3..d6b192b 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -212,11 +212,22 @@ specified, as well as 'body' if --no-signed-off-cc is specified.
 	value; if that is unspecified, default to --no-suppress-from.
 
 --[no-]thread::
-	If this is set, the In-Reply-To header will be set on each email sent.
-	If disabled with "--no-thread", no emails will have the In-Reply-To
-	header set, unless specified with --in-reply-to.
-	Default is the value of the 'sendemail.thread' configuration
-	value; if that is unspecified, default to --thread.
+	If this is set, the In-Reply-To and References headers will be
+	added to each email sent.  Whether each mail refers to the
+	previous email (`deep` threading per 'git format-patch'
+	wording) or to the first email (`shallow` threading) is
+	governed by "--[no-]chain-reply-to".
++
+If disabled with "--no-thread", those headers will not be added
+(unless specified with --in-reply-to).  Default is the value of the
+'sendemail.thread' configuration value; if that is unspecified,
+default to --thread.
++
+It is up to the user to ensure that no In-Reply-To header already
+exists when 'git send-email' is asked to add it (especially note that
+'git format-patch' can be configured to do the threading itself).
+Failure to do so may not produce the expected result in the
+recipient's MUA.
 
 
 Administering
-- 
1.6.4.rc1.12.g05859c
