From: Jeff King <peff@peff.net>
Subject: Re: keeping track of where a patch begins
Date: Mon, 26 Oct 2009 10:30:07 -0400
Message-ID: <20091026143006.GA3300@sigill.intra.peff.net>
References: <3a69fa7c0910210745r311cf18xf966f5c63650cde6@mail.gmail.com>
 <alpine.LFD.2.00.0910211402490.21460@xanadu.home>
 <7veiow4iqc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nicolas Pitre <nico@fluxnic.net>, E R <pc88mxer@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 26 15:30:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2QaR-0007Yr-9F
	for gcvg-git-2@lo.gmane.org; Mon, 26 Oct 2009 15:30:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751764AbZJZOaH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Oct 2009 10:30:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751766AbZJZOaH
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Oct 2009 10:30:07 -0400
Received: from peff.net ([208.65.91.99]:56721 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751606AbZJZOaG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Oct 2009 10:30:06 -0400
Received: (qmail 24966 invoked by uid 107); 26 Oct 2009 14:33:47 -0000
Received: from c-98-234-220-119.hsd1.ca.comcast.net (HELO sigill.intra.peff.net) (98.234.220.119)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 26 Oct 2009 10:33:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Oct 2009 10:30:07 -0400
Content-Disposition: inline
In-Reply-To: <7veiow4iqc.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131253>

On Wed, Oct 21, 2009 at 01:03:55PM -0700, Junio C Hamano wrote:

>  (0) Define a way to identify the bottom of a branch.  One way to do this
>      is by an extra ref (e.g. refs/branchpoints/frotz).  Then the commits
>      between refs/branchpoints/frotz..refs/heads/frotz identifies the
>      commits on the branch.  None of the additional restrictions below
>      applies when the branch does not have such bottom defined (i.e.
>      created by the current git without this extension).

Hmm. This feels like redundant information to me. It has always been
git's strategy to record the history graph, and to use merge bases as
the "bottom" of branches, rather than keeping an artificial "started
here" commit. So I am trying to see the advantages of recording a static
bottom versus doing a merge-base calculation later. Some things I can
think of:

  - a bottom implies a specific commit, whereas a merge-base is always
    with respect to anothe tip. So to have a default "bottom" calculated
    by merge-base, you need a default "upstream". Which we do have, but
    of course it is subject to being rewound.

  - your merge-base will move when you merge. But arguably, that is a
    good thing. If you are talking about "git log" only looking at the
    commits on this branch (as you do later in the quoted email), I
    would expect to see only stuff that happened since upstream last
    merged. Although to be honest, I am not sure such a limit is all
    that useful. We already have "git log upstream..branch".

So I am not really clear on what you are trying to accomplish by
recording such a bottom. Your steps (0) through (3) seem to be leading
up to this use case:

>  (4) Operations that browse histories, e.g. "log", "show-branch", while on
>      a branch that records its bottom can be taught to pay attention to
>      the bottom.  For example, it is conceivable that
> 
>      $ git log
>      $ git log -- Documentation/
> 
>      without an explicit branch name that fell back to the default HEAD
>      while on branch "frotz" might be better run with an implicit bottom
>      ^refs/branchpoint/frotz.

If that is all you want, can't we just default to something like:

  $ git log $(git for-each-ref --format='%(upstream)' $(git symbolic-ref HEAD)))..

Of course it would be much easier to type as "git log @{upstream}.." :)

-Peff
