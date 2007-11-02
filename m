From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 1/3] gitweb: Add tests for overriding gitweb config with repo config
Date: Sat,  3 Nov 2007 00:41:18 +0100
Message-ID: <1194046880-29941-2-git-send-email-jnareb@gmail.com>
References: <1194046880-29941-1-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 03 00:39:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Io66x-000709-Dz
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 00:39:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755424AbXKBXiu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 19:38:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755426AbXKBXit
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 19:38:49 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:23248 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755393AbXKBXis (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 19:38:48 -0400
Received: by ug-out-1314.google.com with SMTP id z38so694635ugc
        for <git@vger.kernel.org>; Fri, 02 Nov 2007 16:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=DB7vx/wkQ3Z/MvLS/Se1mlG8ZPSpXSxyni+i7MK4Suk=;
        b=Nf7HPy16IutIlKZQibYhlUS45DohbFJp3A7pWG9lZjs+7lDNwy2ZtLWYCS8Pt3tqY95iH7gvd4PXsbT5jAtKC629FHcQVGPrJp8z5wz27wWLCUQcbT3NPkxM/IwPQqSxB4OaZSVAIRug+pUUR4n9NhNYl4SQnw0wvxbpSQ+8Mr4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=XDAGxRELS+EwoCGOEut7ARMajkPk0+jQPhCiHNJedeP6dQUP2/J6JabviVv/qz6AouXlC5oiRhDXZKWM6pZMRyVtBdFQtVYT0ur3oRR5B0i9zl8LuI4Ku3LKcwarELKmsDv5dGWlZWJ2JF4bXhOrSYjASP0aEOuzvSivQEPpLAs=
Received: by 10.66.217.20 with SMTP id p20mr2747668ugg.1194046726577;
        Fri, 02 Nov 2007 16:38:46 -0700 (PDT)
Received: from roke.D-201 ( [83.8.198.10])
        by mx.google.com with ESMTPS id u6sm9167622uge.2007.11.02.16.38.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 02 Nov 2007 16:38:45 -0700 (PDT)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id lA2NfMGk029960;
	Sat, 3 Nov 2007 00:41:22 +0100
Received: (from jnareb@localhost)
	by roke.D-201 (8.13.4/8.13.4/Submit) id lA2NfM9o029959;
	Sat, 3 Nov 2007 00:41:22 +0100
X-Mailer: git-send-email 1.5.3.5
In-Reply-To: <1194046880-29941-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63189>

Make blame view and snapshot support overridable by repository
config. Test tree view with both features disabled, and with both
features enabled.

Test with features enabled also tests multiple formats snapshot
support (in tree view).

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
If I remember correctly it was when creating this test that there were
probles with CGI::Carp::set_programname() in t9500 test. And it took
me some time to discover where the bug was.

 t/t9500-gitweb-standalone-no-errors.sh |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb-standalone-no-errors.sh
index 1bf0988..35fff3d 100755
--- a/t/t9500-gitweb-standalone-no-errors.sh
+++ b/t/t9500-gitweb-standalone-no-errors.sh
@@ -557,4 +557,27 @@ test_expect_success \
 	'gitweb_run "p=.git;a=tree;opt=--no-merges"'
 test_debug 'cat gitweb.log'
 
+# ----------------------------------------------------------------------
+# gitweb config and repo config
+
+cat >>gitweb_config.perl <<EOF
+
+\$feature{'blame'}{'override'} = 1;
+\$feature{'snapshot'}{'override'} = 1;
+EOF
+
+test_expect_success \
+	'config override: tree view, features disabled in repo config' \
+	'git config gitweb.blame no &&
+	 git config gitweb.snapshot none &&
+	 gitweb_run "p=.git;a=tree"'
+test_debug 'cat gitweb.log'
+
+test_expect_success \
+	'config override: tree view, features enabled in repo config' \
+	'git config gitweb.blame yes &&
+	 git config gitweb.snapshot "zip,tgz, tbz2" &&
+	 gitweb_run "p=.git;a=tree"'
+test_debug 'cat gitweb.log'
+
 test_done
-- 
1.5.3.5
