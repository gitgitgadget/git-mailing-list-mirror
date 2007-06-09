From: Johan Herland <johan@herland.net>
Subject: [PATCH 18/21] git-fsck: Do thorough verification of tag objects
Date: Sat, 09 Jun 2007 02:20:26 +0200
Message-ID: <200706090220.26342.johan@herland.net>
References: <Pine.LNX.4.64.0706072348110.4046@racer.site>
 <7vzm3aig7j.fsf@assigned-by-dhcp.cox.net>
 <200706090210.36270.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 09 02:20:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hwogx-0004pF-5N
	for gcvg-git@gmane.org; Sat, 09 Jun 2007 02:20:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031629AbXFIAU3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 20:20:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S970010AbXFIAU3
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 20:20:29 -0400
Received: from smtp.getmail.no ([84.208.20.33]:50264 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S968031AbXFIAU3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2007 20:20:29 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JJC00A01EA47200@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Sat, 09 Jun 2007 02:20:28 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJC000SNEA2ZK30@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Sat, 09 Jun 2007 02:20:26 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJC00FMMEA2RBG0@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Sat, 09 Jun 2007 02:20:26 +0200 (CEST)
In-reply-to: <200706090210.36270.johan@herland.net>
Content-disposition: inline
User-Agent: KMail/1.9.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49545>

Teach git-fsck to do the same kind of verification on tag objects that is
already done by git-mktag.

Signed-off-by: Johan Herland <johan@herland.net>
---
 builtin-fsck.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/builtin-fsck.c b/builtin-fsck.c
index 944a496..7b4c36b 100644
--- a/builtin-fsck.c
+++ b/builtin-fsck.c
@@ -359,11 +359,26 @@ static int fsck_commit(struct commit *commit)
 static int fsck_tag(struct tag *tag)
 {
 	struct object *tagged = tag->tagged;
+	enum object_type type;
+	unsigned long size;
+	char *data = (char *) read_sha1_file(tag->object.sha1, &type, &size);
 
 	if (verbose)
 		fprintf(stderr, "Checking tag %s\n",
 			sha1_to_hex(tag->object.sha1));
 
+	if (!data)
+		return objerror(&tag->object, "could not read tag");
+	if (type != OBJ_TAG) {
+		free(data);
+		return objerror(&tag->object, "not a tag (internal error)");
+	}
+	if (parse_and_verify_tag_buffer(0, data, size, 1)) { /* thoroughly verify tag object */
+		free(data);
+		return objerror(&tag->object, "failed thorough tag object verification");
+	}
+	free(data);
+
 	if (!tagged) {
 		return objerror(&tag->object, "could not load tagged object");
 	}
-- 
1.5.2
