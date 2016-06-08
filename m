From: Jeff King <peff@peff.net>
Subject: [PATCH] send-pack: use buffered I/O to talk to pack-objects
Date: Wed, 8 Jun 2016 15:42:16 -0400
Message-ID: <20160608194216.GA3731@sigill.intra.peff.net>
References: <20160606151340.22424-1-william.duclot@ensimag.grenoble-inp.fr>
 <20160606151340.22424-4-william.duclot@ensimag.grenoble-inp.fr>
 <xmqqvb1mxmk4.fsf@gitster.mtv.corp.google.com>
 <20160606203901.GA7667@Messiaen>
 <xmqqfusquedk.fsf@gitster.mtv.corp.google.com>
 <20160606225847.GA22756@sigill.intra.peff.net>
 <xmqqbn3dvr22.fsf@gitster.mtv.corp.google.com>
 <20160607090653.GA4665@Messiaen>
 <575845D9.2010604@alum.mit.edu>
 <20160608191918.GB19572@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: William Duclot <william.duclot@ensimag.grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	antoine.queru@ensimag.grenoble-inp.fr,
	francois.beutin@ensimag.grenoble-inp.fr,
	Johannes.Schindelin@gmx.de, mh@glandium.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Jun 08 21:42:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAjMy-0001WT-Q9
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jun 2016 21:42:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423466AbcFHTmX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2016 15:42:23 -0400
Received: from cloud.peff.net ([50.56.180.127]:51509 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753503AbcFHTmV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2016 15:42:21 -0400
Received: (qmail 888 invoked by uid 102); 8 Jun 2016 19:42:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 08 Jun 2016 15:42:19 -0400
Received: (qmail 12115 invoked by uid 107); 8 Jun 2016 19:42:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 08 Jun 2016 15:42:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Jun 2016 15:42:16 -0400
Content-Disposition: inline
In-Reply-To: <20160608191918.GB19572@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296845>

On Wed, Jun 08, 2016 at 03:19:18PM -0400, Jeff King wrote:

> That made me wonder if we could repeatedly reuse a buffer attached to
> the file descriptor. And indeed, isn't that what stdio is? The whole
> reason this buffer exists is because we are using a direct descriptor
> write. If we switched this function to use fprintf(), we'd avoid the
> whole buffer question, have a fixed cap on our memory use (since we just
> flush anytime the buffer is full) _and_ we'd reduce the number of
> write syscalls we're making by almost a factor of 100.

So all of this strbuf discussion aside, I think it is worth doing
something like this for this particular case.

-- >8 --
Subject: send-pack: use buffered I/O to talk to pack-objects

We start a pack-objects process and then write all of the
positive and negative sha1s to it over a pipe. We do so by
formatting each item into a fixed-size buffer and then
writing each individually. This has two drawbacks:

  1. There's some manual computation of the buffer size,
     which is not immediately obvious is correct (though it
     is).

  2. We write() once per sha1, which means a lot more system
     calls than are necessary.

We can solve both by wrapping the pipe descriptor in a stdio
handle; this is the same technique used by upload-pack when
serving fetches.

Note that we can also simplify and improve the error
handling here. The original detected a single write error
and broke out of the loop (presumably to avoid writing the
error message over and over), but never actually acted on
seeing an error; we just fed truncated input and took
whatever pack-objects returned.

In practice, this probably didn't matter, as the likely
errors would be caused by pack-objects dying (and we'd
probably just die with SIGPIPE anyway). But we can easily
make this simpler and more robust; the stdio handle keeps an
error flag, which we can check at the end.

Signed-off-by: Jeff King <peff@peff.net>
---
 send-pack.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/send-pack.c b/send-pack.c
index 37ee04e..299d303 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -36,18 +36,15 @@ int option_parse_push_signed(const struct option *opt,
 	die("bad %s argument: %s", opt->long_name, arg);
 }
 
-static int feed_object(const unsigned char *sha1, int fd, int negative)
+static void feed_object(const unsigned char *sha1, FILE *fh, int negative)
 {
-	char buf[42];
-
 	if (negative && !has_sha1_file(sha1))
-		return 1;
+		return;
 
-	memcpy(buf + negative, sha1_to_hex(sha1), 40);
 	if (negative)
-		buf[0] = '^';
-	buf[40 + negative] = '\n';
-	return write_or_whine(fd, buf, 41 + negative, "send-pack: send refs");
+		putc('^', fh);
+	fputs(sha1_to_hex(sha1), fh);
+	putc('\n', fh);
 }
 
 /*
@@ -73,6 +70,7 @@ static int pack_objects(int fd, struct ref *refs, struct sha1_array *extra, stru
 		NULL,
 	};
 	struct child_process po = CHILD_PROCESS_INIT;
+	FILE *po_in;
 	int i;
 
 	i = 4;
@@ -97,21 +95,22 @@ static int pack_objects(int fd, struct ref *refs, struct sha1_array *extra, stru
 	 * We feed the pack-objects we just spawned with revision
 	 * parameters by writing to the pipe.
 	 */
+	po_in = xfdopen(po.in, "w");
 	for (i = 0; i < extra->nr; i++)
-		if (!feed_object(extra->sha1[i], po.in, 1))
-			break;
+		feed_object(extra->sha1[i], po_in, 1);
 
 	while (refs) {
-		if (!is_null_oid(&refs->old_oid) &&
-		    !feed_object(refs->old_oid.hash, po.in, 1))
-			break;
-		if (!is_null_oid(&refs->new_oid) &&
-		    !feed_object(refs->new_oid.hash, po.in, 0))
-			break;
+		if (!is_null_oid(&refs->old_oid))
+			feed_object(refs->old_oid.hash, po_in, 1);
+		if (!is_null_oid(&refs->new_oid))
+			feed_object(refs->new_oid.hash, po_in, 0);
 		refs = refs->next;
 	}
 
-	close(po.in);
+	fflush(po_in);
+	if (ferror(po_in))
+		die_errno("error writing to pack-objects");
+	fclose(po_in);
 
 	if (args->stateless_rpc) {
 		char *buf = xmalloc(LARGE_PACKET_MAX);
-- 
2.9.0.rc2.138.geb72a36
