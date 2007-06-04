From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 3/6] git-fsck: Do thorough verification of tag objects.
Date: Mon, 04 Jun 2007 09:51:06 +0200
Message-ID: <200706040951.06620.johan@herland.net>
References: <200706040251.05286.johan@herland.net>
 <200706040253.51920.johan@herland.net> <20070604055655.GB15148@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Matthias Lederhofer <matled@gmx.net>
X-From: git-owner@vger.kernel.org Mon Jun 04 09:51:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hv7LR-0000EB-V2
	for gcvg-git@gmane.org; Mon, 04 Jun 2007 09:51:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752322AbXFDHvL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jun 2007 03:51:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752285AbXFDHvL
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jun 2007 03:51:11 -0400
Received: from smtp.getmail.no ([84.208.20.33]:40920 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752075AbXFDHvK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2007 03:51:10 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JJ300001PT8VB00@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 04 Jun 2007 09:51:08 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJ300E4CPT7SE40@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 04 Jun 2007 09:51:07 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJ300MQPPT6U320@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Mon, 04 Jun 2007 09:51:07 +0200 (CEST)
In-reply-to: <20070604055655.GB15148@moooo.ath.cx>
Content-disposition: inline
User-Agent: KMail/1.9.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49078>

Teach git-fsck to do the same kind of verification on tag objects that is
already done by git-mktag.

Signed-off-by: Johan Herland <johan@herland.net>
---

Matthias Lederhofer <matled@gmx.net> wrote:
> The objerror() function prints the sha1 and object type, I think this
> one should be used instead of error() here.

Of course, you're right. Like this, I hope:

 builtin-fsck.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/builtin-fsck.c b/builtin-fsck.c
index cbbcaf0..71a5fd5 100644
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
 
 	if (!tagged) {
 		return objerror(&tag->object, "could not load tagged object");
-- 
1.5.2
