From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC 2/2] Add Git-aware CGI for Git-aware smart HTTP transport
Date: Mon, 4 Aug 2008 07:48:24 -0700
Message-ID: <20080804144824.GB27666@spearce.org>
References: <20080803025602.GB27465@spearce.org> <1217748317-70096-1-git-send-email-spearce@spearce.org> <1217748317-70096-2-git-send-email-spearce@spearce.org> <7vwsix7nhw.fsf@gitster.siamese.dyndns.org> <20080804035921.GB2963@spearce.org> <4896D19C.6040704@dawes.za.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
To: Rogan Dawes <lists@dawes.za.net>
X-From: git-owner@vger.kernel.org Mon Aug 04 16:49:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQ1NH-0006SS-0S
	for gcvg-git-2@gmane.org; Mon, 04 Aug 2008 16:49:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753279AbYHDOsZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2008 10:48:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753075AbYHDOsZ
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Aug 2008 10:48:25 -0400
Received: from george.spearce.org ([209.20.77.23]:41295 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752627AbYHDOsY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2008 10:48:24 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 46DA738419; Mon,  4 Aug 2008 14:48:24 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <4896D19C.6040704@dawes.za.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91363>

Rogan Dawes <lists@dawes.za.net> wrote:
> Shawn O. Pearce wrote:
>>
>> 	Smart Server Detection
>> 	----------------------
>>
>> 	To detect a smart (Git-aware) server a client sends an
>> 	empty POST request to info/refs; [...]
>>
>> 		C: POST /repository.git/info/refs HTTP/1.0
>> 		C: Content-Length: 0
>
> I don't understand why you would want to keep the commands in the URL  
> when you are doing a POST?

Well, as Dscho pointed out this partly has to do with caching and
the transparent dumb server functionality.  By using the command in
the URL, and having the command match that of the dumb server file,
its easier to emulate a dumb server and also to permit caching.

Currently git-http-backend requests no caching for info/refs, but
I could see us tweaking that to permit several minutes of caching,
especially on big public sites like kernel.org.  Having info/refs
report stale by 5 minutes is not an issue when writes to there
already have a lag due to the master-slave mirroring system in use.

Because git-http-backend emulates a dumb server there is a command
dispatch table based upon the URL submitted.  Thus we already have
the command dispatch behavior implemented in the URL and doing it
in the POST body would only complicate the code further.

> Also, if everything is done via POST, you don't have to worry about a  
> wget-cloned server appearing to be "smart", since no "smarts" will ever  
> be returned in response to a GET request (and to the best of my  
> knowledge, wget can't mirror using POST).

I think we fixed the wget-cloned server issue by requesting
that clients use POST /info/refs to identify a smart server.
A wget-cloned repository will fail on this, and the client can
fallback to GET /info/refs and assume it must use the object
walker to fetch (or WebDAV to push).  A smart server would
respond to the POST /info/refs request correctly and the
client would know its smart.

-- 
Shawn.
