From: Rogan Dawes <lists@dawes.za.net>
Subject: Re: [RFC 2/2] Add Git-aware CGI for Git-aware smart HTTP transport
Date: Mon, 04 Aug 2008 18:18:52 +0200
Message-ID: <48972BEC.1060105@dawes.za.net>
References: <20080803025602.GB27465@spearce.org> <1217748317-70096-1-git-send-email-spearce@spearce.org> <1217748317-70096-2-git-send-email-spearce@spearce.org> <7vwsix7nhw.fsf@gitster.siamese.dyndns.org> <20080804035921.GB2963@spearce.org> <4896D19C.6040704@dawes.za.net> <20080804144824.GB27666@spearce.org> <48972437.5050008@dawes.za.net> <20080804155956.GF27666@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Aug 04 18:20:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQ2nB-0004Ei-CE
	for gcvg-git-2@gmane.org; Mon, 04 Aug 2008 18:20:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754169AbYHDQTP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2008 12:19:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754117AbYHDQTP
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Aug 2008 12:19:15 -0400
Received: from sd-green-bigip-81.dreamhost.com ([208.97.132.81]:53406 "EHLO
	spunkymail-a12.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753936AbYHDQTO (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Aug 2008 12:19:14 -0400
Received: from [192.168.201.100] (unknown [41.247.123.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by spunkymail-a12.g.dreamhost.com (Postfix) with ESMTP id A9FC37FA8;
	Mon,  4 Aug 2008 09:19:01 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
In-Reply-To: <20080804155956.GF27666@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91379>

Shawn O. Pearce wrote:
> Rogan Dawes <lists@dawes.za.net> wrote:
>> Shawn O. Pearce wrote:
>>> Currently git-http-backend requests no caching for info/refs [...]
>> Fair enough, but what about the quote from RFC2616 that I posted in  
>> rebuttal to Dscho?
>>
>>> 13.10 Invalidation After Updates or Deletions
>>>
>>> ...
>>>
>>> Some HTTP methods MUST cause a cache to invalidate an entity. This is
>>> either the entity referred to by the Request-URI, or by the Location
>>> or Content-Location headers (if present). These methods are:
>>>
>>>       - PUT
>>>       - DELETE
>>>       - POST
>> This doesn't seem negotiable to me.
> 
> Its not negotiable.  POST requires no caching.  End of discussion.

Aha. So now I see the objective. I had misunderstood the intention to be 
to *allow* caching of POST'ed resources.

>> For those resources that are expected to be cacheable, the request  
>> should be made using a GET.
> 
> That's exactly what we are doing.  Where caching is reasonable we are
> using a GET request.  Where caching cannot be performed as the server
> state is changing (e.g. actually updating refs) we are using POST.
> That is entirely within the guidelines of the RFC.
> 
> However we are "abusing" POST for "POST /info/refs" to detect a
> Git-aware HTTP server.  Sending POST to a static resource should
> always fail.

Right. Either with a "405 Method not supported", or a "404 Not found". 
as I discovered.

>>> Because git-http-backend emulates a dumb server there is a command
>>> dispatch table based upon the URL submitted.  Thus we already have
>>> the command dispatch behavior implemented in the URL and doing it
>>> in the POST body would only complicate the code further.
>> Not by a huge amount, surely?
>>
>> if (method == "GET") command = ...
>> else if (method == "POST") command = ...
>> dispatch(command);
> 
> Well, true, we could do that.  But then we have to break the
> command name out of the input stream.  In some cases we may just be
> exec'ing another Git process and letting it handle the input stream.
> Shoving the command name into the start of it just makes it that
> much harder to parse out.

Fair enough. I had not thought about other uses for the input stream.

> One of the problems with these RPC-in-HTTP systems is always the
> fact that the true nature of the action isn't visible in the method
> and URL, causing servers and proxies to have to parse the stream to
> implement firewall rules.  Or to provide access control.  I'm trying
> to reuse as much of the access control support as possible from the
> HTTP server and put as little of it as possible into the backend CGI.
> 
> Since the backend CGI is based upon git-receive-pack itself admins
> can use the standard pre-receive/update hook pair to manage branch
> level security in a repository, while gross-level read/write can
> be done in the server.

Works for me!

Thanks for doing all the hard thinking for this feature :-)

Rogan
