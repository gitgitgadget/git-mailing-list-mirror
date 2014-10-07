From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] use skip_prefix() to avoid more magic numbers
Date: Tue, 07 Oct 2014 11:21:58 -0700
Message-ID: <xmqqfvezg2pl.fsf@gitster.dls.corp.google.com>
References: <5430427A.5080800@web.de> <20141005224919.GA19998@google.com>
	<20141006011827.GA11027@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 07 20:22:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XbZOh-00006B-JT
	for gcvg-git-2@plane.gmane.org; Tue, 07 Oct 2014 20:22:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754657AbaJGSWD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2014 14:22:03 -0400
Received: from smtp.pobox.com ([208.72.237.35]:63672 "EHLO sasl.smtp.pobox.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753857AbaJGSWB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2014 14:22:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0834D13B15;
	Tue,  7 Oct 2014 14:22:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=x5VGuYWUj4iqt5oLtxUjYXwfLpo=; b=kX7bpx
	QwO2UAY1fGCceM8T2eIVFrxsA0BU+fyAMVEPPjbuUwrH+LqJ5Pl47YPJitipm1XE
	sawo4YADnQiauE89+xMnZNI6eoNtT/IWZNPA6+sos+CptYlV43q2F1H55xhnbK0G
	QEXjkE4cSrH1zwo5okAEWL+8BWw+6T7EuFQ7U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=D+3jTBlQfiGAs91UrL3AL9A91xN5Gdmc
	HFeGnj9MLlH37LkrqSqOqIhy8RS1Uc+zX09X3anvoKK+TTvjR+h+WJWLptuAbtGi
	bp7nqjMOnJpsqKi4TnEqemmHZhguzuh3SLMfTxr/cDh/pDVDhslNHI80MpFeW54S
	ISWEAmy8Mmc=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C454B13B12;
	Tue,  7 Oct 2014 14:22:00 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2E06C13B11;
	Tue,  7 Oct 2014 14:22:00 -0400 (EDT)
In-Reply-To: <20141006011827.GA11027@peff.net> (Jeff King's message of "Sun, 5
	Oct 2014 21:18:28 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D437F5BC-4E4E-11E4-8BF7-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Sun, Oct 05, 2014 at 03:49:19PM -0700, Jonathan Nieder wrote:
>
>> > --- a/builtin/branch.c
>> > +++ b/builtin/branch.c
>> > @@ -81,14 +81,16 @@ static int parse_branch_color_slot(const char *var, int ofs)
>> >  
>> >  static int git_branch_config(const char *var, const char *value, void *cb)
>> >  {
>> > +	const char *slot_name;
>> > +
>> >  	if (starts_with(var, "column."))
>> >  		return git_column_config(var, value, "branch", &colopts);
>> >  	if (!strcmp(var, "color.branch")) {
>> >  		branch_use_color = git_config_colorbool(var, value);
>> >  		return 0;
>> >  	}
>> > -	if (starts_with(var, "color.branch.")) {
>> > -		int slot = parse_branch_color_slot(var, 13);
>> > +	if (skip_prefix(var, "color.branch.", &slot_name)) {
>> > +		int slot = parse_branch_color_slot(var, slot_name - var);
>> 
>> I wonder why the separate var and offset parameters exist in the first
>> place.  Wouldn't taking a single const char * so the old code could use
>> 'var + 13' instead of 'var, 13' have worked?
>
> I think this is in the same boat as parse_diff_color_slot, which I fixed
> in 9e1a5eb (parse_diff_color_slot: drop ofs parameter, 2014-06-18). The
> short of it is that the function used to want both the full name and the
> slot name, but now needs only the latter.
>
> The fix you proposed below is along the same line, and looks good to me
> (and grepping for 'var *+ *ofs' shows only the two sites you found, so
> hopefully that is the last of it).

builtin/commit.c::parse_status_slot() has the same construct.
