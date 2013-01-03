From: Jeff King <peff@peff.net>
Subject: Re: [RFD] annnotating a pair of commit objects?
Date: Thu, 3 Jan 2013 03:14:59 -0500
Message-ID: <20130103081459.GB32377@sigill.intra.peff.net>
References: <7vr4m2ycij.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 03 09:15:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqfxT-0007ZI-9F
	for gcvg-git-2@plane.gmane.org; Thu, 03 Jan 2013 09:15:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752378Ab3ACIPE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jan 2013 03:15:04 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:41854 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752036Ab3ACIPC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jan 2013 03:15:02 -0500
Received: (qmail 4593 invoked by uid 107); 3 Jan 2013 08:16:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 03 Jan 2013 03:16:13 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 03 Jan 2013 03:14:59 -0500
Content-Disposition: inline
In-Reply-To: <7vr4m2ycij.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212574>

On Wed, Jan 02, 2013 at 11:03:00PM -0800, Junio C Hamano wrote:

> I'd like a datastore that maps a pair of commit object names to
> another object name, such that:
> 
>  * When looking at two commits A and B, efficiently query all data
>    associated with a pair of commits <X,Y> where X is contained in
>    the range A..B and not in B..A, and Y is contained in the range
>    B..A and not in A..B.
> [...]
> Obviously, with O(cnt(A..B))*O(cnt(B..A)) complexity, this can be
> trivially coded, by trying all pairs in symmetric difference.
> 
> But I am hoping we can do better than that.
> 
> Ideas?

Just thinking out loud, the problem can be generalized in math terms as:

  - you have a universe of elements, `U` (i.e., all commits)

  - you have two sets, `X` and `Y`, such that each is a subset of `U`
    (these correspond to the two sides of the range, but we can think of
    them just as sets of commits). We happen to know that the sets are
    disjoint, but I don't know if that is helpful here.

  - you have a set of sets `M` that is a subset of the cartesian product
    `U x U` (i.e., its elements are "{x,y}" pairs, and membership in
    that set is your "bit"; you could also think of it as a mapping if
    you wanted more than a bit).

  - you want to know the intersection of `X x Y` and `M` (which of your
    pairs are in the mapping set).

Without doing any careful analysis, my gut says that in the worst case,
you are going to be stuck with `O(|X|*|Y|)` (i.e., what you are trying
to do better than above). But if we assume that `M` is relatively sparse
(which it should be; you only create entries when you do a merge between
two commits, and even then, only when it is tricky), we can probably do
better in practice.

For example, consider this naive way of doing it. Store `M` as a mapping
of commits to sets of commits, with fast lookup (a hash, or sorted
list).  For each element of `X`, look it up in `M`; call its value `V`
(which, remember, is a set itself).  For each element of `Y`, look it up
in `V`. The complexity would be:

  O(|X| * lg(|M|) * |Y| * lg(V_avg))

where "V_avg" is the average cardinality of each of the value sets we
map in the first step. But imagine we pre-sort `Y`, and then in the
second step, rather than looking up each `Y` in `V`, we instead look up
each `V` in `Y`. Then we have:

  O(|X| * lg(|M|) * V_avg * lg(|Y|))

IOW, we get to apply the log to |Y|. This is a win if we expect that
V_avg is going to be much smaller than |Y|. Which I think it would be,
since we would only have entries for merges we've done before[1].

That's just off the top of my head. This seems like it should be a
classic databases problem (since the cartesian product here is really
just a binary relation), but I couldn't find anything obvious online
(and I never paid attention in class, either).

-Peff

[1] You can do the same inversion trick for looking up elements of `M`
    in `X` instead of vice versa. It would probably buy you less, as you
    have a lot of commits that have merges at all (i.e., `M` is big),
    but only a few matching partners for each entry (i.e., `V` is
    small).
