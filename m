From: Ivan Todoroski <grnch@gmx.net>
Subject: Re: [PATCH/RFC v2 1/4] fetch-pack: new --stdin option to read refs
 from stdin
Date: Wed, 28 Mar 2012 01:18:52 +0200
Message-ID: <4F724ADC.2030909@gmx.net>
References: <loom.20120318T083216-96@post.gmane.org> <m3fwd550j3.fsf@localhost.localdomain> <20120318190659.GA24829@sigill.intra.peff.net> <CACsJy8BNT-dY+wDONY_TgLnv0135RZ-47BEVMzX6c3ddH=83Zw@mail.gmail.com> <20120319024436.GB10426@sigill.intra.peff.net> <4F69B5F0.2060605@gmx.net> <CAJo=hJu0H5wfXB_y5XQ6=S0VJ9t4pxHWkuy_=rehJL_6psf00g@mail.gmail.com> <20120321171423.GA13140@sigill.intra.peff.net> <4F715CF7.5070903@gmx.net> <4F715D55.8020109@gmx.net> <7vhaxaj7yi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 28 01:18:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCfeo-000172-7k
	for gcvg-git-2@plane.gmane.org; Wed, 28 Mar 2012 01:18:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756615Ab2C0XSZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Mar 2012 19:18:25 -0400
Received: from mailout-de.gmx.net ([213.165.64.23]:54715 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755884Ab2C0XSY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2012 19:18:24 -0400
Received: (qmail invoked by alias); 27 Mar 2012 23:18:22 -0000
Received: from unknown (EHLO [127.0.0.1]) [77.28.166.58]
  by mail.gmx.net (mp031) with SMTP; 28 Mar 2012 01:18:22 +0200
X-Authenticated: #7905487
X-Provags-ID: V01U2FsdGVkX198vDs2NYh8QBZcx3DI+75XI+kzS6Bkd2ZVIWhI/a
	k29+RGG5PXtnKW
User-Agent: Thunderbird 2.0.0.24 (Windows/20100228)
In-Reply-To: <7vhaxaj7yi.fsf@alter.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194094>

On 27.03.2012 18:59, Junio C Hamano wrote:
> Ivan Todoroski <grnch@gmx.net> writes:
> 
>> +		int alloc_heads = nr_heads;
>> +		int size = nr_heads * sizeof(*heads);
>> +		heads = memcpy(xmalloc(size), heads, size);
>> +		if (args.stateless_rpc) {
>> +			/* in stateless RPC mode we use pkt-line to read
>> +			   from stdin, until we get a flush packet */
>> +			static char line[1000];
> 
> We will never have a refname that is longer than this limit?

I don't know. I grepped the code for existing usages of packet_read_line 
and that seemed to be a common idiom everywhere. Should I just bump up 
the size or is there some accepted way to read arbitrary length packets?

>> +			}
>> +		}
>> +		else {
>> +			/* read from stdin one ref per line, until EOF */
>> +			struct strbuf line;
>> +			strbuf_init(&line, 0);
>> +			for (;;) {
>> +				if (strbuf_getline(&line, stdin, '\n') == EOF)
>> +					break;
>> +				strbuf_trim(&line);
>> +				if (!line.len)
>> +					continue; /* skip empty lines */
> 
> Curious.  "stop at EOF", "trim" and "skip empty" imply that you are
> catering to people who debug this from the terminal by typing (or copy
> pasting).  Is that the expected use case?

The expected use case is people using this from shell scripts that could 
be getting refs by slicing and dicing output of other commands with 
regexps and what not which could leave some whitespace here and there, 
so a more liberal interface might be more friendly to such script writers.

Currently you would pass a list of generated refs to fetch-pack using 
something like this:

     generate-refs | xargs fetch-pack

or this:

     fetch-pack $(generate-refs)

Both of these commands will ignore any extra whitespace produced by 
"generate-refs".

Since --stdin is meant to be a spiritual replacement for the two 
commands above, I thought it should behave in a similar spirit.

At least that was the reasoning... if you're not swayed by it I can just 
remove those lines and not tolerate any extra whitespace.
