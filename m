From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] revision: introduce --exclude=<glob> to tame wildcards
Date: Tue, 03 Sep 2013 09:03:31 -0700
Message-ID: <xmqq4na1vqng.fsf@gitster.dls.corp.google.com>
References: <1377838805-7693-1-git-send-email-felipe.contreras@gmail.com>
	<7vhae7k7t1.fsf@alter.siamese.dyndns.org>
	<CAMP44s1y2kvSnF3dKDMr9QtS40PNSW93DWCxFUoL658YkqYeVA@mail.gmail.com>
	<CAPc5daVSqoE74kmsobg7RpMtiL3vzKN+ckAcWEKU_Q_wF8HYuA@mail.gmail.com>
	<CAMP44s0P=XF5C8+fU2cJ-Xuq57iqcAn674Upub6N=+iiMpQK0g@mail.gmail.com>
	<xmqqeh9b15x6.fsf@gitster.dls.corp.google.com>
	<xmqq1u5aybri.fsf_-_@gitster.dls.corp.google.com>
	<5224F0EE.1080205@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Sep 03 18:03:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGt52-00053L-RO
	for gcvg-git-2@plane.gmane.org; Tue, 03 Sep 2013 18:03:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756707Ab3ICQDo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Sep 2013 12:03:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61373 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756036Ab3ICQDn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Sep 2013 12:03:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 94EEF3E88C;
	Tue,  3 Sep 2013 16:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Jd9P/tOXv6UkHMTD8cAV+3X/XvM=; b=xhwjuM
	JE8xo1nW8MUHhS5hZCKA93OBEFUJ4mbMV86IgVUn9bvYq2hrlQfFmQv9YKbP0Eqx
	ZQ14kYYW03prwdeCEc2VVx1aLIA0pg8Rbtgxh2j53pHH3FUMscJ/AliWDEM0aD8t
	Xrs+TgZa6tInrn7EXOxf97zU6nPAxpY0LTF3o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RVA77JkKAfr9mHJb+0B1qq25m26khv4k
	K6lefbD8bxY7hfn6I1172efcyhVJ7WhYiMAkQ8WNQnFs1rNx1p2vOO5lHsSEXTk+
	WbRv2SxMRLrzbYOHgOyT0hSZvf2Miwm8bMFOvnW4FHDu8xip4EdxGno2qou/TNQ4
	gtigC9+qefY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6AA0E3E88B;
	Tue,  3 Sep 2013 16:03:42 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E267B3E87A;
	Tue,  3 Sep 2013 16:03:39 +0000 (UTC)
In-Reply-To: <5224F0EE.1080205@kdbg.org> (Johannes Sixt's message of "Mon, 02
	Sep 2013 22:11:26 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 6601B83E-14B2-11E3-A695-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233733>

Johannes Sixt <j6t@kdbg.org> writes:

> Am 31.08.2013 01:55, schrieb Junio C Hamano:
>> People often find "git log --branches" etc. that includes _all_
>> branches is cumbersome to use when they want to grab most but except
>> some.  The same applies to --tags, --all and --glob.
>> 
>> Teach the revision machinery to remember patterns, and then upon the
>> next such a globbing option, exclude those that match the pattern.
>> 
>> With this, I can view only my integration branches (e.g. maint,
>> master, etc.) without topic branches, which are named after two
>> letters from primary authors' names, slash and topic name.
>> 
>>     git rev-list --no-walk --exclude=??/* --branches |
>>     git name-rev --refs refs/heads/* --stdin
>> 
>> This one shows things reachable from local and remote branches that
>> have not been merged to the integration branches.
>> 
>>     git log --remotes --branches --not --exclude=??/* --branches
>> 
>> It may be a bit rough around the edges, in that the pattern to give
>> the exclude option depends on what globbing option follows.  In
>> these examples, the pattern "??/*" is used, not "refs/heads/??/*",
>> because the globbing option that follows the -"-exclude=<pattern>"
>> is "--branches".  As each use of globbing option resets previously
>> set "--exclude", this may not be such a bad thing, though.
>
> I argued "--except should trump everything" earlier, but the case
> involving --not
>
>   --branches --except maint --not master
>
> to mean the same as
>
>   --branches --except maint master
>
> just does not make sense.

I'll have to mull the above two over to firmly grasp what you mean
by "'except' trumping 'not'" before deciding if you are agreeing or
disagreeing with the approach of taking it as a "taming wildcard"
issue...

> An alternative would be that --not would divide the command line
> arguments into ranges within which one --except would subtract
> subsequent refs from earlier globbing arguments in the same range.
> That's not simpler to explain than your current proposal.
>
> So I like the relative simplicity of this approach. Here is a bit of
> documentation.

Oh, thanks for helping.  An example or two may also help, and using
your original "I have branches and wip/" situation would be good.

        git log --exclude='wip/*' --branches::

                Show history of local branches whose names do not
                match pattern `wip/*`.

	git log --remotes --not --exclude='wip/*' --branches::

		Show history of other people's work that are not
		merged to local branches whose names do not match
		pattern `wip/*`.

or something like that, perhaps?

> --- 8< ---
> Subject: [PATCH] document --exclude option
>
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
>  Documentation/rev-list-options.txt | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
> index 5bdfb42..650c252 100644
> --- a/Documentation/rev-list-options.txt
> +++ b/Documentation/rev-list-options.txt
> @@ -174,6 +174,21 @@ parents) and `--max-parents=-1` (negative numbers denote no upper limit).
>  	is automatically prepended if missing. If pattern lacks '?', '{asterisk}',
>  	or '[', '/{asterisk}' at the end is implied.
>  
> +--exclude=<glob-pattern>::
> +
> +	Do not include refs matching '<glob-pattern>' that the next `--all`,
> +	`--branches`, `--tags`, `--remotes`, or `--glob` would otherwise
> +	consider. Repetitions of this option accumulate exclusion patterns
> +	up to the next `--all`, `--branches`, `--tags`, `--remotes`, or
> +	`--glob` option (other options or arguments do not clear
> +	accumlated patterns).
> ++
> +The patterns given should not begin with `refs/heads`, `refs/tags`, or
> +`refs/remotes` when applied to `--branches`, `--tags`, or `--remotes`,
> +restrictively, and they must begin with `refs/` when applied to `--glob`
> +or `--all`. If a trailing '/{asterisk}' is intended, it must be given
> +explicitly.
> +
>  --ignore-missing::
>  
>  	Upon seeing an invalid object name in the input, pretend as if
