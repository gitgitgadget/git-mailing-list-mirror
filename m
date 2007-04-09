From: Tomash Brechko <tomash.brechko@gmail.com>
Subject: [PATCH (resend)] Pass -C1 to git-apply in StGIT's apply_diff() and apply_patch().
Date: Mon, 9 Apr 2007 15:24:22 +0400
Message-ID: <20070409112422.GE11593@moonlight.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: catalin.marinas@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 09 13:25:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Harz5-0005e5-M5
	for gcvg-git@gmane.org; Mon, 09 Apr 2007 13:24:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753094AbXDILY3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Apr 2007 07:24:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753112AbXDILY2
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Apr 2007 07:24:28 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:56455 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753094AbXDILY0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Apr 2007 07:24:26 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1520288uga
        for <git@vger.kernel.org>; Mon, 09 Apr 2007 04:24:25 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:received:date:from:to:subject:message-id:mail-followup-to:mime-version:content-type:content-disposition:user-agent;
        b=EJV/pZ2Yx58W5r9jEfQt9V76gGwi0+uRiEsWaax2z4bMvIsn9M2kfaaH1sRb7rPZTPkESo361JdrfzGcnnpbuglAyjurdaYVCbzRqHjC+n53bxQ1XPZs8oiO7hhu7RV1zJs37So6O14OwciGQ2rkD2GPeOH7G5cvJerQ0o0kFkY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:subject:message-id:mail-followup-to:mime-version:content-type:content-disposition:user-agent;
        b=OG8a+HvZVdartV29RaV1Js/hNv4fLfdWDJ3zg5oyudDQgOzkN+UF5gm81J3QoUKl7fBoUXg7sHgZf20W8tMox+X54/choywN9tzt8sSlVLh0gZzZuqWZeKP/qM8vIP7IDqszwJkqteHMGClx+pSTffORjEaP1m87dO5fN+DWc/4=
Received: by 10.67.40.12 with SMTP id s12mr5199663ugj.1176117865730;
        Mon, 09 Apr 2007 04:24:25 -0700 (PDT)
Received: from moonlight.home ( [80.246.71.156])
        by mx.google.com with ESMTP id b35sm8674553ugd.2007.04.09.04.24.24;
        Mon, 09 Apr 2007 04:24:25 -0700 (PDT)
Received: from moonlight.home (localhost.localdomain [127.0.0.1])
	by moonlight.home (Postfix) with ESMTP id AFF783A7C2;
	Mon,  9 Apr 2007 15:24:22 +0400 (MSD)
Received: (from tomash@localhost)
	by moonlight.home (8.13.1/8.13.1/Submit) id l39BOM6h018561;
	Mon, 9 Apr 2007 15:24:22 +0400
Mail-Followup-To: catalin.marinas@gmail.com, git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44051>

Running git-apply without -C is too restrictive: when the patch has
some fuzz (it could have been applied upstream with the fuzz, or
different local branches have slightly different context), StGIT would
start manual merge because of the conflict in the context.  Passing
-C1 makes git-apply behave close to default mode of diff/patch: 'diff'
generates 3 lines of context, and 'patch' allows 2 line mismatch,
i.e. it requires the match of at least one context line.

Fix in apply_diff() relaxes the restriction in 'push --merged' and
'rebase --merged' for detection of upstream merges, fix in
apply_patch() does relaxation 'import', 'fold' and 'sync' commands.

This patch is a quick hack, better solution would be to have a control
over the value to -C option, or to have the option similar to
git-cvsexportcommit -p (pedantic mode).
---
 stgit/git.py |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/stgit/git.py b/stgit/git.py
index f6d6b43..bbb41fe 100644
--- a/stgit/git.py
+++ b/stgit/git.py
@@ -660,7 +660,7 @@ def apply_diff(rev1, rev2, check_index = True, files = None):
     diff_str = diff(files, rev1, rev2)
     if diff_str:
         try:
-            _input_str('git-apply %s' % index_opt, diff_str)
+            _input_str('git-apply -C1 %s' % index_opt, diff_str)
         except GitException:
             return False
 
@@ -930,7 +930,7 @@ def apply_patch(filename = None, diff = None, base = None,
         refresh_index()
 
     try:
-        _input_str('git-apply --index', diff)
+        _input_str('git-apply -C1 --index', diff)
     except GitException:
         if base:
             switch(orig_head)
-- 
1.5.1.82.g46af1-dirty
