From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 5/6] compat/nedmalloc: Fix some sparse warnings
Date: Sat, 27 Apr 2013 19:45:02 +0100
Message-ID: <517C1CAE.8060006@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 27 21:46:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWB4y-0008Lu-LR
	for gcvg-git-2@plane.gmane.org; Sat, 27 Apr 2013 21:46:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756295Ab3D0Tqg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Apr 2013 15:46:36 -0400
Received: from mdfmta009.mxout.tbr.inty.net ([91.221.168.50]:33089 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754847Ab3D0Tqf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Apr 2013 15:46:35 -0400
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id 279B6384083;
	Sat, 27 Apr 2013 20:46:34 +0100 (BST)
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id 4DFAD38407C;
	Sat, 27 Apr 2013 20:46:33 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP;
	Sat, 27 Apr 2013 20:46:32 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
X-MDF-HostID: 4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222670>


Sparse issues many "Using plain integer as NULL pointer" warnings
while checking nedmalloc.c (at least 98 such warnings before giving
up due to "too many warnings"). In addition, sparse issues some
"non-ANSI function declaration" type warnings for the symbols
'win32_getcurrentthreadid', 'malloc_stats' and 'malloc_footprint'.

In order to suppress the NULL pointer warnings, rather than replace
all uses of '0' as a null pointer representation with NULL, we add
-Wno-non-pointer-null to SPARSE_FLAGS while checking nedmalloc.c.

In order to suppress the "non-ANSI function declaration" warnings,
we simply include the missing 'empty parameter list' prototype (void)
in the function declarations.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 Makefile                     | 1 +
 compat/nedmalloc/malloc.c.h  | 2 +-
 compat/nedmalloc/nedmalloc.c | 4 ++--
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 0f931a2..450a1d4 100644
--- a/Makefile
+++ b/Makefile
@@ -2004,6 +2004,7 @@ endif
 ifdef USE_NED_ALLOCATOR
 compat/nedmalloc/nedmalloc.sp compat/nedmalloc/nedmalloc.o: EXTRA_CPPFLAGS = \
 	-DNDEBUG -DOVERRIDE_STRDUP -DREPLACE_SYSTEM_ALLOCATOR
+compat/nedmalloc/nedmalloc.sp: SPARSE_FLAGS += -Wno-non-pointer-null
 endif
 
 git-%$X: %.o GIT-LDFLAGS $(GITLIBS)
diff --git a/compat/nedmalloc/malloc.c.h b/compat/nedmalloc/malloc.c.h
index 1401a67..fdcca82 100644
--- a/compat/nedmalloc/malloc.c.h
+++ b/compat/nedmalloc/malloc.c.h
@@ -1802,7 +1802,7 @@ struct win32_mlock_t
 
 static MLOCK_T malloc_global_mutex = { 0, 0, 0};
 
-static FORCEINLINE long win32_getcurrentthreadid() {
+static FORCEINLINE long win32_getcurrentthreadid(void) {
 #ifdef _MSC_VER
 #if defined(_M_IX86)
   long *threadstruct=(long *)__readfsdword(0x18);
diff --git a/compat/nedmalloc/nedmalloc.c b/compat/nedmalloc/nedmalloc.c
index 91c4e7f..609ebba 100644
--- a/compat/nedmalloc/nedmalloc.c
+++ b/compat/nedmalloc/nedmalloc.c
@@ -159,8 +159,8 @@ struct mallinfo nedmallinfo(void) THROWSPEC			{ return nedpmallinfo(0); }
 #endif
 int    nedmallopt(int parno, int value) THROWSPEC	{ return nedpmallopt(0, parno, value); }
 int    nedmalloc_trim(size_t pad) THROWSPEC			{ return nedpmalloc_trim(0, pad); }
-void   nedmalloc_stats() THROWSPEC					{ nedpmalloc_stats(0); }
-size_t nedmalloc_footprint() THROWSPEC				{ return nedpmalloc_footprint(0); }
+void   nedmalloc_stats(void) THROWSPEC					{ nedpmalloc_stats(0); }
+size_t nedmalloc_footprint(void) THROWSPEC				{ return nedpmalloc_footprint(0); }
 void **nedindependent_calloc(size_t elemsno, size_t elemsize, void **chunks) THROWSPEC	{ return nedpindependent_calloc(0, elemsno, elemsize, chunks); }
 void **nedindependent_comalloc(size_t elems, size_t *sizes, void **chunks) THROWSPEC	{ return nedpindependent_comalloc(0, elems, sizes, chunks); }
 
-- 
1.8.2
