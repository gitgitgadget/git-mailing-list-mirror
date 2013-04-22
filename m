From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 03/16] remote-hg: use python urlparse
Date: Mon, 22 Apr 2013 16:55:11 -0500
Message-ID: <1366667724-567-4-git-send-email-felipe.contreras@gmail.com>
References: <1366667724-567-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Simon Ruderich <simon@ruderich.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 22 23:57:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUOk1-0001Cs-2r
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 23:57:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753938Ab3DVV5i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 17:57:38 -0400
Received: from mail-ob0-f178.google.com ([209.85.214.178]:52190 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753556Ab3DVV5i (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Apr 2013 17:57:38 -0400
Received: by mail-ob0-f178.google.com with SMTP id 16so1974048obc.37
        for <git@vger.kernel.org>; Mon, 22 Apr 2013 14:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=F5DHp+Rl+y5OJMwP9nJdHzQMj7/vn6SXQy3slll4uq4=;
        b=oChTAkIHnPsHoSr3nIWo2EIXeR1WN4+Wus0oCYFmJT2FgF7h/P4XX6cPzmTnJTxwcd
         NQNbkt6w47qga2y+y6pYbrEkCjGTnsovlAt+wveF4Ok3QfFyRiQMmnQ8HzRgJFoecIa1
         3jZPxkUUwicWuJGqvW/WDYD7O95MObJKFWXZX8GE1aHd5Ny3dq6b14136JLzX67P8DNG
         CR8oo0oFy6INYfoSJQmnBrBhXXvNng/TwGp5ailRmZcgbvGn7ECmYWqE+sfHQPfev1Rz
         RL9QyrkTmRSkQvWaaOP+la++QVDpB41jeQXKqESeqRn4qrh6g+53tXFRmavOUqr3z4u9
         MyoA==
X-Received: by 10.182.28.68 with SMTP id z4mr10530743obg.36.1366667857632;
        Mon, 22 Apr 2013 14:57:37 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id do4sm20868017oeb.0.2013.04.22.14.57.30
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 22 Apr 2013 14:57:36 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.790.g4588561
In-Reply-To: <1366667724-567-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222100>

It's simpler, and we don't need to depend on certain Mercurial versions.

Also, now we don't update the URL if 'file://' is not present.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index dcf6c98..b6589a3 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -22,6 +22,7 @@ import shutil
 import subprocess
 import urllib
 import atexit
+import urlparse
 
 #
 # If you want to switch to hg-git compatibility mode:
@@ -793,11 +794,11 @@ def do_export(parser):
     print
 
 def fix_path(alias, repo, orig_url):
-    repo_url = util.url(repo.url())
-    url = util.url(orig_url)
-    if str(url) == str(repo_url):
+    url = urlparse.urlparse(orig_url, 'file')
+    if url.scheme != 'file' or os.path.isabs(url.path):
         return
-    cmd = ['git', 'config', 'remote.%s.url' % alias, "hg::%s" % repo_url]
+    abs_url = urlparse.urljoin("%s/" % os.getcwd(), orig_url)
+    cmd = ['git', 'config', 'remote.%s.url' % alias, "hg::%s" % abs_url]
     subprocess.call(cmd)
 
 def main(args):
-- 
1.8.2.1.790.g4588561
