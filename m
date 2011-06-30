From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 1/2] gitweb: Serve text/* 'blob_plain' as text/plain with $prevent_xss
Date: Thu, 30 Jun 2011 11:39:20 +0200
Message-ID: <1309426761-819-2-git-send-email-jnareb@gmail.com>
References: <1309426761-819-1-git-send-email-jnareb@gmail.com>
Cc: Matt McCutchen <matt@mattmccutchen.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 30 11:42:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QcDlX-000752-W9
	for gcvg-git-2@lo.gmane.org; Thu, 30 Jun 2011 11:42:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754076Ab1F3Jm1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jun 2011 05:42:27 -0400
Received: from mail-fx0-f52.google.com ([209.85.161.52]:41151 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752310Ab1F3Jm0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2011 05:42:26 -0400
Received: by fxd18 with SMTP id 18so2070287fxd.11
        for <git@vger.kernel.org>; Thu, 30 Jun 2011 02:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=2yIQDoJa+E0SqotFXD/TKwWjhsYi999MTTy1UxYWrIQ=;
        b=lfsmSURy5K2N7qh7f5V6v5a203SG9t6LWfM1hdExSFQcRZquk+Ox4XGDJPmrubcpCn
         nT5HoiYfmI7t7RJeMId2zrnPGaeKgmTGzGqa7aa63VS2GV3xSN9hZjdlsBkWjCc2T6u6
         5p07IA9r6lejjt/R21ZG3osfiopxxfeB/wdYM=
Received: by 10.223.145.144 with SMTP id d16mr2750580fav.100.1309426867262;
        Thu, 30 Jun 2011 02:41:07 -0700 (PDT)
Received: from localhost.localdomain (abwr29.neoplus.adsl.tpnet.pl [83.8.241.29])
        by mx.google.com with ESMTPS id 21sm1349341fay.45.2011.06.30.02.41.05
        (version=SSLv3 cipher=OTHER);
        Thu, 30 Jun 2011 02:41:06 -0700 (PDT)
X-Mailer: git-send-email 1.7.5
In-Reply-To: <1309426761-819-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176483>

One of mechanism enabled by setting $prevent_xss to true is 'blob_plain'
view protection.  With XSS prevention on, blobs of all types except a
few known safe ones are served with "Content-Disposition: attachment" to
make sure they don't run in our security domain.

Instead of serving text/* type files, except text/plain (and including
text/html), as attachements, downgrade it to text/plain.  This way HTML
pages in 'blob_plain' (raw) wiew would be displayed in browser, but
safely as a source, and not asked to be saved.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 8620aca..cb2e7bc 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -6139,7 +6139,15 @@ sub git_blob_plain {
 	# want to be sure not to break that by serving the image as an
 	# attachment (though Firefox 3 doesn't seem to care).
 	my $sandbox = $prevent_xss &&
-		$type !~ m!^(?:text/plain|image/(?:gif|png|jpeg))(?:[ ;]|$)!;
+		$type !~ m!^(?:text/[a-z]+|image/(?:gif|png|jpeg))(?:[ ;]|$)!;
+
+	# serve text/* as text/plain
+	if ($prevent_xss &&
+	    $type =~ m!^text/[a-z]+\b(.*)$!) {
+		my $rest = $1;
+		$rest = defined $rest ? $rest : '';
+		$type = "text/plain$rest";
+	}
 
 	print $cgi->header(
 		-type => $type,
-- 
1.7.5
