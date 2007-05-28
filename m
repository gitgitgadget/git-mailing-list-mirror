From: Johan Herland <johan@herland.net>
Subject: [PATCH] Add fsck_verify_ref_to_tag_object() to verify that refname
 matches name stored in tag object
Date: Tue, 29 May 2007 01:46:44 +0200
Message-ID: <200705290146.44914.johan@herland.net>
References: <Pine.LNX.4.64.0705091406350.18541@iabervon.org>
 <200705281254.23297.johan@herland.net>
 <7vps4kbrtb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 29 01:47:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HsovT-0003CF-3m
	for gcvg-git@gmane.org; Tue, 29 May 2007 01:46:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753057AbXE1Xqx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 May 2007 19:46:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757164AbXE1Xqx
	(ORCPT <rfc822;git-outgoing>); Mon, 28 May 2007 19:46:53 -0400
Received: from smtp.getmail.no ([84.208.20.33]:33060 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753057AbXE1Xqw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2007 19:46:52 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JIR00I07ZE37Y00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Tue, 29 May 2007 01:46:51 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JIR00H4RZDXO700@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Tue, 29 May 2007 01:46:45 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JIR009QXZDX83E0@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Tue, 29 May 2007 01:46:45 +0200 (CEST)
In-reply-to: <7vps4kbrtb.fsf@assigned-by-dhcp.cox.net>
Content-disposition: inline
User-Agent: KMail/1.9.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48655>

On Monday 28 May 2007, Junio C Hamano wrote:
> However it would be a good
> idea to add logic to fsck to warn upon inconsistencis (perhaps
> by mistake) between refname and tag's true name.
>
> The check would say something like:
>
> 	If an annotated (signed or unsigned) tag has a "tag"
> 	line to give it the official $name, and if it is pointed
> 	at by a ref, the refname must end with "/$name".
> 	Otherwise we warn.
>
> Trivially, the above rule says that having v2.6.22 tag under
> refs/tags/v2.6.20 is a mistake we would want to be warned upon.

This patch adds the check described by Junio.

It is assumed that the "tag" header is mandatory for all tag objects.
This might change in the future, at which point this patch should be
revised.

Signed-off-by: Johan Herland <johan@herland.net>
---

I hope this is what you had in mind :)


Have fun!

...Johan

 builtin-fsck.c |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/builtin-fsck.c b/builtin-fsck.c
index cbbcaf0..3594bd3 100644
--- a/builtin-fsck.c
+++ b/builtin-fsck.c
@@ -501,6 +501,23 @@ static int fsck_handle_reflog(const char *logname, const unsigned char *sha1, in
 	return 0;
 }
 
+static void fsck_verify_ref_to_tag_object(const char *refname, struct object *obj)
+{
+	/* Verify that refname matches the name stored in obj's "tag" header */
+	struct tag *tagobj = (struct tag *) parse_object(obj->sha1);
+	size_t tagname_len = strlen(tagobj->tag);
+	size_t refname_len = strlen(refname);
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
@@ -515,6 +532,8 @@ static int fsck_handle_ref(const char *refname, const unsigned char *sha1, int f
 		/* We'll continue with the rest despite the error.. */
 		return 0;
 	}
+	if (obj->type == OBJ_TAG) /* ref to tag object */
+		fsck_verify_ref_to_tag_object(refname, obj);
 	default_refs++;
 	obj->used = 1;
 	mark_reachable(obj, REACHABLE);
-- 
1.5.2.87.g875de-dirty
