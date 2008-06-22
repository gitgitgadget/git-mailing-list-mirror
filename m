From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/5] rerere: remove dubious "tail_optimization"
Date: Sun, 22 Jun 2008 02:47:52 -0700
Message-ID: <7vd4m9ol6f.fsf@gitster.siamese.dyndns.org>
References: <20080616110113.GA22945@elte.hu>
 <7vej6xb4lr.fsf@gitster.siamese.dyndns.org> <20080616190911.GA7047@elte.hu>
 <7vskvd9kai.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Sun Jun 22 11:49:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAMC0-0006IJ-Fa
	for gcvg-git-2@gmane.org; Sun, 22 Jun 2008 11:49:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751521AbYFVJsI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jun 2008 05:48:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751491AbYFVJsG
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jun 2008 05:48:06 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:37841 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751469AbYFVJsF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jun 2008 05:48:05 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id CBA41A35D;
	Sun, 22 Jun 2008 05:48:03 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id E4617A35B; Sun, 22 Jun 2008 05:48:00 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4EFC3C00-4040-11DD-9F99-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85759>

It is dubious if it is cheaper to shift entries repeatedly using memmove()
to collect entries that needs to be written out in front of an array than
simply marking the entries to be skipped.  In addition, the label called this
"tail optimization", but this obviously is not what people usually call
with that name.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-rerere.c |   19 +++++++++----------
 1 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/builtin-rerere.c b/builtin-rerere.c
index addc5c7..0eec1f9 100644
--- a/builtin-rerere.c
+++ b/builtin-rerere.c
@@ -66,8 +66,12 @@ static int write_rr(struct path_list *rr, int out_fd)
 {
 	int i;
 	for (i = 0; i < rr->nr; i++) {
-		const char *path = rr->items[i].path;
-		int length = strlen(path) + 1;
+		const char *path;
+		int length;
+		if (!rr->items[i].util)
+			continue;
+		path = rr->items[i].path;
+		length = strlen(path) + 1;
 		if (write_in_full(out_fd, rr->items[i].util, 40) != 40 ||
 		    write_in_full(out_fd, "\t", 1) != 1 ||
 		    write_in_full(out_fd, path, length) != length)
@@ -319,7 +323,7 @@ static int do_plain_rerere(struct path_list *rr, int fd)
 			if (!merge(name, path)) {
 				fprintf(stderr, "Resolved '%s' using "
 						"previous resolution.\n", path);
-				goto tail_optimization;
+				goto mark_resolved;
 			}
 		}
 
@@ -330,13 +334,8 @@ static int do_plain_rerere(struct path_list *rr, int fd)
 
 		fprintf(stderr, "Recorded resolution for '%s'.\n", path);
 		copy_file(rr_path(name, "postimage"), path, 0666);
-tail_optimization:
-		if (i < rr->nr - 1)
-			memmove(rr->items + i,
-				rr->items + i + 1,
-				sizeof(rr->items[0]) * (rr->nr - i - 1));
-		rr->nr--;
-		i--;
+	mark_resolved:
+		rr->items[i].util = NULL;
 	}
 
 	return write_rr(rr, fd);
-- 
1.5.6.12.g73f03
