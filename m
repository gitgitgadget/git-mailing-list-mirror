From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH 5/5] git send-email: turn --compose on when more than one patch.
Date: Tue,  4 Nov 2008 17:24:18 +0100
Message-ID: <1225815858-30617-6-git-send-email-madcoder@debian.org>
References: <1225450632-7230-1-git-send-email-madcoder@debian.org>
 <1225815858-30617-1-git-send-email-madcoder@debian.org>
 <1225815858-30617-2-git-send-email-madcoder@debian.org>
 <1225815858-30617-3-git-send-email-madcoder@debian.org>
 <1225815858-30617-4-git-send-email-madcoder@debian.org>
 <1225815858-30617-5-git-send-email-madcoder@debian.org>
Cc: Pierre Habouzit <madcoder@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 04 17:25:47 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxOix-0006x8-5v
	for gcvg-git-2@gmane.org; Tue, 04 Nov 2008 17:25:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754926AbYKDQYc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Nov 2008 11:24:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754910AbYKDQYb
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Nov 2008 11:24:31 -0500
Received: from pan.madism.org ([88.191.52.104]:54660 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754814AbYKDQYX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Nov 2008 11:24:23 -0500
Received: from madism.org (unknown [213.223.38.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id C05AE3BFD0;
	Tue,  4 Nov 2008 17:24:22 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 75A57110A3F; Tue,  4 Nov 2008 17:24:18 +0100 (CET)
X-Mailer: git-send-email 1.6.0.3.844.gcde3
In-Reply-To: <1225815858-30617-5-git-send-email-madcoder@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100087>

Automatically turn --compose on when there is more than one patch, and
that the output is a tty.

Do not print the list of files sent anymore in that case, as the list is
shown in the summary editor.

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 git-send-email.perl |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index fd72127..3c7818f 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -51,7 +51,7 @@ git send-email [options] <file | directory | rev-list options >
     --subject               <str>  * Email "Subject:"
     --in-reply-to           <str>  * Email "In-Reply-To:"
     --annotate                     * Review each patch that will be sent in an editor.
-    --compose                      * Open an editor for introduction.
+    --[no-]compose                 * Open an editor for introduction.
 
   Sending:
     --envelope-sender       <str>  * Email envelope sender.
@@ -237,7 +237,7 @@ my $rc = GetOptions("sender|from=s" => \$sender,
 		    "smtp-encryption=s" => \$smtp_encryption,
 		    "identity=s" => \$identity,
 		    "annotate" => \$annotate,
-		    "compose" => \$compose,
+		    "compose!" => \$compose,
 		    "quiet" => \$quiet,
 		    "cc-cmd=s" => \$cc_cmd,
 		    "suppress-from!" => \$suppress_from,
@@ -425,7 +425,11 @@ if ($validate) {
 }
 
 if (@files) {
-	unless ($quiet) {
+	if (!defined($compose) && -t STDOUT) {
+		# turn $compose on if there is more than one file
+		$compose = $#files;
+	}
+	unless ($quiet || $compose) {
 		print $_,"\n" for (@files);
 	}
 } else {
-- 
1.5.6.5
