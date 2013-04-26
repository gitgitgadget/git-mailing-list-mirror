From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 9/9] remote-bzr: use proper push method
Date: Fri, 26 Apr 2013 16:12:39 -0500
Message-ID: <1367010759-17928-10-git-send-email-felipe.contreras@gmail.com>
References: <1367010759-17928-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 26 23:14:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVpyS-0007W3-Dv
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 23:14:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757530Ab3DZVOY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Apr 2013 17:14:24 -0400
Received: from mail-ob0-f171.google.com ([209.85.214.171]:40527 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754987Ab3DZVOW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Apr 2013 17:14:22 -0400
Received: by mail-ob0-f171.google.com with SMTP id er7so3930751obc.2
        for <git@vger.kernel.org>; Fri, 26 Apr 2013 14:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=7tmoHKit1Q4ZYk+HFNdoaxdXRozLq3cGgq5GQSWbZyY=;
        b=tUucihb5W+0E258O6da4rHW+r0SGyAZmISDhDyA8QZ1jzeaHyEHORjAqJTfjmeUyuk
         FyGH+scTo98w9wjfJsvz3U1EcJ2lbzAhPbrVKmxGtoYbtTbYDA34bDdB9UCK38A4kop5
         phtMcg8P3O4d5/aAs+87KytgBRtBZFmTpZZAuUZOkzlC0ZnCO/WYiPf4N9HwZ04vaeo6
         aoP4/sj3dOFp0U8YpsuGbqwYf7z7c01RC1mF6vmAJQazWuML31wTnS9a4bdcpxWuOS5v
         mlz8BVBm3w3xShEwPSjnOljbkWRIiIKrL31j/vJ4WJAQvuKQ9jAUIbJYS9PHUk7KWyey
         wEmg==
X-Received: by 10.60.33.105 with SMTP id q9mr22350092oei.54.1367010862062;
        Fri, 26 Apr 2013 14:14:22 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id t9sm9383095obk.13.2013.04.26.14.14.20
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 26 Apr 2013 14:14:21 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.1031.g2ee5873
In-Reply-To: <1367010759-17928-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222590>

Not just randomly synchronize the revisions with no checks at all. This
is the way bazaar's UI does it.

Also, add a non-ff check.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-bzr | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
index 9f56297..c19ed0e 100755
--- a/contrib/remote-helpers/git-remote-bzr
+++ b/contrib/remote-helpers/git-remote-bzr
@@ -639,12 +639,12 @@ def do_export(parser):
     for ref, revid in parsed_refs.iteritems():
         if ref == 'refs/heads/master':
             repo.generate_revision_history(revid, marks.get_tip('master'))
-            revno, revid = repo.last_revision_info()
             if peer:
-                if hasattr(peer, "import_last_revision_info_and_tags"):
-                    peer.import_last_revision_info_and_tags(repo, revno, revid)
-                else:
-                    peer.import_last_revision_info(repo.repository, revno, revid)
+                try:
+                    repo.push(peer, stop_revision=revid)
+                except bzrlib.errors.DivergedBranches:
+                    print "error %s non-fast forward" % ref
+                    continue
             else:
                 wt = repo.bzrdir.open_workingtree()
                 wt.update()
-- 
1.8.2.1.1031.g2ee5873
