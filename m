From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: upload-pack is slow with lots of refs
Date: Tue, 09 Oct 2012 22:30:05 +0200
Message-ID: <5074894D.90307@kdbg.org>
References: <CACBZZX70NTic2WtrXooTg+yBbiFFDAEX_Y-b=W=rAkcYKJ3T2g@mail.gmail.com> <20121003180324.GB27446@sigill.intra.peff.net> <7vobkj4cb4.fsf@alter.siamese.dyndns.org> <20121003185542.GA3635@sigill.intra.peff.net> <CAJo=hJtZ_8H6+kXPpZcRCbJi3LPuuF7M1U8YsjAp-iWvut9oMw@mail.gmail.com> <506E7D01.8080509@viscovery.net> <CAJo=hJsYVdWeG0ZyqexEXNfOq_k1XDR_gGP+fy_z==LvdnWJTQ@mail.gmail.com> <5072EBD1.40500@kdbg.org> <CAJo=hJsJgqZqPxucRcSgYSa0N3pcw5seT9vcu2BE8WwfJVrvKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Oct 09 22:30:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLgRg-0007bL-LO
	for gcvg-git-2@plane.gmane.org; Tue, 09 Oct 2012 22:30:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754755Ab2JIUaS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2012 16:30:18 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:58012 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752478Ab2JIUaR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2012 16:30:17 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 98A93130052;
	Tue,  9 Oct 2012 22:30:12 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id E1BE719F3D5;
	Tue,  9 Oct 2012 22:30:05 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120825 Thunderbird/15.0
In-Reply-To: <CAJo=hJsJgqZqPxucRcSgYSa0N3pcw5seT9vcu2BE8WwfJVrvKQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207342>

Am 09.10.2012 08:46, schrieb Shawn Pearce:
> On Mon, Oct 8, 2012 at 8:05 AM, Johannes Sixt <j6t@kdbg.org> wrote:
>> Am 05.10.2012 18:57, schrieb Shawn Pearce:
>>> Smart HTTP is not bidirectional. The client can't cut off the server.
>>
>> Smart HTTP does not need it: you already posted a better solution (I'm
>> refering to "&v=2").
> 
> Yes but then it diverges even further from the native bidirectional protocol.

I won't argue here because I know next to nothing about Smart HTTP. But
it sounds like you either have compatibility, but a diverging protocol
or at least implementation, or no compatibility.

>> +static int client_spoke(void)
>> +{
>> +       struct pollfd pfd;
>> +       pfd.fd = 0;
>> +       pfd.events = POLLIN;
>> +       return poll(&pfd, 1, 0) > 0 &&
>> +               (pfd.revents & (POLLIN|POLLHUP));
> 
> Except doing this in Java is harder on an arbitrary InputStream type.
> I guess we really only care about basic TCP, in which case we can use
> NIO to implement an emulation of poll, and SSH, where MINA SSHD
> probably doesn't provide a way to see if the client has given us data
> without blocking. That makes supporting v2 really hard in e.g. Gerrit
> Code Review. You could argue that its improper to attempt to implement
> a network protocol in a language whose standard libraries have gone
> out of their way to prevent you from polling to see if data is
> immediately available, but I prefer to ignore such arguments.

Can't you read the inbound stream in a second thread while the first
thread writes the advertisements to the outbound stream? Then you don't
even need to poll; you can just read the 4-byte length header, stash it
away and set a flag. The implementation of client_spoke() would only
amount to check that flag.

> As it turns out we don't really have this problem with git://. Clients
> can bury a v2 request in the extended headers where the host line
> appears today.

I tried, but it seems that todays git-daemons are too strict and accept
only \0host=foo\0, nothing else :-(

-- Hannes
