From: bdowning@lavos.net (Brian Downing)
Subject: Re: Preferring shallower deltas on repack
Date: Mon, 9 Jul 2007 01:52:35 -0500
Message-ID: <20070709065235.GJ4087@lavos.net>
References: <20070709044326.GH4087@lavos.net> <7v1wfixhvk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 09 08:52:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7n78-0002YP-T7
	for gcvg-git@gmane.org; Mon, 09 Jul 2007 08:52:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751501AbXGIGwq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jul 2007 02:52:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751270AbXGIGwq
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jul 2007 02:52:46 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:41003 "EHLO
	asav01.insightbb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751185AbXGIGwp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jul 2007 02:52:45 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AnA9ACt4kUZKhvbzR2dsb2JhbACBTIVdiAQBAT8B
Received: from 74-134-246-243.dhcp.insightbb.com (HELO mail.lavos.net) ([74.134.246.243])
  by asav01.insightbb.com with ESMTP; 09 Jul 2007 02:52:44 -0400
Received: by mail.lavos.net (Postfix, from userid 1000)
	id 5E1FE309F31; Mon,  9 Jul 2007 01:52:35 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <7v1wfixhvk.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51964>

On Sun, Jul 08, 2007 at 10:31:43PM -0700, Junio C Hamano wrote:
> Putting aside a potential argument that the way the file in
> question, version.lisp-expr, is kept track of might be insane,
> this is an interesting topic.

Yeah, that version numbering system worked quite well for CVS, given its
lack of any other kind of useful whole-tree versioning, and the fact
that there wasn't much branching and merging, due to it being a pain in
the ass.  If an when we move to something like Git, something else will
have to be done, as that file will /always/ be in conflict.

> In addition to the above stats, it may be interesting to know:
> 
>  - pack generation time and memory footprint (/usr/bin/time);
> 
>    I suspect you would have to try_delta more candidates, so
>    this may degrade a bit, but that is done for getting a better
>    deltification, so we would need to see if the extra cost is
>    within reason and worth spending.

It was already try_delta'ing everything in the window.  The only
difference now is that create_delta may generate one more byte of delta
before giving up.  That doesn't seem to have affected things at all
outside of sampling noise:

(These timings are for the Git pack on Linux/amd64, --window and --depth
both 100.  Since /usr/bin/time doesn't seem to report any useful memory
statistics on Linux, I also have a "ps aux" line from when the memory
size looked stable.  This was different from run to run but it shows the
two are in the same order of magnitude.)

Unpatched:
54.99user 0.18system 0:56.80elapsed 97%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (14major+32417minor)pagefaults 0swaps
bdowning  5290 98.7  4.5 106788 92900 pts/1    R+   01:26   0:49 git pack-obj

Patched:
55.37user 0.19system 0:56.35elapsed 98%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+32249minor)pagefaults 0swaps
bdowning  6086  100  4.5 106880 92996 pts/1    R+   01:29   0:49 git pack-obj

>  - resulting pack size (ls -l pack-*.pack)
> 
>    I do not expect your change would degrade in this area, as
>    you are currently not trading size with shallower delta
>    depth.

The patched version is actually smaller in both SBCL's and Git's case
(again, --window 100 and --depth 100):

SBCL: 61696 bytes smaller (13294225-13232529)
Git:  16010 bytes smaller (12690424-12674414)

I believe the reason for this is that more deltas can get in under the
depth limit.  If I repack the Git pack with --depth=999999999, the patched
version generates a pack that is 1793 bytes smaller.  (12334183-12332390)
(Hmm, I was expecting that to be the same, I'm not sure why it's not.
Padding?)

> Regarding your patch, I think it does not look too bad, as you
> never pick delta that is larger than the best-so-far in favor of
> shallower depth.
> 
> It would become worrysome (*BUT* infinitely more interesting)
> once you start talking about a tradeoff between slightly larger
> delta and much shorter delta.  Such a tradeoff, if done right,
> would make a lot of sense, but I do not offhand think of a way
> to strike a proper balance between them efficiently.

Yeah, I was thinking about that too, and came to the same conclusion.
I suspect you'd have to save a /lot/ of delta depth to want to pay any
more I/O, though.

Another thing that might be iffy (and complicated) is that if you keep
making a good low-depth delta off of a particular object, it might be
good to promote it so it stays in the window for longer.

-bcd
