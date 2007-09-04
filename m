From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] fix memleak from tree pathspec in git-blame
Date: Mon, 03 Sep 2007 23:54:19 -0700
Message-ID: <7vir6q7wf8.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 04 08:54:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISSIu-0003Jc-ER
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 08:54:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751300AbXIDGyX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 02:54:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751240AbXIDGyX
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 02:54:23 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:35359 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751289AbXIDGyX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 02:54:23 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id D704912C84E;
	Tue,  4 Sep 2007 02:54:42 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57535>

We repeatedly run diff-tree while finding code movements.  The
pathspec data is changed into a list of paths and their lengths
for quicker access by diff_tree_setup_paths(), and you need to
release the extra memory when you are done using that pathspec
data.

Not releasing it is not a problem for "git log -- path" (or its
plumbing equivalent "git rev-list -- paths"), because the
pathspec never changes during the traversal, but it was
noticeable for blame especially with -C -C.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 builtin-blame.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/builtin-blame.c b/builtin-blame.c
index dc88a95..aace08c 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -380,6 +380,7 @@ static struct origin *find_origin(struct scoreboard *sb,
 		}
 	}
 	diff_flush(&diff_opts);
+	diff_tree_release_paths(&diff_opts);
 	if (porigin) {
 		/*
 		 * Create a freestanding copy that is not part of
@@ -436,6 +437,7 @@ static struct origin *find_rename(struct scoreboard *sb,
 		}
 	}
 	diff_flush(&diff_opts);
+	diff_tree_release_paths(&diff_opts);
 	return porigin;
 }
 
@@ -1157,6 +1159,7 @@ static int find_copy_in_parent(struct scoreboard *sb,
 		}
 	}
 	diff_flush(&diff_opts);
+	diff_tree_release_paths(&diff_opts);
 
 	return retval;
 }
