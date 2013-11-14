From: Jeff King <peff@peff.net>
Subject: Re: 64-bit support.
Date: Thu, 14 Nov 2013 17:15:50 -0500
Message-ID: <20131114221550.GB16466@sigill.intra.peff.net>
References: <CAJc7Lbr9Ej8JHo6m4HFwdo9GE2tBQCkypEMxMW+jEXKB1Lry=g@mail.gmail.com>
 <27C8BBEE-128F-4CC1-AACE-248CA0CD8FBE@acm.org>
 <CAJc7Lbp2gF18xAM1z-NCo8cp73px_-RTqGcB1MiPup9iGn+uRw@mail.gmail.com>
 <20131114191131.dd568689c8a2ac5f0dd7b04c@domain007.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?0JvQtdC20LDQvdC60LjQvSDQmNCy0LDQvQ==?= 
	<abyss.7@gmail.com>, "Kent R. Spillner" <kspillner@acm.org>,
	Git Mailing List <git@vger.kernel.org>
To: Konstantin Khomoutov <flatworm@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Thu Nov 14 23:15:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vh5Cf-0004b9-42
	for gcvg-git-2@plane.gmane.org; Thu, 14 Nov 2013 23:15:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757604Ab3KNWPx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Nov 2013 17:15:53 -0500
Received: from cloud.peff.net ([50.56.180.127]:39446 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755637Ab3KNWPw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Nov 2013 17:15:52 -0500
Received: (qmail 8966 invoked by uid 102); 14 Nov 2013 22:15:52 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 14 Nov 2013 16:15:52 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Nov 2013 17:15:50 -0500
Content-Disposition: inline
In-Reply-To: <20131114191131.dd568689c8a2ac5f0dd7b04c@domain007.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237880>

On Thu, Nov 14, 2013 at 07:11:31PM +0400, Konstantin Khomoutov wrote:

> > I just guess, that this limit comes from the O(N^2) complexity of the
> > comparison algorithm. Since the max 32-bit signed value is 2^31, then
> > the 2^15 = 32768 is somehow correlated with its square root, maybe,
> > like 2^(32/2 - 1) - to prevent overflow.
> > I'm trying to prepare the patch right now, that changes the `int
> > rename_limit` => `long rename_limit` and all intermediate variable
> > types. Is it a correct way to do?

Yes, the 32768 limit is there to prevent 32-bit overflow of the
squared value. We can use a uint64_t and bump the overflow limit to 2^32
if we are actually bumping up against this.

> I beleive rename_limit comes from reading the diff.renameLimit
> configuration variable.  The gitconfig(1) manual page hints to look at
> the "-l" command-line option of `git diff` which is described this way:

Yes, though there are also builtin defaults, depending on the operation
(400 for diffs, 1000 for merges).

> Looks like you're on the right track but the patch appears to require a
> more wide impact:
> * 32767 should be a default limit, applied in the case the user did not
>   specify neither diff.renameLimit nor "-l".

That is probably too high for a default limit. The point is that we are
making an O(n^2) matrix, and consuming CPU and memory in line with that.
The defaults were determined empirically on "reasonable" times (and are
now based on old hardware, so it may be time to bump them up).

The idea was that 32767 was unreasonably high, and you would not want to
spend that much CPU time anyway. On my shiny new machine, doing a 2048^2
matrix takes 5s. A 32767^2 matrix would be 21 minutes.

And it was also expected that you would simply not have that big a
matrix anyway (you might >32767 candidates on one side, but you will not
have a square bigger than rename_limit^2, which is what this is
checking).

> * If whatever value read from those sources is less than 0, an error
>   should be thrown--it looks strange to just revert it to the default
>   value in this case.

It's not the default, though. The default is something like 400. So
saying "-1" (or 0) is a way of saying "turn off the limit" without
having to guess at an arbitrarily high number.

> * If the user-supplied value is >= 0, then just use it, assume the user
>   knows what they are doing.

At some point we have to deal with integer overflow. It was assumed that
a 32-bit max was "big enough" and that nobody would have a real world
case that hit that. I'd be curious to hear if that has actually been
hit, or if there is simply confusion over how the rename-limit config
works (the limit is the square root of the max matrix size).

Here's what the 64-bit patch could look like (I notice that we are not
using unsigned 32-bit integers, either, and we probably should be):

---
diff --git a/diffcore-rename.c b/diffcore-rename.c
index 6c7a72f..8356a62 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -427,11 +427,16 @@ static void record_if_better(struct diff_score m[], struct diff_score *o)
  * 1 if we need to disable inexact rename detection;
  * 2 if we would be under the limit if we were given -C instead of -C -C.
  */
-static int too_many_rename_candidates(int num_create,
+static int too_many_rename_candidates(uint64_t num_create,
 				      struct diff_options *options)
 {
-	int rename_limit = options->rename_limit;
-	int num_src = rename_src_nr;
+	/*
+	 * signed to unsigned conversion here is intentional, and
+	 * converts limits < 0 into large (effectively infinite)
+	 * limits
+	 */
+	uint64_t rename_limit = options->rename_limit;
+	uint64_t num_src = rename_src_nr;
 	int i;
 
 	options->needed_rename_limit = 0;
@@ -442,11 +447,10 @@ static int too_many_rename_candidates(int num_create,
 	 *
 	 *    num_create * num_src > rename_limit * rename_limit
 	 *
-	 * but handles the potential overflow case specially (and we
-	 * assume at least 32-bit integers)
+	 * but handles the potential overflow case specially.
 	 */
-	if (rename_limit <= 0 || rename_limit > 32767)
-		rename_limit = 32767;
+	if (!rename_limit || rename_limit > 4294967295)
+		rename_limit = 4294967295;
 	if ((num_create <= rename_limit || num_src <= rename_limit) &&
 	    (num_create * num_src <= rename_limit * rename_limit))
 		return 0;
