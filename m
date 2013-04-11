From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 20/21] remote-hg: fix bad file paths
Date: Thu, 11 Apr 2013 07:23:16 -0500
Message-ID: <1365682997-11329-21-git-send-email-felipe.contreras@gmail.com>
References: <1365682997-11329-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 11 14:25:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQGZV-0000DH-W8
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 14:25:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161554Ab3DKMZd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 08:25:33 -0400
Received: from mail-qc0-f175.google.com ([209.85.216.175]:58518 "EHLO
	mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161510Ab3DKMZ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 08:25:29 -0400
Received: by mail-qc0-f175.google.com with SMTP id j3so657256qcs.20
        for <git@vger.kernel.org>; Thu, 11 Apr 2013 05:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=h1XAex8HmEthzSrOZnP1po15MVaP3xsP/9ZuTvVkpPM=;
        b=p+uD5X6QOviAVLl8OyOOh7p6Jip4FD0fDrdYuPXDnKQIkEl2e5jyVXHGnu6PNHTcIx
         LjZTxtXrnuYZf9RMsezjlCurMbwSm1TKWMCe1tuzRf2rjS7dCD9CjYxyGTO24Y4Cgusk
         sAr//MztNLWY7Tm1OHww7dKjaTOkWi4mR8vcVaf474KZdTwBsJnY3jiU8BFjQW6Z3Edn
         Jj6ZkBk/cWpjgiRIDge2TICTcFykjeOzOJ/wMXxJlFM7Qmmg9aWF3ISG9T76apcBT61w
         Ktc3vkXc1Lqf5cE9HFVY4n2DW3jV8G6ddaxPLBINymUHDWpf3i9OzNx35es5JHtqA/xB
         Jefg==
X-Received: by 10.224.33.141 with SMTP id h13mr6797802qad.34.1365683128672;
        Thu, 11 Apr 2013 05:25:28 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id bt19sm7025952qab.0.2013.04.11.05.25.26
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 11 Apr 2013 05:25:27 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1365682997-11329-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220872>

Mercurial allows absolute file paths, and Git doesn't like that.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 0db4cca..a5f0013 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -205,9 +205,15 @@ class Parser:
         tz = ((tz / 100) * 3600) + ((tz % 100) * 60)
         return (user, int(date), -tz)
 
+def fix_file_path(path):
+    if not os.path.isabs(path):
+        return path
+    return os.path.relpath(path, '/')
+
 def export_file(fc):
     d = fc.data()
-    print "M %s inline %s" % (gitmode(fc.flags()), fc.path())
+    path = fix_file_path(fc.path())
+    print "M %s inline %s" % (gitmode(fc.flags()), path)
     print "data %d" % len(d)
     print d
 
@@ -401,7 +407,7 @@ def export_ref(repo, name, kind, head):
         for f in modified:
             export_file(c.filectx(f))
         for f in removed:
-            print "D %s" % (f)
+            print "D %s" % (fix_file_path(f))
         print
 
         count += 1
-- 
1.8.2.1
