From: Jeff King <peff@peff.net>
Subject: [PATCH v3 10/19] pkt-line: drop safe_write function
Date: Wed, 20 Feb 2013 15:01:56 -0500
Message-ID: <20130220200156.GJ25647@sigill.intra.peff.net>
References: <20130220195147.GA25332@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 20 21:02:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8Fs1-0004bE-9z
	for gcvg-git-2@plane.gmane.org; Wed, 20 Feb 2013 21:02:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935116Ab3BTUB7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2013 15:01:59 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:54598 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935049Ab3BTUB7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2013 15:01:59 -0500
Received: (qmail 17753 invoked by uid 107); 20 Feb 2013 20:03:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 20 Feb 2013 15:03:30 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Feb 2013 15:01:56 -0500
Content-Disposition: inline
In-Reply-To: <20130220195147.GA25332@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216724>

This is just write_or_die by another name. The one
distinction is that write_or_die will treat EPIPE specially
by suppressing error messages. That's fine, as we die by
SIGPIPE anyway (and in the off chance that it is disabled,
write_or_die will simulate it).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/receive-pack.c |  2 +-
 builtin/send-pack.c    |  2 +-
 fetch-pack.c           |  2 +-
 http-backend.c         |  8 ++++----
 pkt-line.c             | 21 ++-------------------
 pkt-line.h             |  1 -
 remote-curl.c          |  4 ++--
 send-pack.c            |  2 +-
 sideband.c             |  9 +++++----
 upload-pack.c          |  3 ++-
 10 files changed, 19 insertions(+), 35 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 62ba6e7..9129563 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -932,7 +932,7 @@ static void report(struct command *commands, const char *unpack_status)
 	if (use_sideband)
 		send_sideband(1, 1, buf.buf, buf.len, use_sideband);
 	else
-		safe_write(1, buf.buf, buf.len);
+		write_or_die(1, buf.buf, buf.len);
 	strbuf_release(&buf);
 }
 
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 57a46b2..8778519 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -79,7 +79,7 @@ static void print_helper_status(struct ref *ref)
 		}
 		strbuf_addch(&buf, '\n');
 
-		safe_write(1, buf.buf, buf.len);
+		write_or_die(1, buf.buf, buf.len);
 	}
 	strbuf_release(&buf);
 }
diff --git a/fetch-pack.c b/fetch-pack.c
index 27a3e80..b53a18f 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -247,7 +247,7 @@ static void send_request(struct fetch_pack_args *args,
 		send_sideband(fd, -1, buf->buf, buf->len, LARGE_PACKET_MAX);
 		packet_flush(fd);
 	} else
-		safe_write(fd, buf->buf, buf->len);
+		write_or_die(fd, buf->buf, buf->len);
 }
 
 static void insert_one_alternate_ref(const struct ref *ref, void *unused)
diff --git a/http-backend.c b/http-backend.c
index f50e77f..8144f3a 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -70,7 +70,7 @@ static void format_write(int fd, const char *fmt, ...)
 	if (n >= sizeof(buffer))
 		die("protocol error: impossibly long line");
 
-	safe_write(fd, buffer, n);
+	write_or_die(fd, buffer, n);
 }
 
 static void http_status(unsigned code, const char *msg)
@@ -111,7 +111,7 @@ static void end_headers(void)
 
 static void end_headers(void)
 {
-	safe_write(1, "\r\n", 2);
+	write_or_die(1, "\r\n", 2);
 }
 
 __attribute__((format (printf, 1, 2)))
@@ -157,7 +157,7 @@ static void send_strbuf(const char *type, struct strbuf *buf)
 	hdr_int(content_length, buf->len);
 	hdr_str(content_type, type);
 	end_headers();
-	safe_write(1, buf->buf, buf->len);
+	write_or_die(1, buf->buf, buf->len);
 }
 
 static void send_local_file(const char *the_type, const char *name)
@@ -185,7 +185,7 @@ static void send_local_file(const char *the_type, const char *name)
 			die_errno("Cannot read '%s'", p);
 		if (!n)
 			break;
-		safe_write(1, buf, n);
+		write_or_die(1, buf, n);
 	}
 	close(fd);
 	free(buf);
diff --git a/pkt-line.c b/pkt-line.c
index 5138f47..699c2dd 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -46,23 +46,6 @@ static void packet_trace(const char *buf, unsigned int len, int write)
 	strbuf_release(&out);
 }
 
-ssize_t safe_write(int fd, const void *buf, ssize_t n)
-{
-	ssize_t nn = n;
-	while (n) {
-		int ret = xwrite(fd, buf, n);
-		if (ret > 0) {
-			buf = (char *) buf + ret;
-			n -= ret;
-			continue;
-		}
-		if (!ret)
-			die("write error (disk full?)");
-		die_errno("write error");
-	}
-	return nn;
-}
-
 /*
  * If we buffered things up above (we don't, but we should),
  * we'd flush it here
@@ -70,7 +53,7 @@ void packet_flush(int fd)
 void packet_flush(int fd)
 {
 	packet_trace("0000", 4, 1);
-	safe_write(fd, "0000", 4);
+	write_or_die(fd, "0000", 4);
 }
 
 void packet_buf_flush(struct strbuf *buf)
@@ -106,7 +89,7 @@ void packet_write(int fd, const char *fmt, ...)
 	va_start(args, fmt);
 	n = format_packet(fmt, args);
 	va_end(args);
-	safe_write(fd, buffer, n);
+	write_or_die(fd, buffer, n);
 }
 
 void packet_buf_write(struct strbuf *buf, const char *fmt, ...)
diff --git a/pkt-line.h b/pkt-line.h
index 7a67e9c..3b6c19c 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -27,6 +27,5 @@ int packet_get_line(struct strbuf *out, char **src_buf, size_t *src_len);
 int packet_read_line(int fd, char *buffer, unsigned size);
 int packet_read(int fd, char *buffer, unsigned size);
 int packet_get_line(struct strbuf *out, char **src_buf, size_t *src_len);
-ssize_t safe_write(int, const void *, ssize_t);
 
 #endif
diff --git a/remote-curl.c b/remote-curl.c
index 933c69a..7be4b53 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -685,7 +685,7 @@ static int fetch_git(struct discovery *heads,
 
 	err = rpc_service(&rpc, heads);
 	if (rpc.result.len)
-		safe_write(1, rpc.result.buf, rpc.result.len);
+		write_or_die(1, rpc.result.buf, rpc.result.len);
 	strbuf_release(&rpc.result);
 	strbuf_release(&preamble);
 	free(depth_arg);
@@ -805,7 +805,7 @@ static int push_git(struct discovery *heads, int nr_spec, char **specs)
 
 	err = rpc_service(&rpc, heads);
 	if (rpc.result.len)
-		safe_write(1, rpc.result.buf, rpc.result.len);
+		write_or_die(1, rpc.result.buf, rpc.result.len);
 	strbuf_release(&rpc.result);
 	free(argv);
 	return err;
diff --git a/send-pack.c b/send-pack.c
index e91cbe2..bde796b 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -280,7 +280,7 @@ int send_pack(struct send_pack_args *args,
 			send_sideband(out, -1, req_buf.buf, req_buf.len, LARGE_PACKET_MAX);
 		}
 	} else {
-		safe_write(out, req_buf.buf, req_buf.len);
+		write_or_die(out, req_buf.buf, req_buf.len);
 		packet_flush(out);
 	}
 	strbuf_release(&req_buf);
diff --git a/sideband.c b/sideband.c
index d5ffa1c..8f7b25b 100644
--- a/sideband.c
+++ b/sideband.c
@@ -1,3 +1,4 @@
+#include "cache.h"
 #include "pkt-line.h"
 #include "sideband.h"
 
@@ -108,7 +109,7 @@ int recv_sideband(const char *me, int in_stream, int out)
 			} while (len);
 			continue;
 		case 1:
-			safe_write(out, buf + pf+1, len);
+			write_or_die(out, buf + pf+1, len);
 			continue;
 		default:
 			fprintf(stderr, "%s: protocol error: bad band #%d\n",
@@ -138,12 +139,12 @@ ssize_t send_sideband(int fd, int band, const char *data, ssize_t sz, int packet
 		if (0 <= band) {
 			sprintf(hdr, "%04x", n + 5);
 			hdr[4] = band;
-			safe_write(fd, hdr, 5);
+			write_or_die(fd, hdr, 5);
 		} else {
 			sprintf(hdr, "%04x", n + 4);
-			safe_write(fd, hdr, 4);
+			write_or_die(fd, hdr, 4);
 		}
-		safe_write(fd, p, n);
+		write_or_die(fd, p, n);
 		p += n;
 		sz -= n;
 	}
diff --git a/upload-pack.c b/upload-pack.c
index 63cea91..c2b2c61 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -69,7 +69,8 @@ static ssize_t send_client_data(int fd, const char *data, ssize_t sz)
 		xwrite(fd, data, sz);
 		return sz;
 	}
-	return safe_write(fd, data, sz);
+	write_or_die(fd, data, sz);
+	return sz;
 }
 
 static FILE *pack_pipe = NULL;
-- 
1.8.2.rc0.9.g352092c
