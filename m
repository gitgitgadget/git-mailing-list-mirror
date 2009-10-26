From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git hang with corrupted .pack
Date: Mon, 26 Oct 2009 07:23:51 -0700
Message-ID: <20091026142351.GZ10505@spearce.org>
References: <20091014042249.GA5250@hexapodia.org> <20091014142351.GI9261@spearce.org> <alpine.LFD.2.00.0910141208170.20122@xanadu.home> <20091014161259.GK9261@spearce.org> <alpine.LFD.2.00.0910141234540.20122@xanadu.home> <20091014180302.GL9261@spearce.org> <alpine.LFD.2.00.0910141435040.20122@xanadu.home> <7vbpk985t1.fsf@alter.siamese.dyndns.org> <81b0412b0910200814v269e91fbkd7841308685e1c54@mail.gmail.com> <7vr5sqq3vm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>, Nicolas Pitre <nico@fluxnic.net>,
	Andy Isaacson <adi@hexapodia.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 26 15:23:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2QUI-0004sf-4s
	for gcvg-git-2@lo.gmane.org; Mon, 26 Oct 2009 15:23:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752172AbZJZOXr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Oct 2009 10:23:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751981AbZJZOXr
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Oct 2009 10:23:47 -0400
Received: from george.spearce.org ([209.20.77.23]:45258 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751868AbZJZOXq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Oct 2009 10:23:46 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id A98BE381D3; Mon, 26 Oct 2009 14:23:51 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7vr5sqq3vm.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131252>

Junio C Hamano <gitster@pobox.com> wrote:
> Alex Riesen <raa.lkml@gmail.com> writes:
> > I seem to have problems with this change (on Cygwin). Sometimes
> > accessing an object in a pack fails in unpack_compressed_entry.
> > When it happens, both avail_in and avail_out of the stream are 0,
> > and the reported status is Z_BUF_ERROR.
...
> Subject: Fix incorrect error check while reading deflated pack data

Wow.  
 
> The right fix for this loop is likely to be to increment the initial
> avail_out by one (we allocate one extra byte to terminate it with NUL
> anyway, so there is no risk to overrun the buffer), and break out if we
> see that avail_out has become zero, in order to detect that the stream
> wants to produce more than what we expect.  After the loop, we have a
> check that exactly tests this condition:
> 
>     if ((st != Z_STREAM_END) || stream.total_out != size) {
>         free(buffer);
>         return NULL;
>     }
> 
> So here is a patch (without my previous botched attempts) to fix this
> issue.  The first hunk reverts the corresponding hunk from b3118bd, and
> the second hunk is the same fix proposed earlier. 

ACK.  This looks right to me too.  I forgot about that end-of-stream
marker on the input buffer, and my testing failed to have a stream
where the end-of-stream marker was in the next back window, so this
"fix" wasn't triggering.

*sigh*  Thanks for digging into this and fixing it while I was away.

-- 
Shawn.
