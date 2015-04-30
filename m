From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH v3] git-compat-util.h: implement a different ARRAY_SIZE macro for for safely deriving the size of array
Date: Thu, 30 Apr 2015 14:44:14 +0200
Message-ID: <1430397854-28908-1-git-send-email-gitter.spiros@gmail.com>
Cc: gitster@pobox.com, peff@peff.net,
	Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 30 14:44:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YnnpQ-0008A2-3U
	for gcvg-git-2@plane.gmane.org; Thu, 30 Apr 2015 14:44:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750973AbbD3Mo1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Apr 2015 08:44:27 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:34728 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750862AbbD3Mo0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Apr 2015 08:44:26 -0400
Received: by pacyx8 with SMTP id yx8so58891928pac.1
        for <git@vger.kernel.org>; Thu, 30 Apr 2015 05:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=P8na9GoxfvTCy7z6vwp+7CKVzHwrZ0UezSBOMV5gN7o=;
        b=U+Jitb+ZzWIhqs2wrHjWu4tZGoZgJzPKEIqshH3TA9lI5gHq0wcCjfpzbpT4p7XMSx
         wOS+o3R8Ltn3QaBJZSk9FZIIwTA9un+OGymdzVFHJfjn3/fRjdwlkOhgVbbtyEJoQoid
         mDUuI2HnYPVwGwH6NYNIGfx1GGtp8UEdOCl26baxUl0WhSKce/L3oehq0VvMuPDhsTcV
         lGaY2zdDzBeUytAK2eDVZKWQf8U+Mt1niNBvAa6Xg31p67ZeEd1D1gYWyUWtvMAWLztV
         StbwblhnyLp0Q592aWxzGhpN25xLKroIxK5QFU7ef8OvrnjoBRuc7NbwBLHFfuRmeW2I
         I4Ow==
X-Received: by 10.70.56.98 with SMTP id z2mr7873213pdp.120.1430397865892;
        Thu, 30 Apr 2015 05:44:25 -0700 (PDT)
Received: from ubuntu14.nephoscale.com (141.195.207.67.nephoscale.net. [67.207.195.141])
        by mx.google.com with ESMTPSA id in4sm2146115pbd.40.2015.04.30.05.44.24
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 30 Apr 2015 05:44:25 -0700 (PDT)
X-Mailer: git-send-email 2.1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268071>

To get number of elements in an array git use the ARRAY_SIZE macro
defined as:

       #define ARRAY_SIZE(x) (sizeof(x)/sizeof((x)[0]))

The problem with it is a possibility of mistakenly passing to it a
pointer instead an array. The ARRAY_SIZE macro as conventionally
defined does not provide good type-safety and the open-coded
approach is more fragile, more verbose and provides no improvement in
type-safety.

Use instead a different but compatible ARRAY_SIZE() macro,
which will also break compile if you try to
use it on a pointer. This implemention revert to the original code
if the compiler doesn't know the typeof and __builtin_types_compatible_p
GCC extensions.

This can ensure our code is robust to changes, without
needing a gratuitous macro or constant. A similar
ARRAY_SIZE implementation also exists in the linux kernel.

Credits to Rusty Russell and his ccan library.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 git-compat-util.h | 54 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

This is the third version of the patch.

Compared to the second version:

- Eliminated the autoconf use. I use instead the GCC (and compatible compilers) macros
  for checking if the not portable builtin is supported or not ("Jeff suggestion")
- Changed the name of the macro from _array_size_chk to BARF_IF_IS_NOT_AN_ARRAY i
 ("Junio suggestion. In ALL_CAPS for the Jeff comment )"

diff --git a/git-compat-util.h b/git-compat-util.h
index bc8fc8c..b29c9f3 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -3,6 +3,23 @@
 
 #define _FILE_OFFSET_BITS 64
 
+
+/* Derived from Linux "Features Test Macro" header
+ * Convenience macros to test the versions of gcc (or 
+ * a compatible compiler).
+ * Use them like this:
+ *  #if GIT_GNUC_PREREQ (2,8)
+ *   ... code requiring gcc 2.8 or later ...
+ *  #endif
+*/
+#if defined(__GNUC__) && defined(__GNUC_MINOR__)
+# define GIT_GNUC_PREREQ(maj, min) \
+	((__GNUC__ << 16) + __GNUC_MINOR__ >= ((maj) << 16) + (min))
+#else
+ #define GIT_GNUC_PREREQ(maj, min) 0
+#endif
+
+
 #ifndef FLEX_ARRAY
 /*
  * See if our compiler is known to support flexible array members.
@@ -25,7 +42,42 @@
 #endif
 #endif
 
-#define ARRAY_SIZE(x) (sizeof(x)/sizeof(x[0]))
+
+/*
+ * BUILD_ASSERT_OR_ZERO - assert a build-time dependency, as an expression.
+ * @cond: the compile-time condition which must be true.
+ *
+ * Your compile will fail if the condition isn't true, or can't be evaluated
+ * by the compiler.  This can be used in an expression: its value is "0".
+ *
+ * Example:
+ *	#define foo_to_char(foo)					\
+ *		 ((char *)(foo)						\
+ *		  + BUILD_ASSERT_OR_ZERO(offsetof(struct foo, string) == 0))
+ */
+#define BUILD_ASSERT_OR_ZERO(cond) \
+	(sizeof(char [1 - 2*!(cond)]) - 1)
+
+#if defined(__GNUC__) && (__GNUC__ >= 3)
+# if GIT_GNUC_PREREQ(3, 1)
+ /* &arr[0] degrades to a pointer: a different type from an array */
+# define BARF_IF_IS_NOT_AN_ARRAY(arr)						\
+	BUILD_ASSERT_OR_ZERO(!__builtin_types_compatible_p(typeof(arr), \
+							typeof(&(arr)[0])))
+# else
+#  define BARF_IF_IS_NOT_AN_ARRAY(arr) 0 
+# endif
+#endif 
+/*
+ * ARRAY_SIZE - get the number of elements in a visible array
+ *  <at> x: the array whose size you want.
+ *
+ * This does not work on pointers, or arrays declared as [], or
+ * function parameters.  With correct compiler support, such usage
+ * will cause a build error (see the build_assert_or_zero macro).
+ */
+#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]) + BARF_IF_IS_NOT_AN_ARRAY(x))
+
 #define bitsizeof(x)  (CHAR_BIT * sizeof(x))
 
 #define maximum_signed_value_of_type(a) \
-- 
2.1.0
