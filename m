From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] tree-walk.c: fix some sparse 'NULL pointer' warnings
Date: Tue, 19 May 2015 23:16:19 +0100
Message-ID: <555BB633.8030204@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed May 20 00:16:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YupoP-0003EY-LT
	for gcvg-git-2@plane.gmane.org; Wed, 20 May 2015 00:16:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751293AbbESWQ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2015 18:16:29 -0400
Received: from mdfmta005.mxout.tch.inty.net ([91.221.169.46]:50361 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751104AbbESWQ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2015 18:16:28 -0400
Received: from mdfmta005.tch.inty.net (unknown [127.0.0.1])
	by mdfmta005.tch.inty.net (Postfix) with ESMTP id 1208418CDB0;
	Tue, 19 May 2015 23:16:26 +0100 (BST)
Received: from mdfmta005.tch.inty.net (unknown [127.0.0.1])
	by mdfmta005.tch.inty.net (Postfix) with ESMTP id C94D018CAE1;
	Tue, 19 May 2015 23:16:25 +0100 (BST)
Received: from [10.0.2.15] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mdfmta005.tch.inty.net (Postfix) with ESMTP;
	Tue, 19 May 2015 23:16:25 +0100 (BST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
X-MDF-HostID: 18
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269421>


Commit 811cd77b ("tree-walk: learn get_tree_entry_follow_symlinks",
14-05-2015) introduced a new function to locate an object by path
while following symlinks in the repository. However, sparse now
issues some "Using plain integer as NULL pointer" warnings as
follows:

      SP tree-walk.c
  tree-walk.c:517:31: warning: Using plain integer as NULL pointer
  tree-walk.c:521:28: warning: Using plain integer as NULL pointer

The first warning relates to the use of an '{0}' initializer for
the 'struct tree_desc' t. The first field of this structure has
pointer type. A simple solution would replace the initializer
expression with '{NULL}'. However, we choose to remove the
initializer expression and make the initialization more explicit
with a call to the 'init_tree_desc' function.

The second warning relates to the '0' initializer for the buf
field of the 'result_path' strbuf pointer. A simple solution
would replace this initializer with 'NULL'. However, this would
violate a strbuf invariant that the 'buf' field is never NULL.
(see strbuf documentation in strbuf.h header.) Assuming the
documentation of 'get_tree_entry_follow_symlinks' regarding the
'result_path' parameter is observed by callers (ie that the
parameter points to an _unitialized_ strbuf), a better solution
is to simply call the 'strbuf_init' function.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Hi David,

If you need to re-roll the patches in your 'dt/cat-file-follow-symlinks'
branch, could you please squash this, or something like this, into the
relevant patch (commit 811cd77b).

Thanks!

ATB,
Ramsay Jones

 tree-walk.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tree-walk.c b/tree-walk.c
index 8031f3a..6dccd2d 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -514,13 +514,12 @@ enum follow_symlinks_result get_tree_entry_follow_symlinks(unsigned char *tree_s
 	ssize_t parents_nr = 0;
 	unsigned char current_tree_sha1[20];
 	struct strbuf namebuf = STRBUF_INIT;
-	struct tree_desc t = {0};
+	struct tree_desc t;
 	int follows_remaining = GET_TREE_ENTRY_FOLLOW_SYMLINKS_MAX_LINKS;
 	int i;
 
-	result_path->buf = 0;
-	result_path->alloc = 0;
-	result_path->len = 0;
+	init_tree_desc(&t, NULL, 0UL);
+	strbuf_init(result_path, 0);
 	strbuf_addstr(&namebuf, name);
 	hashcpy(current_tree_sha1, tree_sha1);
 
-- 
2.4.0
