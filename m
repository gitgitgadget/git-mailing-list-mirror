From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC 0/3] faster inexact rename handling
Date: Tue, 30 Oct 2007 09:43:55 -0400
Message-ID: <20071030134355.GA21342@coredump.intra.peff.net>
References: <20071030042118.GA14729@sigill.intra.peff.net> <alpine.LFD.0.999.0710292156580.30120@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Andy C <andychup@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Oct 30 14:44:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImrO9-0001qT-Ni
	for gcvg-git-2@gmane.org; Tue, 30 Oct 2007 14:44:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752734AbXJ3NoA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 09:44:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752790AbXJ3Nn7
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 09:43:59 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4667 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752209AbXJ3Nn7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2007 09:43:59 -0400
Received: (qmail 709 invoked by uid 111); 30 Oct 2007 13:43:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 30 Oct 2007 09:43:57 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 30 Oct 2007 09:43:55 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.999.0710292156580.30120@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 29, 2007 at 10:06:11PM -0700, Linus Torvalds wrote:

> Have you compared the results? IOW, does it find the *same* renames?

>From my limited testing, it generally finds the same pairs. However,
there are a number of renames that it _doesn't_ find, because they are
composed of "uninteresting" lines, dropping them below the minimum
score. Try (in git.git):

  git-show --raw -M -l0 :/'Big tool rename'

with the old and new code. Pairs like Documentation/git-add-script.txt
-> Documentation/git-add.txt are not found, because the file is composed
almost entirely of boilerplate.

Moving the size normalization into the similarity engine should probably
fix that, and will let us compare old and new results more accurately.
I'll try to work on that.

> I'm a bit worried about the fact that you just pick a single (arbitrary) 
> src/dst per fingerprint. Yes, it should be limited, but that seems to be a 
> bit too *extremely* limited. But if it gives the same results in practice, 
> maybe nobody cares?

Yes, I have not convinced myself yet that it's the right approach (but
it seemed like a good place to try first, for simplicity and speed).  As
I noted, this approach seems to be a bit memory hungry on large, so I am
a bit concerned about increasing the size of the fingerprint_entry
structure.  However, Andy's sampling approach might help fix that.

The current code also doesn't bother marking overflow, so common lines
get attributes to some random file (actually, worse than random: if a
bunch of files have the same common lines, _all_ of the lines will go to
the last file, which means we subtly favor renames from the end of the
input list). So probably it should be tested as-is, with an "overflow,
this line is too common to be interesting" bit, and with a small-ish
limit (I had at one point tried 5, but the implementation was naive and
too memory-hungry).

-Peff
