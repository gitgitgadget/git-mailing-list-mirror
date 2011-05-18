From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 00/11] writing out a huge blob to working tree
Date: Wed, 18 May 2011 04:17:33 -0400
Message-ID: <20110518081733.GF27482@sigill.intra.peff.net>
References: <1305505831-31587-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 18 10:17:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMbwr-000511-Tu
	for gcvg-git-2@lo.gmane.org; Wed, 18 May 2011 10:17:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755021Ab1ERIRg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2011 04:17:36 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:44628
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754865Ab1ERIRf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2011 04:17:35 -0400
Received: (qmail 3010 invoked by uid 107); 18 May 2011 08:19:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 18 May 2011 04:19:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 May 2011 04:17:33 -0400
Content-Disposition: inline
In-Reply-To: <1305505831-31587-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173857>

On Sun, May 15, 2011 at 05:30:20PM -0700, Junio C Hamano wrote:

> Recently "diff" learned to avoid reading the contents only to say "Binary
> files differ" when these large blobs are marked as binary.

With your series, we should be able to get similar speedups even if the
user didn't explicitly mark a file as binary. We need only peek at the
beginning of a blob to see if it is binary, so we can be conservative
with big files. Something like this (which doesn't work because of the
"size" bug I mentioned elsewhere, but is meant to be illustrative):

diff --git a/diff.c b/diff.c
index ba5f7aa..bfe1b2d 100644
--- a/diff.c
+++ b/diff.c
@@ -15,6 +15,7 @@
 #include "sigchain.h"
 #include "submodule.h"
 #include "ll-merge.h"
+#include "streaming.h"
 
 #ifdef NO_FAST_WORKING_DIRECTORY
 #define FAST_WORKING_DIRECTORY 0
@@ -1931,6 +1932,37 @@ static void diff_filespec_load_driver(struct diff_filespec *one)
 		one->driver = userdiff_find_by_name("default");
 }
 
+static char *populate_or_peek(struct diff_filespec *df,
+			      unsigned long want,
+			      unsigned long *got)
+{
+	struct git_istream *st;
+	enum object_type type;
+	char *buf;
+
+	st = open_istream(df->sha1, &type, &df->size);
+	if (!st) {
+		diff_populate_filespec(df, 0);
+		*got = df->size;
+		return df->data;
+	}
+
+	if (df->size < big_file_threshold) {
+		buf = df->data = xmallocz(df->size);
+		want = df->size;
+		df->should_free = 1;
+	}
+	else
+		buf = xmallocz(want);
+
+	/* looks like it will always read_in_full? */
+	if (read_istream(st, buf, want) != want)
+		die("failed to read object");
+	close_istream(st);
+	*got = want;
+	return buf;
+}
+
 int diff_filespec_is_binary(struct diff_filespec *one)
 {
 	if (one->is_binary == -1) {
@@ -1938,13 +1970,25 @@ int diff_filespec_is_binary(struct diff_filespec *one)
 		if (one->driver->binary != -1)
 			one->is_binary = one->driver->binary;
 		else {
-			if (!one->data && DIFF_FILE_VALID(one))
-				diff_populate_filespec(one, 0);
-			if (one->data)
-				one->is_binary = buffer_is_binary(one->data,
-						one->size);
+			char *buf;
+			unsigned long size;
+
+			if (one->data) {
+				buf = one->data;
+				size = one->size;
+			}
+			else if (DIFF_FILE_VALID(one))
+				buf = populate_or_peek(one, 8192, &size);
+			else
+				buf = NULL;
+
+			if (buf)
+				one->is_binary = buffer_is_binary(buf, size);
 			if (one->is_binary == -1)
 				one->is_binary = 0;
+
+			if (buf != one->data)
+				free(buf);
 		}
 	}
 	return one->is_binary;

I think a "peek" function like this would be a nice addition to the
streaming API. Something like:

  char *peek_sha1(const unsigned char sha1[20], /* which object */
                  enum object_type *type, /* out: type */
                  unsigned long want, /* how much do we need */
                  unsigned long big, /* if less than this, just give us
                                        everything in the name of
                                        efficiency */
                  unsigned long *got, /* out: how much did we peek */
                  unsigned long *size, /* out: how big is the whole thing */
                  );

but maybe diff is the only place where that is useful. I dunno.

-Peff
