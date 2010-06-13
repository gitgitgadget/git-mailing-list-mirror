From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Return or exit after done serving request
Date: Sun, 13 Jun 2010 12:09:32 +0200
Message-ID: <20100613100800.28221.77529.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 13 12:10:09 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ONk8l-00060x-Fy
	for gcvg-git-2@lo.gmane.org; Sun, 13 Jun 2010 12:10:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753272Ab0FMKJ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jun 2010 06:09:59 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:26394 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752531Ab0FMKJ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jun 2010 06:09:58 -0400
Received: by fg-out-1718.google.com with SMTP id l26so799263fgb.1
        for <git@vger.kernel.org>; Sun, 13 Jun 2010 03:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:subject:to:cc
         :date:message-id:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=zJIoYNN7Yob5dRRxNEo5rbhN/njlS9fiS0XnFqHlnfs=;
        b=mZT7shx0b1XIC7K3ikjdAh6aW4TaG+x3SRa9FroJmapLP4DstXiEMIHUAazeAtHcgO
         6E3C1uJC1vSg0rSfPeSY9r7nY961uTu5fkHWIpQK4xAX3dTMClU/IImRNsRMRvpb/Mtk
         Ue2YS/VkNQ2kZHIQIQlEazQwI5sYnPFfZEuxQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:subject:to:cc:date:message-id:user-agent:mime-version
         :content-type:content-transfer-encoding;
        b=O9ya6uvFOM+lrYgjTEjBMO2rL0U8UqJ3dHN7sHit036oAaZrFr1Ilp3di/ye1DAki6
         pKNGo03cA/PcjaQyk/fxIOHbGqPb3wrpsjb49Rl7uAoGTK7voquw6rcLud7+V22R6Tuj
         gNJOHCaNvLcr9kjrRwt0fXY4ajIYAn8zavBi0=
Received: by 10.87.63.21 with SMTP id q21mr6840703fgk.52.1276423796846;
        Sun, 13 Jun 2010 03:09:56 -0700 (PDT)
Received: from localhost.localdomain (abve213.neoplus.adsl.tpnet.pl [83.8.202.213])
        by mx.google.com with ESMTPS id d6sm7069441fga.28.2010.06.13.03.09.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 13 Jun 2010 03:09:56 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o5DA9XwB028274;
	Sun, 13 Jun 2010 12:09:38 +0200
User-Agent: StGIT/0.14.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149040>

Check if there is a caller in top frame of gitweb, and either 'return'
if gitweb code is wrapped in subroutine, or 'exit' if it is not.

This should avoid

  gitweb.cgi: Subroutine git_SOMETHING redefined at gitweb.cgi line NNN

warnings in error_log when running gitweb with mod_perl (using
ModPerl::Registry handler)

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
I have noticed bunch of

  [Sun Jun 13 11:58:02 2010] gitweb.cgi: Subroutine git_opml redefined
  at /var/www/perl/gitweb/gitweb.cgi line 6808.

warnings in /var/log/httpd/error_log, after running gitweb from mod_perl.
This fixes it.

 gitweb/gitweb.perl |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index e108bbc..02f366d 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -987,7 +987,16 @@ if ($action !~ m/^(?:opml|project_list|project_index)$/ &&
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
+	exit;
+}
 1;
 
 ## ======================================================================
