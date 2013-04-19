From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 7/8] contrib: cc-cmd: fix parsing of rev-list args
Date: Fri, 19 Apr 2013 00:14:17 -0500
Message-ID: <1366348458-7706-8-git-send-email-felipe.contreras@gmail.com>
References: <1366348458-7706-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 19 07:16:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UT3g1-00087I-06
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 07:16:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753227Ab3DSFPw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Apr 2013 01:15:52 -0400
Received: from mail-gg0-f181.google.com ([209.85.161.181]:58559 "EHLO
	mail-gg0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751294Ab3DSFPu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Apr 2013 01:15:50 -0400
Received: by mail-gg0-f181.google.com with SMTP id l4so561434ggi.12
        for <git@vger.kernel.org>; Thu, 18 Apr 2013 22:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=jq6dkkh7YILoWpw0rM3L3m61GlZ/cIaOviuqr7W6Xk0=;
        b=IoIr81cEGRXaHUTLStA99K3RZBgfXvOOhFRB9ZkYxOHA53NA0ht379OxgwFnvYXDM1
         RmNmsBL7zKmCgX4xHxNvURkXLLAP169qVVDsSpA2VW5kWEctmP0RpHmG1bVn4spco2y0
         rTnyrr8l1AbaHjN2qkoPGO3Qejqo49VieDW05pcZ8DcpwuVW1Fn11PjystTQhsMJVOHO
         KOt7ebvLgxaK/Xi6Gpr0eT7RCxA1hgLnWM9whctmscUyvvGurMJs1rqcKpiEqChvacBD
         QNRbX+MRM/DyDLBOgrDXj11mXB6SAwtf8CUpKOqoK1rowoyXrlbkrKJKqGSHJ9hObur8
         I88g==
X-Received: by 10.236.190.66 with SMTP id d42mr10077877yhn.90.1366348549588;
        Thu, 18 Apr 2013 22:15:49 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id h68sm22309122yhj.24.2013.04.18.22.15.47
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 18 Apr 2013 22:15:48 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.790.g4588561
In-Reply-To: <1366348458-7706-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221734>

For example '-1'.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/cc-cmd/git-cc-cmd | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/contrib/cc-cmd/git-cc-cmd b/contrib/cc-cmd/git-cc-cmd
index 02e1a99..6911259 100755
--- a/contrib/cc-cmd/git-cc-cmd
+++ b/contrib/cc-cmd/git-cc-cmd
@@ -23,7 +23,8 @@ begin
       $show_commits = v || true
     end
   end.parse!
-rescue OptionParser::InvalidOption
+rescue OptionParser::InvalidOption => e
+  $rev_args += e.args
 end
 
 class Commit
@@ -147,9 +148,11 @@ class Commits
 
     case revs.size
     when 1
-      committish = [ '%s..HEAD' % revs[0] ]
+      r = revs[0]
+      r = '^' + r if r[0] != '-'
+      args = [ r, 'HEAD' ]
     else
-      committish = revs
+      args = revs
     end
 
     source = nil
-- 
1.8.2.1.790.g4588561
