From: Jeff King <peff@peff.net>
Subject: Re: git log --follow for directories
Date: Tue, 19 May 2015 19:55:52 -0400
Message-ID: <20150519235552.GB22748@peff.net>
References: <CAOMwXhP-BRd356xpfdLgZ0zKYTMVryt8jtmi3T2jhVh91hY04Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>
To: Laszlo Papp <lpapp@kde.org>
X-From: git-owner@vger.kernel.org Wed May 20 01:56:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YurMd-0008HJ-P8
	for gcvg-git-2@plane.gmane.org; Wed, 20 May 2015 01:56:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751230AbbESXzz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2015 19:55:55 -0400
Received: from cloud.peff.net ([50.56.180.127]:32946 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751132AbbESXzy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2015 19:55:54 -0400
Received: (qmail 25297 invoked by uid 102); 19 May 2015 23:55:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 19 May 2015 18:55:54 -0500
Received: (qmail 18947 invoked by uid 107); 19 May 2015 23:55:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 19 May 2015 19:55:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 May 2015 19:55:52 -0400
Content-Disposition: inline
In-Reply-To: <CAOMwXhP-BRd356xpfdLgZ0zKYTMVryt8jtmi3T2jhVh91hY04Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269433>

On Tue, May 19, 2015 at 02:56:48PM +0100, Laszlo Papp wrote:

> I have just realized that this would not work on directories
> triggering directory renames somewhat pointless for those who want to
> keep track of a group of files in directories.
> 
> It is unfortunate when you have a directory with many files and more
> often than not, you would like to look at the history of all rather
> than individually.
> 
> Is there any benefit about having it like it is today or is it just
> the usual "no one has implemented it yet"?

I have fooled around with accepting a full pathspec for --follow, rather
than a single file. In the single-file case, if we see a rename of "A"
to "B" (and we are following "B"), we switch to following "A". With a
pathspec, that is not right. If you are following "foo" and "foo/A" is
renamed to "bar/A", you would want to start following "bar/A", but you
would _not_ want to stop matching "foo" (because you want to still look
at "foo/B").

The most correct thing would be to match ("!foo/A", "foo", "bar/A").
That is, once we follow a rename, it is explicitly excluded from the
pathspec. It is much simpler to just do ("foo", "bar/A").  I.e., just
always add to the pathspec, but never take away. It is not correct, but
it works OK in practice (and it always shows more than you might be
interested in, not less).

Junio mentioned the other problem: our pathspec is global, but it
actually should follow the graph itself. This is orthogonal to the
question of whether we are matching one file or several, but in practice
I suspect matching several files may make it worse (that is, the
inaccuracies would surface more frequently).

The right way to do --follow is something like:

  1. Topo-sort the commits. Attach the initial pathspec to each of the
     initial tip commits. Do our usual walk backwards (respecting the
     topo-sort).

  2. If there are no renames to follow in a commit, attach the pathspec to
     its parents.

  3. If there is a rename, make a new pathspec (as above) to attach to
     the parents.

  4. When we try to attach a pathspec to a commit that already has one,
     we need to reconcile the two. I haven't thought hard about it, but
     it's probably something like a union of the two pathspecs. E.g.,
     consider a traversal starting at two tips, and we're interested in
     path "B". One line of commits renamed "A" to "B", so we start
     matching "A". The other created it from scratch. When we come to
     the shared ancestor of the two branches, we are probably interested
     in both "A" and "B".

     But like I said, I haven't really thought hard about it. That's
     just my intuition.

-Peff
