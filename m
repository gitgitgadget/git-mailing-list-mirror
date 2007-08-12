From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH 2/2] checkout: fix attribute handling in checkout all
Date: Mon, 13 Aug 2007 00:26:15 +0200
Message-ID: <BC69C8EA-7486-4542-B866-EC52A5BF4B1F@zib.de>
References: <11869508753328-git-send-email-prohaska@zib.de> <118695087531-git-send-email-prohaska@zib.de> <7veji8ifs2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: dmitry.kakurin@gmail.com, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 13 00:25:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKLsX-0003W6-GT
	for gcvg-git@gmane.org; Mon, 13 Aug 2007 00:25:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S938534AbXHLWZh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Aug 2007 18:25:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932614AbXHLWZg
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Aug 2007 18:25:36 -0400
Received: from mailer.zib.de ([130.73.108.11]:61017 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S938800AbXHLWZe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Aug 2007 18:25:34 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l7CMPTTk012016;
	Mon, 13 Aug 2007 00:25:29 +0200 (CEST)
Received: from [192.168.178.32] (brln-4db1ff88.pool.einsundeins.de [77.177.255.136])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l7CMPRl2010588
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Mon, 13 Aug 2007 00:25:28 +0200 (MEST)
In-Reply-To: <7veji8ifs2.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55731>


On Aug 12, 2007, at 11:50 PM, Junio C Hamano wrote:

> Steffen Prohaska <prohaska@zib.de> writes:
>
>> We need to check out .gitattributes files first to have
>> them in place when we check out the remaining files. This
>> is needed to get the right attributes during checkout,
>> for example having the right crlf conversion on the first
>> checkout if crlf is controlled by a .gitattribute file.
>>
>> This works only together with the commit
>>
>> 'attr: fix attribute handling if .gitattributes is involved'
>
> While I think it is _one_ good approach to make things two-pass,
> I do not know if this is enough.  A logic similar to this should
> be made available to the codepath that switches branches,
> shouldn't it?

I think so. I played a bit more and I am pretty sure that
switching branches suffers from the same problem. After I
understood the problem I now remember that I wondered why
I needed '-f' now and then to convince git to do things
that normally just work.


> It feels somewhat bogus to treat only the files that contain
> ".gitattributes" as substring.  Don't you want to at least say
> "is .gitattributes or ends with /.gitattributes"?

Yes, if someone really want to construct a case, he can break
my code. Where should I place a helper function, such as
ends_with_gitattributes()?


> I am not 100% convinced that it is "unexpected" that
> these two sequences give different results.
>
>  (1) rm -f .gitattributes other
>      git-checkout-index -f .gitattributes
>      git-checkout-index -f other
>
>  (2) rm -f .gitattributes other
>      git-checkout-index -f other
>      git-checkout-index -f .gitattributes

Yeah, it's not obvious to me either.

My feeling it that the working tree should match the current
content of .gitattributes. That is after you modified
.gittattributes by whatever means (checkout, editor, ...),
or you modified the global default for autocrlf, you should
have a way to update your working tree. One way would be to
force a fresh checkout of all files in the working tree.
How can I do that?

I'm pretty certain that all files in the working tree resulting
from a single command should match the .gitattributes that
were modified by the same command. This is true for initial
checkout, but also for branch switching.


> And if this is mostly to work around the chicken-and-egg problem
> of the initial checkout, I do not know if we would want to
> complicate checkout_all() nor prepare_attr_stack().  Perhaps the
> _initial_ checkout can do something like:
>
>  * look at index, checkout .gitattributes and */.gitattributes;
>  * checkout -f -a
>
> _at the Porcelain level_, without complicating the plumbing?

I'm not convinced that it's only the initial checkout. As you
already mentioned above, branch switching suffers from the
same problem. But it could perhaps be handled on a porcelain
level.

Maybe we should start with some test cases first?


> Both patches are seriously out of existing coding style, by the
> way.  Extra spaces after called function names everywhere, etc.

Hmm, I see, ... my daytime coding style got burnt into my brain.
I'd rework if needed. But let's first find out what's needed.

	Steffen
