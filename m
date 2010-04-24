From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 3/5] gitweb: Use nonlocal jump instead of 'exit' in die_error
Date: Sat, 24 Apr 2010 15:56:13 +0200
Message-ID: <20100424135334.30511.26522.stgit@localhost.localdomain>
References: <20100424132255.30511.98829.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 24 15:56:45 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5fqf-0001WC-F9
	for gcvg-git-2@lo.gmane.org; Sat, 24 Apr 2010 15:56:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751405Ab0DXN4l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Apr 2010 09:56:41 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:46362 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751034Ab0DXN4k (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Apr 2010 09:56:40 -0400
Received: by wwg30 with SMTP id 30so493520wwg.19
        for <git@vger.kernel.org>; Sat, 24 Apr 2010 06:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:subject:to:cc
         :date:message-id:in-reply-to:references:user-agent:mime-version
         :content-type:content-transfer-encoding;
        bh=1p9+HEtzy7481uOxjytACPVupKz8FtvCMrTrdPAcObc=;
        b=B/+ucnLZ7ptsWD9MZqRQx5vj9bXtua8/3M3JUqag8Njhp3dZmJeZd5lmhd7WeHS2s5
         EC00Bc4Tk8Ksfg5hQaTZ5KSA2IF5NanhdVZQ8fnh/dDowVBh075oGNiLojZ92zFjVr4F
         DrBJSrxIy6uaqh6GbF1xryxeRJLUYoCoqaSRM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:subject:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-type:content-transfer-encoding;
        b=jHxHM5x2+0ITRdbrGD2WaK8pKRPx1/DBINwx825r+geMITDAYBn0MCF1aEuUL273FR
         ZheFcEVyve1RQCcxU6cFOOhnFDOkDnvmFgSSr5tIpVOcX8Db1sKNFVgOvUNRKCz35VzF
         VyEYlMoZf8zHT69A+25JmTKfFg821v0affuiI=
Received: by 10.216.161.84 with SMTP id v62mr1926103wek.58.1272117398397;
        Sat, 24 Apr 2010 06:56:38 -0700 (PDT)
Received: from localhost.localdomain (abvk50.neoplus.adsl.tpnet.pl [83.8.208.50])
        by mx.google.com with ESMTPS id t27sm4892820wbc.5.2010.04.24.06.56.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 24 Apr 2010 06:56:38 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o3ODuEO7031023;
	Sat, 24 Apr 2010 15:56:22 +0200
In-Reply-To: <20100424132255.30511.98829.stgit@localhost.localdomain>
User-Agent: StGIT/0.14.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145678>

Use 'goto DONE' in place of 'exit' to end request processing in
die_error() subroutine.  While at it, do not end gitweb with 'exit'.

This would make it easier in the future to add support or improve
support for persistent environments such as FastCGI and mod_perl.
It would also make it easier to make use of die_error() as an error
handler (for fatalsToBrowser).

Perl 5 allows non-local jumps; the restriction is that you cannot jump
into a scope.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This patch is most independent of introducing caching support to
gitweb, and I think it would be good to have nevertheless.

 gitweb/gitweb.perl |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 6cefb09..ed92dca 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -972,7 +972,8 @@ if ($action !~ m/^(?:opml|project_list|project_index)$/ &&
 	die_error(400, "Project needed");
 }
 $actions{$action}->();
-exit;
+DONE_GITWEB:
+1;
 
 ## ======================================================================
 ## action links
@@ -3432,7 +3433,7 @@ EOF
 	print "</div>\n";
 
 	git_footer_html();
-	exit;
+	goto DONE_GITWEB;
 }
 
 ## ----------------------------------------------------------------------
