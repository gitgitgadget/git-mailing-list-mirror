From: mkoegler@auto.tuwien.ac.at (Martin Koegler)
Subject: Re: git fsck segmentation fault
Date: Wed, 10 Dec 2008 08:53:38 +0100
Message-ID: <20081210075338.GA7776@auto.tuwien.ac.at>
References: <200811271814.06941.simon@lst.de> <200811272021.56108.simon@lst.de> <alpine.LFD.2.00.0811271449500.14328@xanadu.home> <200811280919.10685.simon@lst.de> <alpine.LFD.2.00.0812091408560.14328@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Simon Hausmann <simon@lst.de>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Dec 10 08:54:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAJuM-0000wL-KK
	for gcvg-git-2@gmane.org; Wed, 10 Dec 2008 08:54:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754761AbYLJHxl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2008 02:53:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754421AbYLJHxk
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Dec 2008 02:53:40 -0500
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:48132 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754565AbYLJHxk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2008 02:53:40 -0500
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id F10C9680507D;
	Wed, 10 Dec 2008 08:53:38 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id d+tNpKw3RyNj; Wed, 10 Dec 2008 08:53:38 +0100 (CET)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id CD6836804342; Wed, 10 Dec 2008 08:53:38 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0812091408560.14328@xanadu.home>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102670>

Maybe something like this could help:

>From 32be177cbb0825fc019200b172f3d79117b28140 Mon Sep 17 00:00:00 2001
From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Date: Wed, 10 Dec 2008 08:42:08 +0100
Subject: [PATCH] fsck: use fewer stack

This patch moves the state while traversing the tree
from the stack to the heap.

Not-really-tested-by: Martin Koegler
Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
---
 builtin-fsck.c |   19 +++++++++++++++++--
 1 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/builtin-fsck.c b/builtin-fsck.c
index afded5e..8184699 100644
--- a/builtin-fsck.c
+++ b/builtin-fsck.c
@@ -36,6 +36,9 @@ static int verbose;
 #define DIRENT_SORT_HINT(de) ((de)->d_ino)
 #endif
 
+static int objectstack_nr, objectstack_alloc;
+struct object **objectstack;
+
 static void objreport(struct object *obj, const char *severity,
                       const char *err, va_list params)
 {
@@ -66,9 +69,7 @@ static int fsck_error_func(struct object *obj, int type, const char *err, ...)
 
 static int mark_object(struct object *obj, int type, void *data)
 {
-	struct tree *tree = NULL;
 	struct object *parent = data;
-	int result;
 
 	if (!obj) {
 		printf("broken link from %7s %s\n",
@@ -95,6 +96,15 @@ static int mark_object(struct object *obj, int type, void *data)
 		}
 		return 1;
 	}
+	ALLOC_GROW(objectstack, objectstack_nr + 1, objectstack_alloc);
+	objectstack[objectstack_nr++] = obj;
+	return 0;
+}
+
+static int mark_child_object(struct object *obj)
+{
+	struct tree *tree = NULL;
+	int result;
 
 	if (obj->type == OBJ_TREE) {
 		obj->parsed = 0;
@@ -116,6 +126,11 @@ static int mark_object(struct object *obj, int type, void *data)
 static void mark_object_reachable(struct object *obj)
 {
 	mark_object(obj, OBJ_ANY, 0);
+	while (objectstack_nr > 0) {
+		struct object *obj = objectstack[--objectstack_nr];
+		if (mark_child_object(obj) < 0)
+			break;
+	}
 }
 
 static int mark_used(struct object *obj, int type, void *data)
-- 
1.6.1.rc2.283.g32be1
