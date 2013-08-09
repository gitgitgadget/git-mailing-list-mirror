From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/2] remote-hg: simplify shared repo setup
Date: Fri,  9 Aug 2013 15:03:00 -0500
Message-ID: <1376078581-24766-2-git-send-email-felipe.contreras@gmail.com>
References: <1376078581-24766-1-git-send-email-felipe.contreras@gmail.com>
Cc: Antoine Pelisse <apelisse@gmail.com>,
	=?UTF-8?q?J=C3=B6rn=20Hees?= <dev@joernhees.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 09 22:07:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7sxv-0001Ik-FI
	for gcvg-git-2@plane.gmane.org; Fri, 09 Aug 2013 22:07:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030976Ab3HIUHB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Aug 2013 16:07:01 -0400
Received: from mail-ob0-f177.google.com ([209.85.214.177]:43525 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030920Ab3HIUG5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Aug 2013 16:06:57 -0400
Received: by mail-ob0-f177.google.com with SMTP id f8so2673317obp.36
        for <git@vger.kernel.org>; Fri, 09 Aug 2013 13:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gFMcTZn5X+19hAUQG2pmx/nLDwxBSgvVOX2dseF3sQI=;
        b=Q5zXAFIPcmbKPH9hsWQfasJwfCHDdXVIFqVs5wjC+QLjtwRvlSqAx1BluCVZFWZIPF
         6KEaJoYnSKihbwDwwCropdSYigZirXCFqmyWeaSy4gLD7xHfr3pg48D+7KmqQ/VUWXch
         O3DNOkkwoHgnXqN6rEESmX2IQSGfEjSg10Hji4VxYSvLLHTNQ2QzNNrjWU5o4+VnsKXY
         i7UlNVGooMTXHopaQsaUPQhYefMw+4n8VevKAxZJGhnLPAkJfgfqggywu3X0Hg0PGaRl
         ptd+YW00UWTkGzLKCKuEHMsX4pTvytFePsjv8KEaj2VV/Bnbk/gfLrFu+bZZWGKsyEyY
         mBYg==
X-Received: by 10.182.215.133 with SMTP id oi5mr14978obc.83.1376078816738;
        Fri, 09 Aug 2013 13:06:56 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id ps5sm20818807oeb.8.2013.08.09.13.06.54
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 09 Aug 2013 13:06:55 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.267.gbb4989f
In-Reply-To: <1376078581-24766-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232020>

We don't need the initial clone, if the repository is shared, pulling
from the child updates the parent's storage; it's exactly the same as
cloning.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 0194c67..cfd4f53 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -391,11 +391,12 @@ def get_repo(url, alias):
             os.makedirs(dirname)
     else:
         shared_path = os.path.join(gitdir, 'hg')
-        if not os.path.exists(shared_path):
-            try:
-                hg.clone(myui, {}, url, shared_path, update=False, pull=True)
-            except:
-                die('Repository error')
+
+        # setup shared repo (if not there)
+        try:
+            hg.peer(myui, {}, shared_path, create=True)
+        except error.RepoError:
+            pass
 
         if not os.path.exists(dirname):
             os.makedirs(dirname)
-- 
1.8.3.267.gbb4989f
