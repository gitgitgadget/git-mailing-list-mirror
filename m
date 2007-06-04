From: Johan Herland <johan@herland.net>
Subject: [PATCH 3/6] git-fsck: Do thorough verification of tag objects.
Date: Mon, 04 Jun 2007 02:53:51 +0200
Message-ID: <200706040253.51920.johan@herland.net>
References: <200706040251.05286.johan@herland.net>
 <200706040251.52613.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 04 02:54:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hv0pf-00022U-5n
	for gcvg-git@gmane.org; Mon, 04 Jun 2007 02:54:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751288AbXFDAx6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Jun 2007 20:53:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751289AbXFDAx6
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jun 2007 20:53:58 -0400
Received: from smtp.getmail.no ([84.208.20.33]:33466 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751288AbXFDAx5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jun 2007 20:53:57 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JJ300J056HW3H00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 04 Jun 2007 02:53:56 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJ300EBV6HSJV20@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 04 Jun 2007 02:53:52 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJ300JZ46HRFE20@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Mon, 04 Jun 2007 02:53:52 +0200 (CEST)
In-reply-to: <200706040251.52613.johan@herland.net>
Content-disposition: inline
User-Agent: KMail/1.9.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49056>

Teach git-fsck to do the same kind of verification on tag objects that is
already done by git-mktag.

Signed-off-by: Johan Herland <johan@herland.net>
---
 builtin-fsck.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/builtin-fsck.c b/builtin-fsck.c
index cbbcaf0..a8914ae 100644
--- a/builtin-fsck.c
+++ b/builtin-fsck.c
@@ -344,6 +344,20 @@ static int fsck_commit(struct commit *commit)
 static int fsck_tag(struct tag *tag)
 {
 	struct object *tagged = tag->tagged;
+	enum object_type type;
+	unsigned long size;
+	char *data = (char *) read_sha1_file(tag->object.sha1, &type, &size);
+	if (!data)
+		return error("Could not read tag %s", sha1_to_hex(tag->object.sha1));
+	if (type != OBJ_TAG) {
+		free(data);
+		return error("Internal error: Tag %s not a tag", sha1_to_hex(tag->object.sha1));
+	}
+	if (parse_and_verify_tag_buffer(0, data, size, 1)) { /* Thoroughly verify tag object */
+		free(data);
+		return error("Tag %s failed thorough tag object verification", sha1_to_hex(tag->object.sha1));
+	}
+	free(data);
 
 	if (!tagged) {
 		return objerror(&tag->object, "could not load tagged object");
-- 
1.5.2
