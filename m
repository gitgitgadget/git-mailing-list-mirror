From: Junio C Hamano <junkio@cox.net>
Subject: Re: http-fetch troubles
Date: Fri, 02 Jun 2006 15:15:53 -0700
Message-ID: <7vmzcv9pba.fsf@assigned-by-dhcp.cox.net>
References: <20060601232437.GD12261@reactrix.com>
	<7vhd34dptq.fsf@assigned-by-dhcp.cox.net>
	<7vac8vbgqg.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sat Jun 03 00:16:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FmHw6-00066r-Dv
	for gcvg-git@gmane.org; Sat, 03 Jun 2006 00:16:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932579AbWFBWP4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Jun 2006 18:15:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932581AbWFBWP4
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jun 2006 18:15:56 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:49845 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S932580AbWFBWPz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jun 2006 18:15:55 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060602221554.YTLJ5347.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 2 Jun 2006 18:15:54 -0400
To: Nick Hengeveld <nickh@reactrix.com>
In-Reply-To: <7vac8vbgqg.fsf_-_@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Fri, 02 Jun 2006 10:38:15 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21178>

I think this fixes the http trouble with tree parser change in
the "next" branch.

-- >8 --
fetch.c: do not call process_tree() from process_tree().

This function reads a freshly fetched tree object, and schedules
the objects pointed by it for further fetching, so calling lookup-tree
and doing process_tree() recursively from there does not make
much sense.  We need to use process() on it to make sure we
fetch it first.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
diff --git a/fetch.c b/fetch.c
index ec2d8c3..107504b 100644
--- a/fetch.c
+++ b/fetch.c
@@ -46,13 +46,20 @@ static int process_tree(struct tree *tre
 	desc.buf = tree->buffer;
 	desc.size = tree->size;
 	while (tree_entry(&desc, &entry)) {
+		struct object *obj = NULL;
+
 		if (S_ISDIR(entry.mode)) {
 			struct tree *tree = lookup_tree(entry.sha1);
-			process_tree(tree);
-		} else {
+			if (tree)
+				obj = &tree->object;
+		}
+		else {
 			struct blob *blob = lookup_blob(entry.sha1);
-			process(&blob->object);
+			if (blob)
+				obj = &blob->object;
 		}
+		if (!obj || process(obj))
+			return -1;
 	}
 	free(tree->buffer);
 	tree->buffer = NULL;
