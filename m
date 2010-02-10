From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] blame: allow -L n,m to have an m bigger than the file's 
 line count
Date: Wed, 10 Feb 2010 10:58:02 -0800
Message-ID: <7vwrykapfp.fsf@alter.siamese.dyndns.org>
References: <1265786864-5460-1-git-send-email-bebarino@gmail.com>
 <76718491002100537h521fcc26gb267ed7cd2b8db6f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stephen Boyd <bebarino@gmail.com>, git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 10 19:58:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfHlS-0000PA-O1
	for gcvg-git-2@lo.gmane.org; Wed, 10 Feb 2010 19:58:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756438Ab0BJS6N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Feb 2010 13:58:13 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:62181 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755772Ab0BJS6M (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Feb 2010 13:58:12 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3DFFD9850E;
	Wed, 10 Feb 2010 13:58:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KpRQ+akfmOU1SsK5OCMFLAiudu0=; b=ApiVPI
	paJShMq9kPatmTREpMJDZL4b/FQ2K+21TFdlPYKv6qq3M4K1HHDsqw6pJ5N/oGDe
	biARh9IkhO6GSJYQ/nwr0j4tzMi26OioMRJohecQP1okXaQB5aAGGYZnMQxaXN2V
	jx9dkYJKyPjCop7FE/y+mwSZ6GnWKi4HPdmug=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VMgR1n3T+ptFd5J5YArWAQKeRonMQWaa
	xZhQr2/U/uO1pr7GO2k0q+YGZ7aAh6H6iJRNHnR/x9/QsbipIYo4KJfe57t/lEgA
	pDpr2hYW1OhnV9t8wK+tj5IuIn+RqB8qKVRAnwtQyoBgkjMRjit4jOq9Q73kkUHj
	ch5klijC+uE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0090E9850D;
	Wed, 10 Feb 2010 13:58:07 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1072A98501; Wed, 10 Feb
 2010 13:58:03 -0500 (EST)
In-Reply-To: <76718491002100537h521fcc26gb267ed7cd2b8db6f@mail.gmail.com>
 (Jay Soffian's message of "Wed\, 10 Feb 2010 08\:37\:36 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3A02ED04-1676-11DF-8C51-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139531>

Jay Soffian <jaysoffian@gmail.com> writes:

> On Wed, Feb 10, 2010 at 2:27 AM, Stephen Boyd <bebarino@gmail.com> wrote:
>> and get what I want but that isn't very discoverable. If the range is
>> greater than the number of lines just truncate the range to go up to
>> the end of the file.
>
> I agree this is the right thing to do. I'm working on a patch to
> support matching multiple times when given a regex range and made just
> that change as well. :-)

I would mildly suggest against going in that direction.

This is merely "mildly", because truncating 99999 in "-L200,99999" to the
number of lines in the target blob would _not_ hurt.  But it is an ugly
hack.  I would be Ok with coding that special case, but I do not want to
see it advertised, especially if we are making "omission defaults to the
end" the documented way to explicitly say "I don't care to count, just do
it til the end".

While we are talking about touching the vicinity, I think we should
tighten the -L s,e parsing rules a bit further.

There is an undocumented code that swaps start and end if the given end is
smaller than the start.  This triggers even when "-L280,300" is mis-typed
as "-L280,30".  I was bitten by this more than once---when the input does
not make sense, we should actively error out, instead of doing a wrong
thing.  I suspect that I coded it that way _only_ to support this pattern:

	-L'/^#endif \/\* !WINDOWS \/\*/,-30'

i.e. "blame 30 lines before the '#endif' line".  But the code also
internally turns "-L50,-20" into "-L 50,30" and then swaps them to may
make it "-L30,50"; this was merely an unintended side effect.

I do want to see -L'/regexp/,-offset' keep working, I do not mind if we
keep taking "-L50,-20" as an unintuitive way to spell "-L30,50", or reject
"-L50,-20" as a nonsense.  But I do want to see us reject "-L280,30" as a
typo.

As to use of more than one -L option, especially when the start (or end
for that matter) is specified with an regexp, I am of two minds.

When annotating the body of two functions, frotz and nitfol, I might
expect this to work:

    -L'/^int frotz(/,/^}/'  -L'/^int nitfol(/,/^}/'

regardless of the order these functions appear in the blob (i.e. nitfol
may be defined first).  This requires that parsing of "regexp" needs to
reset to the beginning of blob for each -L option (iow, multiple -L are
parsed independently from each other).

But at the same time, if I am actually looking at the blob contents in one
terminal while spelling the blame command line in another, it would be
nicer if the multiple -L looked for patterns incrementally.  I may
appreciate if I can write the above command line as:

    -L'/^int frotz(/,/^}/'  -L'/nitfol/,/^}/'

when I can see in my "less" of the blob contents in the other terminal
that the first line that has string "nitfol" after the end of the
definition of "frotz" is the beginning of function "nitfol".

Another thing we _might_ want to consider doing is something like:

    -L'*/^#ifdef WINDOWS/,/^#endif \/\* WINDOWS \/\*/'

to tell it "I don't care to count how many WINDOWS ifdef blocks there are;
grab all of them".

Regardless of how parsing of multiple -L goes, you need to be careful to
sort the resulting line ranges and possibly coalesce them when there are
overlaps (e.g. "-L12,+7 -L10,+5" should become "-L10,17").  And be careful
about refcounting of origin.  You'll be making multiple blame_ent and
queuing them to the scoreboard when starting, all pointing at the blame
target blob; the origin blob needs to start with the right number of
references to keep origin_decref() discarding it.
