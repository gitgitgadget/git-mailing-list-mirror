From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 17/44] ruby: request-pull: use native git_config()
Date: Sat, 28 Sep 2013 17:03:42 -0500
Message-ID: <1380405849-13000-18-git-send-email-felipe.contreras@gmail.com>
References: <1380405849-13000-1-git-send-email-felipe.contreras@gmail.com>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 29 00:10:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQ2j3-0003LP-Vl
	for gcvg-git-2@plane.gmane.org; Sun, 29 Sep 2013 00:10:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755276Ab3I1WKx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Sep 2013 18:10:53 -0400
Received: from mail-ob0-f170.google.com ([209.85.214.170]:59593 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755099Ab3I1WKu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Sep 2013 18:10:50 -0400
Received: by mail-ob0-f170.google.com with SMTP id va2so4152166obc.15
        for <git@vger.kernel.org>; Sat, 28 Sep 2013 15:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9DjC0ArpX4hStrG3Cn76GSdpT/uk9hEbVHfY5tFgtB0=;
        b=GEyLzs/VuGDKB6LXZVpQkrmRngCJ/c0TfCvaEBFk8CCoKK3gy7NJN9YjIbcNYH3k2K
         j1Mr0RjCCQzgwm7nQAccoVL+h3tqZCnn2Sy0fUhn59CWfo01H4dMkoWC7koT3kdlMs77
         XyMpiRzlk9h/FQ6xAWY0wH5k4w0Vjwk/fEBgDfG83BnKw332TozU11S559WKvFGoGRPt
         b+MzlMyoEdnjRVA266jYrfwXjELG0ut2EuVg6mVRppmfFh21DZuO+TPuhR1YVNxmIUi+
         UOIWEWtp6bHCwNNkl9wVgAocp/R35XiFrqri/hxAc9d4NndqOmfW5cq31V3XDHtiG4HZ
         zHzA==
X-Received: by 10.182.121.137 with SMTP id lk9mr12545708obb.32.1380406250154;
        Sat, 28 Sep 2013 15:10:50 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id u8sm19507814obd.7.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 28 Sep 2013 15:10:49 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1380405849-13000-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235536>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 git-request-pull.rb | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/git-request-pull.rb b/git-request-pull.rb
index 416f880..0f85024 100755
--- a/git-request-pull.rb
+++ b/git-request-pull.rb
@@ -14,6 +14,13 @@ EOF
   exit 1
 end
 
+def read_branch_desc(name)
+  git_config() do |key, value|
+    return value if key == "branch.#{name}.description"
+  end
+  return nil
+end
+
 def abbr(ref)
   if (ref =~ %r{^refs/heads/(.*)} || ref =~ %r{^refs/(tags/.*)})
     return $1
@@ -70,8 +77,8 @@ _, _, headref = dwim_ref(head)
 
 if headref.start_with?('refs/heads')
   branch_name = headref[11..-1]
-  branch_desc = `git config "branch.#{branch_name}.description"`.chomp
-  branch_name = nil if branch_desc.empty?
+  branch_desc = read_branch_desc(branch_name)
+  branch_name = nil if not branch_desc
 end
 
 tag_name = `git describe --exact "#{head}^0" 2>/dev/null`.chomp
-- 
1.8.4-fc
