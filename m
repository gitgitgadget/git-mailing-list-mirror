From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 1/2] remote-hg: ensure shared repo is initialized
Date: Fri,  9 Aug 2013 17:38:03 -0500
Message-ID: <1376087884-32060-2-git-send-email-felipe.contreras@gmail.com>
References: <1376087884-32060-1-git-send-email-felipe.contreras@gmail.com>
Cc: Antoine Pelisse <apelisse@gmail.com>,
	=?UTF-8?q?J=C3=B6rn=20Hees?= <dev@joernhees.de>,
	Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 10 00:42:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7vNo-0001hk-2t
	for gcvg-git-2@plane.gmane.org; Sat, 10 Aug 2013 00:42:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031381Ab3HIWmE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Aug 2013 18:42:04 -0400
Received: from mail-oa0-f45.google.com ([209.85.219.45]:64287 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031355Ab3HIWmD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Aug 2013 18:42:03 -0400
Received: by mail-oa0-f45.google.com with SMTP id m1so7548946oag.18
        for <git@vger.kernel.org>; Fri, 09 Aug 2013 15:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1iVHqEHx+jk/zhjnH45+c306MEmUut8jYLO10yk0j+Y=;
        b=rZg2CycFhPiNz4C0VLd74tLgiQ7vdGuh02b+Qnhxl3j/RYGqEfNOM84gNUR4ZgE+7H
         50uYzkqEbCZ1MdLfHQx2DSI6svDQM3DEWAIlTb7VaSMD3QoeitoIyZY/8GUlumOWniSj
         SQRjsTY5IqqWeUV4mwiAtTwCh8VhnzxLqMZuv6rvzUA2Sp8NJH9ztVS0cSrAlfRP0s1c
         p0PctcLceBb3WqLI0Au3kkLx1c1DR8BbEv07x8JPW15dxNspEv/ALSJlYIXOa9vBrOD8
         dkmJTjYVOOu7yqUYk7KQjA37qy/AWMsRbteUDWSrOTVmuS+D18y7yrzweti8mloKeas2
         8kKA==
X-Received: by 10.182.56.197 with SMTP id c5mr2242396obq.51.1376088122982;
        Fri, 09 Aug 2013 15:42:02 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id pt4sm21194871obb.14.2013.08.09.15.42.00
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 09 Aug 2013 15:42:02 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.267.gbb4989f
In-Reply-To: <1376087884-32060-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232049>

6796d49 (remote-hg: use a shared repository store) introduced a bug by
making the shared repository '.git/hg', which is already used before
that patch, so clones that happened before that patch, fail after that
patch, because there's no shared Mercurial repo.

So, instead of simply checking if the directory exists, let's always try
to create an empty shared repository to ensure it's there. This works
because we don't need the initial clone, if the repository is shared,
pulling from the child updates the parent's storage; it's exactly the
same as cloning, so we can simplify the shared repo setup this way while
at the same time fixing the problem.

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
