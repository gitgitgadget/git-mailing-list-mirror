From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] fsck: do not crash on tag objects which do not contain an
 empty line
Date: Thu, 7 Jun 2007 23:40:12 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706072338260.4046@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jun 08 00:42:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwQgZ-0007ZH-TN
	for gcvg-git@gmane.org; Fri, 08 Jun 2007 00:42:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937397AbXFGWm0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jun 2007 18:42:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937204AbXFGWm0
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jun 2007 18:42:26 -0400
Received: from mail.gmx.net ([213.165.64.20]:60009 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S937916AbXFGWmY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2007 18:42:24 -0400
Received: (qmail invoked by alias); 07 Jun 2007 22:42:22 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp012) with SMTP; 08 Jun 2007 00:42:22 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+2+T99hd62fcEQwMMFRITXY7x664NZ5uHNxQ3JLw
	g3c7d9hpfXOYDS
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49397>


The first empty line in a tag object separates the header from the
message. If the tag object has no empty line, do not crash, but
complain loudly instead.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	I have no idea how this tag crept into one of my repos, but it is 
	no good to crash for git-fsck.

 builtin-fsck.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/builtin-fsck.c b/builtin-fsck.c
index 7a92e47..607136a 100644
--- a/builtin-fsck.c
+++ b/builtin-fsck.c
@@ -545,9 +545,14 @@ static void fsck_verify_ref_to_tag_object(const char *refname, struct object *ob
 {
 	/* Verify that refname matches the name stored in obj's "tag" header */
 	struct tag *tagobj = (struct tag *) parse_object(obj->sha1);
-	size_t tagname_len = strlen(tagobj->tag);
+	size_t tagname_len;
 	size_t refname_len = strlen(refname);
 
+	if (!tagobj->tag) {
+		error("tag %s does not contain any tag?", refname);
+		return;
+	}
+	tagname_len = strlen(tagobj->tag);
 	if (!tagname_len) return; /* No tag name stored in tagobj. Nothing to do. */
 
 	if (tagname_len < refname_len &&
-- 
1.5.2.1.2683.gab86-dirty
