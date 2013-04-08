From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/2] remote-bzr: improve tag handling
Date: Mon,  8 Apr 2013 13:36:39 -0500
Message-ID: <1365446199-11382-3-git-send-email-felipe.contreras@gmail.com>
References: <1365446199-11382-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 08 20:38:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPGx6-0007YC-So
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 20:38:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935374Ab3DHShu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 14:37:50 -0400
Received: from mail-ob0-f180.google.com ([209.85.214.180]:58583 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934738Ab3DHShu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 14:37:50 -0400
Received: by mail-ob0-f180.google.com with SMTP id un3so1919483obb.11
        for <git@vger.kernel.org>; Mon, 08 Apr 2013 11:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=TSLSp5paqTSZQfcxs0CEpbVupC1HZesVT0SK/UTtPuI=;
        b=yZDVQiA4Fzone0uMfcSWgSBVFLY+yPkxjtu0UJP4xRk9+oNkENMT7tZyizF53/avxT
         WXYu1q8gkXhTvWUgvYi4WFf2skeat+yfY3gjsXi4vpd/bCwXEoKWJtatATkdtj+e7H1h
         tmZYZEoVmCkxpHWEjiaGC33CABz55ng42TLY2gTsy7WW2neooCD+h9nbKIZTECeWRkS7
         dm5h4cMKF3QaGsfM9PqKru7iJ4FHPNwmZf15wckcK/6d31H6EwmuLKvNPhlx1v5ob3/1
         2qEcyfRIe+OXHw5yqd113+XQdYaIufGqxKAE60hU5TJlNF8atqPq4TnwlbX/4MrAPBEE
         br7A==
X-Received: by 10.60.135.103 with SMTP id pr7mr15154033oeb.142.1365446269429;
        Mon, 08 Apr 2013 11:37:49 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id a3sm26478616oee.8.2013.04.08.11.37.44
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 08 Apr 2013 11:37:48 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <1365446199-11382-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220488>

revision_history() is deprecated and doesn't do what we want (revno
instead of dotted_revno?).

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-bzr | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
index 55ebf19..bd25e08 100755
--- a/contrib/remote-helpers/git-remote-bzr
+++ b/contrib/remote-helpers/git-remote-bzr
@@ -25,6 +25,7 @@ bzrlib.plugin.load_plugins()
 
 import bzrlib.generate_ids
 import bzrlib.transport
+import bzrlib.errors
 
 import sys
 import os
@@ -335,12 +336,9 @@ def export_branch(branch, name):
 
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
@@ -660,16 +658,25 @@ def do_capabilities(parser):
 
     print
 
+def ref_is_valid(name):
+    return not True in [c in name for c in '~^: \\']
+
 def do_list(parser):
     global tags
     print "? refs/heads/%s" % 'master'
 
-    history = parser.repo.revision_history()
-    for tag, revid in parser.repo.tags.get_tag_dict().items():
-        if revid not in history:
+    branch = parser.repo
+    branch.lock_read()
+    for tag, revid in branch.tags.get_tag_dict().items():
+        try:
+            branch.revision_id_to_dotted_revno(revid)
+        except bzrlib.errors.NoSuchRevision:
+            continue
+        if not ref_is_valid(tag):
             continue
         print "? refs/tags/%s" % tag
         tags[tag] = revid
+    branch.unlock()
     print "@refs/heads/%s HEAD" % 'master'
     print
 
-- 
1.8.2
