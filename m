From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 11/48] remote-hg: improve node traversing
Date: Fri, 24 May 2013 21:29:27 -0500
Message-ID: <1369449004-17981-12-git-send-email-felipe.contreras@gmail.com>
References: <1369449004-17981-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 25 04:32:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ug4HS-0001j5-Vj
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 04:32:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754853Ab3EYCcT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 22:32:19 -0400
Received: from mail-oa0-f44.google.com ([209.85.219.44]:36988 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754551Ab3EYCcQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 22:32:16 -0400
Received: by mail-oa0-f44.google.com with SMTP id n12so7046512oag.31
        for <git@vger.kernel.org>; Fri, 24 May 2013 19:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=cb7+X8AFmXOhg+vN+HGtc1dujI+8z/oRefS2WS/+LYM=;
        b=ZJGQWn4S49L19st393s7V/cSVPvzMwY/Kk8FNCad+2JNQNZ/+BB0hdfB5uyna3iBfQ
         y17MhDjuhOmxCspCPnDlilt3ApmvT6+82Sc2ItmQwIQKWXHXbDvistMv+wnjoeMrrPxE
         7CFNrY+h+RePeDJjHqxdOQxDax/CZ1ZDfk9IvM5xMf7LgSy49Cw9ozZHCEiKhHeQtaWY
         2K4cpy/d0qTKb91vfHA8A+O3Gc0lwk5Tu4UOiXNrH8K/eJX02vaHBWoC41YcAcyd1VZf
         hxMDZS3PitWV8AiByrdCTCgFi/K89jYGAjDtptnWcq4UbNt+B4aGd/LodqKyq3ZUmzzc
         danw==
X-Received: by 10.60.59.163 with SMTP id a3mr13778553oer.45.1369449135882;
        Fri, 24 May 2013 19:32:15 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id pm16sm20575755oeb.3.2013.05.24.19.32.14
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 24 May 2013 19:32:15 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
In-Reply-To: <1369449004-17981-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225425>

We won't be able to count the unmarked commits, but we are not going to
be able to do that anyway when we switch to SHA-1 ids.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 62520ee..07ea104 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -389,12 +389,16 @@ def export_ref(repo, name, kind, head):
     revs = xrange(tip, head.rev() + 1)
     count = 0
 
-    revs = [rev for rev in revs if not marks.is_marked(rev)]
-
     for rev in revs:
 
         c = repo[rev]
-        (manifest, user, (time, tz), files, desc, extra) = repo.changelog.read(c.node())
+        node = c.node()
+
+        if marks.is_marked(c.hex()):
+            count += 1
+            continue
+
+        (manifest, user, (time, tz), files, desc, extra) = repo.changelog.read(node)
         rev_branch = extra['branch']
 
         author = "%s %d %s" % (fixup_user(user), time, gittz(tz))
-- 
1.8.3.rc3.312.g47657de
