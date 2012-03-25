From: Ivan Todoroski <grnch_lists@gmx.net>
Subject: Re: [PATCH/RFC 2/2] remote-curl: send the refs to fetch-pack on stdin
Date: Sun, 25 Mar 2012 11:52:35 +0200
Message-ID: <4F6EEAE3.60204@gmx.net>
References: <m3fwd550j3.fsf@localhost.localdomain> <20120318190659.GA24829@sigill.intra.peff.net> <CACsJy8BNT-dY+wDONY_TgLnv0135RZ-47BEVMzX6c3ddH=83Zw@mail.gmail.com> <20120319024436.GB10426@sigill.intra.peff.net> <4F69B5F0.2060605@gmx.net> <CAJo=hJu0H5wfXB_y5XQ6=S0VJ9t4pxHWkuy_=rehJL_6psf00g@mail.gmail.com> <20120321171423.GA13140@sigill.intra.peff.net> <4F6A33C5.2080909@gmx.net> <20120321201722.GA15021@sigill.intra.peff.net> <4F6E3478.3090505@gmx.net> <20120325012432.GD27651@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Shawn Pearce <spearce@spearce.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Mar 25 11:52:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SBk7n-0006ya-Iz
	for gcvg-git-2@plane.gmane.org; Sun, 25 Mar 2012 11:52:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755444Ab2CYJwa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Mar 2012 05:52:30 -0400
Received: from mailout-de.gmx.net ([213.165.64.23]:56062 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755286Ab2CYJwP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Mar 2012 05:52:15 -0400
Received: (qmail invoked by alias); 25 Mar 2012 09:52:13 -0000
Received: from unknown (EHLO [127.0.0.1]) [77.28.174.228]
  by mail.gmx.net (mp035) with SMTP; 25 Mar 2012 11:52:13 +0200
X-Authenticated: #14478976
X-Provags-ID: V01U2FsdGVkX1/3TiVV0Lb3arXjrwWb8dJQ64iXZda3TiuGFmHjzR
	zoVi0ChUyBwgYi
User-Agent: Thunderbird 2.0.0.24 (Windows/20100228)
In-Reply-To: <20120325012432.GD27651@sigill.intra.peff.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193863>

On 25.03.2012 03:24, Jeff King wrote:
> On Sat, Mar 24, 2012 at 09:54:16PM +0100, Ivan Todoroski wrote:
>> -static int rpc_service(struct rpc_state *rpc, struct discovery *heads)
>> +static int rpc_service(struct rpc_state *rpc, struct discovery *heads,
>> +		int nr_fetch, struct ref **to_fetch)
> 
> I was curious why you needed to add new arguments for this, since we
> surely must be passing the information into rpc_service already (since
> it has to put them on the command line). And the answer is that they are
> already in the argv member of the struct rpc_state. I wonder if it would
> fit the existing style of the code to pass the arguments through a
> member in the rpc_state in the same way. I don't feel strongly about it,
> though.

Yeah, I realized this was ugly after I sent it.... not only are new 
arguments added to rpc_service(), but they seem completely arbitrary and 
specific to fetch-pack. There is no reason other callers of 
rpc_service() would want args in the exact same format.

On the other hand I can't reuse rpc_state.argv because that is already 
passed to client.argv for start_command().

Would it be OK if I add a new memeber in rpc_state, e.g. "struct strbuf 
*stdin_preamble"? If non-NULL, it would contain any data the caller of 
rpc_service() wants shoved into the stdin of the sub-command before 
anything else. That way the caller is free to format this data in 
whatever format they need, not only in the pkt-line format needed by 
fetch-pack.
