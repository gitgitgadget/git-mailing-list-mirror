From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] send-pack: use buffered I/O to talk to pack-objects
Date: Thu, 09 Jun 2016 09:40:42 -0700
Message-ID: <xmqqr3c6iad1.fsf@gitster.mtv.corp.google.com>
References: <20160606151340.22424-1-william.duclot@ensimag.grenoble-inp.fr>
	<20160606151340.22424-4-william.duclot@ensimag.grenoble-inp.fr>
	<xmqqvb1mxmk4.fsf@gitster.mtv.corp.google.com>
	<20160606203901.GA7667@Messiaen>
	<xmqqfusquedk.fsf@gitster.mtv.corp.google.com>
	<20160606225847.GA22756@sigill.intra.peff.net>
	<xmqqbn3dvr22.fsf@gitster.mtv.corp.google.com>
	<20160607090653.GA4665@Messiaen> <575845D9.2010604@alum.mit.edu>
	<20160608191918.GB19572@sigill.intra.peff.net>
	<20160608194216.GA3731@sigill.intra.peff.net>
	<vpqwplypnpr.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
	William Duclot <william.duclot@ensimag.grenoble-inp.fr>,
	git@vger.kernel.org, antoine.queru@ensimag.grenoble-inp.fr,
	francois.beutin@ensimag.grenoble-inp.fr,
	Johannes.Schindelin@gmx.de, mh@glandium.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Jun 09 18:40:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bB30l-0004m0-Or
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jun 2016 18:40:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932238AbcFIQkq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2016 12:40:46 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64102 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751815AbcFIQkp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2016 12:40:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6540B21623;
	Thu,  9 Jun 2016 12:40:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=q6T8xqTmZHyRzuQeWiBxSviuINk=; b=ZmZDHd
	16SFpFdM5cDBfIFjfDjELMB5K32FqW/1V1qq8sla3vraEVNL3yiqnAaFrbaUJRbs
	hQFsnsugxOO7l4jnhheM2A1H4RNFwcymAZnb2i1WguJOn9mWpr0pKjuz+W1a+1u0
	K+lnN9j0gSoe5Pi20rkJm7KBdsv/1d/NQsdZ0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=H0hKDpUasUO+XrvCOVRAevu66yuQIgSa
	AYTkHJSJmNG8mUR+KIeq6uzfZMxzpOyxGkPh/+X2AAZ+ts6+sG3XeLXBBQT3kvjs
	wKnmZT7BZx3yqOe+3OSlASVXESeob1hXLfTOaF/2hxInlyWF/gRHc1Mwo8yanIR5
	CpI5eECljLI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5C89021622;
	Thu,  9 Jun 2016 12:40:44 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CB44F21621;
	Thu,  9 Jun 2016 12:40:43 -0400 (EDT)
In-Reply-To: <vpqwplypnpr.fsf@anie.imag.fr> (Matthieu Moy's message of "Thu,
	09 Jun 2016 14:10:24 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E8D07B4A-2E60-11E6-AAB4-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296901>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Jeff King <peff@peff.net> writes:
>
>> --- a/send-pack.c
>> +++ b/send-pack.c
>> @@ -36,18 +36,15 @@ int option_parse_push_signed(const struct option *opt,
>>  	die("bad %s argument: %s", opt->long_name, arg);
>>  }
>>  
>> -static int feed_object(const unsigned char *sha1, int fd, int negative)
>> +static void feed_object(const unsigned char *sha1, FILE *fh, int negative)
>>  {
>> -	char buf[42];
>> -
>>  	if (negative && !has_sha1_file(sha1))
>> -		return 1;
>> +		return;
> [...]
>> @@ -97,21 +95,22 @@ static int pack_objects(int fd, struct ref *refs, struct sha1_array *extra, stru
> [...]
>>  	for (i = 0; i < extra->nr; i++)
>> -		if (!feed_object(extra->sha1[i], po.in, 1))
>> -			break;
>> +		feed_object(extra->sha1[i], po_in, 1);
>
> I may have missed the obvious, but doesn't this change the behavior when
> "negative && !has_sha1_file(sha1)" happens? I understand that you don't
> need write_or_whine anymore, but don't understand how you get rid of the
> "return 1" here.

The original feed_object() has somewhat strange interface in that a
non-zero return from it is "Everything went alright!", and zero
means "Oops, something went wrong".  When the function actually
writes things out, it calls write_or_whine(), whose return value
also uses that (unusual) convention, which is the reason why it
behaves that way.

The "return 1" you noticed happens when the function is told not to
send history behind one object, but that object does not exist in
our repository.  This is a perfectly normal condition and the
function just ignores it and returns without feeding it to
pack-objects.  It reports to the caller "Everything went alright!".

The original caller checks for errors to break out the feeding of
the process early, with things like:

	if (!feed_object(...))
        	break;

IOW, the caller would have continued when hitting that "return 1"
codepath.

And the code with the patch, the caller continues unconditionally,
so there is no behaviour change, if I am reading the code correctly.

Thanks for carefully reading the change and pointing out hard-to-read
parts, as always.
