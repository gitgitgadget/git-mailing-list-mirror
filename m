From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 48/48] remote-hg: add support for --force
Date: Fri, 24 May 2013 21:30:04 -0500
Message-ID: <1369449004-17981-49-git-send-email-felipe.contreras@gmail.com>
References: <1369449004-17981-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 25 04:34:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ug4JG-0003AF-F2
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 04:34:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755939Ab3EYCeO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 22:34:14 -0400
Received: from mail-oa0-f52.google.com ([209.85.219.52]:46936 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755882Ab3EYCeK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 22:34:10 -0400
Received: by mail-oa0-f52.google.com with SMTP id h1so6845514oag.39
        for <git@vger.kernel.org>; Fri, 24 May 2013 19:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=BTrxiEgEC+skCoqPS/kWwQ6yphPSQstrCLu7aUj9d90=;
        b=hSdT+HiSBTRixxax7cYwLgqBU0saUNZEZpglDZr4se5JzU078x4z6uN5aMgX9AzenG
         vcyidSjOLnIB4ClqXVAYYL4QyZ/tdzZ7+jR1mvmXHoJgMLMdR5q6xr/WWLuzEZCbux73
         h73gYnxxaMZxLBAydcHxi8SgTqdjDv4ROUDgBUBKWaB9c7pWBNNZFuWcp8S3zZF7MYzr
         r2mB64gKjyuwsy/FRfqvnFn1Iy2+oON1QPo6rv2IvAjPYz4LswhTy+Uy795V75h3B5wB
         mGKyKOlYxn7w6YZA+Y35ctZrSF7JmDk9j4rlGEc08enN5odVmg8SC+IOtwqKSI9IT4Y2
         A4uw==
X-Received: by 10.182.112.133 with SMTP id iq5mr13378852obb.75.1369449250361;
        Fri, 24 May 2013 19:34:10 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id x10sm20560492oes.6.2013.05.24.19.34.08
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 24 May 2013 19:34:09 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
In-Reply-To: <1369449004-17981-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225461>

And get rid of the remote-hg.force-push option hack.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 30 +++++++++++++++++-------------
 contrib/remote-helpers/test-hg.sh    | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+), 13 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 20abb34..0194c67 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -29,9 +29,6 @@ import urlparse, hashlib
 # named branches:
 # git config --global remote-hg.track-branches false
 #
-# If you don't want to force pushes (and thus risk creating new remote heads):
-# git config --global remote-hg.force-push false
-#
 # If you want the equivalent of hg's clone/pull--insecure option:
 # git config --global remote-hg.insecure true
 #
@@ -877,9 +874,6 @@ def write_tag(repo, tag, node, msg, author):
     return (tagnode, branch)
 
 def checkheads_bmark(repo, ref, ctx):
-    if force_push:
-        return True
-
     bmark = ref[len('refs/heads/'):]
     if not bmark in bmarks:
         # new bmark
@@ -888,8 +882,11 @@ def checkheads_bmark(repo, ref, ctx):
     ctx_old = bmarks[bmark]
     ctx_new = ctx
     if not repo.changelog.descendant(ctx_old.rev(), ctx_new.rev()):
-        print "error %s non-fast forward" % ref
-        return False
+        if force_push:
+            print "ok %s forced update" % ref
+        else:
+            print "error %s non-fast forward" % ref
+            return False
 
     return True
 
@@ -936,8 +933,12 @@ def checkheads(repo, remote, p_revs):
                 continue
 
             node = repo.changelog.node(rev)
-            print "error %s non-fast forward" % p_revs[node]
-            ret = False
+            ref = p_revs[node]
+            if force_push:
+                print "ok %s forced update" % ref
+            else:
+                print "error %s non-fast forward" % ref
+                ret = False
 
     return ret
 
@@ -949,7 +950,7 @@ def push_unsafe(repo, remote, parsed_refs, p_revs):
     commoninc = fci(repo, remote, force=force)
     common, _, remoteheads = commoninc
 
-    if not force and not checkheads(repo, remote, p_revs):
+    if not checkheads(repo, remote, p_revs):
         return None
 
     cg = repo.getbundle('push', heads=list(p_revs), common=common)
@@ -1110,11 +1111,14 @@ def do_export(parser):
     print
 
 def do_option(parser):
-    global dry_run
+    global dry_run, force_push
     _, key, value = parser.line.split(' ')
     if key == 'dry-run':
         dry_run = (value == 'true')
         print 'ok'
+    elif key == 'force':
+        force_push = (value == 'true')
+        print 'ok'
     else:
         print 'unsupported'
 
@@ -1142,7 +1146,7 @@ def main(args):
 
     hg_git_compat = get_config_bool('remote-hg.hg-git-compat')
     track_branches = get_config_bool('remote-hg.track-branches', True)
-    force_push = get_config_bool('remote-hg.force-push')
+    force_push = False
 
     if hg_git_compat:
         mode = 'hg'
diff --git a/contrib/remote-helpers/test-hg.sh b/contrib/remote-helpers/test-hg.sh
index bf3635e..30f4ff6 100755
--- a/contrib/remote-helpers/test-hg.sh
+++ b/contrib/remote-helpers/test-hg.sh
@@ -68,6 +68,9 @@ check_push () {
 		'fetch-first')
 			grep "^ ! \[rejected\] *${branch} -> ${branch} (fetch first)$" error || ref_ret=1
 			;;
+		'forced-update')
+			grep "^ + [a-f0-9]*\.\.\.[a-f0-9]* *${branch} -> ${branch} (forced update)$" error || ref_ret=1
+			;;
 		'')
 			grep "^   [a-f0-9]*\.\.[a-f0-9]* *${branch} -> ${branch}$" error || ref_ret=1
 			;;
@@ -594,6 +597,36 @@ test_expect_success 'remote big push fetch first' '
 	)
 '
 
+test_expect_failure 'remote big push force' '
+	test_when_finished "rm -rf hgrepo gitrepo*" &&
+
+	setup_big_push
+
+	(
+	cd gitrepo &&
+
+	check_push 0 --force --all <<-EOF
+	master
+	good_bmark
+	branches/good_branch
+	new_bmark:new
+	branches/new_branch:new
+	bad_bmark1:forced-update
+	bad_bmark2:forced-update
+	branches/bad_branch:forced-update
+	EOF
+	) &&
+
+	check_branch hgrepo default six &&
+	check_branch hgrepo good_branch eight &&
+	check_branch hgrepo bad_branch nine &&
+	check_branch hgrepo new_branch ten &&
+	check_bookmark hgrepo good_bmark three &&
+	check_bookmark hgrepo bad_bmark1 four &&
+	check_bookmark hgrepo bad_bmark2 five &&
+	check_bookmark hgrepo new_bmark six
+'
+
 test_expect_failure 'remote big push dry-run' '
 	test_when_finished "rm -rf hgrepo gitrepo*" &&
 
-- 
1.8.3.rc3.312.g47657de
