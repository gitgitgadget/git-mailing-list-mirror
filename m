From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 1/3] refs.c: ensure struct whose member may be passed to realloc is initialized
Date: Fri,  7 Oct 2011 22:20:20 -0500
Message-ID: <5WORKOGzj9pUA6-WazYHWim-cjAN1gZZBHymptluatadyqEWEpUinYhFsc02ctuYig5h-KCIT7ge7OiIw7zj9AjhDiO51YTCsLXHwmXkf9dE8yVtvwLqmJRFg5DOJRvlrZ-UjhNb04k@cipher.nrlssc.navy.mil>
References: <3k7giKa3PkJZo51iAXivXCFEZpYY2WC3depjtuvksrCQPax7dSLVCXpMlqLxWtZfSp6P10yMhMg@cipher.nrlssc.navy.mil>
Cc: julian@quantumfyre.co.uk, Brandon Casey <drafnel@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 08 05:21:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCNTP-0002NB-U4
	for gcvg-git-2@lo.gmane.org; Sat, 08 Oct 2011 05:21:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753641Ab1JHDU7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Oct 2011 23:20:59 -0400
Received: from mail4.nrlssc.navy.mil ([128.160.11.9]:52794 "EHLO
	mail3.nrlssc.navy.mil" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752949Ab1JHDU7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Oct 2011 23:20:59 -0400
Received: by mail3.nrlssc.navy.mil id p983KtYM006458; Fri, 7 Oct 2011 22:20:55 -0500
In-Reply-To: <3k7giKa3PkJZo51iAXivXCFEZpYY2WC3depjtuvksrCQPax7dSLVCXpMlqLxWtZfSp6P10yMhMg@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 08 Oct 2011 03:20:54.0901 (UTC) FILETIME=[4A26AA50:01CC8569]
X-Virus-Scanned: clamav-milter 0.97.2 at mail4
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183135>

From: Brandon Casey <drafnel@gmail.com>

The variable "refs" is allocated on the stack but is not initialized.  It
is passed to read_packed_refs(), and its struct members may eventually be
passed to add_ref() and ALLOC_GROW().  Since the structure has not been
initialized, its members may contain random non-zero values.  So let's
initialize it.

The call sequence looks something like this:

   resolve_gitlink_packed_ref(...) {

       struct cached_refs refs;
       ...
       read_packed_refs(f, &refs);
       ...
   }

   read_packed_refs(FILE*, struct cached_refs *cached_refs) {
       ...
       add_ref(name, sha1, flag, &cached_refs->packed, &last);
       ...
   }

   add_ref(..., struct ref_array *refs, struct ref_entry **) {
       ...
       ALLOC_GROW(refs->refs, refs->nr + 1, refs->alloc);
   }

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 refs.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/refs.c b/refs.c
index 5835b40..c31b461 100644
--- a/refs.c
+++ b/refs.c
@@ -360,6 +360,7 @@ static int resolve_gitlink_packed_ref(char *name, int pathlen, const char *refna
 	f = fopen(name, "r");
 	if (!f)
 		return -1;
+	memset(&refs, 0, sizeof(refs));
 	read_packed_refs(f, &refs);
 	fclose(f);
 	ref = search_ref_array(&refs.packed, refname);
-- 
1.7.7
