From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 19/47] remote-hg: improve node traversing
Date: Mon, 13 May 2013 23:36:42 -0500
Message-ID: <1368506230-19614-20-git-send-email-felipe.contreras@gmail.com>
References: <1368506230-19614-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 14 06:39:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uc71e-0004Aq-8M
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 06:39:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753565Ab3ENEjn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 00:39:43 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:60099 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752627Ab3ENEjl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 00:39:41 -0400
Received: by mail-oa0-f46.google.com with SMTP id h2so101959oag.19
        for <git@vger.kernel.org>; Mon, 13 May 2013 21:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=jusapONP/4tRfgc5Nat7Gh8kFzwKB4rgn7njdPX6lvk=;
        b=VtQAfYR2HbC0qR2YQ5/0Db/Kdffko4CWkABYTBgkVvEnYjdCnVZUlnaUxo2TZ92dTo
         HH89uq0moZL8F2jDGusboI5TVaqRPh5KME7nr4fQo3oft17JwWTXGiK7/tx17QZddQBf
         +PKouKIznLoCtDp6TbULUAMvuVob2xhKaon2gY/ZpWh7qERzd3W02KyvINA2PNDYNDgp
         oigXbRD70veBp6D8QLFGqiEAdCkAB9Pzo0/MjhzgmtLjEJVYHKHc2Cjqj5CfpOmUBvqS
         mWqHPr9N407IoVQryWtF9wXzZv5zLGWDm0wMcwuFTq8gouQFEFdPikC1fMCiH2BBVP4y
         189Q==
X-Received: by 10.60.83.103 with SMTP id p7mr15253534oey.130.1368506381125;
        Mon, 13 May 2013 21:39:41 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id eq4sm20017361obb.5.2013.05.13.21.39.39
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 13 May 2013 21:39:40 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.579.g184e698
In-Reply-To: <1368506230-19614-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224251>

We won't be able to count the unmarked commits, but we are not going to
be able to do that anyway when we switch to SHA-1 ids.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 8417d1e..a3618de 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -392,12 +392,16 @@ def export_ref(repo, name, kind, head):
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
1.8.3.rc1.579.g184e698
