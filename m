From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH (BUGFIX)] gitweb: Handle invalid regexp in regexp search
Date: Tue, 28 Feb 2012 19:41:47 +0100
Message-ID: <20120228183919.26435.86795.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 28 19:41:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2Rzm-0001cH-SW
	for gcvg-git-2@plane.gmane.org; Tue, 28 Feb 2012 19:41:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965963Ab2B1Slu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Feb 2012 13:41:50 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:49336 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755310Ab2B1Slt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Feb 2012 13:41:49 -0500
Received: by eaah12 with SMTP id h12so2719617eaa.19
        for <git@vger.kernel.org>; Tue, 28 Feb 2012 10:41:48 -0800 (PST)
Received-SPF: pass (google.com: domain of jnareb@gmail.com designates 10.213.105.71 as permitted sender) client-ip=10.213.105.71;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of jnareb@gmail.com designates 10.213.105.71 as permitted sender) smtp.mail=jnareb@gmail.com; dkim=pass header.i=jnareb@gmail.com
Received: from mr.google.com ([10.213.105.71])
        by 10.213.105.71 with SMTP id s7mr6130804ebo.23.1330454508420 (num_hops = 1);
        Tue, 28 Feb 2012 10:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:subject:to:cc:date:message-id:user-agent:mime-version
         :content-type:content-transfer-encoding;
        bh=4KXiYanPHiiNDf79D22vptJkGGIwbTcwikak+Ez1yiQ=;
        b=DBiqcgFTYf5kTKJFuEEFPap003OZsHSu1tjqyjjuQLjM7YWschY/LBVTGw/VAacOTG
         BCPRrTLuPVqF4i5W5pQBoHarFrM0SSrGzSz1aeqbuRUsvRuzmSDPuxknsAuljUenAnC7
         /OjL3eOtR3qIrAqlnJzWGqeQvdPGaCadlpkoA=
Received: by 10.213.105.71 with SMTP id s7mr4607483ebo.23.1330454508304;
        Tue, 28 Feb 2012 10:41:48 -0800 (PST)
Received: from localhost.localdomain (abwh28.neoplus.adsl.tpnet.pl. [83.8.231.28])
        by mx.google.com with ESMTPS id s48sm73130758eem.0.2012.02.28.10.41.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 28 Feb 2012 10:41:47 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id q1SIflIU026506;
	Tue, 28 Feb 2012 19:41:48 +0100
User-Agent: StGIT/0.14.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191758>

When using regexp search ('sr' parameter / $search_use_regexp variable
is true), check first that regexp is valid.

Without this patch we would get an error from Perl during search (if
searching is performed by gitweb), or highlighting matches substring
(if applicable), if user provided invalid regexp... which means broken
HTML, with error page (including HTTP headers) generated after gitweb
already produced some output.

Add test that illustrates such error: for example for regexp "*\.git"
we would get the following error:

  Quantifier follows nothing in regex; marked by <-- HERE in m/* <-- HERE \.git/
  at /var/www/cgi-bin/gitweb.cgi line 3084.

Reported-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
See "Re: gitweb: (potential) problems with new installation"
http://thread.gmane.org/gmane.comp.version-control.git/191746

 gitweb/gitweb.perl                       |   11 ++++++++++-
 t/t9501-gitweb-standalone-http-status.sh |   10 ++++++++++
 2 files changed, 20 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 1fc5361..22ad279 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1081,7 +1081,16 @@ sub evaluate_and_validate_params {
 		if (length($searchtext) < 2) {
 			die_error(403, "At least two characters are required for search parameter");
 		}
-		$search_regexp = $search_use_regexp ? $searchtext : quotemeta $searchtext;
+		if ($search_use_regexp) {
+			$search_regexp = $searchtext;
+			if (!eval { qr/$search_regexp/; 1; }) {
+				(my $error = $@) =~ s/ at \S+ line \d+.*\n?//;
+				die_error(400, "Invalid search regexp '$search_regexp'",
+				          esc_html($error));
+			}
+		} else {
+			$search_regexp = quotemeta $searchtext;
+		}
 	}
 }
 
diff --git a/t/t9501-gitweb-standalone-http-status.sh b/t/t9501-gitweb-standalone-http-status.sh
index 26102ee..31076ed 100755
--- a/t/t9501-gitweb-standalone-http-status.sh
+++ b/t/t9501-gitweb-standalone-http-status.sh
@@ -134,4 +134,14 @@ our $maxload = undef;
 EOF
 
 
+# ----------------------------------------------------------------------
+# invalid arguments
+
+test_expect_success 'invalid arguments: invalid regexp (in project search)' '
+	gitweb_run "a=project_list;s=*\.git;sr=1" &&
+	grep "Status: 400" gitweb.headers &&
+	grep "400 - Invalid.*regexp" gitweb.body
+'
+test_debug 'cat gitweb.headers'
+
 test_done
