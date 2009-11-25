From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] grep: --full-tree
Date: Wed, 25 Nov 2009 15:39:23 -0500
Message-ID: <20091125203922.GA18487@coredump.intra.peff.net>
References: <7vk4xggv27.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 25 21:39:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDOe8-0000WS-8h
	for gcvg-git-2@lo.gmane.org; Wed, 25 Nov 2009 21:39:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759759AbZKYUjQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 15:39:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759686AbZKYUjQ
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 15:39:16 -0500
Received: from peff.net ([208.65.91.99]:51361 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759145AbZKYUjP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 15:39:15 -0500
Received: (qmail 16121 invoked by uid 107); 25 Nov 2009 20:43:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 25 Nov 2009 15:43:46 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Nov 2009 15:39:23 -0500
Content-Disposition: inline
In-Reply-To: <7vk4xggv27.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133669>

On Tue, Nov 24, 2009 at 12:56:32AM -0800, Junio C Hamano wrote:

>  * In http://article.gmane.org/gmane.comp.version-control.git/111717, I
>    once argued in the opposite way, but I think it is Ok to aim for making
>    the default --full-tree in the longer run (cf. $gmane/127885).  This is
>    the first step in that direction.

Ironically, I argued for --full-tree behavior in the same thread, but
have since softened my view. What I have come to realize is that (for
me, anyway) it is very dependent on the organization of the project you
are working on.

For git.git, and most of my small-ish other projects, I want "git grep"
to search the full tree. But recently, I have been working on a
large-ish project imported from svn where the parts of interest to me
are rooted two directories deep (i.e., I am working in
"linux/subproject/", and I don't care at all what's happening in
"windows/otherproject"). I don't want grep hits from the other area to
clutter my output, and I especially don't want to waste time hitting the
disk for those pages, which are an order of magnitude larger than the
working set of files that are actually of interest to me.

On top of that, I think there are two ways within a logical subproject
to use subdirectories. In git.git, I tend to actually chdir into
Documentation/ or t/, because they have their own Makefiles. But for a
project that organizes its code into a bunch of module subdirectories
all driven by a top-level non-recursive Makefile, I tend to stay at the
root and actually do "vi module/foo.c; make".

So what that tells me is:

  1. It is not necessarily the _developer_, but a combination of
     developer and project that decides which behavior (of --full-tree
     and the current behavior) is more useful. Which to me really points
     to the utility of a config option.

  2. It would be useful to have a "partial-tree" middle ground. In other
     words, if I am in "linux/subproject/t", I would find it most
     useful if "git grep" searched all of "linux/subproject".
     Implementing that would become much more complex, though. Probably
     the user would specify a list of rooted subprojects, and we would
     prefix-match our path to find which one we were in, and then
     do a full-tree grep on that subtree.

     And yes, this is somewhat an argument in favor of splitting the
     project into submodules. But I'd really rather not do that. They
     introduce significant complexity, and the rest of git is so _good_
     at ignoring uninteresting parts.

-Peff
