From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 46/48] remote-hg: check if a fetch is needed
Date: Fri, 24 May 2013 21:30:02 -0500
Message-ID: <1369449004-17981-47-git-send-email-felipe.contreras@gmail.com>
References: <1369449004-17981-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 25 04:34:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ug4J9-00036S-Sw
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 04:34:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755904Ab3EYCeH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 22:34:07 -0400
Received: from mail-ob0-f182.google.com ([209.85.214.182]:50904 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755882Ab3EYCeE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 22:34:04 -0400
Received: by mail-ob0-f182.google.com with SMTP id va2so6213668obc.27
        for <git@vger.kernel.org>; Fri, 24 May 2013 19:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=xdWVNE27DYhi1Pyo/js1f1kD53M09xiYdra6ExDCyLY=;
        b=ZtHWQO3s2Gy0GjrTgQpxZTxXrrwQmrDGIoiOuPsCdVgdhD5LJZd3+2lP0xpCy2WSJY
         fK4bqjm5bHzT+hYZIZ8yzPr3ew4MCMRkEtpr4p9uWD37Hx3ahXMvq7x9nJB7KxcjVSll
         a/CBvhTjganQxjrhzVFP7J14w1XTsGE5HC7bnc/HTnw6fCaRdC7Kg7HC0uMoxfm3uf+I
         CEUVS8zXs5gAzNM4BEOitIS5jk9s0upV03qwCg5Tu2lqX8hptXfcX/k+HRP3lNfjOiLQ
         XGAUD5tSzIQOXSqu4LWU7FgLCJ5+gVrX6zc+vr07iaq0mwKzHuSId2RBcfZgCWpW7+gH
         mUVQ==
X-Received: by 10.182.84.193 with SMTP id b1mr13465664obz.68.1369449244039;
        Fri, 24 May 2013 19:34:04 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id c20sm20574458oez.4.2013.05.24.19.34.02
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 24 May 2013 19:34:03 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
In-Reply-To: <1369449004-17981-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225459>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 39 ++++++++++++++++++++
 contrib/remote-helpers/test-hg.sh    | 71 +++++++++++++++++++++++++++++++++++-
 2 files changed, 109 insertions(+), 1 deletion(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index b08f909..b983627 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -973,6 +973,15 @@ def push(repo, remote, parsed_refs, p_revs):
 
     return ret
 
+def check_tip(ref, kind, name, heads):
+    try:
+        ename = '%s/%s' % (kind, name)
+        tip = marks.get_tip(ename)
+    except KeyError:
+        return True
+    else:
+        return tip in heads
+
 def do_export(parser):
     global parsed_refs, bmarks, peer
 
@@ -995,6 +1004,8 @@ def do_export(parser):
         else:
             die('unhandled export command: %s' % line)
 
+    need_fetch = False
+
     for ref, node in parsed_refs.iteritems():
         bnode = hgbin(node)
         if ref.startswith('refs/heads/branches'):
@@ -1002,6 +1013,16 @@ def do_export(parser):
             if branch in branches and bnode in branches[branch]:
                 # up to date
                 continue
+
+            if peer:
+                remotemap = peer.branchmap()
+                if remotemap and branch in remotemap:
+                    heads = [hghex(e) for e in remotemap[branch]]
+                    if not check_tip(ref, 'branches', branch, heads):
+                        print "error %s fetch first" % ref
+                        need_fetch = True
+                        continue
+
             p_revs[bnode] = ref
             print "ok %s" % ref
         elif ref.startswith('refs/heads/'):
@@ -1017,6 +1038,14 @@ def do_export(parser):
                     not (bmark == 'master' and bmark not in parser.repo._bookmarks):
                 p_bmarks.append((ref, bmark, old, new))
 
+            if peer:
+                remote_old = peer.listkeys('bookmarks').get(bmark)
+                if remote_old:
+                    if not check_tip(ref, 'bookmarks', bmark, remote_old):
+                        print "error %s fetch first" % ref
+                        need_fetch = True
+                        continue
+
             p_revs[bnode] = ref
         elif ref.startswith('refs/tags/'):
             tag = ref[len('refs/tags/'):]
@@ -1037,6 +1066,16 @@ def do_export(parser):
             # transport-helper/fast-export bugs
             continue
 
+    if need_fetch:
+        print
+        return
+
+    if dry_run:
+        if peer and not force_push:
+            checkheads(parser.repo, peer, p_revs)
+        print
+        return
+
     if peer:
         if not push(parser.repo, peer, parsed_refs, p_revs):
             # do not update bookmarks
diff --git a/contrib/remote-helpers/test-hg.sh b/contrib/remote-helpers/test-hg.sh
index aeab48a..91ddac7 100755
--- a/contrib/remote-helpers/test-hg.sh
+++ b/contrib/remote-helpers/test-hg.sh
@@ -65,6 +65,9 @@ check_push () {
 		'non-fast-forward')
 			grep "^ ! \[rejected\] *${branch} -> ${branch} (non-fast-forward)$" error || ref_ret=1
 			;;
+		'fetch-first')
+			grep "^ ! \[rejected\] *${branch} -> ${branch} (fetch first)$" error || ref_ret=1
+			;;
 		'')
 			grep "^   [a-f0-9]*\.\.[a-f0-9]* *${branch} -> ${branch}$" error || ref_ret=1
 			;;
@@ -407,7 +410,7 @@ test_expect_success 'remote update bookmark diverge' '
 	echo diverge > content &&
 	git commit -a -m diverge &&
 	check_push 1 <<-EOF
-	diverge:non-fast-forward
+	diverge:fetch-first
 	EOF
 	) &&
 
@@ -525,6 +528,72 @@ test_expect_success 'remote big push' '
 	check_bookmark hgrepo new_bmark ''
 '
 
+test_expect_success 'remote big push fetch first' '
+	test_when_finished "rm -rf hgrepo gitrepo*" &&
+
+	(
+	hg init hgrepo &&
+	cd hgrepo &&
+	echo zero > content &&
+	hg add content &&
+	hg commit -m zero &&
+	hg bookmark bad_bmark &&
+	hg bookmark good_bmark &&
+	hg bookmark -i good_bmark &&
+	hg -q branch good_branch &&
+	echo "good branch" > content &&
+	hg commit -m "good branch" &&
+	hg -q branch bad_branch &&
+	echo "bad branch" > content &&
+	hg commit -m "bad branch"
+	) &&
+
+	git clone "hg::hgrepo" gitrepo &&
+
+	(
+	cd hgrepo &&
+	hg bookmark -f bad_bmark &&
+	echo update_bmark > content &&
+	hg commit -m "update bmark"
+	) &&
+
+	(
+	cd gitrepo &&
+	echo two > content &&
+	git commit -q -a -m two &&
+
+	git checkout -q good_bmark &&
+	echo three > content &&
+	git commit -q -a -m three &&
+
+	git checkout -q bad_bmark &&
+	echo four > content &&
+	git commit -q -a -m four &&
+
+	git checkout -q branches/bad_branch &&
+	echo five > content &&
+	git commit -q -a -m five &&
+
+	check_push 1 --all <<-EOF
+	master
+	good_bmark
+	new_bmark:new
+	new_branch:new
+	bad_bmark:fetch-first
+	branches/bad_branch:festch-first
+	EOF
+
+	git fetch &&
+
+	check_push 1 --all <<-EOF
+	master
+	good_bmark
+	bad_bmark:non-fast-forward
+	branches/bad_branch:non-fast-forward
+	EOF
+	)
+'
+
 test_expect_success 'remote double failed push' '
 	test_when_finished "rm -rf hgrepo gitrepo*" &&
 
-- 
1.8.3.rc3.312.g47657de
