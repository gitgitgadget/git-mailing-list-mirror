From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC PATCH v2 08/16] remote-helpers: Support custom transport
	options
Date: Tue, 13 Oct 2009 14:51:31 -0700
Message-ID: <20091013215131.GG9261@spearce.org>
References: <1255400715-10508-1-git-send-email-spearce@spearce.org> <1255400715-10508-9-git-send-email-spearce@spearce.org> <alpine.LNX.2.00.0910122357230.32515@iabervon.org> <20091013184531.GB9261@spearce.org> <alpine.LNX.2.00.0910131550170.32515@iabervon.org> <20091013205258.GD9261@spearce.org> <alpine.LNX.2.00.0910131732260.32515@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Oct 13 23:54:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxpIp-00018o-EP
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 23:53:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934404AbZJMVwI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2009 17:52:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934387AbZJMVwI
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Oct 2009 17:52:08 -0400
Received: from george.spearce.org ([209.20.77.23]:39756 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934374AbZJMVwH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2009 17:52:07 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 99B7A381FE; Tue, 13 Oct 2009 21:51:31 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.0910131732260.32515@iabervon.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130221>

Daniel Barkalow <barkalow@iabervon.org> wrote:
> On Tue, 13 Oct 2009, Shawn O. Pearce wrote:
> > 
> > For fetch it defaults to "on", but for push I think it defaults
> > to "off".
> 
> Nope, on ~line 849 of transport.c, it gets set for all native-transport 
> handlers, and never gets turned off. Looks like a misconversion 2 years 
> ago defaulting "data->thin" to 1 instead of 0, but it seems not to have 
> caused problems.

The rationale for why it was off by default on push was to avoid
making suboptimal packs on the server due to needing to complete
the thin pack out.  If its been off for 2 years I guess its not
that big of a deal.  We can probably leave thin out then and just
start deprecating the option.


Actually... right now I'm more concerned about why a negotiation
over the native protocol is making the client mention "have v1.5.5"
(yes, the tag object) when I'm trying to fetch between two git.git
repositories that are only 1 Junio work day apart.

In the grand scheme of things over TCP or SSH, that's a few extra
have lines.  Over the stateless HTTP its why the final request is
bloating out to 8 KiB worth of have lines.  In one Junio work day
we should only be seeing a few hundred new objects, yea pu rewinds,
but v1.5.5 isn't the best common base available to us... IMHO we
shouldn't have even mentioned it.

But fixing this is independent of smart HTTP, I'll try to circle
back later and look at why I'm seeing this oddity in the common
commit negotiation.

-- 
Shawn.
