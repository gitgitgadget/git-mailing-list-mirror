From: Antoine Pelisse <apelisse@gmail.com>
Subject: [PATCH] remote-hg: unquote C-style paths when exporting
Date: Fri, 18 Oct 2013 19:03:41 +0200
Message-ID: <1382115821-12586-1-git-send-email-apelisse@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Antoine Pelisse <apelisse@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 18 19:04:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VXDTI-0001og-Ul
	for gcvg-git-2@plane.gmane.org; Fri, 18 Oct 2013 19:04:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756674Ab3JRREQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Oct 2013 13:04:16 -0400
Received: from mail-wg0-f49.google.com ([74.125.82.49]:54649 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756626Ab3JRREO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Oct 2013 13:04:14 -0400
Received: by mail-wg0-f49.google.com with SMTP id x12so3974672wgg.28
        for <git@vger.kernel.org>; Fri, 18 Oct 2013 10:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=FAjtPmiNZa1wcozotSe9KkBRRU3UEmVmwuQR0Q4JMuA=;
        b=Tyo++Y423LqZ7P/SLk7dF/dqo7cLtjLKSSc1bK07AyfFsUPBf9u66oG/mYwwXQ1erE
         Q6lhrAO06+mTiIlHtMA2zVL/Mto1lpnT22d6QLi4H2fsJbuBSje7gmwSnmKqjXZhi7tK
         4Py7qW+BE96ysdUIsjxLPAh5A7FRYodGeej4m8KxR3hCNUaRo5DElFy1zWCJQxZx1Y0w
         g2dRWlVU+OfDHkkDWIjjyhTI6Jdx9kaGeGDZS8xuItxmoZ57uf7Gp94djSYCKqmSW+eD
         UjywEtEdEEDuBmmb7eE1LzhzUoYXT5O0/bgWj/Y88QCi2kXl6nhKkxbWnJjw8HXzqjLR
         LKyQ==
X-Received: by 10.194.48.74 with SMTP id j10mr3081616wjn.41.1382115853417;
        Fri, 18 Oct 2013 10:04:13 -0700 (PDT)
Received: from localhost.localdomain ([82.247.80.218])
        by mx.google.com with ESMTPSA id bs15sm28768868wib.10.2013.10.18.10.04.11
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 18 Oct 2013 10:04:12 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.1.507.g9768648.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236360>

git-fast-import documentation says that paths can be C-style quoted.
Unfortunately, the current remote-hg helper doesn't unquote quoted
path and pass them as-is to Mercurial when the commit is created.

This result in the following situation:

- clone a mercurial repository with git
- Add a file with space: `mkdir dir/foo\ bar`
- Commit that new file, and push the change to mercurial
- The mercurial repository as now a new directory named '"dir', which
contains a file named 'foo bar"'

Use python ast.literal_eval to unquote the string if it starts with ".
It has been tested with quotes, spaces, and utf-8 encoded file-names.

Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 92d994e..0141949 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -14,6 +14,7 @@
 
 from mercurial import hg, ui, bookmarks, context, encoding, node, error, extensions, discovery, util
 
+import ast
 import re
 import sys
 import os
@@ -742,6 +743,8 @@ def parse_commit(parser):
             f = { 'deleted' : True }
         else:
             die('Unknown file command: %s' % line)
+        if path.startswith('"'):
+            path = ast.literal_eval(path)
         files[path] = f
 
     # only export the commits if we are on an internal proxy repo
-- 
1.8.4.1.507.g9768648.dirty
