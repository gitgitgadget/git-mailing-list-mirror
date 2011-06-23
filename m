From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 1/4] git-instaweb: Extract configuring web server into
	configure_httpd
Date: Thu, 23 Jun 2011 21:55:00 +0200
Message-ID: <20110623195111.18265.77040.stgit@localhost.localdomain>
References: <20110623194624.18265.82482.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Gurjeet Singh <singh.gurjeet@gmail.com>,
	Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 23 21:55:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZpzr-0001PG-Ob
	for gcvg-git-2@lo.gmane.org; Thu, 23 Jun 2011 21:55:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933490Ab1FWTzX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jun 2011 15:55:23 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:59726 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932718Ab1FWTzW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jun 2011 15:55:22 -0400
Received: by fxm17 with SMTP id 17so1474459fxm.19
        for <git@vger.kernel.org>; Thu, 23 Jun 2011 12:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:subject:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=+sdawkseO3P0u/YLJQjCgeNg6v2mhHgNuAlKG/rk3Bw=;
        b=T3s9uviGMQNKZnI8K41qEbFKNd9cJZHXSB612SOMJY3w7LVm/zN71J+XoD3CyNzcT4
         TBEtdVf9XYo3XGkD9il0dOFfAMYbR3VYDAiBj95/NKvRkQatfcaTV6vHqXiLr52/IxsQ
         GS474Gh2Y7wwsFnzdHMj3Kig5LQApdWJuyY3I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:subject:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-type:content-transfer-encoding;
        b=AT91JelC0zhX0gpD7AcBp+nRYTC7gA7gRFABIq17BNOiK03XEApS9tg54IkYur+aW+
         roV5jIfVko+1TGELoDWG34SxdbqH5OG43dHaPORToWtHZC9JEQecQSumGsE7B3OmMag7
         E1GCnRtzFFwWzkIac/5HaJN2X6Beh/lmLhhhE=
Received: by 10.223.5.212 with SMTP id 20mr3206080faw.40.1308858920926;
        Thu, 23 Jun 2011 12:55:20 -0700 (PDT)
Received: from localhost.localdomain (abva28.neoplus.adsl.tpnet.pl [83.8.198.28])
        by mx.google.com with ESMTPS id g8sm1193177fai.44.2011.06.23.12.55.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 23 Jun 2011 12:55:20 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p5NJt0Vn018437;
	Thu, 23 Jun 2011 21:55:11 +0200
In-Reply-To: <20110623194624.18265.82482.stgit@localhost.localdomain>
User-Agent: StGIT/0.14.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176289>

This is preparatory work for making start/restart check that
git-instaweb set up correct configuration, and generate it if it is
missing.

Pure refactoring, no functional changes. 

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
As usual, you can check this change with

  $ git blame -w --date=short -C -C HEAD^.. -- git-instaweb.sh |
    grep -C 3 -e '^[^^]' | less -S

assuming that it is checked out (HEAD == this commit).

Thanks Junio for the tip!


Nb. it would be nice to have an option to 'git diff' which would
function like '-w' but ignore code movement...

 git-instaweb.sh |   46 +++++++++++++++++++++++++---------------------
 1 files changed, 25 insertions(+), 21 deletions(-)

diff --git a/git-instaweb.sh b/git-instaweb.sh
index 8bfa8a0..49bab7b 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -587,32 +587,36 @@ our \$projects_list = \$projectroot;
 EOF
 }
 
+configure_httpd() {
+	case "$httpd" in
+	*lighttpd*)
+		lighttpd_conf
+		;;
+	*apache2*|*httpd*)
+		apache2_conf
+		;;
+	webrick)
+		webrick_conf
+		;;
+	*mongoose*)
+		mongoose_conf
+		;;
+	*plackup*)
+		plackup_conf
+		;;
+	*)
+		echo "Unknown httpd specified: $httpd"
+		exit 1
+		;;
+	esac
+}
+
 gitweb_conf
 
 resolve_full_httpd
 mkdir -p "$fqgitdir/gitweb/$httpd_only"
 
-case "$httpd" in
-*lighttpd*)
-	lighttpd_conf
-	;;
-*apache2*|*httpd*)
-	apache2_conf
-	;;
-webrick)
-	webrick_conf
-	;;
-*mongoose*)
-	mongoose_conf
-	;;
-*plackup*)
-	plackup_conf
-	;;
-*)
-	echo "Unknown httpd specified: $httpd"
-	exit 1
-	;;
-esac
+configure_httpd
 
 start_httpd
 url=http://127.0.0.1:$port
