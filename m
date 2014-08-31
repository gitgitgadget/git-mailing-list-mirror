From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/2] t5309: mark delta-cycle failover tests as passing
Date: Sun, 31 Aug 2014 11:15:50 -0400
Message-ID: <20140831151550.GA16499@peff.net>
References: <53F868F8.9080000@web.de>
 <20140823105640.GA6881@peff.net>
 <20140823110459.GA13087@peff.net>
 <20140823111804.GA17335@peff.net>
 <53FB66D1.709@web.de>
 <20140828220821.GA31545@peff.net>
 <20140828222227.GA30879@peff.net>
 <xmqq1ts08ax2.fsf@gitster.dls.corp.google.com>
 <20140829205538.GD29456@peff.net>
 <20140830132311.GA14709@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Shawn Pearce <spearce@spearce.org>,
	Martin von Gagern <Martin.vGagern@gmx.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 31 17:16:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XO6rL-0001pK-3s
	for gcvg-git-2@plane.gmane.org; Sun, 31 Aug 2014 17:16:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751234AbaHaPPy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Aug 2014 11:15:54 -0400
Received: from cloud.peff.net ([50.56.180.127]:41867 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751123AbaHaPPx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Aug 2014 11:15:53 -0400
Received: (qmail 15400 invoked by uid 102); 31 Aug 2014 15:15:52 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 31 Aug 2014 10:15:52 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 31 Aug 2014 11:15:50 -0400
Content-Disposition: inline
In-Reply-To: <20140830132311.GA14709@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256287>

On Sat, Aug 30, 2014 at 09:23:11AM -0400, Jeff King wrote:

> The implications of this make me slightly nervous, though. In the
> --fix-thin case, the resulting pack will have 3 objects:
> 
>   - A as a delta on B
>   - B as a delta on A
>   - a full copy of either A (or B) provided by --fix-thin
> 
> We create a .idx that has duplicate entries for A. If a reader is trying
> to reconstruct B and they find the full copy of A, they're fine. If they
> find the delta copy, what happens?
> 
> Ideally the reader would say "hey, I can't reconstruct A here, let me
> try to find another copy". But I am not sure if that happens, or if we
> are even capable of finding another copy of A (certainly we can find one
> in another pack, but I do not think we are smart enough to find a
> duplicate in the same pack).

The main reason this was "makes me nervous" before is that I did not
fully understand _why_ it worked with the current code. That bugged me,
so I dug further. And the answer is that it does not, but just happens
to work for some small cases.

Try this on top:

diff --git a/t/t5309-pack-delta-cycles.sh b/t/t5309-pack-delta-cycles.sh
index 5309095..4086983 100755
--- a/t/t5309-pack-delta-cycles.sh
+++ b/t/t5309-pack-delta-cycles.sh
@@ -58,9 +58,19 @@ test_expect_success 'index-pack detects REF_DELTA cycles' '
 
 test_expect_success 'failover to an object in another pack' '
 	clear_packs &&
+	{
+		pack_header 100 &&
+		for i in $(test_seq 50); do
+			pack_obj $A $B &&
+			pack_obj $B $A || break
+		done
+	} >megacycle.pack &&
+	pack_trailer megacycle.pack &&
 	git index-pack --stdin <ab.pack &&
-	git index-pack --stdin --fix-thin <cycle.pack &&
-	test_must_fail git index-pack --strict --stdin --fix-thin <cycle.pack
+	git index-pack --stdin --fix-thin <megacycle.pack &&
+	echo >&2 indexed pack successfully... &&
+	git fsck &&
+	echo >&2 actually re-read pack successfully
 '
 
 test_expect_success 'failover to a duplicate object in the same pack' '


It has the same cycle problem, but we are just adding a larger number of
instances to the pack. Which means that any given sha1-lookup in the
index is more likely to hit a delta rather than the base object.

We successfully index the pack, but our fsck goes into an infinite loop.
Yikes.

I haven't really looked into it, but I suspect we would need some kind
of cycle detection on the delta resolution (and possibly to teach the
sha1-lookup to recognize duplicate objects in the pack and treat them
individually). Frankly, I don't think it is worth the effort or
complexity. We should probably just declare delta cycles insane and
reject them outright.

We used to do that because the only way to correctly resolve them was by
introducing a duplicate base object, and we did not allow that. Patch 2
from my series loosened this, which makes index-pack work, but not
necessarily the rest of git. And since index-pack is the gatekeeper on
receiving objects from remotes, it needs to be the _most_ picky. So my
series is definitely a regression as-is.

We can solve this in one of three ways:

  1. Teach the rest of git to handle recoverable delta cycles. This is
     probably crazy and not worth the effort (and it just lets crap
     through that will hurt other git implementations, too).

  2. Continue to let through duplicate objects in index-pack, but
     specifically detect and reject delta cycles. This is more work (I'm
     not sure yet how easy it would be to detect cycles), but it would
     mean we can treat duplicates (a much less nasty problem) and cycles
     differently.

  3. Go back to outlawing duplicate bases. This is very easy. Just drop
     my patch 2. :)

I am inclined to go with the third option. There has already been a
suggestion from Shawn that we disallow duplicates entirely, and I was
tempted to go that direction even without this finding. But to me this
makes it a no-brainer; the question has gone from "how strict do we want
to be" to "do we want to protect the rest of the code against useless
and potentially harmful violations of their assumptions".

If we do go with (3), that opens up two new questions:

  a. Should we disallow _all_ duplicates, or just those that are bases?
     This is actually easy to code; the assert() in find_unresolved_deltas
     catches the bases, and the .idx writer catches any other ones.

  b. How optional do we want to make this? Right now (without this
     series) the delta-base duplicates always die, and regular
     duplicates are prevented only under --strict.

     If we treat them the same, it should probably be die-by-default.
     Should there be an optional mode to let this stuff through (i.e., a
     "I know this might cause problems with the rest of git, but I am
     desperate to get the data out of this pack" mode?)

     If we treat them differently, there is not much harm in an option
     to loosen regular duplicates, as I think the rest of git handles
     it. For bases, in theory you might be able to recover some data.
     But you may also run into this infinite loop. It is very much "at
     your own risk".

     I wonder if index-pack is really the right place for such a "please
     help me get the data out of this broken pack" operation in the
     first place. If it is a broken pack, we are probably much better
     off to explode it into loose objects than try to index a broken
     pack. That's way less efficient, but this should be a last-resort.

I think my preference is to outlaw all duplicates unconditionally in
index-pack. Catch the duplicate base in find_unresolved_deltas as we do
now, but improve the error message. Confirm that unpack-objects can
handle these cases. Optionally attach advice to the duplicate errors
directing people to use "unpack-objects" and/or set
transfer.unpackLimit higher.

-Peff
