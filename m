From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [REPLACEMENT PATCH] bundle create: keep symbolic refs' names instead
 of resolving them
Date: Thu, 22 Nov 2007 12:24:59 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711221224230.27959@racer.site>
References: <8aa486160711210654p357ccd87i4809e0cda9471303@mail.gmail.com> 
 <Pine.LNX.4.64.0711211554370.27959@racer.site>
 <8aa486160711210815g5a1973c2see28a6263fc56030@mail.gmail.com>
 <Pine.LNX.4.64.0711211652470.27959@racer.site>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811741-16122431-1195734299=:27959"
Cc: Git Mailing List <git@vger.kernel.org>
To: Santi B?jar <sbejar@gmail.com>, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Nov 22 13:26:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvB7d-0003Bq-Fk
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 13:25:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751907AbXKVMZH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2007 07:25:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751905AbXKVMZH
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 07:25:07 -0500
Received: from mail.gmx.net ([213.165.64.20]:41468 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751365AbXKVMZF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2007 07:25:05 -0500
Received: (qmail invoked by alias); 22 Nov 2007 12:25:02 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp008) with SMTP; 22 Nov 2007 13:25:02 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/HJGNXFf7HPCCaYDRgKFzbbQM+ZtitQcmVYL9cPE
	ue8Pr8qLtKtR2h
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0711211652470.27959@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65816>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811741-16122431-1195734299=:27959
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT


When creating a bundle, symbolic refs used to be resolved to the
non-symbolic refs they point to before being written to the list
of contained refs.  I.e. "git bundle create a1.bundle HEAD master"
would show something like

388afe7881b33102fada216dd07806728773c011        refs/heads/master
388afe7881b33102fada216dd07806728773c011        refs/heads/master

instead of

388afe7881b33102fada216dd07806728773c011        HEAD
388afe7881b33102fada216dd07806728773c011        refs/heads/master

Introduce a special handling so that the symbolic refs are listed
with the names passed on the command line.

Noticed by Santi Béjar.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	... and this patch actually does not break the test suite.

 bundle.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/bundle.c b/bundle.c
index e4d60cd..9b9b916 100644
--- a/bundle.c
+++ b/bundle.c
@@ -6,6 +6,7 @@
 #include "revision.h"
 #include "list-objects.h"
 #include "run-command.h"
+#include "refs.h"
 
 static const char bundle_signature[] = "# v2 git bundle\n";
 
@@ -232,11 +233,17 @@ int create_bundle(struct bundle_header *header, const char *path,
 		struct object_array_entry *e = revs.pending.objects + i;
 		unsigned char sha1[20];
 		char *ref;
+		const char *display_ref;
+		int flag;
 
 		if (e->item->flags & UNINTERESTING)
 			continue;
 		if (dwim_ref(e->name, strlen(e->name), sha1, &ref) != 1)
 			continue;
+		if (!resolve_ref(e->name, sha1, 1, &flag))
+			flag = 0;
+		display_ref = (flag & REF_ISSYMREF) ? e->name : ref;
+
 		/*
 		 * Make sure the refs we wrote out is correct; --max-count and
 		 * other limiting options could have prevented all the tips
@@ -287,7 +294,7 @@ int create_bundle(struct bundle_header *header, const char *path,
 		ref_count++;
 		write_or_die(bundle_fd, sha1_to_hex(e->item->sha1), 40);
 		write_or_die(bundle_fd, " ", 1);
-		write_or_die(bundle_fd, ref, strlen(ref));
+		write_or_die(bundle_fd, display_ref, strlen(display_ref));
 		write_or_die(bundle_fd, "\n", 1);
 		free(ref);
 	}
-- 
1.5.3.6.1977.g54d30


---1463811741-16122431-1195734299=:27959--
