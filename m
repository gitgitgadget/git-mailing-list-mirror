From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Preferring shallower deltas on repack
Date: Sun, 08 Jul 2007 22:31:43 -0700
Message-ID: <7v1wfixhvk.fsf@assigned-by-dhcp.cox.net>
References: <20070709044326.GH4087@lavos.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: bdowning@lavos.net (Brian Downing)
X-From: git-owner@vger.kernel.org Mon Jul 09 07:31:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7lqe-00088S-Au
	for gcvg-git@gmane.org; Mon, 09 Jul 2007 07:31:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750989AbXGIFbp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jul 2007 01:31:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750788AbXGIFbp
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jul 2007 01:31:45 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:51021 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750759AbXGIFbo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jul 2007 01:31:44 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070709053143.UWWC11062.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Mon, 9 Jul 2007 01:31:43 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id MHXj1X0031kojtg0000000; Mon, 09 Jul 2007 01:31:44 -0400
In-Reply-To: <20070709044326.GH4087@lavos.net> (Brian Downing's message of
	"Sun, 8 Jul 2007 23:43:26 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51955>

bdowning@lavos.net (Brian Downing) writes:

> I modified this to prefer shallower deltas of the same size.  This made
> the deltas for this file a very wide tree with a maximum depth of about
> 65.  Other (much smaller) improvements were seen elsewhere in the pack.
> Runtime does not seem to have been affected, as most of the work had
> already been done when it was tossing deltas before.
>
> Some simple statistics:
>
> SBCL, standard pack-objects, window 100, depth 1000:
>   Max depth: 980
>   Mean depth: 100.223622114502
>   Median depth: 12
>   Standard deviation: 188.214331919176
>
> SBCL, patched pack-objects, window 100, depth 1000:
>   Max depth: 787
>   Mean depth: 61.5669990817656
>   Median depth: 11
>   Standard deviation: 127.644652607399

Putting aside a potential argument that the way the file in
question, version.lisp-expr, is kept track of might be insane,
this is an interesting topic.

In addition to the above stats, it may be interesting to know:

 - pack generation time and memory footprint (/usr/bin/time);

   I suspect you would have to try_delta more candidates, so
   this may degrade a bit, but that is done for getting a better
   deltification, so we would need to see if the extra cost is
   within reason and worth spending.

 - resulting pack size (ls -l pack-*.pack)

   I do not expect your change would degrade in this area, as
   you are currently not trading size with shallower delta
   depth.

Regarding your patch, I think it does not look too bad, as you
never pick delta that is larger than the best-so-far in favor of
shallower depth.

It would become worrysome (*BUT* infinitely more interesting)
once you start talking about a tradeoff between slightly larger
delta and much shorter delta.  Such a tradeoff, if done right,
would make a lot of sense, but I do not offhand think of a way
to strike a proper balance between them efficiently.
