From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH 3/3] git send-email: turn --compose on when more than one patch.
Date: Fri, 31 Oct 2008 13:36:49 +0100
Message-ID: <1225456609-694-4-git-send-email-madcoder@debian.org>
References: <1225450632-7230-1-git-send-email-madcoder@debian.org>
 <1225456609-694-1-git-send-email-madcoder@debian.org>
 <1225456609-694-2-git-send-email-madcoder@debian.org>
 <1225456609-694-3-git-send-email-madcoder@debian.org>
Cc: Pierre Habouzit <madcoder@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 31 13:38:52 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvtGX-00007v-8Y
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 13:38:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751271AbYJaMgx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 08:36:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751262AbYJaMgx
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 08:36:53 -0400
Received: from pan.madism.org ([88.191.52.104]:54660 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751127AbYJaMgw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 08:36:52 -0400
Received: from madism.org (def92-12-88-177-251-208.fbx.proxad.net [88.177.251.208])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 2C6593B5AB;
	Fri, 31 Oct 2008 13:36:51 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 44A815EE240; Fri, 31 Oct 2008 13:36:49 +0100 (CET)
X-Mailer: git-send-email 1.6.0.3.763.g0275.dirty
In-Reply-To: <1225456609-694-3-git-send-email-madcoder@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99584>

Automatically turn --compose on when there is more than one patch, and
that the output is a tty.

Do not print the list of files sent anymore in that case, as the list is
shown in the summary editor.

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 git-send-email.perl |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 5c189a7..5cebb40 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -49,7 +49,7 @@ git send-email [options] <file | directory | rev-list >
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
@@ -409,7 +409,11 @@ if ($validate) {
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
1.6.0.3.763.g0275.dirty
