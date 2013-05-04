From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 2/2] remote-bzr: avoid bad refs
Date: Fri,  3 May 2013 19:31:07 -0500
Message-ID: <1367627467-15132-3-git-send-email-felipe.contreras@gmail.com>
References: <1367627467-15132-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 04 02:32:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UYQP6-0008BC-Pd
	for gcvg-git-2@plane.gmane.org; Sat, 04 May 2013 02:32:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763338Ab3EDAcg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 May 2013 20:32:36 -0400
Received: from mail-ye0-f176.google.com ([209.85.213.176]:59590 "EHLO
	mail-ye0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763256Ab3EDAcb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 May 2013 20:32:31 -0400
Received: by mail-ye0-f176.google.com with SMTP id r9so210888yen.35
        for <git@vger.kernel.org>; Fri, 03 May 2013 17:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=yXiLSbb8Uedx4VafSVzKyLqMWkuVR01GPaY3GMmzHx0=;
        b=X6KrLQOL3qs9sZxEp8Sc4DzdD5ypRjXkWD1kmr+au1+Y873CSLGpY1dH952Aow5Dqc
         6L3CJnqYePVpA2j8L58FioKfX9gN+pCmoWF3xtWNUt6Uv3h69fbLJs36gA/oUA3P/0hk
         hIn14hxW0/0n4p6Ds4sC9c1+P+l52oVXUBQHONe64Tf8W4tAN2uRVFR8Uh1sNEp9Kanw
         SjUA/CymhDvu0oXv1VBJ9P3ThTvAvxik4IVc13N9KlZC3nVbZlb/7NIabo33fALoAfks
         CboyuZUYu5Z1OZ/JOUuwBheblEbpH0APVXAXKRQBaDEdryIn7jq1b4SxbK+V3nXxYwRT
         +k1w==
X-Received: by 10.236.20.102 with SMTP id o66mr10860260yho.125.1367627551054;
        Fri, 03 May 2013 17:32:31 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id j27sm24916635yhf.18.2013.05.03.17.32.29
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 03 May 2013 17:32:30 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc0.401.g45bba44
In-Reply-To: <1367627467-15132-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223347>

Turns out fast-export throws bad 'reset' commands because of a behavior
in transport-helper that is not even needed.

We should ignore them, otherwise we will threat them as branches and
fail.

This was fixed in v1.8.2, but some people use this script in older
versions of git.

Also, check if the ref was a tag, and skip it for now.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-bzr | 38 +++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
index bbaaa8f..0ef30f8 100755
--- a/contrib/remote-helpers/git-remote-bzr
+++ b/contrib/remote-helpers/git-remote-bzr
@@ -682,23 +682,31 @@ def do_export(parser):
             die('unhandled export command: %s' % line)
 
     for ref, revid in parsed_refs.iteritems():
-        name = ref[len('refs/heads/'):]
-        branch = bzrlib.branch.Branch.open(branches[name])
-        branch.generate_revision_history(revid, marks.get_tip(name))
+        if ref.startswith('refs/heads/'):
+            name = ref[len('refs/heads/'):]
+            branch = bzrlib.branch.Branch.open(branches[name])
+            branch.generate_revision_history(revid, marks.get_tip(name))
 
-        if name in peers:
-            peer = bzrlib.branch.Branch.open(peers[name])
-            try:
-                peer.bzrdir.push_branch(branch, revision_id=revid)
-            except bzrlib.errors.DivergedBranches:
-                print "error %s non-fast forward" % ref
-                continue
+            if name in peers:
+                peer = bzrlib.branch.Branch.open(peers[name])
+                try:
+                    peer.bzrdir.push_branch(branch, revision_id=revid)
+                except bzrlib.errors.DivergedBranches:
+                    print "error %s non-fast forward" % ref
+                    continue
 
-        try:
-            wt = branch.bzrdir.open_workingtree()
-            wt.update()
-        except bzrlib.errors.NoWorkingTree:
-            pass
+            try:
+                wt = branch.bzrdir.open_workingtree()
+                wt.update()
+            except bzrlib.errors.NoWorkingTree:
+                pass
+        elif ref.startswith('refs/tags/'):
+            # TODO: implement tag push
+            print "error %s pushing tags not supported" % ref
+            continue
+        else:
+            # transport-helper/fast-export bugs
+            continue
 
         print "ok %s" % ref
 
-- 
1.8.3.rc0.401.g45bba44
