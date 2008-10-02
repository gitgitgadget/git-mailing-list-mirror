From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH (BUGFIX)] gitweb: Fix two 'uninitialized value' varnings in
	git_tree()
Date: Thu, 02 Oct 2008 16:50:04 +0200
Message-ID: <20081002144602.19247.4434.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 02 16:55:03 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlPWW-0002BP-Da
	for gcvg-git-2@gmane.org; Thu, 02 Oct 2008 16:51:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753925AbYJBOuN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2008 10:50:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753898AbYJBOuN
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Oct 2008 10:50:13 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:39178 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753805AbYJBOuL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2008 10:50:11 -0400
Received: by ug-out-1314.google.com with SMTP id k3so1034286ugf.37
        for <git@vger.kernel.org>; Thu, 02 Oct 2008 07:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:subject:to:cc
         :date:message-id:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=jh+54bzXAIs6kX16nQwQWEwTc/ZCUNbGTlM2Zb51lvQ=;
        b=dRk8sPBgRSXD91T1cNeXgJPtKGMa8gMvYD3li39pV2ZQMcjhEX77K5eMfD/C5fe9za
         FYCZMWXYPc9HpHV/38LHSIf/AMw0x+VARTR3EE+Yobi3FxdWlwd8j3QhbGZ9Dj1P0sLf
         gfBg2aTY/AJJP+WFXFJqiSGCuqbwOpQBHhi/k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:subject:to:cc:date:message-id:user-agent:mime-version
         :content-type:content-transfer-encoding;
        b=m00TIwygZOgu2Wsb5v6dgUWudLTcIPbYTkq1b35vUfWV547MmU4Pwm4NDam26rUm0u
         jAnWz3ykvnqjSpKOdt9lnCAw3T8UCYyA8U9C7k0V3AH4Sf27jFfS8fS728JDJOrI7aTF
         HTFkCCdRfHhnRupwDu06EnRXfk4tUk8zJvLSk=
Received: by 10.67.22.2 with SMTP id z2mr4044461ugi.34.1222959007946;
        Thu, 02 Oct 2008 07:50:07 -0700 (PDT)
Received: from localhost.localdomain (abwk221.neoplus.adsl.tpnet.pl [83.8.234.221])
        by mx.google.com with ESMTPS id b30sm1973325ika.9.2008.10.02.07.50.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 02 Oct 2008 07:50:06 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m92Eo4a5019298;
	Thu, 2 Oct 2008 16:50:05 +0200
User-Agent: StGIT/0.14.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97346>

If we did try to access nonexistent directory or file, which means
that git_get_hash_by_path() returns `undef`, uninitialized $hash
variable was passed to 'open' call.  Now we fail early with "404 Not
Found - No such tree" error.  (If we try to access something which
does not resolve to tree-ish, for example a file / 'blob' object, the
error will be caught later, as "404 Not Found - Reading tree failed"
error).

If we tried to use 'tree' action without $file_name ('f' parameter)
set, which means either tree given by hash or a top tree (and we
currently cannot distinguish between those two cases), we cannot print
path breadcrumbs with git_print_page_path().  Fix this by moving call
to git_print_page_path() inside conditional.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Those two errors were discovered when creating new basic test for
path_info (following). 

I was also thinking about alternate solution of using instead
"$hash_base:$file_name" for $hash, but it caused some errors I didn't
feel like debugging. Current diff is also smaller than mentioned
solution.

BTW. should we use "No such tree" or "No such directory".

 gitweb/gitweb.perl |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 18e70a3..bb20ed7 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -4445,6 +4445,7 @@ sub git_tree {
 			$hash = $hash_base;
 		}
 	}
+	die_error(404, "No such tree") unless defined($hash);
 	$/ = "\0";
 	open my $fd, "-|", git_cmd(), "ls-tree", '-z', $hash
 		or die_error(500, "Open git-ls-tree failed");
@@ -4485,8 +4486,8 @@ sub git_tree {
 		if ($basedir ne '' && substr($basedir, -1) ne '/') {
 			$basedir .= '/';
 		}
+		git_print_page_path($file_name, 'tree', $hash_base);
 	}
-	git_print_page_path($file_name, 'tree', $hash_base);
 	print "<div class=\"page_body\">\n";
 	print "<table class=\"tree\">\n";
 	my $alternate = 1;
