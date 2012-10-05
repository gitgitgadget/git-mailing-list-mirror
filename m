From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: upload-pack is slow with lots of refs
Date: Fri, 05 Oct 2012 08:24:01 +0200
Message-ID: <506E7D01.8080509@viscovery.net>
References: <CACBZZX70NTic2WtrXooTg+yBbiFFDAEX_Y-b=W=rAkcYKJ3T2g@mail.gmail.com> <20121003180324.GB27446@sigill.intra.peff.net> <7vobkj4cb4.fsf@alter.siamese.dyndns.org> <20121003185542.GA3635@sigill.intra.peff.net> <CAJo=hJtZ_8H6+kXPpZcRCbJi3LPuuF7M1U8YsjAp-iWvut9oMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Oct 05 08:43:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TK1dH-0006mS-Ld
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 08:43:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750810Ab2JEGn0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2012 02:43:26 -0400
Received: from so.liwest.at ([212.33.55.24]:19342 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750754Ab2JEGnZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2012 02:43:25 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1TK1KM-0003Lm-5W; Fri, 05 Oct 2012 08:24:02 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id DE5F71660F;
	Fri,  5 Oct 2012 08:24:01 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:15.0) Gecko/20120907 Thunderbird/15.0.1
In-Reply-To: <CAJo=hJtZ_8H6+kXPpZcRCbJi3LPuuF7M1U8YsjAp-iWvut9oMw@mail.gmail.com>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207072>

Am 10/3/2012 21:41, schrieb Shawn Pearce:
> On Wed, Oct 3, 2012 at 11:55 AM, Jeff King <peff@peff.net> wrote:
>> On Wed, Oct 03, 2012 at 11:53:35AM -0700, Junio C Hamano wrote:
>>> Jeff King <peff@peff.net> writes:
>>>
>>>>> Has there been any work on extending the protocol so that the client
>>>>> tells the server what refs it's interested in?
>>>>
>>>> I don't think so. It would be hard to do in a backwards-compatible way,
>>>> because the advertisement is the first thing the server says, before it
>>>> has negotiated any capabilities with the client at all.
>>>
>>> That is being discussed but hasn't surfaced on the list.
>>
>> Out of curiosity, how are you thinking about triggering such a new
>> behavior in a backwards-compatible way? Invoke git-upload-pack2, and
>> fall back to reconnecting to start git-upload-pack if it fails?
> 
> Basically, yes. New clients connect for git-upload-pack2. Over git://
> the remote peer will just close the TCP socket with no messages. The
> client can fallback to git-upload-pack and try again. Over SSH a
> similar thing will happen in the sense there is no data output from
> the remote side, so the client can try again.

These connections are bidirectional. Upload-pack can just start
advertising refs in the "v1" way and announce a "v2" capability and listen
for response in parallel. A v2 capable client can start sending "wants" or
some other signal as soon as it sees the "v2" capability. Upload-pack,
which was listening for responses in parallel, can interrupt its
advertisements and continue with v2 protocol from here.

This sounds so simple (not the implementation, of course) - I must be
missing something.

-- Hannes
