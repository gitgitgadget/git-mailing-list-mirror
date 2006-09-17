From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 1/2] gitweb: Always use git-peek-remote in git_get_references
Date: Sun, 17 Sep 2006 02:37:00 +0200
Message-ID: <200609170237.00593.jnareb@gmail.com>
References: <200609170226.39330.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Sep 17 02:36:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GOke5-00089E-Rq
	for gcvg-git@gmane.org; Sun, 17 Sep 2006 02:36:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964885AbWIQAg0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Sep 2006 20:36:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964886AbWIQAg0
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Sep 2006 20:36:26 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:12311 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S964885AbWIQAgZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Sep 2006 20:36:25 -0400
Received: by ug-out-1314.google.com with SMTP id o38so263535ugd
        for <git@vger.kernel.org>; Sat, 16 Sep 2006 17:36:24 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Ic0H0kKa6TjNbMzlFUm3sBUUeGVCRcnezzhDn3bRE/OE7PmFEE7IrNcANBL0Tl7CnOoTZOKwtwH5X5AEM20jlTpdEpTqG2X4lr6oSQsFplWzE7XItmjDAURPtoY+yqM6uCaCKaroy0729pZSB27qittiP9OETCyJn8ZNyauNcVA=
Received: by 10.66.216.20 with SMTP id o20mr6282350ugg;
        Sat, 16 Sep 2006 17:36:23 -0700 (PDT)
Received: from roke.d-201 ( [193.0.122.19])
        by mx.gmail.com with ESMTP id y7sm2097353ugc.2006.09.16.17.36.22;
        Sat, 16 Sep 2006 17:36:23 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200609170226.39330.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27144>

Instead of trying to read info/refs file, which might not be present
(we did fallback to git-ls-remote), always use git-peek-remote in
git_get_references.

It is preparation for git_get_refs_info to also return references
info. We cannot use info/refs for git_get_refs_info as the information
contained therein is usually stale.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This patch should be before the one it is reply to, i.e.
  gitweb:  Make git_get_refs_list do work of git_get_references

 gitweb/gitweb.perl |   10 ++--------
 1 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index a81c8d4..8c3c13d 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -786,16 +786,10 @@ sub git_get_project_owner {
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
