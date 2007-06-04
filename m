From: Johan Herland <johan@herland.net>
Subject: [PATCH 6/6] Add fsck_verify_ref_to_tag_object() to verify that refname
 matches name stored in tag object
Date: Mon, 04 Jun 2007 02:54:56 +0200
Message-ID: <200706040254.56482.johan@herland.net>
References: <200706040251.05286.johan@herland.net>
 <200706040251.52613.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 04 02:55:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hv0qo-0002Bp-Uj
	for gcvg-git@gmane.org; Mon, 04 Jun 2007 02:55:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751349AbXFDAzI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Jun 2007 20:55:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751388AbXFDAzI
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jun 2007 20:55:08 -0400
Received: from smtp.getmail.no ([84.208.20.33]:34199 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751349AbXFDAzG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jun 2007 20:55:06 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JJ300J0D6JS6900@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 04 Jun 2007 02:55:04 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJ300EDZ6JKJV20@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 04 Jun 2007 02:54:56 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJ300J1U6JKQ220@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Mon, 04 Jun 2007 02:54:56 +0200 (CEST)
In-reply-to: <200706040251.52613.johan@herland.net>
Content-disposition: inline
User-Agent: KMail/1.9.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49059>

On Monday 28 May 2007, Junio C Hamano wrote:
> However it would be a good
> idea to add logic to fsck to warn upon inconsistencis (perhaps
> by mistake) between refname and tag's true name.
>
> The check would say something like:
>
>   If an annotated (signed or unsigned) tag has a "tag"
>   line to give it the official $name, and if it is pointed
>   at by a ref, the refname must end with "/$name".
>   Otherwise we warn.
>
> Trivially, the above rule says that having v2.6.22 tag under
> refs/tags/v2.6.20 is a mistake we would want to be warned upon.

This patch adds the check described by Junio.

Signed-off-by: Johan Herland <johan@herland.net>
---
 builtin-fsck.c |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/builtin-fsck.c b/builtin-fsck.c
index a8914ae..379317e 100644
--- a/builtin-fsck.c
+++ b/builtin-fsck.c
@@ -515,6 +515,25 @@ static int fsck_handle_reflog(const char *logname, const unsigned char *sha1, in
 	return 0;
 }
 
+static void fsck_verify_ref_to_tag_object(const char *refname, struct object *obj)
+{
+	/* Verify that refname matches the name stored in obj's "tag" header */
+	struct tag *tagobj = (struct tag *) parse_object(obj->sha1);
+	size_t tagname_len = strlen(tagobj->tag);
+	size_t refname_len = strlen(refname);
+
+	if (!tagname_len) return; /* No tag name stored in tagobj. Nothing to do. */
+
+	if (tagname_len < refname_len &&
+	    !memcmp(tagobj->tag, refname + (refname_len - tagname_len), tagname_len) &&
+	    refname[(refname_len - tagname_len) - 1] == '/') {
+		/* OK: tag name is "$name", and refname ends with "/$name" */
+		return;
+	}
+	else
+		error("%s: Mismatch between tag ref and tag object's name %s", refname, tagobj->tag);
+}
+
 static int fsck_handle_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
 {
 	struct object *obj;
@@ -529,6 +548,8 @@ static int fsck_handle_ref(const char *refname, const unsigned char *sha1, int f
 		/* We'll continue with the rest despite the error.. */
 		return 0;
 	}
+	if (obj->type == OBJ_TAG) /* ref to tag object */
+		fsck_verify_ref_to_tag_object(refname, obj);
 	default_refs++;
 	obj->used = 1;
 	mark_reachable(obj, REACHABLE);
-- 
1.5.2
