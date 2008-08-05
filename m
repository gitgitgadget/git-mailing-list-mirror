From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC 2/2] Add Git-aware CGI for Git-aware smart HTTP transport
Date: Mon, 4 Aug 2008 18:57:17 -0700
Message-ID: <20080805015717.GB383@spearce.org>
References: <20080803025602.GB27465@spearce.org> <1217748317-70096-1-git-send-email-spearce@spearce.org> <1217748317-70096-2-git-send-email-spearce@spearce.org> <7vwsix7nhw.fsf@gitster.siamese.dyndns.org> <20080804035921.GB2963@spearce.org> <4896D19C.6040704@dawes.za.net> <20080804144824.GB27666@spearce.org> <4897A6E4.3070508@zytor.com> <20080805012459.GC32543@spearce.org> <4897AE53.4030107@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Rogan Dawes <lists@dawes.za.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Tue Aug 05 03:58:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQBoc-0004t2-VS
	for gcvg-git-2@gmane.org; Tue, 05 Aug 2008 03:58:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758318AbYHEB5S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2008 21:57:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758840AbYHEB5S
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Aug 2008 21:57:18 -0400
Received: from george.spearce.org ([209.20.77.23]:60916 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757049AbYHEB5R (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2008 21:57:17 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 4F66138419; Tue,  5 Aug 2008 01:57:17 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <4897AE53.4030107@zytor.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91405>

"H. Peter Anvin" <hpa@zytor.com> wrote:
> Shawn O. Pearce wrote:
>>
>> I think it is a really good idea.  Then clients don't have to worry
>> about which HTTP URL is the "correct" one for them to be using.
>
> Not arguing that URL compatibility isn't a good thing, but there are  
> other ways to accomplish it, too.  After detecting either a smart or  
> dumb server, we can use a redirect to point them to a different URL, as  
> appropriate.

I'm not sure this is necessary.

Of course it all comes down to "how does an admin map Git repositories
into the URL space of the server"?

I thought it would be simple if the admin was able to map
repositories using a ScriptAlias and allow the server to perform
path info translation to give us the filesystem location of the
repository.  Then we don't have to configure our own map of the
available Git repositories.

Once you do that though you now have the URL space associated with
that repository served by a CGI.  For older clients we need to
either serve them the file, or issue a redirect to serve the file.
The redirect is messy because we need some configuration to explain
where the files are available in the server's URL space.

Or you go the other way, and have newer git+http clients try to
find the git aware server by a redirect.  Again we have to explain
where that git aware server is in the URL space of the server.

*sigh*

> Furthermore, in the case of round-robin sites like kernel.org, this is  
> actually *mandatory* in the case of a stateful server (we need a  
> redirect to a server-specific URL), and highly recommended in the case  
> of a stateless server (because of potential skew.)

Well, the git+http protocol will hold all state in the client, making
each RPC a stateless RPC operation.  The only issue is then dealing with
skew in a server farm.

I guess we need to ask client implementations to honor a redirect
on the first request and reuse that new base URL for all subsequent
requests that are part of the same "operation".  Then server farms
can issue a redirect to a server-specific hostname if a client
comes in with a round-robin DNS hostname, thus ensuring that for
this current operation there isn't skew.

-- 
Shawn.
