From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 34/48] remote-hg: implement custom checkheads()
Date: Fri, 24 May 2013 21:29:50 -0500
Message-ID: <1369449004-17981-35-git-send-email-felipe.contreras@gmail.com>
References: <1369449004-17981-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 25 04:33:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ug4Ia-0002do-U8
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 04:33:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755595Ab3EYCda (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 22:33:30 -0400
Received: from mail-oa0-f53.google.com ([209.85.219.53]:63872 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755587Ab3EYCd2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 22:33:28 -0400
Received: by mail-oa0-f53.google.com with SMTP id g12so6857131oah.40
        for <git@vger.kernel.org>; Fri, 24 May 2013 19:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Bg+Qu2jC4kFYInM9I7mYqA7lt5ghQCh0xCPYV3V2x4c=;
        b=xOHEcU9++2lW4fuM+K7CZgZ+qt8cp5MTLdvskwB5sjVxe8VayDutur4AgObyaQBJ4f
         cRQgn2oTp80xbRDuoEbCqeXCtnf9rPvghF3IuznFJwQqK1K2W2/GFmKfvbEEgZu70c3/
         6sJAanIhsDWkUHK4bjmUKIiDNn3MpQie6grICyB3Wygx6RouGJZ8rBScTkT6dF/Mt8i8
         HIcGUB70kNnx2eflSZovoNyDdB+1Yrcmypur7yDLRT5MrVnyrPU9SMm3EHrD9I0ZK/jh
         gDhrRz0ZTL4qj+1jXnTkn+3JcQquqYSCUGeyZqQZ0CD5j3/nLeWn/Hrtmgs5Z8lAvEpu
         UjJA==
X-Received: by 10.182.226.162 with SMTP id rt2mr13678149obc.9.1369449207927;
        Fri, 24 May 2013 19:33:27 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id x5sm20597213oep.1.2013.05.24.19.33.25
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 24 May 2013 19:33:27 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
In-Reply-To: <1369449004-17981-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225449>

The version from Mercurial is extremely inefficient and convoluted, this
version achieves basically the same, at least for our purposes.

No functional changes.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 52 +++++++++++++++++++++++++++++++++---
 1 file changed, 49 insertions(+), 3 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index c2c1cb8..7eb809b 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -12,7 +12,7 @@
 # For remote repositories a local clone is stored in
 # "$GIT_DIR/hg/origin/clone/.hg/".
 
-from mercurial import hg, ui, bookmarks, context, encoding, node, error, extensions, discovery
+from mercurial import hg, ui, bookmarks, context, encoding, node, error, extensions, discovery, util
 
 import re
 import sys
@@ -86,6 +86,11 @@ def hgref(ref):
 def gitref(ref):
     return ref.replace(' ', '___')
 
+def check_version(*check):
+    if not hg_version:
+        return True
+    return hg_version >= check
+
 def get_config(config):
     cmd = ['git', 'config', '--get', config]
     process = subprocess.Popen(cmd, stdout=subprocess.PIPE)
@@ -854,6 +859,42 @@ def write_tag(repo, tag, node, msg, author):
 
     return tagnode
 
+def checkheads(repo, remote, p_revs):
+
+    remotemap = remote.branchmap()
+    if not remotemap:
+        # empty repo
+        return
+
+    new = {}
+
+    for node in p_revs:
+        ctx = repo[node]
+        branch = ctx.branch()
+        if not branch in remotemap:
+            # new branch
+            continue
+        new.setdefault(branch, []).append(ctx.rev())
+
+    for branch, heads in new.iteritems():
+        old = [repo.changelog.rev(x) for x in remotemap[branch]]
+        for rev in heads:
+            if check_version(2, 3):
+                ancestors = repo.changelog.ancestors([rev], stoprev=min(old))
+            else:
+                ancestors = repo.changelog.ancestors(rev)
+            found = False
+
+            for x in old:
+                if x in ancestors:
+                    found = True
+                    break
+
+            if found:
+                continue
+
+            raise Exception("non-fast-forward")
+
 def push_unsafe(repo, remote, parsed_refs, p_revs):
 
     force = force_push
@@ -862,7 +903,8 @@ def push_unsafe(repo, remote, parsed_refs, p_revs):
     commoninc = fci(repo, remote, force=force)
     common, _, remoteheads = commoninc
 
-    # TODO checkheads
+    if not force:
+        checkheads(repo, remote, p_revs)
 
     cg = repo.getbundle('push', heads=list(p_revs), common=common)
 
@@ -991,7 +1033,7 @@ def main(args):
     global track_branches, force_push, is_tmp
     global parsed_tags
     global filenodes
-    global fake_bmark
+    global fake_bmark, hg_version
 
     alias = args[1]
     url = args[2]
@@ -1026,6 +1068,10 @@ def main(args):
     parsed_tags = {}
     filenodes = {}
     fake_bmark = None
+    try:
+        hg_version = tuple(int(e) for e in util.version().split('.'))
+    except:
+        hg_version = None
 
     repo = get_repo(url, alias)
     prefix = 'refs/hg/%s' % alias
-- 
1.8.3.rc3.312.g47657de
