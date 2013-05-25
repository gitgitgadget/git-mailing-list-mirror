From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 47/48] remote-hg: add support for --dry-run
Date: Fri, 24 May 2013 21:30:03 -0500
Message-ID: <1369449004-17981-48-git-send-email-felipe.contreras@gmail.com>
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
	id 1Ug4JF-0003AF-N3
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 04:34:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755912Ab3EYCeJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 22:34:09 -0400
Received: from mail-oa0-f41.google.com ([209.85.219.41]:46752 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755882Ab3EYCeH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 22:34:07 -0400
Received: by mail-oa0-f41.google.com with SMTP id n9so7067010oag.14
        for <git@vger.kernel.org>; Fri, 24 May 2013 19:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=0rO1fhctU8ncSg3tTYxb8KMeA7MBYJaDGji6v+4dHi4=;
        b=FPLqpcU9xP+ugJ3VTInEiaFHhjx0BEmM/IpayILm/hJTWNgwxDsT/F/YHz0QmDPfjs
         fIKx1a6AvFCLB/GBJpajjA2DxnUtuKZ27gxaR6rbRp7B38JFWqn134ze28bS9oxQfjE3
         TMeio5bUk5gfgAP9E1XHFhlyL/Eo0ziPf58wbj0u3sfIFAwvtKvl92zg+uXk104qcZtQ
         vuDwtQS+udNWlzBcsjwUsdxCztmttYDQ5Hd81z4mIzoKPqS+OyId3ZoneAe7AIziAPbm
         tOtGG3v6KPD7bPJQXC0+p3VXxpPTC22Ynst4pj4wQbHOqFfSx+8/v21thiWN2p10AKXu
         vJgw==
X-Received: by 10.182.128.106 with SMTP id nn10mr13769647obb.72.1369449247197;
        Fri, 24 May 2013 19:34:07 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id b1sm9146320oeo.8.2013.05.24.19.34.05
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 24 May 2013 19:34:06 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
In-Reply-To: <1369449004-17981-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225462>

This needs a specific patch from Git not applied yet.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 29 +++++++++++++++++++++++++--
 contrib/remote-helpers/test-hg.sh    | 38 ++++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+), 2 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index b983627..20abb34 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -557,6 +557,7 @@ def do_capabilities(parser):
     if os.path.exists(path):
         print "*import-marks %s" % path
     print "*export-marks %s" % path
+    print "option"
 
     print
 
@@ -724,6 +725,11 @@ def parse_commit(parser):
             die('Unknown file command: %s' % line)
         files[path] = f
 
+    # only export the commits if we are on an internal proxy repo
+    if dry_run and not peer:
+        parsed_refs[ref] = None
+        return
+
     def getfilectx(repo, memctx, f):
         of = files[f]
         if 'deleted' in of:
@@ -809,7 +815,10 @@ def parse_reset(parser):
     from_mark = parser.get_mark()
     parser.next()
 
-    rev = mark_to_rev(from_mark)
+    try:
+        rev = mark_to_rev(from_mark)
+    except KeyError:
+        rev = None
     parsed_refs[ref] = rev
 
 def parse_tag(parser):
@@ -1007,7 +1016,7 @@ def do_export(parser):
     need_fetch = False
 
     for ref, node in parsed_refs.iteritems():
-        bnode = hgbin(node)
+        bnode = hgbin(node) if node else None
         if ref.startswith('refs/heads/branches'):
             branch = ref[len('refs/heads/branches/'):]
             if branch in branches and bnode in branches[branch]:
@@ -1048,6 +1057,9 @@ def do_export(parser):
 
             p_revs[bnode] = ref
         elif ref.startswith('refs/tags/'):
+            if dry_run:
+                print "ok %s" % ref
+                continue
             tag = ref[len('refs/tags/'):]
             tag = hgref(tag)
             author, msg = parsed_tags.get(tag, (None, None))
@@ -1097,6 +1109,15 @@ def do_export(parser):
 
     print
 
+def do_option(parser):
+    global dry_run
+    _, key, value = parser.line.split(' ')
+    if key == 'dry-run':
+        dry_run = (value == 'true')
+        print 'ok'
+    else:
+        print 'unsupported'
+
 def fix_path(alias, repo, orig_url):
     url = urlparse.urlparse(orig_url, 'file')
     if url.scheme != 'file' or os.path.isabs(url.path):
@@ -1113,6 +1134,7 @@ def main(args):
     global parsed_tags
     global filenodes
     global fake_bmark, hg_version
+    global dry_run
 
     alias = args[1]
     url = args[2]
@@ -1151,6 +1173,7 @@ def main(args):
         hg_version = tuple(int(e) for e in util.version().split('.'))
     except:
         hg_version = None
+    dry_run = False
 
     repo = get_repo(url, alias)
     prefix = 'refs/hg/%s' % alias
@@ -1175,6 +1198,8 @@ def main(args):
             do_import(parser)
         elif parser.check('export'):
             do_export(parser)
+        elif parser.check('option'):
+            do_option(parser)
         else:
             die('unhandled command: %s' % line)
         sys.stdout.flush()
diff --git a/contrib/remote-helpers/test-hg.sh b/contrib/remote-helpers/test-hg.sh
index 91ddac7..bf3635e 100755
--- a/contrib/remote-helpers/test-hg.sh
+++ b/contrib/remote-helpers/test-hg.sh
@@ -594,6 +594,44 @@ test_expect_success 'remote big push fetch first' '
 	)
 '
 
+test_expect_failure 'remote big push dry-run' '
+	test_when_finished "rm -rf hgrepo gitrepo*" &&
+
+	setup_big_push
+
+	(
+	cd gitrepo &&
+
+	check_push 0 --dry-run --all <<-EOF
+	master
+	good_bmark
+	branches/good_branch
+	new_bmark:new
+	branches/new_branch:new
+	bad_bmark1:non-fast-forward
+	bad_bmark2:non-fast-forward
+	branches/bad_branch:non-fast-forward
+	EOF
+
+	check_push 0 --dry-run master good_bmark new_bmark branches/good_branch branches/new_branch <<-EOF
+	master
+	good_bmark
+	branches/good_branch
+	new_bmark:new
+	branches/new_branch:new
+	EOF
+	) &&
+
+	check_branch hgrepo default one &&
+	check_branch hgrepo good_branch "good branch" &&
+	check_branch hgrepo bad_branch "bad branch" &&
+	check_branch hgrepo new_branch '' &&
+	check_bookmark hgrepo good_bmark one &&
+	check_bookmark hgrepo bad_bmark1 one &&
+	check_bookmark hgrepo bad_bmark2 one &&
+	check_bookmark hgrepo new_bmark ''
+'
+
 test_expect_success 'remote double failed push' '
 	test_when_finished "rm -rf hgrepo gitrepo*" &&
 
-- 
1.8.3.rc3.312.g47657de
