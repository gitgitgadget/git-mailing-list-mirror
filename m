From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] bundle create: keep symbolic refs' names instead of resolving
 them
Date: Wed, 21 Nov 2007 16:53:12 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711211652470.27959@racer.site>
References: <8aa486160711210654p357ccd87i4809e0cda9471303@mail.gmail.com> 
 <Pine.LNX.4.64.0711211554370.27959@racer.site>
 <8aa486160711210815g5a1973c2see28a6263fc56030@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811741-909703578-1195663992=:27959"
Cc: Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-1?Q?Santi_B=E9jar?= <sbejar@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 21 17:54:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuspT-0001w1-Jt
	for gcvg-git-2@gmane.org; Wed, 21 Nov 2007 17:53:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752092AbXKUQxQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2007 11:53:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751821AbXKUQxQ
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 11:53:16 -0500
Received: from mail.gmx.net ([213.165.64.20]:50675 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751583AbXKUQxP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 11:53:15 -0500
Received: (qmail invoked by alias); 21 Nov 2007 16:53:13 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp043) with SMTP; 21 Nov 2007 17:53:13 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/D30ILbKPD1wYTmP3qMqlS8gHUnGpGlPnL42eLGZ
	1F0WFEfbJ9D+cW
X-X-Sender: gene099@racer.site
In-Reply-To: <8aa486160711210815g5a1973c2see28a6263fc56030@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65679>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811741-909703578-1195663992=:27959
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT


When creating a bundle, symbolic refs used to be resolved to the
non-symbolic refs they point to before being written to the list
of contained refs.  I.e. "git bundle create a1.bundle HEAD master"
would show something like

388afe7881b33102fada216dd07806728773c011        refs/heads/master
388afe7881b33102fada216dd07806728773c011        refs/heads/master

Introduce a special handling so that the symbolic refs are listed
with the names passed on the command line.

Noticed by Santi Béjar.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 bundle.c |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/bundle.c b/bundle.c
index e4d60cd..5e8242f 100644
--- a/bundle.c
+++ b/bundle.c
@@ -6,6 +6,7 @@
 #include "revision.h"
 #include "list-objects.h"
 #include "run-command.h"
+#include "refs.h"
 
 static const char bundle_signature[] = "# v2 git bundle\n";
 
@@ -231,12 +232,17 @@ int create_bundle(struct bundle_header *header, const char *path,
 	for (i = 0; i < revs.pending.nr; i++) {
 		struct object_array_entry *e = revs.pending.objects + i;
 		unsigned char sha1[20];
-		char *ref;
+		const char *ref;
+		int flag;
 
 		if (e->item->flags & UNINTERESTING)
 			continue;
-		if (dwim_ref(e->name, strlen(e->name), sha1, &ref) != 1)
+		ref = resolve_ref(e->name, sha1, 1, &flag);
+		if (!ref)
 			continue;
+		if (flag & REF_ISSYMREF)
+			ref = e->name;
+
 		/*
 		 * Make sure the refs we wrote out is correct; --max-count and
 		 * other limiting options could have prevented all the tips
@@ -249,7 +255,6 @@ int create_bundle(struct bundle_header *header, const char *path,
 		if (!(e->item->flags & SHOWN) && e->item->type == OBJ_COMMIT) {
 			warning("ref '%s' is excluded by the rev-list options",
 				e->name);
-			free(ref);
 			continue;
 		}
 		/*
@@ -280,7 +285,6 @@ int create_bundle(struct bundle_header *header, const char *path,
 				obj->flags |= SHOWN;
 				add_pending_object(&revs, obj, e->name);
 			}
-			free(ref);
 			continue;
 		}
 
@@ -289,7 +293,6 @@ int create_bundle(struct bundle_header *header, const char *path,
 		write_or_die(bundle_fd, " ", 1);
 		write_or_die(bundle_fd, ref, strlen(ref));
 		write_or_die(bundle_fd, "\n", 1);
-		free(ref);
 	}
 	if (!ref_count)
 		die ("Refusing to create empty bundle.");
-- 
1.5.3.6.1977.g54d30

---1463811741-909703578-1195663992=:27959--
