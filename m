From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 5/7] remote-bzr: improve tag handling
Date: Mon,  8 Apr 2013 12:27:14 -0500
Message-ID: <1365442036-25732-6-git-send-email-felipe.contreras@gmail.com>
References: <1365442036-25732-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 08 19:28:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPFru-0001Hy-UE
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 19:28:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934769Ab3DHR2c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 13:28:32 -0400
Received: from mail-ob0-f180.google.com ([209.85.214.180]:36671 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934447Ab3DHR2c (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 13:28:32 -0400
Received: by mail-ob0-f180.google.com with SMTP id un3so1780604obb.25
        for <git@vger.kernel.org>; Mon, 08 Apr 2013 10:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=RZ5IL/Bgyz4ZGRR7DXTKzlD+PRtCI7F+M4PhgYJhx+M=;
        b=gabR5Yq82jQmeJW+wNOJM2YWiE6T1ByU6FsVlXJ1SIcL7AHog8zbcPBPGt5ADmBA5l
         hyDr/3aVXIOA8160+Y3G8euj5GIYHevdA67Uc0dP8CvYYX8/D+oUokjl4CPCxpROP6nA
         6YTT3KjQjRiQDNaFtrylVy+tOGGtD5OlYLI6YHJ67BeK0EL+Xc/XxtIPPVPtNcFH+QFV
         +AAbO8BcN7n5VeafoLC/Vo2PFcbubLRcmsjZLqPlUxTZuqqAad/xed3/l3nbbb17fwe/
         Pg0oqIsCioga3SuIVIT/ZDKVCahFAQaPK6Bswewj1UzUHFB5BVHGJyUD2u5W/U75W9nI
         bzrQ==
X-Received: by 10.182.176.71 with SMTP id cg7mr15807353obc.55.1365442111540;
        Mon, 08 Apr 2013 10:28:31 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id t9sm25051611obk.13.2013.04.08.10.28.29
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 08 Apr 2013 10:28:30 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <1365442036-25732-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220469>

If the tags don't have an associated revision, there's nothing we can do
with them, skip them. Also, let's skip the ones git can't handle.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-bzr | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
index 9466cb9..dc0b757 100755
--- a/contrib/remote-helpers/git-remote-bzr
+++ b/contrib/remote-helpers/git-remote-bzr
@@ -25,6 +25,7 @@ bzrlib.plugin.load_plugins()
 
 import bzrlib.generate_ids
 import bzrlib.transport
+import bzrlib.errors
 
 import sys
 import os
@@ -332,12 +333,9 @@ def export_branch(branch, name):
 
 def export_tag(repo, name):
     global tags
-    try:
-        print "reset refs/tags/%s" % name
-        print "from :%u" % rev_to_mark(tags[name])
-        print
-    except KeyError:
-        warn("TODO: fetch tag '%s'" % name)
+    print "reset refs/tags/%s" % name
+    print "from :%u" % rev_to_mark(tags[name])
+    print
 
 def do_import(parser):
     global dirname
@@ -651,12 +649,25 @@ def do_capabilities(parser):
 
     print
 
+def ref_is_valid(name):
+    return not True in [c in name for c in '~^: \\']
+
 def do_list(parser):
     global tags
     print "? refs/heads/%s" % 'master'
-    for tag, revid in parser.repo.tags.get_tag_dict().items():
+
+    branch = parser.repo
+    branch.lock_read()
+    for tag, revid in branch.tags.get_tag_dict().items():
+        try:
+            branch.revision_id_to_dotted_revno(revid)
+        except bzrlib.errors.NoSuchRevision:
+            continue
+        if not ref_is_valid(tag):
+            continue
         print "? refs/tags/%s" % tag
         tags[tag] = revid
+    branch.unlock()
     print "@refs/heads/%s HEAD" % 'master'
     print
 
-- 
1.8.2
