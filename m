From: Jeff King <peff@peff.net>
Subject: Re: [BUG] serious inflate inconsistency on master
Date: Wed, 4 Jul 2012 03:12:14 -0400
Message-ID: <20120704071214.GB24807@sigill.intra.peff.net>
References: <20120703221900.GA28897@sigill.intra.peff.net>
 <7vipe4tqns.fsf@alter.siamese.dyndns.org>
 <CACsJy8AFs6PV8XCAUar9KadE8g-WSaZofKQAGPB6VjbhVpSRig@mail.gmail.com>
 <7vy5n0rq9c.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 04 09:12:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SmJl8-0005DK-Oj
	for gcvg-git-2@plane.gmane.org; Wed, 04 Jul 2012 09:12:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754924Ab2GDHMS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jul 2012 03:12:18 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:52832
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751395Ab2GDHMR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jul 2012 03:12:17 -0400
Received: (qmail 30906 invoked by uid 107); 4 Jul 2012 07:12:24 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 04 Jul 2012 03:12:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 04 Jul 2012 03:12:14 -0400
Content-Disposition: inline
In-Reply-To: <7vy5n0rq9c.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200987>

On Tue, Jul 03, 2012 at 11:31:43PM -0700, Junio C Hamano wrote:

> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
> 
> > By the way I searched the commit that introduces that check with "git
> > log --follow -p builtin/index-pack.c" but I could not find it. What
> > did I do wrong?
> 
> Your commit 8a2e163cc shows changes to the file at ll.535-540; these
> come from 776ea370 builtin-index-pack.c ll.383-388.
> 
>   $ git show 776ea370:builtin-index-pack.c
> 
> The get_data_from_pack() function in that commit gives sufficient
> buffer to output side (avail_out starts out as obj->size), and feeds
> the data from the packfile in chunks.  With the arrangement this
> commit makes to call git_inflate(), it should never get stuck
> because it ran out of output buffer.  In each iteration of the loop,
> when the function returns, status should read Z_OK and the function
> should have consumed all input.
> 
> But the version that uses consume() function does not give
> sufficient output buffer to ensure that the input will always be
> inflated fully (avoiding to use large output buffer is the whole
> point of your patch after all), so with your patch, that no longer
> holds true.

Yeah, that makes sense. I was wondering if we could get rid of the
avail_in check (and instead just _always_ loop to drain avail_in,
whether we are using consume() or not). The intent would be that the
loop would be a harmless no-op in the non-consume case, because we would
always drain the input completely on the first call.

But that's not right; if we _didn't_ drain it, it's probably because the
input is malformed (i.e., the deflated data is larger than the object
size claims), and we would loop infinitely (because we are not extending
the output buffer during each run of the loop).

So the patch I posted earlier is the right direction. I didn't properly
deal with moving last_out into the inner loop in that patch, but after
checking to see where it goes, I'm pretty sure it's superfluous. Here it
is with last_out removed and a proper commit message:

-- >8 --
Subject: index-pack: loop while inflating objects in unpack_data

When the unpack_data function is given a consume() callback,
it unpacks only 64K of the input at a time, feeding it to
git_inflate along with a 64K output buffer.  However,
because we are inflating, there is a good chance that the
output buffer will fill before consuming all of the input.
In this case, we need to loop on git_inflate until we have
fed the whole input buffer, feeding each chunk of output to
the consume buffer.

The current code does not do this, and as a result, will
fail the loop condition and trigger a fatal "serious inflate
inconsistency" error in this case.

While we're rearranging the loop, let's get rid of the
extra last_out pointer. It is meant to point to the
beginning of the buffer that we feed to git_inflate, but in
practice this is always the beginning of our same 64K
buffer, because:

  1. At the beginning of the loop, we are feeding the
     buffer.

  2. At the end of the loop, if we are using a consume()
     function, we reset git_inflate's pointer to the
     beginning of the buffer.  If we are not using a
     consume() function, then we do not care about the value
     of last_out at all.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/index-pack.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 8b5c1eb..50d3876 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -524,7 +524,6 @@ static void *unpack_data(struct object_entry *obj,
 	stream.avail_out = consume ? 64*1024 : obj->size;
 
 	do {
-		unsigned char *last_out = stream.next_out;
 		ssize_t n = (len < 64*1024) ? len : 64*1024;
 		n = pread(pack_fd, inbuf, n, from);
 		if (n < 0)
@@ -538,15 +537,19 @@ static void *unpack_data(struct object_entry *obj,
 		len -= n;
 		stream.next_in = inbuf;
 		stream.avail_in = n;
-		status = git_inflate(&stream, 0);
-		if (consume) {
-			if (consume(last_out, stream.next_out - last_out, cb_data)) {
-				free(inbuf);
-				free(data);
-				return NULL;
-			}
-			stream.next_out = data;
-			stream.avail_out = 64*1024;
+		if (!consume)
+			status = git_inflate(&stream, 0);
+		else {
+			do {
+				status = git_inflate(&stream, 0);
+				if (consume(data, stream.next_out - data, cb_data)) {
+					free(inbuf);
+					free(data);
+					return NULL;
+				}
+				stream.next_out = data;
+				stream.avail_out = 64*1024;
+			} while (status == Z_OK && stream.avail_in);
 		}
 	} while (len && status == Z_OK && !stream.avail_in);
 
-- 
1.7.11.rc1.21.g3c8d91e
