From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] drop support for "experimental" loose objects
Date: Mon, 25 Nov 2013 10:35:19 -0800
Message-ID: <xmqq7gbwz5w8.fsf@gitster.dls.corp.google.com>
References: <20131120203350.GA31139@kitenet.net>
	<20131120213348.GA29004@sigill.intra.peff.net>
	<20131120222805.GC26468@kitenet.net>
	<20131121114157.GA7171@sigill.intra.peff.net>
	<20131121160426.GA21843@kitenet.net>
	<20131122020911.GA12042@sigill.intra.peff.net>
	<20131122172859.GA703@kitenet.net>
	<20131124084444.GA23238@sigill.intra.peff.net>
	<20131124090743.GA495@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Joey Hess <joey@kitenet.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Nov 25 19:35:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vl10L-0008FQ-LU
	for gcvg-git-2@plane.gmane.org; Mon, 25 Nov 2013 19:35:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756993Ab3KYSfZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Nov 2013 13:35:25 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37437 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756840Ab3KYSfY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Nov 2013 13:35:24 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 725E853F19;
	Mon, 25 Nov 2013 13:35:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yM1WH0mOFLd9eDt2Gf/bLGk7rbA=; b=f0sR84
	27MCsMlj1DgAo9yGZPTbuGjiXNbNKoHDcvv+QhjehNB/E+FQ49zMnFotE6hXEpm5
	yyOGjPdJBao6Rqa7vCTFjmhgytQLzsmTavpV23pBnOQOpruNTer1ii1sjQe4pjzV
	ssPKqAIh9AkNN8a2CiLgdu9PrdHckSpTRjY0k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nggFoqdLSebtQdjIz4XpgWPFdRz0h9i+
	DseG6eKJR8ypk+VQd5IMxC4Wg87qJK0sWRm+xWRu68PZ/gTvPX0cPKmez/9CV1Sp
	G80VJHkgiOFmFjrkhkruYfPHXV1xHkl6zyn77zQCyRN+eQLQynt95pfiRJ/SxTwv
	ZGTQ67WMRh8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 44FE553F18;
	Mon, 25 Nov 2013 13:35:23 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7E27253F15;
	Mon, 25 Nov 2013 13:35:22 -0500 (EST)
In-Reply-To: <20131124090743.GA495@sigill.intra.peff.net> (Jeff King's message
	of "Sun, 24 Nov 2013 04:07:43 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 57DBBCFC-5600-11E3-955F-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238328>

Jeff King <peff@peff.net> writes:

> On Sun, Nov 24, 2013 at 03:44:44AM -0500, Jeff King wrote:
>
>> In any code path where we call parse_object, we double-check that the
>> result matches the sha1 we asked for. But low-level commands like
>> cat-file just call read_sha1_file directly, and do not have such a
>> check. We could add it, but I suspect the processing cost would be
>> noticeable.
>
> Curious, I tested this. It is noticeable. Here's the best-of-five
> timings for the patch below when running a --batch cat-file on every
> object in my git.git repo, using the patch below:
>
>   [before]
>   real    0m12.941s
>   user    0m12.700s
>   sys     0m0.244s
>
>   [after]
>   real    0m15.800s
>   user    0m15.472s
>   sys     0m0.344s
>
> So it's about 20% slower. I don't know what the right tradeoff is. It's
> cool to check the data each time we look at it, but it does carry a
> performance penalty.

> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index b2ca775..2b09773 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -199,6 +199,8 @@ static void print_object_or_die(int fd, const unsigned char *sha1,
>  	if (type == OBJ_BLOB) {
>  		if (stream_blob_to_fd(fd, sha1, NULL, 0) < 0)
>  			die("unable to stream %s to stdout", sha1_to_hex(sha1));
> +		if (check_sha1_signature(sha1, NULL, 0, NULL) < 0)
> +			die("object %s sha1 mismatch", sha1_to_hex(sha1));

check_sha1_signature() opens the object again and streams the data.
Essentially the read side is doing twice the work with that patch,
isn't it?

I wonder if we want to extend the stream_blob_to_fd() API to
optionally allow the caller to ask to validate that the returned
data is consistent with the object name the caller asked the data
for.  Something along the lines of the attached weatherbaloon patch?

 builtin/fsck.c |  3 ++-
 entry.c        |  2 +-
 streaming.c    | 29 ++++++++++++++++++++++++++++-
 streaming.h    |  4 +++-
 4 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 97ce678..f42ed9c 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -237,7 +237,8 @@ static void check_unreachable_object(struct object *obj)
 			if (!(f = fopen(filename, "w")))
 				die_errno("Could not open '%s'", filename);
 			if (obj->type == OBJ_BLOB) {
-				if (stream_blob_to_fd(fileno(f), obj->sha1, NULL, 1))
+				if (stream_blob_to_fd(fileno(f), obj->sha1, NULL,
+						      STREAMING_OUTPUT_CAN_SEEK))
 					die_errno("Could not write '%s'", filename);
 			} else
 				fprintf(f, "%s\n", sha1_to_hex(obj->sha1));
diff --git a/entry.c b/entry.c
index 7b7aa81..b3bc827 100644
--- a/entry.c
+++ b/entry.c
@@ -127,7 +127,7 @@ static int streaming_write_entry(const struct cache_entry *ce, char *path,
 	if (fd < 0)
 		return -1;
 
-	result |= stream_blob_to_fd(fd, ce->sha1, filter, 1);
+	result |= stream_blob_to_fd(fd, ce->sha1, filter, STREAMING_OUTPUT_CAN_SEEK);
 	*fstat_done = fstat_output(fd, state, statbuf);
 	result |= close(fd);
 
diff --git a/streaming.c b/streaming.c
index debe904..50599df 100644
--- a/streaming.c
+++ b/streaming.c
@@ -2,6 +2,7 @@
  * Copyright (c) 2011, Google Inc.
  */
 #include "cache.h"
+#include "object.h"
 #include "streaming.h"
 
 enum input_source {
@@ -496,19 +497,33 @@ static open_method_decl(incore)
  ****************************************************************/
 
 int stream_blob_to_fd(int fd, unsigned const char *sha1, struct stream_filter *filter,
-		      int can_seek)
+		      unsigned flags)
 {
 	struct git_istream *st;
 	enum object_type type;
 	unsigned long sz;
 	ssize_t kept = 0;
 	int result = -1;
+	int can_seek = flags & STREAMING_OUTPUT_CAN_SEEK;
+
+	int want_verify = flags & STREAMING_VERIFY_OBJECT_NAME;
+	git_SHA_CTX ctx;
 
 	st = open_istream(sha1, &type, &sz, filter);
 	if (!st)
 		return result;
 	if (type != OBJ_BLOB)
 		goto close_and_exit;
+
+	if (want_verify) {
+		char hdr[32];
+		int hdrlen;
+
+		git_SHA1_Init(&ctx);
+		hdrlen = sprintf(hdr, "%s %lu", typename(type), sz) + 1;
+		git_SHA1_Update(&ctx, hdr, hdrlen);
+	}
+
 	for (;;) {
 		char buf[1024 * 16];
 		ssize_t wrote, holeto;
@@ -518,6 +533,10 @@ int stream_blob_to_fd(int fd, unsigned const char *sha1, struct stream_filter *f
 			goto close_and_exit;
 		if (!readlen)
 			break;
+
+		if (want_verify)
+			git_SHA1_Update(&ctx, buf, readlen);
+
 		if (can_seek && sizeof(buf) == readlen) {
 			for (holeto = 0; holeto < readlen; holeto++)
 				if (buf[holeto])
@@ -542,6 +561,14 @@ int stream_blob_to_fd(int fd, unsigned const char *sha1, struct stream_filter *f
 		goto close_and_exit;
 	result = 0;
 
+	if (want_verify) {
+		unsigned char verify[20];
+
+		git_SHA1_Final(verify, &ctx);
+		if (hashcmp(verify, lookup_replace_object(sha1)))
+			result = -1;
+	}
+
  close_and_exit:
 	close_istream(st);
 	return result;
diff --git a/streaming.h b/streaming.h
index 1d05c2a..68fe3a4 100644
--- a/streaming.h
+++ b/streaming.h
@@ -12,6 +12,8 @@ extern struct git_istream *open_istream(const unsigned char *, enum object_type
 extern int close_istream(struct git_istream *);
 extern ssize_t read_istream(struct git_istream *, void *, size_t);
 
-extern int stream_blob_to_fd(int fd, const unsigned char *, struct stream_filter *, int can_seek);
+#define STREAMING_OUTPUT_CAN_SEEK 01
+#define STREAMING_VERIFY_OBJECT_NAME 02
+extern int stream_blob_to_fd(int fd, const unsigned char *, struct stream_filter *, unsigned flags);
 
 #endif /* STREAMING_H */
