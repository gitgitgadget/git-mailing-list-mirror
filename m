From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 13/18] remote-bzr: add custom method to find branches
Date: Tue, 30 Apr 2013 20:10:05 -0500
Message-ID: <1367370610-14250-14-git-send-email-felipe.contreras@gmail.com>
References: <1367370610-14250-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 01 03:12:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXLb8-0007lg-ON
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 03:12:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934159Ab3EABMh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 21:12:37 -0400
Received: from mail-ye0-f176.google.com ([209.85.213.176]:48481 "EHLO
	mail-ye0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934141Ab3EABMd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 21:12:33 -0400
Received: by mail-ye0-f176.google.com with SMTP id r9so196427yen.7
        for <git@vger.kernel.org>; Tue, 30 Apr 2013 18:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=yS5QZG380mwg1J/pq9hfRW6WtcC8oAx4IKgNjfMP+As=;
        b=oU4tYSbXHAeREPkGHrPt5kzSDt24oUGorHmKGCEsKXp6615cfu88V/TvbbK7EpqXKl
         /v2HHA8mLhGUldfOBApKYa5hnO2JCTZgfMxdjq9h70SSapGGrVP0cLNsxgnc9JuVJdVX
         02yqY9LtEot3+lTI+T3g6UcyLbgu5gk3XZxef131X0JpCcH9YSzOaaf5Z7sk2VY5R8eX
         CkysxkL/CQxESLpJ6OUpUu3zuzomTY9EXWWnqZQV5cJ3jMmpWRDmUoV4055xmIVs0rcR
         lttWTpBBL8IhYhqPnTLwW6XGL3e9RLsDoB3UsCsZexdQV9JIWBK2WN2bRQ8vhbXbzku4
         V1RQ==
X-Received: by 10.236.63.105 with SMTP id z69mr554222yhc.168.1367370752182;
        Tue, 30 Apr 2013 18:12:32 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id j47sm1540499yhm.21.2013.04.30.18.12.30
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 30 Apr 2013 18:12:31 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc0.399.gc96a135
In-Reply-To: <1367370610-14250-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223056>

The official method is incredibly inefficient and slow.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-bzr | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
index af46016..11f2415 100755
--- a/contrib/remote-helpers/git-remote-bzr
+++ b/contrib/remote-helpers/git-remote-bzr
@@ -756,6 +756,25 @@ def get_remote_branch(origin, remote_branch, name):
 
     return branch
 
+def find_branches(repo):
+    transport = repo.user_transport
+
+    for fn in transport.iter_files_recursive():
+        if not fn.endswith('.bzr/branch-format'):
+            continue
+
+        name = subdir = fn[:-len('/.bzr/branch-format')]
+        name = name if name != '' else 'master'
+        name = name.replace('/', '+')
+
+        try:
+            cur = transport.clone(subdir)
+            branch = bzrlib.branch.Branch.open_from_transport(cur)
+        except bzrlib.errors.NotBranchError:
+            continue
+        else:
+            yield name, branch
+
 def get_repo(url, alias):
     global dirname, peer, branches
 
@@ -796,11 +815,7 @@ def get_repo(url, alias):
     else:
         # repository
 
-        for branch in repo.find_branches():
-
-            name = repo.user_transport.relpath(branch.base)
-            name = name if name != '' else 'master'
-            name = name.replace('/', '+')
+        for name, branch in find_branches(repo):
 
             if not is_local:
                 peers[name] = branch
-- 
1.8.3.rc0.399.gc96a135
