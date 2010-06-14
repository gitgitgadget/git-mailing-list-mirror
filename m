From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC PATCHv4 01/17] gitweb: Return or exit after done serving request
Date: Mon, 14 Jun 2010 18:08:13 +0200
Message-ID: <1276531710-22945-2-git-send-email-jnareb@gmail.com>
References: <1276531710-22945-1-git-send-email-jnareb@gmail.com>
Cc: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>,
	Petr Baudis <pasky@ucw.cz>,
	Christian Couder <chriscool@tuxfamily.org>,
	John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 14 18:09:04 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOCDf-0001Wt-PA
	for gcvg-git-2@lo.gmane.org; Mon, 14 Jun 2010 18:09:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755360Ab0FNQIu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jun 2010 12:08:50 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:44776 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754839Ab0FNQIi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jun 2010 12:08:38 -0400
Received: by mail-fx0-f46.google.com with SMTP id 8so2649600fxm.19
        for <git@vger.kernel.org>; Mon, 14 Jun 2010 09:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=amfNlNU4EcffbMdzETfCiUufAl/Xthe0bVpB3dO3Cq4=;
        b=sSMHjeWpIF5HrDqNrXZNPWWEx8PJsxkJUfzZ1TghgaYksAvU6G9wWeI5G0LcGArb2l
         cIqGOL1xfi2ZKEwx4yvjxIWWCFjl23fkhcPNd/husnnn68H3SQ+bvHLpsjmesP2rYd6b
         Qh6mxuwqWriC5L/8VpiQWfKvxysjjfK6NBi58=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=guwzDBJ3e0gmIr2o/ATxCU/kRKx4lcEHonZZHzD38sasEYDoTs0v5kJIisKmyaLr0W
         0MZ1J6ZxNa8xMHnwKMzfSvNFjD6YNMmH/V6KXmlId8ShDsw98+17uKNuBKjWUlybriC4
         Df6wmmJff0bANsy7tPHysy7R1OSDcz63b8y2U=
Received: by 10.223.44.86 with SMTP id z22mr5711545fae.13.1276531718107;
        Mon, 14 Jun 2010 09:08:38 -0700 (PDT)
Received: from localhost.localdomain (abuz111.neoplus.adsl.tpnet.pl [83.8.197.111])
        by mx.google.com with ESMTPS id u12sm7476715fah.28.2010.06.14.09.08.35
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 14 Jun 2010 09:08:36 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.1
In-Reply-To: <1276531710-22945-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149102>

Check if there is a caller in top frame of gitweb, and either 'return'
if gitweb code is wrapped in subroutine, or 'exit' if it is not.

This should avoid

  gitweb.cgi: Subroutine git_SOMETHING redefined at gitweb.cgi line NNN

warnings in error_log when running gitweb with mod_perl (using
ModPerl::Registry handler)

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 934aacb..c54a8a8 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -987,7 +987,17 @@ if ($action !~ m/^(?:opml|project_list|project_index)$/ &&
 	die_error(400, "Project needed");
 }
 $actions{$action}->();
+
 DONE_GITWEB:
+if (defined caller) {
+	# wrapped in a subroutine processing requests,
+	# e.g. mod_perl with ModPerl::Registry, or PSGI with Plack::App::WrapCGI
+	return;
+} else {
+	# pure CGI script, serving single request
+	# or 'exit' hijacked approprietly
+	exit;
+}
 1;
 
 ## ======================================================================
-- 
1.7.0.1
