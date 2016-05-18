From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] cat-file: avoid noop calls to sha1_object_info_extended
Date: Wed, 18 May 2016 12:55:23 -0400
Message-ID: <20160518165522.GA5607@sigill.intra.peff.net>
References: <20160518165411.GA5563@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Charles Bailey <charles@hashpling.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 18 18:55:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b34kt-0005gB-1a
	for gcvg-git-2@plane.gmane.org; Wed, 18 May 2016 18:55:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753009AbcERQz0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2016 12:55:26 -0400
Received: from cloud.peff.net ([50.56.180.127]:41325 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751992AbcERQz0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2016 12:55:26 -0400
Received: (qmail 12050 invoked by uid 102); 18 May 2016 16:55:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 18 May 2016 12:55:25 -0400
Received: (qmail 24306 invoked by uid 107); 18 May 2016 16:55:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 18 May 2016 12:55:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 May 2016 12:55:23 -0400
Content-Disposition: inline
In-Reply-To: <20160518165411.GA5563@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294977>

It is not unreasonable to ask cat-file for a batch-check
format of simply "%(objectname)". At first glance this seems
like a noop (you are generally already feeding the object
names on stdin!), but it has a few uses:

  1. With --batch-all-objects, you can generate a listing of
     the sha1s present in the repository, without any input.

  2. You do not have to feed sha1s; you can feed arbitrary
     sha1 expressions and have git resolve them en masse.

  3. You can even feed a raw sha1, with the result that git
     will tell you whether we actually have the object or
     not.

In case 3, the call to sha1_object_info is useful; it tells
us whether the object exists or not (technically we could
swap this out for has_sha1_file, but the cost is roughly the
same).

In case 2, the existence check is of debatable value. A
mass-resolution might prefer performance to safety (against
outputting a value for a corrupted ref, for example).
However, the object lookup cost is likely not as noticeable
compared to the resolution cost. And since we have provided
that safety in the past, the conservative choice is to keep
it.

In case 1, though, the object lookup is a definite noop; we
know about the object because we found it in the object
database. There is no new information gained by making the
call.

This patch detects that case and optimizes out the call.
Here are best-of-five timings for linux.git:

  [before]
  $ time git cat-file --buffer \
                      --batch-all-objects \
                      --batch-check='%(objectname)'
  real    0m2.117s
  user    0m2.044s
  sys     0m0.072s

  [after]
  $ time git cat-file --buffer \
                      --batch-all-objects \
                      --batch-check='%(objectname)'
  real    0m1.230s
  user    0m1.176s
  sys     0m0.052s

There are two implementation details to note here.

One is that we detect the noop case by seeing that "struct
object_info" does not request any information. But besides
object existence, there is one other piece of information
which sha1_object_info may fill in: whether the object is
cached, loose, or packed. We don't currently provide that
information in the output, but if we were to do so later,
we'd need to take note and disable the optimization in that
case.

And that leads to the second note. If we were to output
that information, a better implementation would be to
remember where we saw the object in --batch-all-objects in
the first place, and avoid looking it up again by sha1.

In fact, we could probably squeeze out some extra
performance for less-trivial cases, too, by remembering the
pack location where we saw the object, and going directly
there to find its information (like type, size, etc). That
would in theory make this optimization unnecessary.

I didn't pursue that path here for two reasons:

  1. It's non-trivial to implement, and has memory
     implications. Because we sort and de-dup the list of
     output sha1s, we'd have to record the pack information
     for each object, too.

  2. It doesn't save as much as you might hope. It saves the
     find_pack_entry() call, but getting the size and type
     for deltified objects requires walking down the delta
     chain (for the real type) or reading the delta data
     header (for the size). These costs tend to dominate the
     non-trivial cases.

By contrast, this optimization is easy and self-contained,
and speeds up a real-world case I've used.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/cat-file.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 54db118..5d3180e 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -154,6 +154,13 @@ struct expand_data {
 	 * elements above, so you can retrieve the response from there.
 	 */
 	struct object_info info;
+
+	/*
+	 * This flag will be true if the requested batch format and options
+	 * don't require us to call sha1_object_info, which can then be
+	 * optimized out.
+	 */
+	unsigned skip_object_info : 1;
 };
 
 static int is_atom(const char *atom, const char *s, int slen)
@@ -258,7 +265,8 @@ static void batch_object_write(const char *obj_name, struct batch_options *opt,
 {
 	struct strbuf buf = STRBUF_INIT;
 
-	if (sha1_object_info_extended(data->sha1, &data->info, LOOKUP_REPLACE_OBJECT) < 0) {
+	if (!data->skip_object_info &&
+	    sha1_object_info_extended(data->sha1, &data->info, LOOKUP_REPLACE_OBJECT) < 0) {
 		printf("%s missing\n", obj_name ? obj_name : sha1_to_hex(data->sha1));
 		fflush(stdout);
 		return;
@@ -369,6 +377,13 @@ static int batch_objects(struct batch_options *opt)
 	strbuf_expand(&buf, opt->format, expand_format, &data);
 	data.mark_query = 0;
 
+	if (opt->all_objects) {
+		struct object_info empty;
+		memset(&empty, 0, sizeof(empty));
+		if (!memcmp(&data.info, &empty, sizeof(empty)))
+			data.skip_object_info = 1;
+	}
+
 	/*
 	 * If we are printing out the object, then always fill in the type,
 	 * since we will want to decide whether or not to stream.
-- 
2.8.2.888.gecb1fe3
