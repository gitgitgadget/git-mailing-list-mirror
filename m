From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] tree-diff: rework diff_tree() to generate diffs for multiparent cases as well
Date: Tue, 18 Feb 2014 13:29:30 -0800
Message-ID: <xmqqtxbwcdol.fsf@gitster.dls.corp.google.com>
References: <cover.1392299516.git.kirr@mns.spb.ru>
	<1dd9ca564e00ef235875aae4944675f53dcd25a3.1392299516.git.kirr@mns.spb.ru>
	<xmqqbnyalrk8.fsf@gitster.dls.corp.google.com>
	<20140214121529.GB3416@tugrik.mns.mnsspb.ru>
	<xmqqppmpiojn.fsf@gitster.dls.corp.google.com>
	<20140216080829.GA3820@mini.zxlink>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: kirr@mns.spb.ru, git@vger.kernel.org
To: Kirill Smelkov <kirr@navytux.spb.ru>
X-From: git-owner@vger.kernel.org Tue Feb 18 22:29:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFsEj-0007Cq-M6
	for gcvg-git-2@plane.gmane.org; Tue, 18 Feb 2014 22:29:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751411AbaBRV3t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Feb 2014 16:29:49 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57317 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751216AbaBRV3s (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Feb 2014 16:29:48 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 601CE6E95A;
	Tue, 18 Feb 2014 16:29:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nvMtrKTmZGuqftUOVgxCOCGCBHA=; b=gCU3G0
	D+71g7OVXD0QZxXUsGzgp6BSwWAClxxzWzrEaXzkgD2658fgN5RZslO5evaRUZRd
	dSQ5oFIVIVKMPI86AxpRPHDaHkwr6/weKgnSDQmo2I6pPIBSD/8ae9DljI+fvJm0
	OQ6fBsOJnTeHVxpXkNISNId8DHLNHVqSiRVcs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IT5l/JhTiiA/XyM62/4ZZC6ODP8i/DdV
	lfwn7lrcaGYpQZNTnKe5C4lF4nV55XvskszC1kJaC4yryUlbqOjmCkVIUycergha
	crOlwTLuAoTaC4Xr9iH7nERJNMw6mOYmj90erctNAhvjnz/i5d6SFj4gB5Pk6hHj
	BEoshK+ohBc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B4A856E958;
	Tue, 18 Feb 2014 16:29:46 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A50B56E939;
	Tue, 18 Feb 2014 16:29:32 -0500 (EST)
In-Reply-To: <20140216080829.GA3820@mini.zxlink> (Kirill Smelkov's message of
	"Sun, 16 Feb 2014 12:08:29 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C1C05288-98E3-11E3-BE19-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242359>

Kirill Smelkov <kirr@navytux.spb.ru> writes:

>> > 2) alloca(), for small arrays, is used for the same reason - if we change
>> > it to xmalloc()/free() the timings get worse
>> 
>> Do you see any use of it outside compat/?
>> 
>> I thought we specifically avoid alloca() for portability.  Also we
>> do not use variable-length-arrays on the stack either, I think.
>
> No, no usage outside compat/ and I knew alloca and VLAs are not used in
> Git codebase for portability, and I understand alloca will be
> criticized, but wanted to start the discussion rolling.
>
> I've actually started without alloca, and used xmalloc/free for
> [nparent] vectors, but the impact was measurable, so it just had to be
> changed to something more optimal.
>
> For me, personally, alloca is ok, but I understand there could be
> portability issues (by the way, what compiler/system Git cares about
> does not have working alloca?). Thats why I propose we do the following
>
> 1. at configure time, determine, do we have working alloca, and define
>
>     #define HAVE_ALLOCA
>
>    if yes.
>
> 2. in code
>
>     #ifdef HAVE_ALLOCA
>     # define xalloca(size)      (alloca(size))
>     # define xalloca_free(p)    do {} while(0)
>     #else
>     # define xalloca(size)      (xmalloc(size))
>     # define xalloca_free(p)    (free(p))
>     #endif
>
>    and use it like
>
>    func() {
>        p = xalloca(size);
>        ...
>
>        xalloca_free(p);
>    }
>
> This way, for systems, where alloca is available, we'll have optimal
> on-stack allocations with fast executions. On the other hand, on
> systems, where alloca is not available, this gracefully fallbacks to
> xmalloc/free.
>
> Please tell me what you think.

I guess the above is clean enough, and we cannot do better than that,
if we want to use alloca() on platforms where we can.
