From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 18/20] remote-bzr: delay peer branch usage
Date: Thu, 25 Apr 2013 20:08:06 -0500
Message-ID: <1366938488-25425-19-git-send-email-felipe.contreras@gmail.com>
References: <1366938488-25425-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 26 03:10:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVXB9-0004Ek-VO
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 03:10:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932943Ab3DZBKS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 21:10:18 -0400
Received: from mail-ob0-f171.google.com ([209.85.214.171]:61123 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932853Ab3DZBKP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 21:10:15 -0400
Received: by mail-ob0-f171.google.com with SMTP id er7so3086916obc.16
        for <git@vger.kernel.org>; Thu, 25 Apr 2013 18:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=XsIuqY3lcW6GiQgc4pwOjFKJqkoHoLwBtBnVPnUfMNU=;
        b=xhvS2GqQ3CFZF+WSniI+zSNESOseuasnk1Pmsh/epdVlIDKQs9xC/A9mtmCQnjJUd2
         5izo5H3jHC1DfR6G7f4yHv6SN+qmtMYWoVOruSJrdO7/ebhT7T+qYIUQbOaMb3kYGM9e
         eZOq4jwq6SyKa3CMTLCO93+Tk4f31XoPnBuUz8NoZzthRrHgsQ11QjNn8/RskCqDN+35
         b9TDCt5ba+1NBL1Zs4dFEDkKB0ou5zXN4CV9BWe4Kd4TfnDhF85q94FUWuO5dDGr6C6X
         9BEXnPEodkdQC6h+6uzVxKU0JCC3YjCqLRmpCRpzG/bLgKbPseotEE3YpqyURTZFb7Wc
         1/EQ==
X-Received: by 10.182.38.201 with SMTP id i9mr10175884obk.55.1366938614990;
        Thu, 25 Apr 2013 18:10:14 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id rn6sm2569056oeb.0.2013.04.25.18.10.13
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 25 Apr 2013 18:10:14 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.884.g3532a8d
In-Reply-To: <1366938488-25425-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222499>

So it doesn't time out.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-bzr | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
index 5f1b9c0..7517645 100755
--- a/contrib/remote-helpers/git-remote-bzr
+++ b/contrib/remote-helpers/git-remote-bzr
@@ -710,7 +710,7 @@ def do_export(parser):
         branch.generate_revision_history(revid, marks.get_tip(name))
 
         if name in peers:
-            peer = peers[name]
+            peer = bzrlib.branch.Branch.open(peers[name])
             try:
                 peer.bzrdir.push_branch(branch, revision_id=revid)
             except bzrlib.errors.DivergedBranches:
@@ -848,7 +848,7 @@ def get_repo(url, alias):
         branch = origin.open_branch()
 
         if not is_local:
-            peers[name] = branch
+            peers[name] = branch.base
             branches[name] = get_remote_branch(origin, branch, name)
         else:
             branches[name] = branch
@@ -864,7 +864,7 @@ def get_repo(url, alias):
         for name, branch in find_branches(repo, wanted):
 
             if not is_local:
-                peers[name] = branch
+                peers[name] = branch.base
                 branches[name] = get_remote_branch(origin, branch, name)
             else:
                 branches[name] = branch
-- 
1.8.2.1.884.g3532a8d
