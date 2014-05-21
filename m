From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH v4 3/3] add command performance tracing to debug scripted commands
Date: Wed, 21 May 2014 10:38:13 -0700
Message-ID: <xmqq1tvnqbga.fsf@gitster.dls.corp.google.com>
References: <537BA806.50600@gmail.com> <537BA8DC.9070104@gmail.com>
	<20140521165508.GC2040@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Karsten Blees <karsten.blees@gmail.com>,
	Git List <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 21 19:38:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnAT9-0003qU-69
	for gcvg-git-2@plane.gmane.org; Wed, 21 May 2014 19:38:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752098AbaEURiT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2014 13:38:19 -0400
Received: from smtp.pobox.com ([208.72.237.35]:54481 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751786AbaEURiS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2014 13:38:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 472E717340;
	Wed, 21 May 2014 13:38:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=E/d1ODDPTuexm9iqrYTFoXeQVaQ=; b=ZVt9+5
	GuwPtEXmP0dKPOcBdAVU/RZMauy5X3IvJNt/x26+zLKj6VYYyM6+QHISYF2axtNY
	QAue1fdGiiy0uoKcQd6qjacyA6KInzVAkXppryJvAAP/egfTDB5MZFO2gO0l2Cgg
	LHmCMqXNIW0QhvDtypb9b7fzvpFCF6is5aEXs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=laXadmiTQm/A2oaGial9kc1slhv5/bYh
	wWTYxK7GESsSJzc5ulyPo+IHOHDIXU1l14GyVGRAFg//yzgNUZgoxaiRIYGc0njz
	FqcXI1XXcXh2sRvZgenIzkxYAlravWU4UbulxXYMgt8eKzY00HMpWLgBKW2HMKWM
	TpzAq4rNIL8=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3D3EB1733F;
	Wed, 21 May 2014 13:38:18 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 150B017339;
	Wed, 21 May 2014 13:38:15 -0400 (EDT)
In-Reply-To: <20140521165508.GC2040@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 21 May 2014 12:55:08 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B01126AC-E10E-11E3-8055-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249815>

Jeff King <peff@peff.net> writes:

> On Tue, May 20, 2014 at 09:11:24PM +0200, Karsten Blees wrote:
>
>> Add performance tracing to identify which git commands are called and how
>> long they execute. This is particularly useful to debug performance issues
>> of scripted commands.
>> 
>> Usage example: > GIT_TRACE_PERFORMANCE=~/git-trace.log git stash list
>> 
>> Creates a log file like this:
>> performance: at trace.c:319, time: 0.000303280 s: git command: 'git' 'rev-parse' '--git-dir'
>> performance: at trace.c:319, time: 0.000334409 s: git command: 'git' 'rev-parse' '--is-inside-work-tree'
>> performance: at trace.c:319, time: 0.000215243 s: git command: 'git' 'rev-parse' '--show-toplevel'
>> performance: at trace.c:319, time: 0.000410639 s: git command: 'git' 'config' '--get-colorbool' 'color.interactive'
>> performance: at trace.c:319, time: 0.000394077 s: git command: 'git' 'config' '--get-color' 'color.interactive.help' 'red bold'
>> performance: at trace.c:319, time: 0.000280701 s: git command: 'git' 'config' '--get-color' '' 'reset'
>> performance: at trace.c:319, time: 0.000908185 s: git command: 'git' 'rev-parse' '--verify' 'refs/stash'
>> performance: at trace.c:319, time: 0.028827774 s: git command: 'git' 'stash' 'list'
>
> Neat. I actually wanted something like this just yesterday. It looks
> like you are mainly tracing the execution of programs. Would it make
> sense to just tie this to regular trace_* calls, and if
> GIT_TRACE_PERFORMANCE is set, add a timestamp to each line?

Yeah, I very much like both, the output and your suggestion to hook
it into the existing infrastructure.

> Then we would not need to add separate trace_command_performance calls,
> and other parts of the code that are already instrumented with GIT_TRACE
> would get the feature for free.
>
> -Peff
>
> -- 
