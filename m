From: Jeff King <peff@peff.net>
Subject: Re: [RFC] Cache negative delta pairs
Date: Wed, 28 Jun 2006 23:50:03 -0400
Message-ID: <20060629035002.GA29486@coredump.intra.peff.net>
References: <20060628223744.GA24421@coredump.intra.peff.net> <7v4py4y7wo.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 29 05:50:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvnXk-000742-G0
	for gcvg-git@gmane.org; Thu, 29 Jun 2006 05:50:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932110AbWF2DuI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Jun 2006 23:50:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932124AbWF2DuH
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jun 2006 23:50:07 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:32689 "HELO
	peff.net") by vger.kernel.org with SMTP id S932110AbWF2DuF (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Jun 2006 23:50:05 -0400
Received: (qmail 7876 invoked from network); 28 Jun 2006 23:49:43 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 28 Jun 2006 23:49:43 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Jun 2006 23:50:03 -0400
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v4py4y7wo.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22835>

On Wed, Jun 28, 2006 at 08:09:43PM -0700, Junio C Hamano wrote:

> Interesting idea.  I think this matters more because for a
> repository with many unrelated undeltifiable files, we do the
> computation for objects that results in _no_ delta.  For normal

Yes, precisely.

> So I am curious where the speed-up comes from for "normal" repos
> in your experiments.  If it turns out that in "normal" repos the

I assumed they were either:
  - blobs of files with only a single revision
  - blobs with one "island" revision which is so different from previous
    revisions that it isn't worth a delta
You can get a (very rough) estimate on the former:
  $ cd linux-2.6 && git-rev-list --objects --all \
     | grep / | cut -d' ' -f2 | sort | uniq -u | wc -l
  8364

As I said, we may also be catching possible deltas at the edge of the
pack depth. I should maybe put the cache check closer to the
create_delta call.

> objects that hit your negative cache are stored undeltified,
> then that suggests that it might be worthwhile to consider using
> a cache of "inherently undeltifiable objects", In other words, a
> negative cache of O(N) entries, instead of O(N^2) entries,

That would certainly be preferable, though I'm not convinced there
aren't objects which are deltifiable, but not right now (e.g., a file
with only one revision, but which will later get a revision).

I'm not sure what would make a file inherently undeltifiable. But you
could put the O(N) cache in front of the other cache, and reduce the
size of N for the O(N^2) cache. 

> deltify against "just in case".  Can you easily instrument your
> code to see where in the sorted delta candidate list the pairs
> that hit your the negative cache are?  That is, in find_deltas()

I'll look into that...

> Another idea is to have a cache of "paths at which inherently
> undeltifiable objects live in".  For example, we currently do
> not delta OpenOffice documents (*.odt, *.odp, etc) very well.
> If one has a repository that tracks the history of "file.odp",
> we know each revision of "file.odp" would not delta against any
> other version anyway, and could skip attempting to deltify them.

I thought about that, but I was trying to avoid "clever" heuristics that
can often be wrong. Case in point: my repo consists mainly of jpegs,
most of which will not delta. But for a few, I edited the exif header
and they delta'd nicely against their previous revision.

> Your message contained string "*pt-in" in the commentary part
> (replace asterisk with lowercase o) and was discarded by vger
> mailing list software because that was a taboo word.  If you

Oops, I didn't know we were filtering. I'll resend in a moment.

> >    reasonably well). My test repo's cache is only 144K. The git cache is
> >    about 2.7M. The linux-2.6 cache is 22M.
> The fully-packed object database is 6.2M pack so you are talking
> about 40% bloat; the kernel is 115M so the overhead is 19%.

Yes, obviously if you're interested in maximal space saving, this is
stupid for the classic git repo case (though it makes sense for repos
with few but very large blobs). However, if you assume that:
  1. Packing is inherently space-saving and more-or-less required on
     large repos like linux-2.6 (which is 1.8G unpacked and 115M packed)
  2. It saves time (36 seconds per repack on linux-2.6)
then a more reasonable question is "do you want to spend 22M to save 30
seconds every time you repack -a?". Or, to really cook the numbers, you
can say that the cache is only wasting 1% versus an unpacked repo. :)

I think it's reasonable that this should be an optional feature. For
some repos, it turns them from almost unusable to very fast. For others,
it's a questionable space-time tradeoff (and for some pathological
cases, it would probably turn the repo from usable to unusable).

-Peff
