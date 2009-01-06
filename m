From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH] Improve the sideband progress scaper to be more
	accurate
Date: Tue, 6 Jan 2009 11:27:47 -0800
Message-ID: <20090106192747.GD24578@spearce.org>
References: <1230055423-9944-1-git-send-email-spearce@spearce.org> <20081231073505.GA22551@spearce.org> <20081231190401.GI29071@spearce.org> <200901032312.53148.robin.rosenberg@dewire.com> <alpine.LFD.2.00.0901061343000.26118@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Jan 06 20:29:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKHbz-0002Uh-QF
	for gcvg-git-2@gmane.org; Tue, 06 Jan 2009 20:29:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751585AbZAFT1u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2009 14:27:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751567AbZAFT1t
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jan 2009 14:27:49 -0500
Received: from george.spearce.org ([209.20.77.23]:40355 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750944AbZAFT1s (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2009 14:27:48 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id CF31B38210; Tue,  6 Jan 2009 19:27:47 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0901061343000.26118@xanadu.home>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104709>

Nicolas Pitre <nico@cam.org> wrote:
> There may indeed be line fragments sent over the sideband channel, as 
> well as the opposite which is multiple lines sent at once in a single 
> packet.  If you look at sideband.c you'll find about all those cases.

Thanks, that's what I thought...
 
> In general, what you have to do is:
> 
>  - for each packet:
>    - split into multiple chunks on line breaks ('\r' or '\n')
>    - for each chunk:
>      - if last chunk didn't end with a line break, or if current 
>        chunk is empty or only contains a line break, then skip printing 
>        the "remote:" prefix.  Otherwise print it.
>      - print the current chunk up to any line break
>      - if current chunk contains a line break and other characters then
>        print a sequence to clear the remaining of the screen line
>      - print the line break if any

Hmm.  I should note that C Git still screws this up sometimes.  I've
seen 1.6.1 git fetch mess up the output from repo.or.cz's sideband.
I'm sure Pasky isn't running JGit's daemon, its too damn fast. :-)

I don't have a spew of it handy, but late last week I saw it screw
up while doing a clone off repo.or.cz.

Robin, maybe we should apply this patch?  Its along the lines
Nico is describing above, but because our progress code doesn't do
direct display its a little less complex, we don't have to worry
about clearing the current line.  But I think I'm doing the chunk
splitting and filtering he's talking about.

-- 
Shawn.
