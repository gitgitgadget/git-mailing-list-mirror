From: iler.ml@gmail.com
Subject: [PATCH] adding NO_INET_NTOP and compat/inet_ntop.c for systems without
 inet_ntop() (old Cygwin).
Date: Mon, 22 May 2006 00:37 +0300
Message-ID: <0IZM00JO4XE2JI20@mxout5.netvision.net.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Cc: iler.ml@gmail.com
X-From: git-owner@vger.kernel.org Sun May 21 23:37:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fhvc1-00069n-9O
	for gcvg-git@gmane.org; Sun, 21 May 2006 23:37:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964941AbWEUVhS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 May 2006 17:37:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964942AbWEUVhR
	(ORCPT <rfc822;git-outgoing>); Sun, 21 May 2006 17:37:17 -0400
Received: from mxout5.netvision.net.il ([194.90.9.29]:34283 "EHLO
	mxout5.netvision.net.il") by vger.kernel.org with ESMTP
	id S964941AbWEUVhQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 May 2006 17:37:16 -0400
Received: from main ([85.250.144.108]) by mxout5.netvision.net.il
 (Sun Java System Messaging Server 6.2-4.03 (built Sep 22 2005))
 with ESMTPA id <0IZM00JO3XE1JI20@mxout5.netvision.net.il> for
 git@vger.kernel.org; Mon, 22 May 2006 00:37:15 +0300 (IDT)
To: git@vger.kernel.org
X-Mailer: Mail::SendEasy/1.2 Perl/5.008005-cygwin
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20463>

For systems which lack inet_ntop(), this adds compat/inet_ntop.c,
and related build constant, NO_INET_NTOP. Older Cygwin(s) lack 
inet_ntop().

Signed-off-by: Yakov Lerner <iler.ml@gmail.com>

---

 Makefile           |    3 +
 compat/inet_ntop.c |  200 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 203 insertions(+), 0 deletions(-)
 create mode 100644 compat/inet_ntop.c

7cd8cb466db39e9253d77db1f07f49bce6901731
diff --git a/Makefile b/Makefile
index 8ce27a6..fffb4ab 100644
--- a/Makefile
+++ b/Makefile
@@ -412,6 +412,9 @@ else
 	ALL_CFLAGS += -Dsockaddr_storage=sockaddr_in6
 endif
 endif
+ifdef NO_INET_NTOP
+	LIB_OBJS += compat/inet_ntop.o
+endif
 
 ifdef NO_ICONV
 	ALL_CFLAGS += -DNO_ICONV
diff --git a/compat/inet_ntop.c b/compat/inet_ntop.c
new file mode 100644
index 0000000..ec8c1bf
--- /dev/null
+++ b/compat/inet_ntop.c
@@ -0,0 +1,200 @@
+/*
+ * Copyright (c) 1996-1999 by Internet Software Consortium.
+ *
+ * Permission to use, copy, modify, and distribute this software for any
+ * purpose with or without fee is hereby granted, provided that the above
+ * copyright notice and this permission notice appear in all copies.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS" AND INTERNET SOFTWARE CONSORTIUM DISCLAIMS
+ * ALL WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES
+ * OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL INTERNET SOFTWARE
+ * CONSORTIUM BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL
+ * DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR
+ * PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS
+ * ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS
+ * SOFTWARE.
+ */
+
+#include <errno.h>
+#include <sys/types.h>
+#include <sys/socket.h>
+#include <sys/socket.h>
+#include <netinet/in.h>
+#include <arpa/inet.h>
+#include <stdio.h>
+#include <string.h>
+
+#ifndef NS_INADDRSZ
+#define NS_INADDRSZ	4
+#endif
+#ifndef NS_IN6ADDRSZ
+#define NS_IN6ADDRSZ	16
+#endif
+#ifndef NS_INT16SZ
+#define NS_INT16SZ	2
+#endif
+
+/*
+ * WARNING: Don't even consider trying to compile this on a system where
+ * sizeof(int) < 4.  sizeof(int) > 4 is fine; all the world's not a VAX.
+ */
+
+/* const char *
+ * inet_ntop4(src, dst, size)
+ *	format an IPv4 address
+ * return:
+ *	`dst' (as a const)
+ * notes:
+ *	(1) uses no statics
+ *	(2) takes a u_char* not an in_addr as input
+ * author:
+ *	Paul Vixie, 1996.
+ */
+static const char *
+inet_ntop4(src, dst, size)
+	const u_char *src;
+	char *dst;
+	size_t size;
+{
+	static const char fmt[] = "%u.%u.%u.%u";
+	char tmp[sizeof "255.255.255.255"];
+	int nprinted;
+
+	nprinted = snprintf(tmp, sizeof(tmp), fmt, src[0], src[1], src[2], src[3]);
+	if (nprinted < 0)
+		return (NULL);	/* we assume "errno" was set by "snprintf()" */
+	if ((size_t)nprinted > size) {
+		errno = ENOSPC;
+		return (NULL);
+	}
+	strcpy(dst, tmp);
+	return (dst);
+}
+
+#ifndef NO_IPV6
+/* const char *
+ * inet_ntop6(src, dst, size)
+ *	convert IPv6 binary address into presentation (printable) format
+ * author:
+ *	Paul Vixie, 1996.
+ */
+static const char *
+inet_ntop6(src, dst, size)
+	const u_char *src;
+	char *dst;
+	size_t size;
+{
+	/*
+	 * Note that int32_t and int16_t need only be "at least" large enough
+	 * to contain a value of the specified size.  On some systems, like
+	 * Crays, there is no such thing as an integer variable with 16 bits.
+	 * Keep this in mind if you think this function should have been coded
+	 * to use pointer overlays.  All the world's not a VAX.
+	 */
+	char tmp[sizeof "ffff:ffff:ffff:ffff:ffff:ffff:255.255.255.255"], *tp;
+	struct { int base, len; } best, cur;
+	u_int words[NS_IN6ADDRSZ / NS_INT16SZ];
+	int i;
+
+	/*
+	 * Preprocess:
+	 *	Copy the input (bytewise) array into a wordwise array.
+	 *	Find the longest run of 0x00's in src[] for :: shorthanding.
+	 */
+	memset(words, '\0', sizeof words);
+	for (i = 0; i < NS_IN6ADDRSZ; i++)
+		words[i / 2] |= (src[i] << ((1 - (i % 2)) << 3));
+	best.base = -1;
+	cur.base = -1;
+	for (i = 0; i < (NS_IN6ADDRSZ / NS_INT16SZ); i++) {
+		if (words[i] == 0) {
+			if (cur.base == -1)
+				cur.base = i, cur.len = 1;
+			else
+				cur.len++;
+		} else {
+			if (cur.base != -1) {
+				if (best.base == -1 || cur.len > best.len)
+					best = cur;
+				cur.base = -1;
+			}
+		}
+	}
+	if (cur.base != -1) {
+		if (best.base == -1 || cur.len > best.len)
+			best = cur;
+	}
+	if (best.base != -1 && best.len < 2)
+		best.base = -1;
+
+	/*
+	 * Format the result.
+	 */
+	tp = tmp;
+	for (i = 0; i < (NS_IN6ADDRSZ / NS_INT16SZ); i++) {
+		/* Are we inside the best run of 0x00's? */
+		if (best.base != -1 && i >= best.base &&
+		    i < (best.base + best.len)) {
+			if (i == best.base)
+				*tp++ = ':';
+			continue;
+		}
+		/* Are we following an initial run of 0x00s or any real hex? */
+		if (i != 0)
+			*tp++ = ':';
+		/* Is this address an encapsulated IPv4? */
+		if (i == 6 && best.base == 0 &&
+		    (best.len == 6 || (best.len == 5 && words[5] == 0xffff))) {
+			if (!inet_ntop4(src+12, tp, sizeof tmp - (tp - tmp)))
+				return (NULL);
+			tp += strlen(tp);
+			break;
+		}
+		tp += snprintf(tp, sizeof tmp - (tp - tmp), "%x", words[i]);
+	}
+	/* Was it a trailing run of 0x00's? */
+	if (best.base != -1 && (best.base + best.len) ==
+	    (NS_IN6ADDRSZ / NS_INT16SZ))
+		*tp++ = ':';
+	*tp++ = '\0';
+
+	/*
+	 * Check for overflow, copy, and we're done.
+	 */
+	if ((size_t)(tp - tmp) > size) {
+		errno = ENOSPC;
+		return (NULL);
+	}
+	strcpy(dst, tmp);
+	return (dst);
+}
+#endif
+
+/* char *
+ * inet_ntop(af, src, dst, size)
+ *	convert a network format address to presentation format.
+ * return:
+ *	pointer to presentation format address (`dst'), or NULL (see errno).
+ * author:
+ *	Paul Vixie, 1996.
+ */
+const char *
+inet_ntop(af, src, dst, size)
+	int af;
+	const void *src;
+	char *dst;
+	size_t size;
+{
+	switch (af) {
+	case AF_INET:
+		return (inet_ntop4(src, dst, size));
+#ifndef NO_IPV6
+	case AF_INET6:
+		return (inet_ntop6(src, dst, size));
+#endif
+	default:
+		errno = EAFNOSUPPORT;
+		return (NULL);
+	}
+	/* NOTREACHED */
+}
-- 
1.3.GIT
