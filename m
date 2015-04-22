From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How do I resolve conflict after popping stash without adding the file to index?
Date: Wed, 22 Apr 2015 12:45:21 -0700
Message-ID: <xmqq8udkdk1a.fsf@gitster.dls.corp.google.com>
References: <5535697E.2030204@yandex.ru>
	<xmqqsibujyit.fsf@gitster.dls.corp.google.com>
	<553583C0.6090404@yandex.ru> <20150421212922.GC13230@peff.net>
	<5536D099.1000103@yandex.ru> <20150421225228.GB26322@peff.net>
	<xmqqa8y0f4cv.fsf@gitster.dls.corp.google.com>
	<20150422183540.GC3535@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Dmitry Gutov <dgutov@yandex.ru>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 22 21:45:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yl0aP-00073P-AZ
	for gcvg-git-2@plane.gmane.org; Wed, 22 Apr 2015 21:45:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758213AbbDVTpZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2015 15:45:25 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53552 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757814AbbDVTpY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2015 15:45:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 812624B808;
	Wed, 22 Apr 2015 15:45:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VxOdEa6jrR3RmAX8qDup8jGxVHI=; b=u8u2ci
	UK9Brh0c3IyAFN2dnQAocc484H1tSpkJxkISnLkR/xuZyubsUFmyZYcQNZcPVTq1
	QKmL5j/NM4DMYFeGh6Sejkf//5yhI64hRGweHl4usJ0Ar7KBYI0A/0O1eis8o6F+
	YoQGkfCC1JGMouwDhAQi7RfwriShE1kGQRRbk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hNRob82gxDfs33/6SuFqjdI5HAg3fAad
	VDWBjjAq9gpdhIGlBA3Sl2V+lQTuxA3cbA12R3UG1OINvJ3k4I4OuI+BUHoRlmlo
	Aap84q9nyL+PWXbc7kKC2PYg13cWLxV+dxtt+Ng7816r0Fj9WK7UvFEPE2+8mmIE
	uFCUjXaoRCg=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7830E4B807;
	Wed, 22 Apr 2015 15:45:23 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id ED7D44B805;
	Wed, 22 Apr 2015 15:45:22 -0400 (EDT)
In-Reply-To: <20150422183540.GC3535@peff.net> (Jeff King's message of "Wed, 22
	Apr 2015 14:35:41 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1D70EBFC-E928-11E4-9217-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267624>

Jeff King <peff@peff.net> writes:

> Ironically, the message before e0e2a9c actually recommends staging
> changes before applying the stash, which would lead to this exact
> situation!

The ancient history is hazy to me, but did we fall back to three-way
merge in old days (or did anything to the index for that matter), I
wonder?  In a world "git stash apply" only applied the change to the
working tree via "git apply", that old recommendation would make
perfect sense.

But obviously we do not live in such a world right now.  And because
we are doing "merge-recursive", we should insist on a clean index;
otherwise there is no way to "undo" its effect without losing the
changes by the end-user.

> So I think the most trivial patch is:
>
> diff --git a/git-stash.sh b/git-stash.sh
> index d4cf818..f1865c9 100755
> --- a/git-stash.sh
> +++ b/git-stash.sh
> @@ -442,6 +442,7 @@ apply_stash () {
>  	assert_stash_like "$@"
>  
>  	git update-index -q --refresh || die "$(gettext "unable to refresh index")"
> +	git diff-index --cached HEAD || die "dirty index; cannot apply stash"

Yes, that makes sense.  The original report from Dmitry was
triggering the safety from one line above and "git stash pop" doing
the right thing by refusing to touch the index with unresolved mergy
operation before doing anything, and with this additional safety, we
would make it even safer from people who do "git add" and then "git
stash pop" (which is somewhat strange thing to do, given that
"stash" was designed for "stash to save away; do other things; come
back to the original commit state that is 'reset --hard' clean;
unstash" sequence in the first place).

>  	# current index state
>  	c_tree=$(git write-tree) ||
>
> but it makes me wonder if somebody would find it annoying that they
> cannot apply a stash into their work-in-progress (i.e., it _might_ cause
> annoyance, but most of the time it will be convenient to do so).

They can always do "git stash show -p stash@{n} | git apply" if they
want to build changes incrementally X-<, but it would be annoying.

> So probably we'd want to refactor that into two separate functions, and
> only call the require_clean_index part.

Hmph, but what would that helper do, other than a single "diff-index
--quiet --cached HEAD" call?
