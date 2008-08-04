From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC 2/2] Add Git-aware CGI for Git-aware smart HTTP transport
Date: Mon, 4 Aug 2008 08:59:56 -0700
Message-ID: <20080804155956.GF27666@spearce.org>
References: <20080803025602.GB27465@spearce.org> <1217748317-70096-1-git-send-email-spearce@spearce.org> <1217748317-70096-2-git-send-email-spearce@spearce.org> <7vwsix7nhw.fsf@gitster.siamese.dyndns.org> <20080804035921.GB2963@spearce.org> <4896D19C.6040704@dawes.za.net> <20080804144824.GB27666@spearce.org> <48972437.5050008@dawes.za.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
To: Rogan Dawes <lists@dawes.za.net>
X-From: git-owner@vger.kernel.org Mon Aug 04 18:01:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQ2UX-0005zt-59
	for gcvg-git-2@gmane.org; Mon, 04 Aug 2008 18:01:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753533AbYHDP76 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2008 11:59:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752739AbYHDP75
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Aug 2008 11:59:57 -0400
Received: from george.spearce.org ([209.20.77.23]:60213 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751920AbYHDP75 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2008 11:59:57 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id B20B938419; Mon,  4 Aug 2008 15:59:56 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <48972437.5050008@dawes.za.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91377>

Rogan Dawes <lists@dawes.za.net> wrote:
> Shawn O. Pearce wrote:
>> Currently git-http-backend requests no caching for info/refs [...]
>
> Fair enough, but what about the quote from RFC2616 that I posted in  
> rebuttal to Dscho?
>
> > 13.10 Invalidation After Updates or Deletions
> >
> > ...
> >
> > Some HTTP methods MUST cause a cache to invalidate an entity. This is
> > either the entity referred to by the Request-URI, or by the Location
> > or Content-Location headers (if present). These methods are:
> >
> >       - PUT
> >       - DELETE
> >       - POST
>
> This doesn't seem negotiable to me.

Its not negotiable.  POST requires no caching.  End of discussion.

> For those resources that are expected to be cacheable, the request  
> should be made using a GET.

That's exactly what we are doing.  Where caching is reasonable we are
using a GET request.  Where caching cannot be performed as the server
state is changing (e.g. actually updating refs) we are using POST.
That is entirely within the guidelines of the RFC.

However we are "abusing" POST for "POST /info/refs" to detect a
Git-aware HTTP server.  Sending POST to a static resource should
always fail.

>> Because git-http-backend emulates a dumb server there is a command
>> dispatch table based upon the URL submitted.  Thus we already have
>> the command dispatch behavior implemented in the URL and doing it
>> in the POST body would only complicate the code further.
>
> Not by a huge amount, surely?
>
> if (method == "GET") command = ...
> else if (method == "POST") command = ...
> dispatch(command);

Well, true, we could do that.  But then we have to break the
command name out of the input stream.  In some cases we may just be
exec'ing another Git process and letting it handle the input stream.
Shoving the command name into the start of it just makes it that
much harder to parse out.

We already have to handle splitting PATH_TRANSLATED into a pair of
(GIT_DIR, command) so we can handle that for a GET.  We might as
well just use that very same code for POST to select the command.

Besides, by placing the command name into the URL server admins can
use regex filters in their configurations to control access.  If we
shove the command name into the body of a POST they cannot do this.

I can see sites wanting to offer anonymous smart fetch, but require
password protected smart push on the same repository URL.  Slapping
a directive like:

	<Location ~ ^/git/.*/receive-pack$>
		require valid-user
		...
	</Location>

Would easily make Apache implement this for us.  Most modern HTTP
servers should be able to be configured like this.

One of the problems with these RPC-in-HTTP systems is always the
fact that the true nature of the action isn't visible in the method
and URL, causing servers and proxies to have to parse the stream to
implement firewall rules.  Or to provide access control.  I'm trying
to reuse as much of the access control support as possible from the
HTTP server and put as little of it as possible into the backend CGI.

Since the backend CGI is based upon git-receive-pack itself admins
can use the standard pre-receive/update hook pair to manage branch
level security in a repository, while gross-level read/write can
be done in the server.

-- 
Shawn.
