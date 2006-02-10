From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] combine-diff: Record diff status a bit more faithfully
Date: Fri, 10 Feb 2006 03:00:45 -0800
Message-ID: <7vzmkzwk9u.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0602081532360.2458@g5.osdl.org>
	<43EAA560.8030504@didntduck.org>
	<Pine.LNX.4.64.0602081817040.2458@g5.osdl.org>
	<7vu0b9jkad.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0602090822100.2458@g5.osdl.org>
	<Pine.LNX.4.64.0602091029310.2458@g5.osdl.org>
	<7v3bisb9qn.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0602091216460.2458@g5.osdl.org>
	<7vd5hw9sk1.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0602091246010.2458@g5.osdl.org>
	<7vzml08cfm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 10 12:00:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F7W1D-0003kG-Uf
	for gcvg-git@gmane.org; Fri, 10 Feb 2006 12:00:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751350AbWBJLAs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Feb 2006 06:00:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751349AbWBJLAs
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Feb 2006 06:00:48 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:62344 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751350AbWBJLAr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Feb 2006 06:00:47 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060210105918.OZLF6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 10 Feb 2006 05:59:18 -0500
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15870>

This shows "new file mode XXXX" and "deleted file mode XXXX"
lines like two-way diff-patch output does, by checking the
status from each parent.

The diff-raw output for combined diff is made a bit uglier by
showing diff status letters with each parent.  While most of the
case you would see "MM" in the output, an Evil Merge that
touches a path that was added by inheriting from one parent is
possible and it would be shown like these:

    $ git-diff-tree --abbrev -c HEAD
    2d7ca89675eb8888b0b88a91102f096d4471f09f
    ::000000 000000 100644 0000000... 0000000... 31dd686... AA	b
    ::000000 100644 100644 0000000... 6c884ae... c6d4fa8... AM	d
    ::100644 100644 100644 4f7cbe7... f8c295c... 19d5d80... RR	e

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 * I also considered showing the rename detection scores but
   felt it was too much information, so refrained from it.
   Maybe MM might be too much, but knowing most of the merges
   are only two parents' kind, one extra column would not be too
   much noise.

   By looking at -c -p or --cc output, you cannot tell any
   renames, which makes me feel a bit uneasy.  I suspect this
   is going into purely academic realm and would not be useful
   in practice at all, so I'd say we should stop ;-).

 combine-diff.c |   32 +++++++++++++++++++++++++-------
 diff.h         |    1 +
 2 files changed, 26 insertions(+), 7 deletions(-)

dc33c79b0f69a1e9acee740a2f7ac5eacfdd49ce
diff --git a/combine-diff.c b/combine-diff.c
index 8ba6949..a38f01b 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -39,6 +39,7 @@ static struct combine_diff_path *interse
 			p->mode = q->queue[i]->two->mode;
 			memcpy(p->parent[n].sha1, q->queue[i]->one->sha1, 20);
 			p->parent[n].mode = q->queue[i]->one->mode;
+			p->parent[n].status = q->queue[i]->status;
 			*tail = p;
 			tail = &p->next;
 		}
@@ -62,6 +63,7 @@ static struct combine_diff_path *interse
 				memcpy(p->parent[n].sha1,
 				       q->queue[i]->one->sha1, 20);
 				p->parent[n].mode = q->queue[i]->one->mode;
+				p->parent[n].status = q->queue[i]->status;
 				break;
 			}
 		}
@@ -739,12 +741,25 @@ static int show_patch_diff(struct combin
 		printf("..%s\n", abb);
 
 		if (mode_differs) {
-			printf("mode ");
-			for (i = 0; i < num_parent; i++) {
-				printf("%s%06o", i ? "," : "",
-				       elem->parent[i].mode);
+			int added = !!elem->mode;
+			for (i = 0; added && i < num_parent; i++)
+				if (elem->parent[i].status !=
+				    DIFF_STATUS_ADDED)
+					added = 0;
+			if (added)
+				printf("new file mode %06o", elem->mode);
+			else {
+				if (!elem->mode)
+					printf("deleted file ");
+				printf("mode ");
+				for (i = 0; i < num_parent; i++) {
+					printf("%s%06o", i ? "," : "",
+					       elem->parent[i].mode);
+				}
+				if (elem->mode)
+					printf("..%06o", elem->mode);
 			}
-			printf("..%06o\n", elem->mode);
+			putchar('\n');
 		}
 		dump_sline(sline, cnt, num_parent);
 	}
@@ -811,8 +826,11 @@ static void show_raw_diff(struct combine
 	}
 
 	if (opt->output_format == DIFF_FORMAT_RAW ||
-	    opt->output_format == DIFF_FORMAT_NAME_STATUS)
-		printf("%c%c", mod_type, inter_name_termination);
+	    opt->output_format == DIFF_FORMAT_NAME_STATUS) {
+		for (i = 0; i < num_parent; i++)
+			putchar(p->parent[i].status);
+		putchar(inter_name_termination);
+	}
 
 	if (line_termination) {
 		if (quote_c_style(p->path, NULL, NULL, 0))
diff --git a/diff.h b/diff.h
index 946a406..8fac465 100644
--- a/diff.h
+++ b/diff.h
@@ -66,6 +66,7 @@ struct combine_diff_path {
 	unsigned int mode;
 	unsigned char sha1[20];
 	struct combine_diff_parent {
+		char status;
 		unsigned int mode;
 		unsigned char sha1[20];
 	} parent[FLEX_ARRAY];
-- 
1.1.6.g94c6
