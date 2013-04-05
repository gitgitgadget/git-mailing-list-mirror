From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC/PATH 2/4] remote-hg: improve node traversing
Date: Fri,  5 Apr 2013 05:36:17 -0600
Message-ID: <1365161779-32170-3-git-send-email-felipe.contreras@gmail.com>
References: <1365161779-32170-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Max Horn <max@quendi.de>,
	Antoine Pelisse <apelisse@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 06 18:55:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOWFY-0002u6-QR
	for gcvg-git-2@plane.gmane.org; Sat, 06 Apr 2013 18:45:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753774Ab3DELhY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Apr 2013 07:37:24 -0400
Received: from mail-ob0-f170.google.com ([209.85.214.170]:60366 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752332Ab3DELhX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Apr 2013 07:37:23 -0400
Received: by mail-ob0-f170.google.com with SMTP id uy19so1409198obc.1
        for <git@vger.kernel.org>; Fri, 05 Apr 2013 04:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=cU92aHW1Np3vCMQWh4WADA/5xWToAuYcfsJ3QhDaH5Y=;
        b=advZmH9PZroBv+K/iL+husyB6Gpg5XcfeAb6iR8HTvmu372aNx19IApbTfSttVZXOg
         EO6clCOJWnz3bytn2VsIxguCqOebz3zJ6xtixATp1kJIjYoxl/DJaV8D+h23ggQmnBF0
         GZbAyHMSLhe0/TnzuzMBIktbtejkLckPSaoRvnrWyT++gLUBQCsrUqJzZs+GKHCsBYDK
         2amvycp9vhRo3PpvwRQZEKGvRzpHLGkPhsCoZzulFpP01RgIrrP6pcfu1QZAjkMpMKn6
         SPxdS3ds/PtREF08vixi0zPjWAKQcYdvKecfZKwCaxRv0L4A+8Br9QPbXE9rMrjA+kzo
         s56Q==
X-Received: by 10.182.43.103 with SMTP id v7mr7651106obl.17.1365161841763;
        Fri, 05 Apr 2013 04:37:21 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id l4sm11895407oek.3.2013.04.05.04.37.20
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 05 Apr 2013 04:37:20 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <1365161779-32170-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220169>

We won't be able to count the unmarked commits, but we are not going to
be able to do that anyway when we switch to SHA-1 ids.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index a8591a2..02fda2d 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -314,12 +314,16 @@ def export_ref(repo, name, kind, head):
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
1.8.2
