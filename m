From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] Cache negative delta pairs
Date: Wed, 28 Jun 2006 20:09:43 -0700
Message-ID: <7v4py4y7wo.fsf@assigned-by-dhcp.cox.net>
References: <20060628223744.GA24421@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 29 05:09:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fvmua-0001jW-Gb
	for gcvg-git@gmane.org; Thu, 29 Jun 2006 05:09:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750930AbWF2DJp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Jun 2006 23:09:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751670AbWF2DJp
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jun 2006 23:09:45 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:6137 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1750918AbWF2DJp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jun 2006 23:09:45 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060629030944.YNFX18458.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 28 Jun 2006 23:09:44 -0400
To: Jeff King <peff@peff.net>
In-Reply-To: <20060628223744.GA24421@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 28 Jun 2006 18:37:44 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22834>

Jeff King <peff@peff.net> writes:

> From repack to repack, we end up trying to delta many of the same object
> pairs, which is computationally expensive.
>...
> I found this especially to be a problem with repos that consist of many
> large, unrelated files (e.g., photos). For example, on my test repo
> (about 300 unrelated 1-2M jpgs), a 'git-repack -a' takes about 10
> minutes to complete. With the delta cache, subsequent repacks take only
> 13 seconds. Results are not quite as dramatic for "normal" repos, but
> there is still some speedup. Repacking a fully packed linux-2.6 repo
> went from 1m12s to 36s. Repacking the git repo goes from 5.6s to 3.0s.

Interesting idea.  I think this matters more because for a
repository with many unrelated undeltifiable files, we do the
computation for objects that results in _no_ delta.  For normal
nearly fully packed repositories, once an object is deltified
against something else, subsequent repacking of the same set of
objects (or a superset thereof) will very likely reuse the delta
without recomputation, so as long as each object _can_ be
deltified with at least _one_ other object, you should not see
improvement on them.

So I am curious where the speed-up comes from for "normal" repos
in your experiments.  If it turns out that in "normal" repos the
objects that hit your negative cache are stored undeltified,
then that suggests that it might be worthwhile to consider using
a cache of "inherently undeltifiable objects", In other words, a
negative cache of O(N) entries, instead of O(N^2) entries,

Another interpretation of your result is that we may be using a
delta window that is unnecessarily too deep, and your negative
cache is collecting less optimum candidates that we attempt to
deltify against "just in case".  Can you easily instrument your
code to see where in the sorted delta candidate list the pairs
that hit your the negative cache are?  That is, in find_deltas()
function, we have "while (--j > 0)" loop that attempts to delta
with the entry that is j (modulo window size) entries away from
the current one, then j-1, j-2, ...; I am interested in the
distribution of "j" value for the pair "n,m" that hits your
negative cache for normal repositories, and I am speculating
that the value would probably be small relative to the delta
window size.

Another idea is to have a cache of "paths at which inherently
undeltifiable objects live in".  For example, we currently do
not delta OpenOffice documents (*.odt, *.odp, etc) very well.
If one has a repository that tracks the history of "file.odp",
we know each revision of "file.odp" would not delta against any
other version anyway, and could skip attempting to deltify them.

Your message contained string "*pt-in" in the commentary part
(replace asterisk with lowercase o) and was discarded by vger
mailing list software because that was a taboo word.  If you
would want to pursue this I would suggest to resend your
original patch after rephrasing that part.

>  - size. The cache is a packed sequence of binary sha1 pairs. I was
>    concerned that it would grow too large (obviously for n blobs you can
>    end up with n^2/2 entries), but it doesn't seem unreasonable for most
>    repos (either you don't have a lot of files, or if you do, they delta
>    reasonably well). My test repo's cache is only 144K. The git cache is
>    about 2.7M. The linux-2.6 cache is 22M.

The fully-packed object database is 6.2M pack so you are talking
about 40% bloat; the kernel is 115M so the overhead is 19%.
