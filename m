From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH v3 2/2] alloc.c: remove the redundant commit_count variable
Date: Fri, 11 Jul 2014 10:41:32 +0100
Message-ID: <53BFB14C.10000@ramsay1.demon.co.uk>
References: <53BF28F4.8050704@ramsay1.demon.co.uk> <20140711003053.GB11360@sigill.intra.peff.net> <53BF3709.6000307@ramsay1.demon.co.uk> <20140711083220.GA5407@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jul 11 11:41:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5XKm-0000WY-Vn
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jul 2014 11:41:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752813AbaGKJli (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2014 05:41:38 -0400
Received: from mdfmta010.mxout.tch.inty.net ([91.221.169.51]:39653 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751854AbaGKJlg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2014 05:41:36 -0400
Received: from mdfmta010.tch.inty.net (unknown [127.0.0.1])
	by mdfmta010.tch.inty.net (Postfix) with ESMTP id CB9D3400B35;
	Fri, 11 Jul 2014 10:41:32 +0100 (BST)
Received: from mdfmta010.tch.inty.net (unknown [127.0.0.1])
	by mdfmta010.tch.inty.net (Postfix) with ESMTP id 8EF17400B22;
	Fri, 11 Jul 2014 10:41:32 +0100 (BST)
Received: from [192.168.254.1] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mdfmta010.tch.inty.net (Postfix) with ESMTP;
	Fri, 11 Jul 2014 10:41:32 +0100 (BST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <20140711083220.GA5407@sigill.intra.peff.net>
X-MDF-HostID: 19
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253266>

On 11/07/14 09:32, Jeff King wrote:
> On Fri, Jul 11, 2014 at 01:59:53AM +0100, Ramsay Jones wrote:
> 
>>> The code you're touching here was trying to make sure that each commit
>>> gets a unique index, under the assumption that commits only get
>>> allocated via alloc_commit_node. But I think that assumption is wrong.
>>> We can also get commit objects by allocating an OBJ_NONE (e.g., via
>>> lookup_unknown_object) and then converting it into an OBJ_COMMIT when we
>>> find out what it is.
>>
>> Hmm, I don't know how the object is converted, but the object allocator
>> is actually allocating an 'union any_object', so it's allocating more
>> space than for a struct object anyway.
> 
> Right, we would generally want to avoid lookup_unknown_object where we
> can for that reason.
> 
>> If you add an 'index' field to struct object, (and remove it from
>> struct commit) it could be set in alloc_object_node(). ie _all_ node
>> types get an index field.
> 
> That was something I considered when we did the original commit-slab
> work, as it would let you do similar tricks for any set of objects, not
> just commits. The reasons against it are:
> 
>   1. It would bloat the size of blob and tree structs by at least 4
>      bytes (probably 8 for alignment). In most repos, commits make up
>      only 10-20% of the total objects (so for linux.git, we're talking
>      about 25MB extra in the working set).
> 
>   2. It makes single types sparse in the index space. In cases where you
>      do just want to keep data on commits (and that is the main use),
>      you end up allocating a slab entry per object, rather than per
>      commit. That wastes memory (much worse than 25MB if your slab items
>      are large), and reduces cache locality.
> 

Ahem, yeah I keep telling myself not to post at 2am ... ;-)

Although I haven't given this too much extra thought, I'm beginning
to think that your best course would be to revert commit 969eba63
and add an convert_object_to_commit() function to commit.c which
would set c->index. Then track down each place an OBJ_NONE gets
converted to an OBJ_COMMIT and insert a call to
convert_object_to_commit(). (which may do more than just set the
index field ...)

Hmm, I've just noticed a new series in my in-box. I guess I will
discover what you decided to do shortly ... ;-P

ATB,
Ramsay Jones
