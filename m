From: Jeff King <peff@peff.net>
Subject: Re: git repack command on larger pack file
Date: Tue, 27 Oct 2015 19:44:06 -0400
Message-ID: <20151027234406.GB4172@sigill.intra.peff.net>
References: <loom.20151026T065553-934@post.gmane.org>
 <xmqq611ujfn0.fsf@gitster.mtv.corp.google.com>
 <xmqqziz6hzom.fsf@gitster.mtv.corp.google.com>
 <loom.20151027T025257-333@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Sivakumar Selvam <gerritcode@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 28 00:44:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrDub-0006zA-Lx
	for gcvg-git-2@plane.gmane.org; Wed, 28 Oct 2015 00:44:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932125AbbJ0XoM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2015 19:44:12 -0400
Received: from cloud.peff.net ([50.56.180.127]:48882 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752138AbbJ0XoK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2015 19:44:10 -0400
Received: (qmail 9515 invoked by uid 102); 27 Oct 2015 23:44:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 27 Oct 2015 18:44:10 -0500
Received: (qmail 30108 invoked by uid 107); 27 Oct 2015 23:44:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 27 Oct 2015 19:44:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Oct 2015 19:44:06 -0400
Content-Disposition: inline
In-Reply-To: <loom.20151027T025257-333@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280318>

On Tue, Oct 27, 2015 at 02:04:23AM +0000, Sivakumar Selvam wrote:

>    When I finished git repacking, I found 12 pack files with each 4 GB and
> the total size is 48 GB. Again I ran the same git repack command by just
> removing only --max-pack-size= parameter, the size of the single pack file
> is 66 GB.
> 
> git repack -A -b -d -q --depth=50 --window=10 abc.git
> 
> Now, I see the total size of the single abc.git has become 66 GB. Initially
> it was 34 GB, After using  --max-pack-size=4g it become 48 GB. When we
> remove the --max-pack-size=4g parameter and tried to create a single pack
> file now it become 66 GB.
>    
> Looks like once we do git repack with multiple pack files, we can't revert
> back to the original size.

Git tries to take some shortcuts when repacking: if two objects are in
the same pack but not deltas, it will not consider making deltas out of
them. The logic is we would already have tried that while making the
original pack. But of course when you are doing weird things with the
packing parameters, that is not always a good assumption.

When doing experiments like this, add "-f" to your repack command-line
to avoid reusing deltas. The result should be much smaller (at the
expense of more CPU time to do the repack).

I'd also recommend increasing "--window" if you can afford the extra CPU
during the repack. It can often produce smaller packs. And it has less
cost than you might think (e.g., window=20 is not twice as expensive as
window=10, because the work to access the objects is cached).  You can
also increase --depth, but I have never found it to be particularly
helpful for decreasing size[1].

-Peff

[1] This is all theory, and I don't know how well git actually finds
    such deltas, but it is probably better to have a dense tree of
    deltas rather than long chains.  If you have a chain of N objects
    and would to add object N+1 to it, you are probably not much worse
    off to base it on object N-1, creating a "fork" at N. The resulting
    objects should be less expensive to access for subsequent operations
    (as any time you want the Nth object, you have to resolve all parts
    of the chain, so shorter chains are better, and you the delta cache
    is more likely to get a hit on that N-1 object).
