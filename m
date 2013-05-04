From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/2] remote-bzr: avoid bad refs
Date: Fri,  3 May 2013 19:22:37 -0500
Message-ID: <1367626957-13858-3-git-send-email-felipe.contreras@gmail.com>
References: <1367626957-13858-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 04 02:24:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UYQH2-0000qj-8N
	for gcvg-git-2@plane.gmane.org; Sat, 04 May 2013 02:24:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763326Ab3EDAYO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 May 2013 20:24:14 -0400
Received: from mail-yh0-f53.google.com ([209.85.213.53]:43193 "EHLO
	mail-yh0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762975Ab3EDAYD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 May 2013 20:24:03 -0400
Received: by mail-yh0-f53.google.com with SMTP id z12so401702yhz.26
        for <git@vger.kernel.org>; Fri, 03 May 2013 17:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=5QYmi/iF3pwe0y/yP9ho/WrQrBBwOpbGeJWe0WFMv6E=;
        b=kWQPjhx/Xi01cmc1D7H/WVAIPbsim+fVj5Fr36y5hwV3Cm0+aaYXupSRsWuGAtSnyu
         iEzQJG5bS8mVGu5tf3mNOdNjpTF1c83auLRnA4k39t3pwX/N1Jui1XTPHC1V2LeP/2Pz
         QLjir0vEOEQC6bHMoaJORK0uM51JCJl+plocgMXnl/rhvvSf0QZbBmClGZJe8nR2cPUq
         4cNufUX0oSVcwo1ow6hFAahcPIx/27HaQvDNq5JlDfAPB1rzgBEl+qgkRTZdABHsLAnb
         ab5WNTdC1YTMIBPeD1PrzdjHM0f+1BMkbSyZbkp5oK6HMc2/A94LWsGt7vcojAK2Gqcc
         il0A==
X-Received: by 10.236.51.167 with SMTP id b27mr11242580yhc.128.1367627042411;
        Fri, 03 May 2013 17:24:02 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id o49sm24928959yhj.3.2013.05.03.17.24.00
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 03 May 2013 17:24:01 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc0.401.g45bba44
In-Reply-To: <1367626957-13858-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223343>

Turns out fast-export throws bad 'reset' commands because of a behavior
in transport-helper that is not even needed.

We should ignore them, otherwise we will threat them as branches and
fail.

This was fixed in v1.8.2, but some people use this script in older
versions of git.

Also, check if the ref was a tag, and skip it for now.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-bzr | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
index bbaaa8f..1f48b00 100755
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
+            if name in peers:
+                peer = bzrlib.branch.Branch.open(peers[name])
             try:
                 peer.bzrdir.push_branch(branch, revision_id=revid)
             except bzrlib.errors.DivergedBranches:
                 print "error %s non-fast forward" % ref
                 continue
 
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
