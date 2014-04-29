From: Marat Radchenko <marat@slonopotamus.org>
Subject: [PATCH 11/12] compat/nedmalloc/malloc.c.h: fix compilation under MinGW-W64
Date: Tue, 29 Apr 2014 13:12:05 +0400
Message-ID: <1398762726-22825-12-git-send-email-marat@slonopotamus.org>
References: <1398762726-22825-1-git-send-email-marat@slonopotamus.org>
Cc: marat@slonopotamus.org,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 29 11:13:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wf46g-0006VR-H0
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 11:13:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933195AbaD2JNg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 05:13:36 -0400
Received: from seldon.slonopotamus.org ([94.242.204.247]:46281 "EHLO
	slonopotamus.org" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S932967AbaD2JNd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 05:13:33 -0400
Received: from [185.6.245.138] (helo=radchenko-d-lnx.mail.msk)
	by slonopotamus.org with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
	(Exim 4.80.1)
	(envelope-from <marat@slonopotamus.org>)
	id 1Wf45N-0006BN-No; Tue, 29 Apr 2014 13:12:22 +0400
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1398762726-22825-1-git-send-email-marat@slonopotamus.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247541>

1. Unlike MinGW, MinGW-W64 already provides _ReadWriteBarrier macro,
   so don't try to redefine it.

2. MinGW-W64 has a strange definition FORCEINLINE as
   extern __inline__ __attribute__((__always_inline__,__gnu_inline__))

   'extern' doesn't work together with 'static', so #undef MinGW-W64
   version of FORCEINLINE.

Signed-off-by: Marat Radchenko <marat@slonopotamus.org>
---
 compat/nedmalloc/malloc.c.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/compat/nedmalloc/malloc.c.h b/compat/nedmalloc/malloc.c.h
index f216a2a..a6c8cac 100644
--- a/compat/nedmalloc/malloc.c.h
+++ b/compat/nedmalloc/malloc.c.h
@@ -715,6 +715,10 @@ struct mallinfo {
 #endif /* HAVE_USR_INCLUDE_MALLOC_H */
 #endif /* NO_MALLINFO */
 
+#ifdef __MINGW64_VERSION_MAJOR
+  #undef FORCEINLINE
+#endif
+
 /*
   Try to persuade compilers to inline. The most critical functions for
   inlining are defined as macros, so these aren't used for them.
@@ -1382,7 +1386,9 @@ LONG __cdecl _InterlockedExchange(LONG volatile *Target, LONG Value);
 
   /*** Atomic operations ***/
   #if (__GNUC__ * 10000 + __GNUC_MINOR__ * 100 + __GNUC_PATCHLEVEL__) > 40100
-    #define _ReadWriteBarrier() __sync_synchronize()
+    #ifndef _ReadWriteBarrier
+      #define _ReadWriteBarrier() __sync_synchronize()
+    #endif
   #else
     static __inline__ __attribute__((always_inline)) long __sync_lock_test_and_set(volatile long * const Target, const long Value)
     {
-- 
1.9.1
