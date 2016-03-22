From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] bisect--helper: convert a function in shell to C
Date: Tue, 22 Mar 2016 09:03:07 -0700
Message-ID: <xmqqh9fyjy9w.fsf@gitster.mtv.corp.google.com>
References: <010201539a8d2b8a-9f168d7a-d4c6-4c23-a61f-1ef6ee22f774-000000@eu-west-1.amazonses.com>
	<010201539d57ae98-ce4860a6-f7b6-4e06-b556-3c1340cd7749-000000@eu-west-1.amazonses.com>
	<alpine.DEB.2.20.1603221552100.4690@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Pranit Bauva <pranit.bauva@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 22 17:03:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiOm4-0001EZ-Bb
	for gcvg-git-2@plane.gmane.org; Tue, 22 Mar 2016 17:03:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752021AbcCVQDN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2016 12:03:13 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:64393 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750860AbcCVQDL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2016 12:03:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A7BB14EBA0;
	Tue, 22 Mar 2016 12:03:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sPQV584XdIPWAwyF5kesa3AfHfI=; b=rigIjE
	NQXgSEslzNplEOsitxDv/tBvYaNquPJRUqOtcnuc+rOFZYrgI2zvoMxEgTH5YyDM
	HxjJRBOQMF3oMHkDjz6UzaP3VyyrZB0r+5JWPehEFlNq3IvwAZeAIJJTaKySx1ZJ
	Gn1qRUwNx/IfDG9xACmhFW2cpV+xY0gRlg5L4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xhMzDfSMVcn8zNASudKQpt4wLKy6iyLo
	hhP+HOn8mJrJj9OrMeFN/xgIi5AxPaa/CpGqPxN3Af68ylaF9o4YTTird73T5tOO
	ACAeKmjvdVDzBhasBB2K0jCURO03Re7Krx4XoURwKe61bDc48rVFebvjCWgrZVWy
	GrndamCb56o=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9D4B24EB9F;
	Tue, 22 Mar 2016 12:03:09 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 143F04EB9C;
	Tue, 22 Mar 2016 12:03:09 -0400 (EDT)
In-Reply-To: <alpine.DEB.2.20.1603221552100.4690@virtualbox> (Johannes
	Schindelin's message of "Tue, 22 Mar 2016 16:09:56 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 92358F16-F047-11E5-8FD7-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289511>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> static int one_of(const char *term, ...)
> {
> 	va_list matches;
> 	const char *match;
>
> 	va_start(matches, term);
> 	while ((match = va_arg(matches, const char *)))
> 		if (!strcmp(term, match))
> 			return 1;
> 	va_end(matches);
>
> 	return 0;
> }

This is a very good suggestion.  We tend to avoid explicit
comparison to NULL and zero, but we avoid assignment in condition
part of if/while statements even more, so

 	while ((match = va_arg(matches, const char *)) != NULL)

would be the best compromise to make it clear and readable.

>> +	if (!strcmp(term, "help") || !strcmp(term, "start") ||
>> +		!strcmp(term, "skip") || !strcmp(term, "next") ||
>> +		!strcmp(term, "reset") || !strcmp(term, "visualize") ||
>> +		!strcmp(term, "replay") || !strcmp(term, "log") ||
>> +		!strcmp(term, "run"))
>> +		die("can't use the builtin command '%s' as a term", term);
>
> This would look so much nicer using the one_of() function above.
>
> Please also note that our coding convention (as can be seen from the
> existing code in builtin/*.c) is to indent the condition differently than
> the block, either using an extra tab, or by using 4 spaces instead of the
> tab.

In general, "or by using 4 spaces" is better spelled as "or by
indenting so that the line aligns with the beginning of the inside
of the opening parenthesis on the above line"; "if (" happens to
take 4 display spaces and that is where "4" comes from and it would
be different for "while (" condition ;-).

But with one_of(...) this part would change a lot, I imagine.
>>  	struct option options[] = {
>>  		OPT_BOOL(0, "next-all", &next_all,
>>  			 N_("perform 'git bisect next'")),
>>  		OPT_BOOL(0, "no-checkout", &no_checkout,
>>  			 N_("update BISECT_HEAD instead of checking out the current commit")),
>> +		OPT_STRING(0, "check-term-format", &term, N_("term"),
>> +			 N_("check the format of the ref")),
>
> Hmm. The existing code suggests to use OPT_BOOL instead.
> ...
> The existing convention is to make the first argument *not* a value of the
> "option", i.e. `--check-term-format "$TERM_BAD"` without an equal sign.

I think it is preferrable to keep using OPT_BOOL() for this new one
if we are incrementally building on top of existing code.

But if the convention is that the option is to specify what opration
is invoked, using OPT_CMDMODE() to implement all of them would be a
worthwhile cleanup to consider at some point.

I agree with all the points you raised in your review.  Just wanted
to add some clarification myself.

Thanks.
