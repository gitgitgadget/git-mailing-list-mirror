From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 37/48] remote-hg: simplify branch_tip()
Date: Fri, 24 May 2013 21:29:53 -0500
Message-ID: <1369449004-17981-38-git-send-email-felipe.contreras@gmail.com>
References: <1369449004-17981-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 25 04:33:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ug4Ik-0002lu-Uv
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 04:33:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755706Ab3EYCdj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 22:33:39 -0400
Received: from mail-oa0-f41.google.com ([209.85.219.41]:37924 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755675Ab3EYCdh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 22:33:37 -0400
Received: by mail-oa0-f41.google.com with SMTP id n9so7066773oag.14
        for <git@vger.kernel.org>; Fri, 24 May 2013 19:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=3gQZpUxRVtyipck4bfjc0e6WjhmVSC0uT3CwLs0fCCc=;
        b=aadF2XG8iTYJn06EmW4Tbe7LCABADa0EVPiXVpn3nkR/YORHyVADzCcYQiNegi024t
         ZTzCaNmB6/SKe14i/CtyrszDDP9gCbPjxWVACjnHUOnEtPZR+ilxLLHmxqGK/cLwcOW6
         c0t9hB+o1gu0XpfXU8iL0NpHfandwHSKCvxvzRczbyEeYmWunQ0DbaNbPLcj7AI4jqic
         ORtjvfBuLnQCUw15505Yl0/JZfj0AYHo7a3tt0bh7ot+AZFZx+LIIUHGghgb+ZEIg4FX
         b0+H1AYJk+HhTF+dy+3X+Bj2Vv3w3uRtjH40hM3e7aW76x/4+JBaTuw4pSBSo0umpo/Q
         6Ihg==
X-Received: by 10.182.102.234 with SMTP id fr10mr13173610obb.85.1369449216900;
        Fri, 24 May 2013 19:33:36 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id x10sm20558742oes.6.2013.05.24.19.33.35
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 24 May 2013 19:33:36 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
In-Reply-To: <1369449004-17981-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225450>

It simply picks the last head that is not closed, but we have a stored
list of open heads.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index e8ebc17..8df72d9 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -560,12 +560,8 @@ def do_capabilities(parser):
 
     print
 
-def branch_tip(repo, branch):
-    # older versions of mercurial don't have this
-    if hasattr(repo, 'branchtip'):
-        return repo.branchtip(branch)
-    else:
-        return repo.branchtags()[branch]
+def branch_tip(branch):
+    return branches[branch][-1]
 
 def get_branch_tip(repo, branch):
     global branches
@@ -577,7 +573,7 @@ def get_branch_tip(repo, branch):
     # verify there's only one head
     if (len(heads) > 1):
         warn("Branch '%s' has more than one head, consider merging" % branch)
-        return branch_tip(repo, hgref(branch))
+        return branch_tip(hgref(branch))
 
     return heads[0]
 
@@ -828,7 +824,7 @@ def parse_tag(parser):
 
 def write_tag(repo, tag, node, msg, author):
     branch = repo[node].branch()
-    tip = branch_tip(repo, branch)
+    tip = branch_tip(branch)
     tip = repo[tip]
 
     def getfilectx(repo, memctx, f):
-- 
1.8.3.rc3.312.g47657de
