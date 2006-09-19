From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 1/2] gitweb: Always use git-peek-remote in git_get_references
Date: Tue, 19 Sep 2006 14:31:49 +0200
Message-ID: <200609191431.49641.jnareb@gmail.com>
References: <200609191430.51252.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Sep 19 14:32:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPemQ-0003P0-Fg
	for gcvg-git@gmane.org; Tue, 19 Sep 2006 14:32:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030219AbWISMcr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Sep 2006 08:32:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030217AbWISMcr
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Sep 2006 08:32:47 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:60054 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030219AbWISMcq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Sep 2006 08:32:46 -0400
Received: by nf-out-0910.google.com with SMTP id o25so136673nfa
        for <git@vger.kernel.org>; Tue, 19 Sep 2006 05:32:45 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=nNlqzZNDY6cb3JGpp4gGRpivHHZCHRAFVHqioGTN/OOQGc9dhxNC5tXEIwtcLpOfGKkPvnRIrF7l+oz07ssa5lJIVgyQuncu4mxRnIDGGtglO71QpBizXsHIXBp2GpNFyOUn5ZPHrN/3mEZ7uzKqyoHBQUC2l6jA3SWPRxQfRd0=
Received: by 10.78.183.15 with SMTP id g15mr3454681huf;
        Tue, 19 Sep 2006 05:32:45 -0700 (PDT)
Received: from host-81-190-25-93.torun.mm.pl ( [81.190.25.93])
        by mx.gmail.com with ESMTP id 3sm10953092hud.2006.09.19.05.32.44;
        Tue, 19 Sep 2006 05:32:44 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200609191430.51252.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27274>

Instead of trying to read info/refs file, which might not be present
(we did fallback to git-ls-remote), always use git-peek-remote in
git_get_references.

It is preparation for git_get_refs_info to also return references
info. We cannot use info/refs for git_get_refs_info as the information
contained therein is usually stale.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |   10 ++--------
 1 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index c77270c..034a88c 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -828,16 +828,10 @@ sub git_get_project_owner {
 sub git_get_references {
 	my $type = shift || "";
 	my %refs;
-	my $fd;
 	# 5dc01c595e6c6ec9ccda4f6f69c131c0dd945f8c	refs/tags/v2.6.11
 	# c39ae07f393806ccf406ef966e9a15afc43cc36a	refs/tags/v2.6.11^{}
-	if (-f "$projectroot/$project/info/refs") {
-		open $fd, "$projectroot/$project/info/refs"
-			or return;
-	} else {
-		open $fd, "-|", git_cmd(), "ls-remote", "."
-			or return;
-	}
+	open my $fd, "-|", $GIT, "peek-remote", "$projectroot/$project/"
+		or return;
 
 	while (my $line = <$fd>) {
 		chomp $line;
-- 
1.4.2.1
