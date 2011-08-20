From: Fredrik Kuivinen <frekui@gmail.com>
Subject: [PATCH v2 3/5] Adapt the kwset code to Git
Date: Sun, 21 Aug 2011 00:41:41 +0200
Message-ID: <20110820224141.GD2199@fredrik-Q430-Q530>
References: <20110820223032.12380.72469.stgit@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: bonzini@gnu.org, dpotapov@gmail.com,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 21 00:41:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuuEf-0008CI-M8
	for gcvg-git-2@lo.gmane.org; Sun, 21 Aug 2011 00:41:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754575Ab1HTWlp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Aug 2011 18:41:45 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:35673 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754145Ab1HTWlo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Aug 2011 18:41:44 -0400
Received: by mail-bw0-f46.google.com with SMTP id 11so2936995bke.19
        for <git@vger.kernel.org>; Sat, 20 Aug 2011 15:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=XKAASeo1mRsMntyb1DBG3a2BY6l6RVeT4uDy3jD723w=;
        b=hacacZzHm3XPRjMbENCYAathND612jQt7IQEHipJOQxYPFZe1P8iCe1Z1D0w6J0v0x
         IpiIXVcFaR22chMmKUbb0agYHbfTyvf04Ps/CUPlAolDGeoOyRhKH1K5yKMST8uT/OrF
         SdpPE4hPZzsaN0pkZbZ5J/HQf4fZSL+jmZN0Q=
Received: by 10.204.132.80 with SMTP id a16mr315608bkt.128.1313880104050;
        Sat, 20 Aug 2011 15:41:44 -0700 (PDT)
Received: from fredrik-Q430-Q530 (c83-250-151-53.bredband.comhem.se [83.250.151.53])
        by mx.google.com with ESMTPS id x19sm1443963bkt.9.2011.08.20.15.41.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 20 Aug 2011 15:41:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110820223032.12380.72469.stgit@localhost6.localdomain6>
User-Agent: StGit/0.15
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179789>



Signed-off-by: Fredrik Kuivinen <frekui@gmail.com>
---
 kwset.c |   31 ++++++++++++-------------------
 kwset.h |   18 ++++++++++++------
 2 files changed, 24 insertions(+), 25 deletions(-)

diff --git a/kwset.c b/kwset.c
index e66193b..06a66e7 100644
--- a/kwset.c
+++ b/kwset.c
@@ -1,3 +1,8 @@
+/* This file has been copied from commit e7ac713d^ in the GNU grep git
+ * repository. A few small changes have been made to adapt the code to
+ * Git.
+ */
+
 /* kwset.c - search for any of a set of keywords.
    Copyright 1989, 1998, 2000, 2005 Free Software Foundation, Inc.
 
@@ -28,22 +33,14 @@
    String Matching:  An Aid to Bibliographic Search," CACM June 1975,
    Vol. 18, No. 6, which describes the failure function used below. */
 
-#ifdef HAVE_CONFIG_H
-# include <config.h>
-#endif
+#include "cache.h"
+
 #include <sys/types.h>
-#include "system.h"
 #include "kwset.h"
 #include "obstack.h"
 
-#ifdef GREP
-extern char *xmalloc();
-# undef malloc
-# define malloc xmalloc
-#endif
-
 #define NCHAR (UCHAR_MAX + 1)
-#define obstack_chunk_alloc malloc
+#define obstack_chunk_alloc xmalloc
 #define obstack_chunk_free free
 
 #define U(c) ((unsigned char) (c))
@@ -93,9 +90,7 @@ kwsalloc (char const *trans)
 {
   struct kwset *kwset;
 
-  kwset = (struct kwset *) malloc(sizeof (struct kwset));
-  if (!kwset)
-    return NULL;
+  kwset = (struct kwset *) xmalloc(sizeof (struct kwset));
 
   obstack_init(&kwset->obstack);
   kwset->words = 0;
@@ -174,7 +169,7 @@ kwsincr (kwset_t kws, char const *text, size_t len)
 	  link = (struct tree *) obstack_alloc(&kwset->obstack,
 					       sizeof (struct tree));
 	  if (!link)
-	    return _("memory exhausted");
+	    return "memory exhausted";
 	  link->llink = NULL;
 	  link->rlink = NULL;
 	  link->trie = (struct trie *) obstack_alloc(&kwset->obstack,
@@ -182,7 +177,7 @@ kwsincr (kwset_t kws, char const *text, size_t len)
 	  if (!link->trie)
 	    {
 	      obstack_free(&kwset->obstack, link);
-	      return _("memory exhausted");
+	      return "memory exhausted";
 	    }
 	  link->trie->accepting = 0;
 	  link->trie->links = NULL;
@@ -405,7 +400,7 @@ kwsprep (kwset_t kws)
       /* Looking for just one string.  Extract it from the trie. */
       kwset->target = obstack_alloc(&kwset->obstack, kwset->mind);
       if (!kwset->target)
-	return _("memory exhausted");
+	return "memory exhausted";
       for (i = kwset->mind - 1, curr = kwset->trie; i >= 0; --i)
 	{
 	  kwset->target[i] = curr->links->label;
@@ -597,9 +592,7 @@ cwexec (kwset_t kws, char const *text, size_t len, struct kwsmatch *kwsmatch)
   register struct tree const *tree;
   register char const *trans;
 
-#ifdef lint
   accept = NULL;
-#endif
 
   /* Initialize register copies and look for easy ways out. */
   kwset = (struct kwset *) kws;
diff --git a/kwset.h b/kwset.h
index 10836be..a21b2ea 100644
--- a/kwset.h
+++ b/kwset.h
@@ -1,3 +1,8 @@
+/* This file has been copied from commit e7ac713d^ in the GNU grep git
+ * repository. A few small changes have been made to adapt the code to
+ * Git.
+ */
+
 /* kwset.h - header declaring the keyword set library.
    Copyright (C) 1989, 1998, 2005 Free Software Foundation, Inc.
 
@@ -27,22 +32,23 @@ struct kwsmatch
   size_t size[1];		/* Length of each submatch. */
 };
 
-typedef ptr_t kwset_t;
+struct kwset_t;
+typedef struct kwset_t* kwset_t;
 
 /* Return an opaque pointer to a newly allocated keyword set, or NULL
    if enough memory cannot be obtained.  The argument if non-NULL
    specifies a table of character translations to be applied to all
    pattern and search text. */
-extern kwset_t kwsalloc PARAMS((char const *));
+extern kwset_t kwsalloc(char const *);
 
 /* Incrementally extend the keyword set to include the given string.
    Return NULL for success, or an error message.  Remember an index
    number for each keyword included in the set. */
-extern const char *kwsincr PARAMS((kwset_t, char const *, size_t));
+extern const char *kwsincr(kwset_t, char const *, size_t);
 
 /* When the keyword set has been completely built, prepare it for
    use.  Return NULL for success, or an error message. */
-extern const char *kwsprep PARAMS((kwset_t));
+extern const char *kwsprep(kwset_t);
 
 /* Search through the given buffer for a member of the keyword set.
    Return a pointer to the leftmost longest match found, or NULL if
@@ -50,8 +56,8 @@ extern const char *kwsprep PARAMS((kwset_t));
    the matching substring in the integer it points to.  Similarly,
    if foundindex is non-NULL, store the index of the particular
    keyword found therein. */
-extern size_t kwsexec PARAMS((kwset_t, char const *, size_t, struct kwsmatch *));
+extern size_t kwsexec(kwset_t, char const *, size_t, struct kwsmatch *);
 
 /* Deallocate the given keyword set and all its associated storage. */
-extern void kwsfree PARAMS((kwset_t));
+extern void kwsfree(kwset_t);
 
