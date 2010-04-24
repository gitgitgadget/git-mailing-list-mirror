From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 5/5] gitweb: Move generating page title to separate subroutine
Date: Sat, 24 Apr 2010 16:01:10 +0200
Message-ID: <20100424140019.30511.55366.stgit@localhost.localdomain>
References: <20100424132255.30511.98829.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 24 16:01:50 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5fvV-0004Nt-Ee
	for gcvg-git-2@lo.gmane.org; Sat, 24 Apr 2010 16:01:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751834Ab0DXOBj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Apr 2010 10:01:39 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:46620 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750910Ab0DXOBi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Apr 2010 10:01:38 -0400
Received: by bwz19 with SMTP id 19so259643bwz.21
        for <git@vger.kernel.org>; Sat, 24 Apr 2010 07:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:subject:to:cc
         :date:message-id:in-reply-to:references:user-agent:mime-version
         :content-type:content-transfer-encoding;
        bh=VGRTCzZNh2bek06uIxkpHH/3qsLfVqkt2O9fDCUbHZ0=;
        b=LkHpQwpTWF3WT0YqDFHM9w2gYqF1iVJB2/S5m/WlffLabKrwkzS6js/gzl4PAWLVqI
         45aKn41mLAI9FkGNbpVMKpYTg5N9zyRZWYdv9rCJKBzxg2JDa5YiNEDSe/x2kfyQ1f5i
         yaKICArKKrsRRMgN8qnWscRXR6ueqxeWKY6g8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:subject:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-type:content-transfer-encoding;
        b=H4hgvcJNhTzmSsOF8nySd+dxHUjEVUwkCn3O/djcCfOv3alcUoVtKmH4LCse7fu2pi
         dk4Th0iorLt5IRuNkEdrBeyhfZDydFZpMj88tIPrXZ2a3AY+YRDcZX13Wht7Ve8K1DcL
         i3Hgso0JCMGUVQNYrvsfqDFXAA7j9tv23StGg=
Received: by 10.204.3.147 with SMTP id 19mr930067bkn.42.1272117697094;
        Sat, 24 Apr 2010 07:01:37 -0700 (PDT)
Received: from localhost.localdomain (abvk50.neoplus.adsl.tpnet.pl [83.8.208.50])
        by mx.google.com with ESMTPS id 13sm843061bwz.11.2010.04.24.07.01.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 24 Apr 2010 07:01:36 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o3OE1AYO031132;
	Sat, 24 Apr 2010 16:01:20 +0200
In-Reply-To: <20100424132255.30511.98829.stgit@localhost.localdomain>
User-Agent: StGIT/0.14.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145680>

get_page_title subroutine is currently used only in git_header_html.
Nevertheless refactoring title generation allowed to reduce indent
level.

[It would be used in more than one callsite in the patch adding
caching activity indicator to gitweb.]

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Refactoring.

 gitweb/gitweb.perl |   32 +++++++++++++++++++-------------
 1 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index e579c14..7d75dc4 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3179,24 +3179,30 @@ sub blob_contenttype {
 ## ======================================================================
 ## functions printing HTML: header, footer, error page
 
+sub get_page_title {
+	my $title = to_utf8($site_name);
+
+	return $title unless (defined $project);
+	$title .= " - " . to_utf8($project);
+
+	return $title unless (defined $action);
+	$title .= "/$action"; # $action is US-ASCII (7bit ASCII)
+
+	return $title unless (defined $file_name);
+	$title .= " - " . esc_path($file_name);
+	if ($action eq "tree" && $file_name !~ m|/$|) {
+		$title .= "/";
+	}
+
+	return $title;
+}
+
 sub git_header_html {
 	my $status = shift || "200 OK";
 	my $expires = shift;
 	my %opts = @_;
 
-	my $title = "$site_name";
-	if (defined $project) {
-		$title .= " - " . to_utf8($project);
-		if (defined $action) {
-			$title .= "/$action";
-			if (defined $file_name) {
-				$title .= " - " . esc_path($file_name);
-				if ($action eq "tree" && $file_name !~ m|/$|) {
-					$title .= "/";
-				}
-			}
-		}
-	}
+	my $title = get_page_title();
 	my $content_type;
 	# require explicit support from the UA if we are to send the page as
 	# 'application/xhtml+xml', otherwise send it as plain old 'text/html'.
