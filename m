From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] cat-file: pass expand_data to print_object_or_die
Date: Thu, 12 Dec 2013 07:01:42 +0800
Message-ID: <20131211230142.GA16606@sigill.intra.peff.net>
References: <20131211115458.GA10561@sigill.intra.peff.net>
 <20131211115642.GA10594@sigill.intra.peff.net>
 <20131211201112.GM2311@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Samuel Bronson <naesten@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 12 00:01:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vqsmz-0005lw-RV
	for gcvg-git-2@plane.gmane.org; Thu, 12 Dec 2013 00:01:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751489Ab3LKXBx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Dec 2013 18:01:53 -0500
Received: from cloud.peff.net ([50.56.180.127]:35395 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751482Ab3LKXBw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Dec 2013 18:01:52 -0500
Received: (qmail 10115 invoked by uid 102); 11 Dec 2013 23:01:52 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (123.127.199.246)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 11 Dec 2013 17:01:52 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 12 Dec 2013 07:01:42 +0800
Content-Disposition: inline
In-Reply-To: <20131211201112.GM2311@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239215>

On Wed, Dec 11, 2013 at 12:11:12PM -0800, Jonathan Nieder wrote:

> >                                        However, if we pass
> > the whole struct, the called function can make more
> > intelligent decisions about which fields were actualled
> > filled by sha1_object_info.
> 
> Thanks.
> 
> s/actualled/actually/, I think.

Yes. Not sure how I managed that typo.

> At first I thought this patch was going to be about making those
> intelligent decisions.  Maybe s/the called function can/a future patch
> can teach the called function/ or something?

I clarified it in the commit message below.

> > There should be no functional change to this patch.
> 
> The patch itself looks straightforward, yep. :)

It technically does typo-fix the error message, which I guess is a
functional change. But I didn't count that. :)

Here it is with the commit message fixes and your reviewed-by.

-- >8 --
Subject: cat-file: pass expand_data to print_object_or_die

We currently individually pass the sha1, type, and size
fields calculated by sha1_object_info. However, if we pass
the whole struct, the called function can make more
intelligent decisions about which fields were actually
filled by sha1_object_info.

This patch takes that first refactoring step, passing the
whole struct, so further patches can make those decisions
with less noise in their diffs. There should be no
functional change to this patch (aside from a minor typo fix
in the error message).

As a side effect, we can rename the local variables in the
function to "type" and "size", since the names are no longer
taken.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/cat-file.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index b2ca775..1434afb 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -193,25 +193,26 @@ static size_t expand_format(struct strbuf *sb, const char *start, void *data)
 	return end - start + 1;
 }
 
-static void print_object_or_die(int fd, const unsigned char *sha1,
-				enum object_type type, unsigned long size)
+static void print_object_or_die(int fd, struct expand_data *data)
 {
-	if (type == OBJ_BLOB) {
+	const unsigned char *sha1 = data->sha1;
+
+	if (data->type == OBJ_BLOB) {
 		if (stream_blob_to_fd(fd, sha1, NULL, 0) < 0)
 			die("unable to stream %s to stdout", sha1_to_hex(sha1));
 	}
 	else {
-		enum object_type rtype;
-		unsigned long rsize;
+		enum object_type type;
+		unsigned long size;
 		void *contents;
 
-		contents = read_sha1_file(sha1, &rtype, &rsize);
+		contents = read_sha1_file(sha1, &type, &size);
 		if (!contents)
 			die("object %s disappeared", sha1_to_hex(sha1));
-		if (rtype != type)
+		if (type != data->type)
 			die("object %s changed type!?", sha1_to_hex(sha1));
-		if (rsize != size)
-			die("object %s change size!?", sha1_to_hex(sha1));
+		if (size != data->size)
+			die("object %s changed size!?", sha1_to_hex(sha1));
 
 		write_or_die(fd, contents, size);
 		free(contents);
@@ -250,7 +251,7 @@ static int batch_one_object(const char *obj_name, struct batch_options *opt,
 	strbuf_release(&buf);
 
 	if (opt->print_contents) {
-		print_object_or_die(1, data->sha1, data->type, data->size);
+		print_object_or_die(1, data);
 		write_or_die(1, "\n", 1);
 	}
 	return 0;
-- 
1.8.5.524.g6743da6
