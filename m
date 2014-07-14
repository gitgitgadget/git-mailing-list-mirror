From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 2/7] move setting of object->type to alloc_* functions
Date: Mon, 14 Jul 2014 12:03:17 +0100
Message-ID: <53C3B8F5.5000702@ramsay1.demon.co.uk>
References: <20140711084141.GA5521@sigill.intra.peff.net> <20140711084611.GB5625@sigill.intra.peff.net> <53C149B6.7010705@ramsay1.demon.co.uk> <20140712180539.GA13806@sigill.intra.peff.net> <20140713064116.GA4768@sigill.intra.peff.net> <53C2DDB7.2070708@ramsay1.demon.co.uk> <20140714055727.GA5593@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jul 14 13:03:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6e2i-0004vx-RJ
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jul 2014 13:03:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753624AbaGNLDX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2014 07:03:23 -0400
Received: from mdfmta005.mxout.tch.inty.net ([91.221.169.46]:47905 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751487AbaGNLDW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2014 07:03:22 -0400
Received: from mdfmta005.tch.inty.net (unknown [127.0.0.1])
	by mdfmta005.tch.inty.net (Postfix) with ESMTP id 6C27518CB59;
	Mon, 14 Jul 2014 12:03:31 +0100 (BST)
Received: from mdfmta005.tch.inty.net (unknown [127.0.0.1])
	by mdfmta005.tch.inty.net (Postfix) with ESMTP id 3495D18CB38;
	Mon, 14 Jul 2014 12:03:31 +0100 (BST)
Received: from [192.168.254.1] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mdfmta005.tch.inty.net (Postfix) with ESMTP;
	Mon, 14 Jul 2014 12:03:30 +0100 (BST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <20140714055727.GA5593@sigill.intra.peff.net>
X-MDF-HostID: 18
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253487>

On 14/07/14 06:57, Jeff King wrote:
> On Sun, Jul 13, 2014 at 08:27:51PM +0100, Ramsay Jones wrote:
> 
>>> Thinking on this more, writing out the definitions is the only sane
>>> thing to do here, now that alloc_commit_node does not use the macro.
>>> Otherwise you are inviting people to modify the macro, but fail to
>>> notice that the commit allocator also needs updating.
>>
>> Hmm, well I could argue that using the macro for all allocators, apart
>> from alloc_commit_node(), clearly shows which allocator is the odd-man
>> out (and conversely, that all others are the same)! :-P
>>
>> No, I don't think this is a telling advantage; I don't think it makes
>> that much difference. (six of one, half-a-dozen of the other).
> 
> Yeah, I agree with your final statement in parentheses. I am OK with it
> either way (but I have a slight preference for what I posted).

Yep, once again, this looks good to me. :-)

>> I was slightly concerned, when reading through this new series, that the
>> alloc_node() function may no longer be inlined in the new allocators.
>> However, I have just tested on Linux (only using gcc this time), and it
>> was just fine. I will test the new series on the above systems later
>> (probably tomorrow) but don't expect to find any problems.
> 
> That should not be due to my patches (which are just expanding macros),
> but rather to your 1/8, right?

Ah, no. Over the years, I've used many compilers which would happily
inline this:

    void *alloc_blob_node(void)
    {
    	return alloc_node(&blob_state, sizeof(struct blob));
    }

but not this:

    void *alloc_blob_node(void)
    {
    	struct blob *b = alloc_node(&blob_state, sizeof(struct blob));
    	return b;
    }

Admittedly, it has been many years since I've had to use such a compiler,
but old habits die hard and I always check! (The compiler is not obliged
to inline the code anyway).

> I do not know that it matters that much anyway. Yes, we allocate a lot
> of objects in some workloads. But I think it is not so tight a loop that
> the extra function call is going to kill us (and we tend to _read_ the
> allocated objects much more than we allocate them).

Yes, my testing indicates that it wouldn't be noticeable if it wasn't
inlined, at least on my git.git repo. (The largest repo I have is an
ffmpeg repo, which is only about twice the size of git.git; but I used
git.git for the timing/profiling tests). So, I'm always slightly nervous
about affecting users of really large repos.

I don't think it will be an issue either way (famous last words!). ;-)

ATB,
Ramsay Jones
