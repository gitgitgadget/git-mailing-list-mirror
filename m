From: Sergey Vlasov <vsu@altlinux.ru>
Subject: [PATCH 1/4] Do not try to process objects more than once during fetch
Date: Wed, 14 Sep 2005 16:42:55 +0400
Message-ID: <20050914124255.GD24405@master.mivlgu.local>
References: <20050914124206.GC24405@master.mivlgu.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Sep 14 14:44:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFWbg-0001bN-M9
	for gcvg-git@gmane.org; Wed, 14 Sep 2005 14:43:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965146AbVINMm6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Sep 2005 08:42:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965147AbVINMm5
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Sep 2005 08:42:57 -0400
Received: from mivlgu.ru ([81.18.140.87]:64704 "EHLO master.mivlgu.local")
	by vger.kernel.org with ESMTP id S965146AbVINMm5 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Sep 2005 08:42:57 -0400
Received: by master.mivlgu.local (Postfix, from userid 1000)
	id D1E2A180119; Wed, 14 Sep 2005 16:42:55 +0400 (MSD)
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20050914124206.GC24405@master.mivlgu.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8518>

fetch.c:process() is often called more than once for the same object;
e.g., for unpacked git repository with 7313 objects there are 320997
calls to process() for objects which were already seen (and 7528 of
those calls are for tree objects, which is a real problem because of
recursive processing).

---

 fetch.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

f8285569e916a21c28379b55415165a89794272a
diff --git a/fetch.c b/fetch.c
--- a/fetch.c
+++ b/fetch.c
@@ -7,6 +7,8 @@
 #include "blob.h"
 #include "refs.h"
 
+#define SEEN		(1u << 0)
+
 const char *write_ref = NULL;
 
 const unsigned char *current_ref = NULL;
@@ -126,6 +128,12 @@ static int process_object(struct object 
 static int process(unsigned char *sha1, const char *type)
 {
 	struct object *obj = lookup_object_type(sha1, type);
+
+	/* Do not try to process objects more than once */
+	if (obj->flags & SEEN)
+		return 0;
+	obj->flags |= SEEN;
+
 	if (has_sha1_file(sha1)) {
 		parse_object(sha1);
 		/* We already have it, so we should scan it now. */
