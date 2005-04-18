From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 2/6] show-diff.c: check unreadbale blob.
Date: Mon, 18 Apr 2005 13:34:02 -0700
Message-ID: <7vr7h7u8n9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 18 22:31:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNcsl-0002kz-6o
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 22:30:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261158AbVDRUeJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 16:34:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261159AbVDRUeJ
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 16:34:09 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:4279 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S261158AbVDRUeE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2005 16:34:04 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050418203403.KMBH15592.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 18 Apr 2005 16:34:03 -0400
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

[PATCH 2/6] show-diff.c: check unreadbale blob.

This patch fixes show-diff to detect unreadable blob and warn
instead of going ahead and crashing.

To be applied on top of:

    [PATCH 1/6] show-diff.c: clean up private buffer use.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 show-diff.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletion(-)

--- a/show-diff.c
+++ b/show-diff.c
@@ -71,6 +71,11 @@ static void show_diff_empty(struct cache
 	unsigned char type[20], *p, *end;
 
 	old = read_sha1_file(ce->sha1, type, &size);
+	if (! old) {
+		error("unable to read blob object for %s (%s)", ce->name,
+		      sha1_to_hex(ce->sha1));
+		return;
+	}
 	if (size > 0) {
 		int startline = 1;
 		int c = 0;
@@ -195,7 +200,11 @@ int main(int argc, char **argv)
 			continue;
 
 		old = read_sha1_file(ce->sha1, type, &size);
-		show_differences(ce->name, old, size);
+		if (! old)
+			error("unable to read blob object for %s (%s)",
+			      ce->name, sha1_to_hex(ce->sha1));
+		else
+			show_differences(ce->name, old, size);
 		free(old);
 	}
 	return 0;

