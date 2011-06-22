From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 2/5] gitweb: Check permissions first in git_search
Date: Wed, 22 Jun 2011 17:28:52 +0200
Message-ID: <1308756535-29701-3-git-send-email-jnareb@gmail.com>
References: <1308756535-29701-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@kernel.org>, admin@repo.or.cz,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 22 17:29:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZPMx-0002BZ-HO
	for gcvg-git-2@lo.gmane.org; Wed, 22 Jun 2011 17:29:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932382Ab1FVP31 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jun 2011 11:29:27 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:59791 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932343Ab1FVP3Z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2011 11:29:25 -0400
Received: by mail-fx0-f46.google.com with SMTP id 17so714045fxm.19
        for <git@vger.kernel.org>; Wed, 22 Jun 2011 08:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=bbbLT8AAJ5DZM2YMl8ahegnJEuWFVW64115HKcZLyH4=;
        b=dk++xpVwJeSDuGGfoqOLTwBgBGWcLaAfKLahS6CrzKv4hqnCPn2jsvCbdQvZRxjCf9
         RJ/sOqWR71KYUCfuMv0bhA1uNnA7q0Q/YsJ/pzbZSIdDDM+yOgTvbmawdjXUf614ZnRj
         mIUbyNCV60IuYBdLtDKNlKWqj0jPWaAOaLY0E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=CqtFG9U91Z7YFZGhkjtvn5Zg3ugVMrHXkL96P4n+8UifTtj2cZYpdfgpc3pb6h90Yl
         PVsgjDXh55/W5ETmvL9lCFy77gLt96wVpkAn9vr8RgXL+GQAOImYo2jL9aa+p2lBUkf5
         oKF7P8gkSeOXXi/9JdwEi2Eq+M2eWA4eKleeY=
Received: by 10.223.158.130 with SMTP id f2mr1028068fax.61.1308756564659;
        Wed, 22 Jun 2011 08:29:24 -0700 (PDT)
Received: from localhost.localdomain (abuz77.neoplus.adsl.tpnet.pl [83.8.197.77])
        by mx.google.com with ESMTPS id l26sm400935fah.14.2011.06.22.08.29.22
        (version=SSLv3 cipher=OTHER);
        Wed, 22 Jun 2011 08:29:23 -0700 (PDT)
X-Mailer: git-send-email 1.7.5
In-Reply-To: <1308756535-29701-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176242>

Check first if relevant features: 'search', 'pickaxe', 'grep', as
appropriate, are enabled before doing anything else in git_search.
This should make git_search code more clear.

While at it, expand a bit error message (e.g. 'Pickaxe' ->
'Pickaxe search').

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |   30 +++++++++++++++++-------------
 1 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index fd93d45..32e50b4 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -7094,7 +7094,23 @@ sub git_history {
 }
 
 sub git_search {
-	gitweb_check_feature('search') or die_error(403, "Search is disabled");
+	$searchtype ||= 'commit';
+
+	# check if appropriate features are enabled
+	gitweb_check_feature('search')
+		or die_error(403, "Search is disabled");
+	if ($searchtype eq 'pickaxe') {
+		# pickaxe may take all resources of your box and run for several minutes
+		# with every query - so decide by yourself how public you make this feature
+		gitweb_check_feature('pickaxe')
+			or die_error(403, "Pickaxe search is disabled");
+	}
+	if ($searchtype eq 'grep') {
+		# grep search might be potentially CPU-intensive, too
+		gitweb_check_feature('grep')
+			or die_error(403, "Grep search is disabled");
+	}
+
 	if (!defined $searchtext) {
 		die_error(400, "Text field is empty");
 	}
@@ -7109,18 +7125,6 @@ sub git_search {
 		$page = 0;
 	}
 
-	$searchtype ||= 'commit';
-	if ($searchtype eq 'pickaxe') {
-		# pickaxe may take all resources of your box and run for several minutes
-		# with every query - so decide by yourself how public you make this feature
-		gitweb_check_feature('pickaxe')
-		    or die_error(403, "Pickaxe is disabled");
-	}
-	if ($searchtype eq 'grep') {
-		gitweb_check_feature('grep')
-		    or die_error(403, "Grep is disabled");
-	}
-
 	git_header_html();
 
 	if ($searchtype eq 'commit' or $searchtype eq 'author' or $searchtype eq 'committer') {
-- 
1.7.5
