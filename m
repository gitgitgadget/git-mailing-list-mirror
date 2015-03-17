From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Add revision range support on "-" and "@{-1}"
Date: Mon, 16 Mar 2015 23:49:48 -0700
Message-ID: <xmqq8uewp183.fsf@gitster.dls.corp.google.com>
References: <1426518703-15785-1-git-send-email-kenny.lee28@gmail.com>
	<1426518703-15785-3-git-send-email-kenny.lee28@gmail.com>
	<xmqqlhiwredj.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Kenny Lee Sin Cheong <kenny.lee28@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 17 07:49:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXlK9-0003y2-83
	for gcvg-git-2@plane.gmane.org; Tue, 17 Mar 2015 07:49:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751943AbbCQGtw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2015 02:49:52 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56867 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751144AbbCQGtv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2015 02:49:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9CDE3313E7;
	Tue, 17 Mar 2015 02:49:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uUQlvKhO2CoNe+/psx5jWL4zj2A=; b=TZUMIV
	lOgRcthr6L9Wt4sl9Lx7hG10St3+RGmM99nWbMeZVeob9U4/5lVr8/hQgQUztwga
	fjA09VyHLlpTDrab4kj3loYVqhGOr+PQu7aGSUosbI4aD2qYaPMD7tThsXvshKvd
	84mdJ8CDgrVvWejv9zqGf9yUGUyQNjnlasJNU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EahUqiNyCC3haYpHr/Fl9mmn/cEok6fg
	tCuq86V5OZo3u1hDuwNelS4PulQpx+xR3FURmIb9tTO6H7+L6Ab5YCHYx/XJDv0m
	ih31R7ZeX7WC/k7W8pvd5KZAmx85W+zsj9hCAbD0tFXVMHdwYwyQr9FQmcBKd5V6
	Z9ARdpdHidM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 96670313E6;
	Tue, 17 Mar 2015 02:49:50 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1E59B313E5;
	Tue, 17 Mar 2015 02:49:50 -0400 (EDT)
In-Reply-To: <xmqqlhiwredj.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 16 Mar 2015 11:22:48 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: CED4A5E2-CC71-11E4-9B9A-A2259F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265611>

Junio C Hamano <gitster@pobox.com> writes:

>> @@ -1499,6 +1500,13 @@ int handle_revision_arg(const char *arg_, struct rev_info *revs, int flags, unsi
>>  			next = head_by_default;
>>  		if (dotdot == arg)
>>  			this = head_by_default;
>> +		/*  Allows -..<rev> and <rev>..- */
>> +		if (!strcmp(this, "-")) {
>> +			this = prev_rev;
>> +		}
>> +		if (!strcmp(next, "-")) {
>> +			next = prev_rev;
>> +		}
>
> The above two hunks are disappointing.  "this" and "next" are passed
> to get_sha1_committish() and the point of the [1/2] patch was to
> allow "-" to be just as usable as "@{-1}" anywhere a branch name can
> be used.
>
>>  		if (this == head_by_default && next == head_by_default &&
>>  		    !symmetric) {
>>  			/*
>> @@ -2198,7 +2206,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
>>  	read_from_stdin = 0;
>>  	for (left = i = 1; i < argc; i++) {
>>  		const char *arg = argv[i];
>> -		if (arg[0] == '-' && arg[1]) {
>> +		if (arg[0] == '-' && !strstr(arg, "..")) {
>
> Isn't this way too loose?  "--some-opt=I.wish..." would have ".."
> in it, and we would want to leave room to add new options that may
> take arbitrary string as an argument.
>
> I would have expected it would be more like
>
> 		if (arg[0] == '-' && arg[1] && !starts_with(arg + 1, "..")) {
>
> That is, "anything that begins with '-', if it is to be taken as an
> option, must not begin with '-..'", which I think should be strict
> enough.

I have an updated version to handle the simplest forms of range
notations on 'pu' as d40f108d ("-" and "@{-1}" on various programs,
2015-03-16).  I do not think either your !strstr(arg, "..") or my
!starts_with(arg + 1, "..")  is correct, if we really wanted to make
"-" a true stand-in for @{-1}, as we would need to stop ourselves
fall into this "This begins with a dash, so it has to be a dashed
option" block when things like these are given:

    "-^"
    "-~10"
    "-^{/^### match next}"

I have a suspicion that it might be a matter of swapping the if
clauses, that is, instead of the current way

	if (starts with '-') {
        	do the option thing;
                continue;
	}
	if (try to see if it is a revision or revision range) {
        	/* if failed, args must be pathspecs from here on */
		check the '--' disambiguation;
                add pathspec to prune-data;
	} else {
		got_rev_arg = 1;
	}

which tries "the option thing" first, do something like this:

	if (try to see if it is a revision or regvision range) {
        	/* if failed ... */
		if (starts with '-') {
                	do the option thing;
                        continue;
		}
		/* args must be pathspecs from here on */
                check the  '--' disambiguation;
                add pathspec to prune-data;
	} else {
		got_rev_arg = 1;
	}

but I didn't trace the logic myself to see if that would work.
