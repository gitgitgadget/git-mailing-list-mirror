From: Jeff King <peff@peff.net>
Subject: Re: Fwd: Git and Large Binaries: A Proposed Solution
Date: Mon, 14 Mar 2011 15:32:54 -0400
Message-ID: <20110314193254.GA21581@sigill.intra.peff.net>
References: <AANLkTin=UySutWLS0Y7OmuvkE=T=+YB8G8aUCxLH=GKa@mail.gmail.com>
 <AANLkTimPua_kz2w33BRPeTtOEWOKDCsJzf0sqxm=db68@mail.gmail.com>
 <20110121222440.GA1837@sigill.intra.peff.net>
 <20110123141417.GA6133@mew.padd.com>
 <4D793C7D.1000502@miseler.de>
 <20110310222443.GC15828@sigill.intra.peff.net>
 <AANLkTimpbhaGEfxW1wwRc14tpV6qnPDiZYnXp_tvA3Ft@mail.gmail.com>
 <20110313025258.GA10452@sigill.intra.peff.net>
 <4D7D1BFE.2030008@miseler.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Montellese <emontellese@gmail.com>,
	Pete Wyckoff <pw@padd.com>, git@vger.kernel.org,
	schacon@gmail.com, joey@kitenet.net
To: Alexander Miseler <alexander@miseler.de>
X-From: git-owner@vger.kernel.org Mon Mar 14 20:33:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzDVm-000776-Oa
	for gcvg-git-2@lo.gmane.org; Mon, 14 Mar 2011 20:33:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751316Ab1CNTc5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Mar 2011 15:32:57 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:52499
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750988Ab1CNTc5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Mar 2011 15:32:57 -0400
Received: (qmail 12666 invoked by uid 107); 14 Mar 2011 19:33:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 14 Mar 2011 15:33:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 14 Mar 2011 15:32:54 -0400
Content-Disposition: inline
In-Reply-To: <4D7D1BFE.2030008@miseler.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169014>

On Sun, Mar 13, 2011 at 08:33:18PM +0100, Alexander Miseler wrote:

> We want to store them as flat as possible. Ideally if we have a temp
> file with the content (e.g. the output of some filter) it should be
> possible to store it by simply doing a move/rename and updating some
> meta data external to the actual file.

Yeah, that would be a nice optimization.  But I'd rather do the easy
stuff first and see if more advanced stuff is still worth doing.

For example, I spent some time a while back designing a faster textconv
interface (the current interface spools the blob to a tempfile, whereas
in some cases a filter needs to only access the first couple kilobytes
of the file to get metadata). But what I found was that an even better
scheme was to cache textconv output in git-notes. Then it speeds up the
slow case _and_ the already-fast case.

Now after this, would my new textconv interface still speed up the
initial non-cached textconv? Absolutely. But I didn't really care
anymore, because the small speed up on the first run was not worth the
trouble of maintaining two interfaces (at least for my datasets).

And this may fall into the same category. Accessing big blobs is
expensive. One solution is to make it a bit faster. Another solution is
to just do it less. So we may find that once we are doing it less, it is
not worth the complexity to make it faster.

And note that I am not saying "it definitely won't be worth it"; only
that it is worth making the easy, big optimizations first and then
seeing what's left to do.

> 1.) The loose file format is inherently unsuited for this. It has a
> header before the actual content and the whole file (header + content)
> is always compressed. Even if one changes this to
> compressing/decompressing header and content independently it is still
> unsuited by a) having the header within the same file and b) because
> the header has no flags or other means to indicate a different
> behavior (e.g. no compression) for the content. We could extend the
> header format or introduce a new object type (e.g. flatblob) but both
> would probably cause more trouble than other solutions. Another idea
> would be to keep the metadata in an external file (e.g. 84d7.header
> for the object 84d7). This would probably have a bad performance
> though since every object lookup would first need to check for the
> existence of a header file. A smarter variant would be to optionally
> keep the meta data directly in the filename (e.g. saving the object as
> 84d7.object_type.size.flag instead of just 84d7).
> This would only require special handling for cases where the normal lookup for 84d7 fails.

A new object type is definitely a bad idea. It changes the sha1 of the
resulting object, which means that our identical trees which differ only
in the use of "flatblob" versus regular blob will have different sha1s.

So I think the right place to insert this would be at the object db
layer. The header just has the type and size. But I don't think anybody
is having a problem with large objects that are _not_ blobs. So the
simplest implementation would be a special blob-only object db
containing pristine files. We implicitly know that objects in this db
are blobs, and we can get the size from the filesystem via stat().
Checking their sha1 would involve prepending "blob <size>\0" to the file
data. It does introduce an extra stat() into object lookup, so probably
we would have the lookup order of pack, regular loose object, flat blob
object. Then you pay the extra stat() only in the less-common case of
accessing either a large blob or a non-existent object.

That being said, I'm not sure how much this optimization will buy us.
There are times when being able to mmap() the file directly, or point an
external program directly at the original blob will be helpful. But we
will still have to copy, for example on checkout. It would be nice if
there was a way to make a copy-on-write link from the working tree to
the original file. But I don't think there is a portable way to do so,
and we can't allow the user to accidentally munge the contents of the
object db, which are supposed to be immutable.

-Peff
