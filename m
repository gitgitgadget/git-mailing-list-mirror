From: Rogan Dawes <lists@dawes.za.net>
Subject: Re: [RFC 2/2] Add Git-aware CGI for Git-aware smart HTTP transport
Date: Mon, 04 Aug 2008 11:53:32 +0200
Message-ID: <4896D19C.6040704@dawes.za.net>
References: <20080803025602.GB27465@spearce.org> <1217748317-70096-1-git-send-email-spearce@spearce.org> <1217748317-70096-2-git-send-email-spearce@spearce.org> <7vwsix7nhw.fsf@gitster.siamese.dyndns.org> <20080804035921.GB2963@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Aug 04 11:55:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPwmw-0003qH-Uj
	for gcvg-git-2@gmane.org; Mon, 04 Aug 2008 11:55:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751946AbYHDJy1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2008 05:54:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751959AbYHDJy0
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Aug 2008 05:54:26 -0400
Received: from balanced.mail.policyd.dreamhost.com ([208.97.132.119]:43029
	"EHLO spunkymail-a13.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751519AbYHDJy0 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Aug 2008 05:54:26 -0400
Received: from [192.168.201.100] (unknown [41.247.123.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by spunkymail-a13.g.dreamhost.com (Postfix) with ESMTP id 4041F129B3A;
	Mon,  4 Aug 2008 02:54:22 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
In-Reply-To: <20080804035921.GB2963@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91334>

Shawn O. Pearce wrote:

> Perhaps the smart server detection is something like:
> 
> 	Smart Server Detection
> 	----------------------
> 
> 	To detect a smart (Git-aware) server a client sends an
> 	empty POST request to info/refs; if a 200 OK response is
> 	received with the proper content type then the server can
> 	be assumed to be Git-aware, and the result contains the
> 	current info/refs data for that repository.
> 
> 		C: POST /repository.git/info/refs HTTP/1.0
> 		C: Content-Length: 0
> 
> 		S: HTTP/1.0 200 OK
> 		S: Content-Type: application/x-git-refs
> 		S:
> 		S: 95dcfa3633004da0049d3d0fa03f80589cbcaf31	refs/heads/maint
> 
> Then clients should just attempt this POST first before issuing
> a GET info/refs.  Non Git-aware servers will issue an error code,
> and the client can retry with a standard GET request, and assume
> the server isn't a newer style.
> 

I don't understand why you would want to keep the commands in the URL 
when you are doing a POST?

How about something like:

	C: POST /repository.git/ HTTP/1.0
	C: Content-Length: <calculated>
         C:
         C: <whatever command you want>

A dumb server will respond with:

	S: HTTP/1.1 405 Method not allowed

(expected according to the RFC)

Or

	S: HTTP/1.1 404 Not Found

(resulting from testing against my own repo :-) )

While a smart server will respond with a "200 Ok" and the results of the 
command.

Also, if everything is done via POST, you don't have to worry about a 
wget-cloned server appearing to be "smart", since no "smarts" will ever 
be returned in response to a GET request (and to the best of my 
knowledge, wget can't mirror using POST).

Rogan
