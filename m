From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 5/6] zlib: wrap deflateBound() too
Date: Fri, 10 Jun 2011 13:15:47 -0700
Message-ID: <1307736948-16956-6-git-send-email-gitster@pobox.com>
References: <1307736948-16956-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 10 22:16:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QV87p-00068o-IR
	for gcvg-git-2@lo.gmane.org; Fri, 10 Jun 2011 22:16:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932145Ab1FJUQH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2011 16:16:07 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:45238 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758120Ab1FJUQE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2011 16:16:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8884E4265
	for <git@vger.kernel.org>; Fri, 10 Jun 2011 16:18:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=xzx1
	56f5PSkBX+lH+dGr0fsFhN4=; b=tSWpnk7Ut8SUDFU7PW45CdjjpEVp0bsV7Y+j
	LoTtIuYHY9EYDWqYiaXyJMgLKDDWY+ZAetFh1E7SFSRMStJLmpiZg0nfi8siCrqR
	nvHZfwal9kbPdoa5YpYwIRGO9WblTZNVcKU7bJqse0OpaxXhmjo+RBihadQCz0p2
	1aezzS0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=DJYETU
	TyHcZnaB7o3kr+tIZRPdZE8MkT8T51FOA+NlJAIVklVMSZYubrE6pQ74bkZZCDoQ
	/+Med6TgPySgEZ3YFG9qGAoT9jZ/j425q96CTtY0VJQFLlO8kUzkyBeB1bLXa7WR
	9jK++pE7gmKkUJbwCg3+ET99+uaG6o/lL7Axg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7A7714264
	for <git@vger.kernel.org>; Fri, 10 Jun 2011 16:18:12 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 65F5A425B for
 <git@vger.kernel.org>; Fri, 10 Jun 2011 16:18:11 -0400 (EDT)
X-Mailer: git-send-email 1.7.6.rc1.118.ge175b4a
In-Reply-To: <1307736948-16956-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: C404F49C-939E-11E0-A88D-C8CFB7AE1C3C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175621>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 archive-zip.c          |    2 +-
 builtin/pack-objects.c |    2 +-
 cache.h                |    4 +---
 diff.c                 |    2 +-
 fast-import.c          |    4 ++--
 http-push.c            |    2 +-
 remote-curl.c          |    2 +-
 zlib.c                 |    9 +++++++++
 8 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/archive-zip.c b/archive-zip.c
index 081ff83..8fbac27 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -97,7 +97,7 @@ static void *zlib_deflate(void *data, unsigned long size,
 
 	memset(&stream, 0, sizeof(stream));
 	git_deflate_init(&stream, compression_level);
-	maxsize = deflateBound(&stream, size);
+	maxsize = git_deflate_bound(&stream, size);
 	buffer = xmalloc(maxsize);
 
 	stream.next_in = data;
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 61f9755..8981dd6 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -132,7 +132,7 @@ static unsigned long do_compress(void **pptr, unsigned long size)
 
 	memset(&stream, 0, sizeof(stream));
 	git_deflate_init(&stream, pack_compression_level);
-	maxsize = deflateBound(&stream, size);
+	maxsize = git_deflate_bound(&stream, size);
 
 	in = *pptr;
 	out = xmalloc(maxsize);
diff --git a/cache.h b/cache.h
index 5eb61ac..85ac5ec 100644
--- a/cache.h
+++ b/cache.h
@@ -16,9 +16,6 @@
 #endif
 
 #include <zlib.h>
-#if defined(NO_DEFLATE_BOUND) || ZLIB_VERNUM < 0x1200
-#define deflateBound(c,s)  ((s) + (((s) + 7) >> 3) + (((s) + 63) >> 6) + 11)
-#endif
 
 void git_inflate_init(z_streamp strm);
 void git_inflate_init_gzip_only(z_streamp strm);
@@ -30,6 +27,7 @@ void git_deflate_init_gzip(z_streamp strm, int level);
 void git_deflate_end(z_streamp strm);
 int git_deflate_end_gently(z_streamp strm);
 int git_deflate(z_streamp strm, int flush);
+unsigned long git_deflate_bound(z_streamp, unsigned long);
 
 #if defined(DT_UNKNOWN) && !defined(NO_D_TYPE_IN_DIRENT)
 #define DTYPE(de)	((de)->d_type)
diff --git a/diff.c b/diff.c
index c15c70f..bac9a4b 100644
--- a/diff.c
+++ b/diff.c
@@ -1733,7 +1733,7 @@ static unsigned char *deflate_it(char *data,
 
 	memset(&stream, 0, sizeof(stream));
 	git_deflate_init(&stream, zlib_compression_level);
-	bound = deflateBound(&stream, size);
+	bound = git_deflate_bound(&stream, size);
 	deflated = xmalloc(bound);
 	stream.next_out = deflated;
 	stream.avail_out = bound;
diff --git a/fast-import.c b/fast-import.c
index 42979e6..e4116a4 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1058,7 +1058,7 @@ static int store_object(
 		s.next_in = (void *)dat->buf;
 		s.avail_in = dat->len;
 	}
-	s.avail_out = deflateBound(&s, s.avail_in);
+	s.avail_out = git_deflate_bound(&s, s.avail_in);
 	s.next_out = out = xmalloc(s.avail_out);
 	while (git_deflate(&s, Z_FINISH) == Z_OK)
 		; /* nothing */
@@ -1081,7 +1081,7 @@ static int store_object(
 			git_deflate_init(&s, pack_compression_level);
 			s.next_in = (void *)dat->buf;
 			s.avail_in = dat->len;
-			s.avail_out = deflateBound(&s, s.avail_in);
+			s.avail_out = git_deflate_bound(&s, s.avail_in);
 			s.next_out = out = xrealloc(out, s.avail_out);
 			while (git_deflate(&s, Z_FINISH) == Z_OK)
 				; /* nothing */
diff --git a/http-push.c b/http-push.c
index 46e68c8..ecd67cf 100644
--- a/http-push.c
+++ b/http-push.c
@@ -360,7 +360,7 @@ static void start_put(struct transfer_request *request)
 	/* Set it up */
 	memset(&stream, 0, sizeof(stream));
 	git_deflate_init(&stream, zlib_compression_level);
-	size = deflateBound(&stream, len + hdrlen);
+	size = git_deflate_bound(&stream, len + hdrlen);
 	strbuf_init(&request->buffer.buf, size);
 	request->buffer.posn = 0;
 
diff --git a/remote-curl.c b/remote-curl.c
index 3c7621a..13d8cee 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -476,7 +476,7 @@ static int post_rpc(struct rpc_state *rpc)
 
 		memset(&stream, 0, sizeof(stream));
 		git_deflate_init_gzip(&stream, Z_BEST_COMPRESSION);
-		size = deflateBound(&stream, rpc->len);
+		size = git_deflate_bound(&stream, rpc->len);
 		gzip_body = xmalloc(size);
 
 		stream.next_in = (unsigned char *)rpc->buf;
diff --git a/zlib.c b/zlib.c
index ee47a3a..8f19d2f 100644
--- a/zlib.c
+++ b/zlib.c
@@ -78,6 +78,15 @@ int git_inflate(z_streamp strm, int flush)
 	return status;
 }
 
+#if defined(NO_DEFLATE_BOUND) || ZLIB_VERNUM < 0x1200
+#define deflateBound(c,s)  ((s) + (((s) + 7) >> 3) + (((s) + 63) >> 6) + 11)
+#endif
+
+unsigned long git_deflate_bound(z_streamp strm, unsigned long size)
+{
+	return deflateBound(strm, size);
+}
+
 void git_deflate_init(z_streamp strm, int level)
 {
 	int status = deflateInit(strm, level);
-- 
1.7.6.rc1.118.ge175b4a
