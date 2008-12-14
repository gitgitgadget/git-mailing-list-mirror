From: YONETANI Tomokazu <qhwt+git@les.ath.cx>
Subject: [PATCH] git-fast-import possible memory corruption problem
Date: Sun, 14 Dec 2008 11:08:22 +0900
Message-ID: <20081214020822.GB4121@les.ath.cx>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="vGgW1X5XWziG23Ko"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 14 03:20:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBgaw-0004su-55
	for gcvg-git-2@gmane.org; Sun, 14 Dec 2008 03:20:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752318AbYLNCTK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Dec 2008 21:19:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752229AbYLNCTJ
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Dec 2008 21:19:09 -0500
Received: from x219233.ppp.asahi-net.or.jp ([122.249.219.233]:3762 "EHLO
	les.ath.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751932AbYLNCTI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Dec 2008 21:19:08 -0500
X-Greylist: delayed 641 seconds by postgrey-1.27 at vger.kernel.org; Sat, 13 Dec 2008 21:19:08 EST
Received: by les.ath.cx (Postfix, from userid 1000)
	id 24CAC86653; Sun, 14 Dec 2008 11:08:23 +0900 (JST)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103043>


--vGgW1X5XWziG23Ko
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello.
While trying to convert NetBSD CVS repository to Git, I've been
experiencing 100% reproducible crash of git-fast-import.  After
poking here and there and I noticed a dubious code fragment in
pool_alloc():
	:

        r = p->next_free;
        /* round out to a 'uintmax_t' alignment */
        if (len & (sizeof(uintmax_t) - 1))
                len += sizeof(uintmax_t) - (len & (sizeof(uintmax_t) - 1));
        p->next_free += len;
        return r;

As the `round out' takes place AFTER it found the room in the mem_pool,
there's a small chance of p->next_free being set outside of the chosen
area, up to (sizeof(uintmax_t) - 1) bytes.  pool_strdup() is one of the
functions which can trigger the problem, when pool_alloc() finds a room
at the end of a pool entry and the requested length is not multiple of
size(uintmax_t).  I believe attached patch addresses this problem.

Best regards,
YONETANI Tomokazu.

--vGgW1X5XWziG23Ko
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="git-fast-import.patch"

diff --git a/fast-import.c b/fast-import.c
index 3c035a5..fb4367a 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -549,11 +549,15 @@ static unsigned int hc_str(const char *s, size_t len)
 	return r;
 }
 
-static void *pool_alloc(size_t len)
+static void *_pool_alloc(size_t len, int zero)
 {
 	struct mem_pool *p;
 	void *r;
 
+	/* round out to a 'uintmax_t' alignment */
+	if (len & (sizeof(uintmax_t) - 1))
+		len += sizeof(uintmax_t) - (len & (sizeof(uintmax_t) - 1));
+
 	for (p = mem_pool; p; p = p->next_pool)
 		if ((p->end - p->next_free >= len))
 			break;
@@ -561,7 +565,8 @@ static void *pool_alloc(size_t len)
 	if (!p) {
 		if (len >= (mem_pool_alloc/2)) {
 			total_allocd += len;
-			return xmalloc(len);
+			r = xmalloc(len);
+			goto out;
 		}
 		total_allocd += sizeof(struct mem_pool) + mem_pool_alloc;
 		p = xmalloc(sizeof(struct mem_pool) + mem_pool_alloc);
@@ -572,19 +577,22 @@ static void *pool_alloc(size_t len)
 	}
 
 	r = p->next_free;
-	/* round out to a 'uintmax_t' alignment */
-	if (len & (sizeof(uintmax_t) - 1))
-		len += sizeof(uintmax_t) - (len & (sizeof(uintmax_t) - 1));
 	p->next_free += len;
+out:
+	if (zero)
+		memset(r, 0, len);
 	return r;
 }
 
+static void *pool_alloc(size_t len)
+{
+	return _pool_alloc(len, 0);
+}
+
 static void *pool_calloc(size_t count, size_t size)
 {
 	size_t len = count * size;
-	void *r = pool_alloc(len);
-	memset(r, 0, len);
-	return r;
+	return _pool_alloc(len, 1);
 }
 
 static char *pool_strdup(const char *s)

--vGgW1X5XWziG23Ko--
