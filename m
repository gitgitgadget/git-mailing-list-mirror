From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 2/2] obstack.c: Fix some sparse warnings
Date: Sun, 11 Sep 2011 20:26:53 +0100
Message-ID: <4E6D0B7D.9070602@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 11 21:44:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R2pwo-0004wR-C5
	for gcvg-git-2@lo.gmane.org; Sun, 11 Sep 2011 21:44:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934113Ab1IKTnv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Sep 2011 15:43:51 -0400
Received: from lon1-post-2.mail.demon.net ([195.173.77.149]:42370 "EHLO
	lon1-post-2.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760370Ab1IKTnu (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Sep 2011 15:43:50 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-2.mail.demon.net with esmtp (Exim 4.69)
	id 1R2pwS-0006f6-bY; Sun, 11 Sep 2011 19:43:49 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181185>


In particular, sparse issues the following warnings:

    compat/obstack.c:176:17: warning: Using plain integer as NULL pointer
    compat/obstack.c:224:17: warning: Using plain integer as NULL pointer
    compat/obstack.c:324:16: warning: Using plain integer as NULL pointer
    compat/obstack.c:329:16: warning: Using plain integer as NULL pointer
    compat/obstack.c:347:16: warning: Using plain integer as NULL pointer
    compat/obstack.c:362:19: warning: Using plain integer as NULL pointer
    compat/obstack.c:379:29: warning: Using plain integer as NULL pointer
    compat/obstack.c:399:1: error: symbol 'print_and_abort' redeclared with \
        different type (originally declared at compat/obstack.c:95) \
        - different modifiers

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 compat/obstack.c |   15 +++++++--------
 1 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/compat/obstack.c b/compat/obstack.c
index a89ab5b..e276ccd 100644
--- a/compat/obstack.c
+++ b/compat/obstack.c
@@ -173,7 +173,7 @@ _obstack_begin (struct obstack *h,
 					       alignment - 1);
   h->chunk_limit = chunk->limit
     = (char *) chunk + h->chunk_size;
-  chunk->prev = 0;
+  chunk->prev = NULL;
   /* The initial chunk now contains no empty object.  */
   h->maybe_empty_object = 0;
   h->alloc_failed = 0;
@@ -221,7 +221,7 @@ _obstack_begin_1 (struct obstack *h, int size, int alignment,
 					       alignment - 1);
   h->chunk_limit = chunk->limit
     = (char *) chunk + h->chunk_size;
-  chunk->prev = 0;
+  chunk->prev = NULL;
   /* The initial chunk now contains no empty object.  */
   h->maybe_empty_object = 0;
   h->alloc_failed = 0;
@@ -321,12 +321,12 @@ _obstack_allocated_p (struct obstack *h, void *obj)
   /* We use >= rather than > since the object cannot be exactly at
      the beginning of the chunk but might be an empty object exactly
      at the end of an adjacent chunk.  */
-  while (lp != 0 && ((void *) lp >= obj || (void *) (lp)->limit < obj))
+  while (lp != NULL && ((void *) lp >= obj || (void *) (lp)->limit < obj))
     {
       plp = lp->prev;
       lp = plp;
     }
-  return lp != 0;
+  return lp != NULL;
 }
 
 /* Free objects in obstack H, including OBJ and everything allocate
@@ -344,7 +344,7 @@ obstack_free (struct obstack *h, void *obj)
   /* We use >= because there cannot be an object at the beginning of a chunk.
      But there can be an empty object at that address
      at the end of another chunk.  */
-  while (lp != 0 && ((void *) lp >= obj || (void *) (lp)->limit < obj))
+  while (lp != NULL && ((void *) lp >= obj || (void *) (lp)->limit < obj))
     {
       plp = lp->prev;
       CALL_FREEFUN (h, lp);
@@ -359,7 +359,7 @@ obstack_free (struct obstack *h, void *obj)
       h->chunk_limit = lp->limit;
       h->chunk = lp;
     }
-  else if (obj != 0)
+  else if (obj != NULL)
     /* obj is not in any of the chunks! */
     abort ();
 }
@@ -376,7 +376,7 @@ _obstack_memory_used (struct obstack *h)
   register struct _obstack_chunk* lp;
   register int nbytes = 0;
 
-  for (lp = h->chunk; lp != 0; lp = lp->prev)
+  for (lp = h->chunk; lp != NULL; lp = lp->prev)
     {
       nbytes += lp->limit - (char *) lp;
     }
@@ -395,7 +395,6 @@ _obstack_memory_used (struct obstack *h)
 # endif
 
 static void
-__attribute__ ((noreturn))
 print_and_abort (void)
 {
   /* Don't change any of these strings.  Yes, it would be possible to add
-- 
1.7.6
