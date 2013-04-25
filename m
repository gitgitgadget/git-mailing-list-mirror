From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] remote-bzr: use proper push method
Date: Thu, 25 Apr 2013 06:25:37 -0500
Message-ID: <1366889137-19700-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 25 13:27:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVKKK-0002g3-8b
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 13:27:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756198Ab3DYL0z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 07:26:55 -0400
Received: from mail-oa0-f54.google.com ([209.85.219.54]:43782 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756264Ab3DYL0y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 07:26:54 -0400
Received: by mail-oa0-f54.google.com with SMTP id l20so2700620oag.13
        for <git@vger.kernel.org>; Thu, 25 Apr 2013 04:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=ZBdaRY+5ffhzWQSSYeBlIVx4U89a85dHukAG7ksEP38=;
        b=WWQlTpdbfVpjuu+j2669X7zIw4ayzarn7cSKANJS7vMCEgSD3v7eUsYaC6aGjXjdxU
         VTGYSF1ZVyzM1wCJmFRZI8i5HGrRD8x/f7qGrlBQIjFrvbHPugHh/3qoWRPYb7nRAsQI
         288qHWqMn7gRHpRUD1kKJWk1PlwcclfsezPvAj8s2RooqnHnlI6zkTsU3fJAtzSQPRok
         6i03ZhMQgQzXWMDvUPVuc9p4rpfv7QoEvMJtAYGh0EuVXSiZ05tj03jLYkehCnY7PFMv
         mpxGVLE0Otgie+ErTtFN0vEkvMje9TyWfJNjzDrTy0H2mkZ+eDK4DzKculyjT1rIG3yZ
         EP+w==
X-Received: by 10.182.106.129 with SMTP id gu1mr14535207obb.34.1366889214024;
        Thu, 25 Apr 2013 04:26:54 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id n1sm3018572obc.10.2013.04.25.04.26.51
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 25 Apr 2013 04:26:53 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222379>

Not just randomly synchronize the revisions with no checks at all. This
is the way bazaar's UI does it.

Also, add a non-ff check.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---

This patch should probably go to maint, as the results of pushing the way we
currently push are not really understood. Perhaps it's similar to a 'git push
 --force', or perhaps it can potentially screw the repository.

It's better to be safe and just do what bazaar does.

 contrib/remote-helpers/git-remote-bzr | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
index 8c316fe..cb8d081 100755
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
1.8.2.1
