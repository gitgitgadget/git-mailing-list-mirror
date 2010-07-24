From: Elijah Newren <newren@gmail.com>
Subject: [PATCH] upload-pack: Remove some unused code
Date: Sat, 24 Jul 2010 14:09:11 -0600
Message-ID: <1280002151-7527-1-git-send-email-newren@gmail.com>
Cc: Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 24 22:07:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ocl0k-0008Vn-JM
	for gcvg-git-2@lo.gmane.org; Sat, 24 Jul 2010 22:07:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755215Ab0GXUHk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jul 2010 16:07:40 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:43795 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753695Ab0GXUHj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jul 2010 16:07:39 -0400
Received: by pzk26 with SMTP id 26so558711pzk.19
        for <git@vger.kernel.org>; Sat, 24 Jul 2010 13:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=KodJiZFKT3oYFWQQiaeZDTdxZiIW6kEW94aMexCSZm4=;
        b=gGjAgewpMuRDXkoVMvI+c02rXD7XRBgZG+nwrxikQMy7un2/Zo5N3UOhysllnM4f+f
         WS7s2Jv+8+dTEgaX2mWg6GJNjZntjRdvzT9KX5qegOk5WWWpUD3YdQvNlarOB2aQWHgy
         MBZg4B5aCr41GL+kUa9x1fshNAXdM6konfzeI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=J6y5GpWOItD6ncjHBsKbRMEOLrTBtvLq1xRu9McL6ZfO06EdwMoH/WBWJkZbPwVL3Q
         LnMrY6ypWVa5mScPWoE60b1efMZ7oTlq9ccZMBt4uhWCjN6EBfc6ZhpuemaQ3Xm1G9lX
         y8akbaLuMD9PuoOCteVi8RBh88xOC9WFJLFd0=
Received: by 10.115.15.18 with SMTP id s18mr7754636wai.5.1280002058851;
        Sat, 24 Jul 2010 13:07:38 -0700 (PDT)
Received: from localhost.localdomain (c-67-169-245-74.hsd1.ut.comcast.net [67.169.245.74])
        by mx.google.com with ESMTPS id s5sm3035078wak.12.2010.07.24.13.07.33
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 24 Jul 2010 13:07:37 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.g83744
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151667>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
I'm not sure if this is too trivial to submit, but I noticed it while
poking around in upload-pack.

Ever since f0cea83f631689331fce73b51f22707e897f7939, the
'create_full_pack' argument has been unused and is always false.  We
can make it clear that this argument is currently unused and remove some
associated code from an 'if' block.

 upload-pack.c |   29 ++++++++++++-----------------
 1 files changed, 12 insertions(+), 17 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index dc464d7..c2e4eae 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -105,7 +105,7 @@ static void show_edge(struct commit *commit)
 	fprintf(pack_pipe, "-%s\n", sha1_to_hex(commit->object.sha1));
 }
 
-static int do_rev_list(int in, int out, void *create_full_pack)
+static int do_rev_list(int in, int out, void *unused)
 {
 	int i;
 	struct rev_info revs;
@@ -118,23 +118,18 @@ static int do_rev_list(int in, int out, void *create_full_pack)
 	if (use_thin_pack)
 		revs.edge_hint = 1;
 
-	if (create_full_pack) {
-		const char *args[] = {"rev-list", "--all", NULL};
-		setup_revisions(2, args, &revs, NULL);
-	} else {
-		for (i = 0; i < want_obj.nr; i++) {
-			struct object *o = want_obj.objects[i].item;
-			/* why??? */
-			o->flags &= ~UNINTERESTING;
-			add_pending_object(&revs, o, NULL);
-		}
-		for (i = 0; i < have_obj.nr; i++) {
-			struct object *o = have_obj.objects[i].item;
-			o->flags |= UNINTERESTING;
-			add_pending_object(&revs, o, NULL);
-		}
-		setup_revisions(0, NULL, &revs, NULL);
+	for (i = 0; i < want_obj.nr; i++) {
+		struct object *o = want_obj.objects[i].item;
+		/* why??? */
+		o->flags &= ~UNINTERESTING;
+		add_pending_object(&revs, o, NULL);
+	}
+	for (i = 0; i < have_obj.nr; i++) {
+		struct object *o = have_obj.objects[i].item;
+		o->flags |= UNINTERESTING;
+		add_pending_object(&revs, o, NULL);
 	}
+	setup_revisions(0, NULL, &revs, NULL);
 	if (prepare_revision_walk(&revs))
 		die("revision walk setup failed");
 	mark_edges_uninteresting(revs.commits, &revs, show_edge);
-- 
1.7.2.1.g83744
