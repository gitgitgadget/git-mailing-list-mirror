From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Smart fetch via HTTP?
Date: Fri, 18 May 2007 23:58:56 -0400
Message-ID: <20070519035856.GB3141@spearce.org>
References: <20070515201006.GD3653@efreet.light.src> <20070517124006.GO4489@pasky.or.cz> <vpqlkfnipjl.fsf@bauges.imag.fr> <alpine.LFD.0.98.0705181123590.3890@woody.linux-foundation.org> <Pine.LNX.4.64.0705181742470.20116@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Sat May 19 05:59:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpG67-0005WM-OP
	for gcvg-git@gmane.org; Sat, 19 May 2007 05:59:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750893AbXESD7J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 May 2007 23:59:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754761AbXESD7J
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 23:59:09 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:57127 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750893AbXESD7I (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2007 23:59:08 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HpG5e-00029Y-M1; Fri, 18 May 2007 23:58:46 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id E95F920FBAE; Fri, 18 May 2007 23:58:56 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0705181742470.20116@asgard.lang.hm>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47707>

david@lang.hm wrote:
> when a person browsing a hostile website will allow that website to take 
> over the machine the demand is created for 'malware filters' for http, to 
> do this the firewalls need to decode the http, and in the process limit 
> you to only doing legitimate http.
> 
> it's also the case that the companies that have firewalls paranoid enough 
> to not let you get to the git port are highly likely to be paranoid enough 
> to have a malware filtering http firewall.

I'm behind such a filter, and fetch git.git via HTTP just to keep
my work system current with Junio.  ;-)

Of course we're really really really paranoid about our firewall,
but are also so paranoid that any other web browser *except*
Microsoft Internet Explorer is thought to be a security risk and
is more-or-less banned from the network.

The kicker is some of our developers create public websites, where
testing your local webpage with Firefox and Safari is pretty much
required...  but those browsers still aren't as trusted as IE and
require special clearances.  *shakes head*

We're pretty much limited to:

 *) Running the native Git protocol SSL, where the remote system
 is answering to port 443.  It may not need to be HTTP at all,
 but it probably has to smell enough like SSL to get it through
 the malware filter.  Oh, what's that?  The filter cannot actually
 filter the SSL data?  Funny!  ;-)

 *) Using a single POST upload followed by response from server,
 formatted with minimal HTTP headers.  The real problem as people
 have pointed out is not the HTTP headers, but it is the single
 exchange.

One might think you could use HTTP pipelining to try and get a
bi-directional channel with the remote system, but I'm sure proxy
servers are not required to reuse the same TCP connection to the
remote HTTP server when the inside client piplines a new request.
So any sort of hack on pipelining won't work.

If you really want a stateful exchange you have to treat HTTP as
though it were IP, but with reliable (and much more expensive)
packet delivery, and make the Git daemon keep track of the protocol
state with the client.  Yes, that means that when the client suddenly
goes away and doesn't tell you he went away you also have to garbage
collect your state.  No nice messages from your local kernel.  :-(

-- 
Shawn.
