From: Sergey Vlasov <vsu@altlinux.ru>
Subject: [PATCH 2/8] fetch.c: Make process() look at each object only once
Date: Wed, 21 Sep 2005 20:18:57 +0400 (MSD)
Message-ID: <20050921161857.96621E01C96@center4.mivlgu.local>
References: <20050921161829.GA20944@master.mivlgu.local>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 21 18:23:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EI7JM-0006Bd-6f
	for gcvg-git@gmane.org; Wed, 21 Sep 2005 18:19:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751120AbVIUQTA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Sep 2005 12:19:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751126AbVIUQTA
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Sep 2005 12:19:00 -0400
Received: from mivlgu.ru ([81.18.140.87]:1158 "EHLO center4.mivlgu.local")
	by vger.kernel.org with ESMTP id S1751120AbVIUQS6 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Sep 2005 12:18:58 -0400
Received: by center4.mivlgu.local (Postfix, from userid 500)
	id 96621E01C96; Wed, 21 Sep 2005 20:18:57 +0400 (MSD)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <20050921161829.GA20944@master.mivlgu.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9059>

The process() function is very often called multiple times for the
same object (because lots of trees refer to the same blobs), but did
not have a fast check for this, therefore a lot of useless calls to
has_sha1_file() and parse_object() were made before discovering that
nothing needs to be done.

This patch adds the SEEN flag which is used in process() to make it
look at each object only once.  When testing git-local-fetch on the
repository of GIT, this gives a 14x improvement in CPU usage (mainly
because the redundant calls to parse_object() are now avoided -
parse_object() always unpacks and parses the object data, even if it
was already parsed before).

---

 fetch.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

03abc6806a4433807bc21cf3f1aac2528c655c8f
diff --git a/fetch.c b/fetch.c
--- a/fetch.c
+++ b/fetch.c
@@ -58,6 +58,7 @@ static int process_tree(struct tree *tre
 #define TO_FETCH	2U
 #define TO_SCAN		4U
 #define SCANNED		8U
+#define SEEN		16U
 
 static struct commit_list *complete = NULL;
 
@@ -134,6 +135,10 @@ static int process_object(struct object 
 
 static int process(struct object *obj)
 {
+	if (obj->flags & SEEN)
+		return 0;
+	obj->flags |= SEEN;
+
 	if (has_sha1_file(obj->sha1)) {
 		parse_object(obj->sha1);
 		/* We already have it, so we should scan it now. */
