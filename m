From: Ben Walton <bdwalton@gmail.com>
Subject: [PATCH] Use unsigned char to squash compiler warnings
Date: Mon,  2 Mar 2015 19:22:31 +0000
Message-ID: <1425324151-5480-1-git-send-email-bdwalton@gmail.com>
Cc: git@vger.kernel.org, Ben Walton <bdwalton@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Mar 02 20:56:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSWS3-0008Q4-G0
	for gcvg-git-2@plane.gmane.org; Mon, 02 Mar 2015 20:56:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754830AbbCBT4X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2015 14:56:23 -0500
Received: from jimi.chass.utoronto.ca ([128.100.160.32]:34035 "EHLO
	jimi.chass.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754576AbbCBT4W (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Mar 2015 14:56:22 -0500
X-Greylist: delayed 2019 seconds by postgrey-1.27 at vger.kernel.org; Mon, 02 Mar 2015 14:56:22 EST
Received: from hendrix.chass.utoronto.ca ([128.100.160.33]:42404 ident=93)
	  by jimi.chass.utoronto.ca with esmtp  (Exim 4.76)
	 (envelope-from <bdwalton@benandwen.net>)
	 id 1YSVvO-0006Oa-Ky ; Mon, 02 Mar 2015 14:22:42 -0500
Received: from 86-42-129-139-dynamic.b-ras1.bbh.dublin.eircom.net ([86.42.129.139]:47096 helo=neilyoung.benandwen.net)
	 (auth info: dovecot_plain:bwalton@chass.utoronto.ca) by hendrix.chass.utoronto.ca with esmtpsa (TLSv1:AES128-SHA:128)
	 (Exim 4.76)
	 (envelope-from <bdwalton@benandwen.net>)
	 id 1YSVvN-0006it-Uc ; Mon, 02 Mar 2015 14:22:42 -0500
Received: from bdwalton by neilyoung.benandwen.net with local (Exim 4.82)
	(envelope-from <bdwalton@benandwen.net>)
	id 1YSVvL-0001Qy-Lm; Mon, 02 Mar 2015 19:22:39 +0000
X-Mailer: git-send-email 1.9.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264615>

Sun Studio on Solaris issues warnings about improper initialization
values being used when defining tolower_trans_tbl in
ctype.c. tolower_trans_tbl is defined as char[], which studio's
compiler defaults to signed char[] due to the Solaris ABI. To resolve
this, instead of supplying -xchar or another option at build time,
declare tolower_trans_tbl as unsigned char.  Update all appropriate
references to the new type.

Signed-off-by: Ben Walton <bdwalton@gmail.com>
---
 ctype.c           | 2 +-
 git-compat-util.h | 2 +-
 kwset.c           | 8 ++++----
 kwset.h           | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/ctype.c b/ctype.c
index 0bfebb4..fc0225c 100644
--- a/ctype.c
+++ b/ctype.c
@@ -30,7 +30,7 @@ const unsigned char sane_ctype[256] = {
 };
 
 /* For case-insensitive kwset */
-const char tolower_trans_tbl[256] = {
+const unsigned char tolower_trans_tbl[256] = {
 	0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
 	0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,
 	0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17,
diff --git a/git-compat-util.h b/git-compat-util.h
index 3455c5e..5eae2b2 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -694,7 +694,7 @@ static inline size_t xsize_t(off_t len)
 }
 
 /* in ctype.c, for kwset users */
-extern const char tolower_trans_tbl[256];
+extern const unsigned char tolower_trans_tbl[256];
 
 /* Sane ctype - no locale, and works with signed chars */
 #undef isascii
diff --git a/kwset.c b/kwset.c
index a0f49b3..e6236a0 100644
--- a/kwset.c
+++ b/kwset.c
@@ -80,13 +80,13 @@ struct kwset
   struct trie *next[NCHAR];	/* Table of children of the root. */
   char *target;			/* Target string if there's only one. */
   int mind2;			/* Used in Boyer-Moore search for one string. */
-  char const *trans;		/* Character translation table. */
+  unsigned char const *trans;  /* Character translation table. */
 };
 
 /* Allocate and initialize a keyword set object, returning an opaque
    pointer to it.  Return NULL if memory is not available. */
 kwset_t
-kwsalloc (char const *trans)
+kwsalloc (unsigned char const *trans)
 {
   struct kwset *kwset;
 
@@ -381,7 +381,7 @@ kwsprep (kwset_t kws)
   register struct kwset *kwset;
   register int i;
   register struct trie *curr;
-  register char const *trans;
+  register unsigned char const *trans;
   unsigned char delta[NCHAR];
 
   kwset = (struct kwset *) kws;
@@ -590,7 +590,7 @@ cwexec (kwset_t kws, char const *text, size_t len, struct kwsmatch *kwsmatch)
   register int d;
   register char const *end, *qlim;
   register struct tree const *tree;
-  register char const *trans;
+  register unsigned char const *trans;
 
   accept = NULL;
 
diff --git a/kwset.h b/kwset.h
index a21b2ea..61a134f 100644
--- a/kwset.h
+++ b/kwset.h
@@ -39,7 +39,7 @@ typedef struct kwset_t* kwset_t;
    if enough memory cannot be obtained.  The argument if non-NULL
    specifies a table of character translations to be applied to all
    pattern and search text. */
-extern kwset_t kwsalloc(char const *);
+extern kwset_t kwsalloc(unsigned char const *);
 
 /* Incrementally extend the keyword set to include the given string.
    Return NULL for success, or an error message.  Remember an index
-- 
1.9.1
