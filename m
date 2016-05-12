From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/7] submodule groups
Date: Wed, 11 May 2016 21:33:59 -0700
Message-ID: <xmqq7fezj3ns.fsf@gitster.mtv.corp.google.com>
References: <1462928397-1708-1-git-send-email-sbeller@google.com>
	<xmqq4ma5l526.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kY3S6SmJOMQ7RAKw0yTvicY=Y1VRRGdm5uK9+Eb7W+Ykg@mail.gmail.com>
	<xmqqd1osi1r8.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu May 12 06:34:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0iKE-0004Ee-Pl
	for gcvg-git-2@plane.gmane.org; Thu, 12 May 2016 06:34:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751527AbcELEeF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2016 00:34:05 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57225 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751327AbcELEeE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2016 00:34:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3039E1BD82;
	Thu, 12 May 2016 00:34:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=B6sXwMQgQLPpUD3el0pU6QhhvTo=; b=ygIFhi
	69TgKpK/cOIrQrxDIWS5DID4sBa9FyAb5h4CQCAVW+ZaSqG0h53ib4O2ztmiHTTA
	JEdtxqQzUP9UIQQbDaE2WyoxUK6Fj8/ZQmDNnQ+HtSZhhjuqE0uYpI6h89zhPKYp
	GgVE2072Pbg3FQmJgh4OXf1tMPGqKQT/GV+QE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wjMcNnBHYgNJVAar7eeRljphs8oAVJ1T
	8kKIzGhj773+vg11h7uwoiS2tv0HMv17wOtZPGNhnQD3ARptZ2DGWneWURVdwyZU
	2IAJIIKAlpHOwKckumbTlZ2aZRDPrFrI+Ll3UqhRSESwc7mRNj01QYNK73zGE9Dt
	0HF40UlgYd8=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 289551BD81;
	Thu, 12 May 2016 00:34:02 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 94E2D1BD80;
	Thu, 12 May 2016 00:34:01 -0400 (EDT)
In-Reply-To: <xmqqd1osi1r8.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Wed, 11 May 2016 17:00:27 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C0431DD0-17FA-11E6-9C3B-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294383>

Junio C Hamano <gitster@pobox.com> writes:

> I'd suggest not to over-engineer this.  Go back and imagine how
> "/bin/ls" would work is a good sanity check to gauge what complexity
> levels ordinary users would feel comfortable to handle.
>
> "ls a b" would give union of what "ls a" and "ls b" would output,
> there is no negation, and the users won't die from having to say "ls
> [A-Za-qs-z]*" to exclude files whose names begin with 'r'.

Having said all that, there is one thing we may want to consider.

For negative pathspecs, we deliberately defined its semantics to
"see if the path matches with any positive pathspec element (and it
is a non-match if no positive one matches), and then exclude if it
matches with any negative pathspec element".

That is, when you are matching 'x.o' against three-element pathspec 

	'*.c' ':(exclude)*.o' 'x.?'

you do not say "x.o does not match *.c, but it matches *.o so it is
to be excluded, ah, wait, x.? matches to revive it so it is a
match".  Instead "*.c does not and x.? does match, but *.o matches
so it is excluded".  IOW, the order of the pathspec elements given
on the command line does not matter.

Now we are adding two different criteria to specify inclusion based
on labels and names.

As implemented in the patch series under discussion, we are saying
that a submodule is included if

    - its path matches the pathspec (using the "matches one or more
      positive pathspec elements, and does not match any negaative
      pathspec element" as the definition of "matches"), OR

    - it is included in the specified set of *labels, OR

    - its name is specified by :name

There is no reason not to consider future enhancements to specify
exclusion base on these two new criretia.  A naive and easier to
implement enhancement would be to rewrite the above to (the latter
two item changes):


    - its path matches the pathspec (using the "matches one or more
      positive pathspec elements, and does not match any negaative
      pathspec element" as the definition of "matches"), OR

    - it is included in the specified set of *labels, and does not
      have any excluded *!labels, OR

    - its name is specified by :name, and is not among any excluded
      :!name.

but it does not have to be that way.  I suspect that it may make it
easier to understand and use if we OR'ed together only the positive
ones from three classes of criteria together and require at least
one of them to match, and then requiring none of the negative ones
to match.  That is, a module-spec with three elements:

     'sub*' '*label0' './:(exclude)*0'

with the implemented algorithm would choose submodules whose name
begins with 'sub' except the ones whose name ends with '0', OR those
with label0, but if we redefine the behaviour to "positive ones
together, and then exclude negative ones", then we would choose ones
whose name begins with 'sub' or ones with label0, and among these,
exclude those whose name ends with '0' (which is what your "test"
wanted to express).

The implementation of match_pathspec() does the "first positive ones
only and then negative ones" two-step process already, so I think
you could update its "int is_dir" argument to "unsigned flags",
introduce a "negative only" flag, and then do something like:

        for each path
                if (!(match_pathspec(ps, name, ..., 0) ||
                      has a "positive" label specified ||
                      has its name specified as a "postiive")
                        /* does not match any positive criteria */
                        continue;
                if (match_pathspec(ps, name, ..., NEGATIVE_ONLY) ||
                    has a "negative" label specified ||
                    has its name specified as a "negative")
                        /* explicitly excluded */
                        continue;
                /* included! */

That would open door to something like

     'sub*' '*label0' './:(exclude)*0' '*!label1'

to allow you to say "(those with label0 or whose path begins with
sub) minus (those with label1 or whose path ends with 0)".
