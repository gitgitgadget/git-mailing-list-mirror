From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 9/9] remote-bzr: use proper push method
Date: Thu, 25 Apr 2013 19:08:22 -0500
Message-ID: <1366934902-18704-10-git-send-email-felipe.contreras@gmail.com>
References: <1366934902-18704-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Christophe Simonis <christophe@kn.gl>,
	Simon Ruderich <simon@ruderich.org>, Max Horn <max@quendi.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 26 02:10:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVWEx-0003zV-1E
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 02:10:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933017Ab3DZAKK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 20:10:10 -0400
Received: from mail-ob0-f169.google.com ([209.85.214.169]:48410 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932477Ab3DZAKE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 20:10:04 -0400
Received: by mail-ob0-f169.google.com with SMTP id tb18so3092075obb.0
        for <git@vger.kernel.org>; Thu, 25 Apr 2013 17:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=1FGn8JuT9988fFd+1DB3buDEZr03dju5oauJcbkzEeo=;
        b=S8v8SFP22/DTIYeOplgCYikP+tH2wTZE8OzHQOhqwBNHU+rMXCwPN7bGqed8LzbEKX
         vLKPgv5m9UDqN1hAyt6qRntjStE3v6E34ha513M5h3FNlac4xys35OGVT8OLM35x0IHZ
         +rAJqKQWdgOUihwKttOzNwPTKubp31OCMwaTlLNtL9zQuRws1uwuTUcAxXDBuKshqFCJ
         F+iGvDMMgQNeB9Do500/UCakHesae0t6Ho5F0KoYki037qVum3gTVkBaMCH6Z7hRE6TO
         XaI/hmKaeBTmHa4c16IdIhWuagZ5JF7yP6/Jo7I3SAAr0BzwA58w1Jqxp5IjXM6K4SWe
         HkRw==
X-Received: by 10.60.101.137 with SMTP id fg9mr17565094oeb.60.1366935004383;
        Thu, 25 Apr 2013 17:10:04 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id qt5sm5888541oeb.4.2013.04.25.17.10.02
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 25 Apr 2013 17:10:03 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.884.g3532a8d
In-Reply-To: <1366934902-18704-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222478>

Do not just randomly synchronize the revisions with no checks at all.

I don't have any evidence that there's anything wrong with the current code,
which Bazaar seems to use, but for different purposes. Let's use the logic
Bazaar UI uses to avoid surprises.

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
1.8.2.1.884.g3532a8d
