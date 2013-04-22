From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 13/16] remote-hg: allow refs with spaces
Date: Mon, 22 Apr 2013 16:55:21 -0500
Message-ID: <1366667724-567-14-git-send-email-felipe.contreras@gmail.com>
References: <1366667724-567-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Simon Ruderich <simon@ruderich.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 23 00:00:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUOmb-0005jQ-0t
	for gcvg-git-2@plane.gmane.org; Tue, 23 Apr 2013 00:00:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753946Ab3DVWAO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 18:00:14 -0400
Received: from mail-ob0-f180.google.com ([209.85.214.180]:49898 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753802Ab3DVWAN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Apr 2013 18:00:13 -0400
Received: by mail-ob0-f180.google.com with SMTP id uk5so1416453obc.25
        for <git@vger.kernel.org>; Mon, 22 Apr 2013 15:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=AOtS31CGkXun+R+no2+fisyGRrVhhuujwlp6vTtP/gU=;
        b=vmKpP2e7jmOCEAQejKORQi15bz2NrfufquLoy6WHIe1AQnPqadLD6KB8vs865rM52k
         GRsFHJrKPl4EZNZFsygiOwdLOyIVcZtfIpLGXtjMZaskRoKtR6Qjbw16Ftl8MMEqU/7c
         9D7muw8YfY6WxfvDkRVidN9/tsT2fFH4PPm/UwoeGotLff0duJNdvkAfq7UIPEfkH9EB
         LorxB0ulAXHWA9E9E04XJKm6vFceDFqIj1qBfYhPa/n2Es/oBsNE0XsBkDLc9YLOz/Pu
         5gImYx3V3RzBNxLG/RooGymY4aZpPrFEMBvdHmEaKeGTQGpI7LSKgG8ERh6f5fwJ3mDI
         YNDg==
X-Received: by 10.60.54.100 with SMTP id i4mr15903291oep.42.1366668012854;
        Mon, 22 Apr 2013 15:00:12 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id b2sm20070280oby.5.2013.04.22.15.00.05
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 22 Apr 2013 15:00:12 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.790.g4588561
In-Reply-To: <1366667724-567-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222111>

Mercurial supports them, Git doesn't.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index dbb4091..6f4afd7 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -75,6 +75,12 @@ def hgmode(mode):
 def hghex(node):
     return hg.node.hex(node)
 
+def hgref(ref):
+    return ref.replace('___', ' ')
+
+def gitref(ref):
+    return ref.replace(' ', '___')
+
 def get_config(config):
     cmd = ['git', 'config', '--get', config]
     process = subprocess.Popen(cmd, stdout=subprocess.PIPE)
@@ -437,10 +443,10 @@ def export_ref(repo, name, kind, head):
     marks.set_tip(ename, rev)
 
 def export_tag(repo, tag):
-    export_ref(repo, tag, 'tags', repo[tag])
+    export_ref(repo, tag, 'tags', repo[hgref(tag)])
 
 def export_bookmark(repo, bmark):
-    head = bmarks[bmark]
+    head = bmarks[hgref(bmark)]
     export_ref(repo, bmark, 'bookmarks', head)
 
 def export_branch(repo, branch):
@@ -479,14 +485,14 @@ def branch_tip(repo, branch):
 def get_branch_tip(repo, branch):
     global branches
 
-    heads = branches.get(branch, None)
+    heads = branches.get(hgref(branch), None)
     if not heads:
         return None
 
     # verify there's only one head
     if (len(heads) > 1):
         warn("Branch '%s' has more than one head, consider merging" % branch)
-        return branch_tip(repo, branch)
+        return branch_tip(repo, hgref(branch))
 
     return heads[0]
 
@@ -508,6 +514,7 @@ def list_head(repo, cur):
             head = 'master'
         bmarks[head] = node
 
+    head = gitref(head)
     print "@refs/heads/%s HEAD" % head
     g_head = (head, node)
 
@@ -529,15 +536,15 @@ def do_list(parser):
                 branches[branch] = heads
 
         for branch in branches:
-            print "? refs/heads/branches/%s" % branch
+            print "? refs/heads/branches/%s" % gitref(branch)
 
     for bmark in bmarks:
-        print "? refs/heads/%s" % bmark
+        print "? refs/heads/%s" % gitref(bmark)
 
     for tag, node in repo.tagslist():
         if tag == 'tip':
             continue
-        print "? refs/tags/%s" % tag
+        print "? refs/tags/%s" % gitref(tag)
 
     print
 
@@ -674,7 +681,8 @@ def parse_commit(parser):
 
     # Check if the ref is supposed to be a named branch
     if ref.startswith('refs/heads/branches/'):
-        extra['branch'] = ref[len('refs/heads/branches/'):]
+        branch = ref[len('refs/heads/branches/'):]
+        extra['branch'] = hgref(branch)
 
     if mode == 'hg':
         i = data.find('\n--HG--\n')
@@ -803,6 +811,7 @@ def do_export(parser):
             continue
         elif ref.startswith('refs/tags/'):
             tag = ref[len('refs/tags/'):]
+            tag = hgref(tag)
             author, msg = parsed_tags.get(tag, (None, None))
             if mode == 'git':
                 if not msg:
-- 
1.8.2.1.790.g4588561
