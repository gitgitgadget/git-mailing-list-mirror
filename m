From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] log -g: ignore revision parameters that have no reflog
Date: Tue, 02 Feb 2016 16:21:55 -0800
Message-ID: <xmqqegcuprrw.fsf@gitster.mtv.corp.google.com>
References: <1454241144.2822.7.camel@kaarsemaker.net>
	<1454455961-10640-1-git-send-email-dennis@kaarsemaker.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Dennis Kaarsemaker <dennis@kaarsemaker.net>
X-From: git-owner@vger.kernel.org Wed Feb 03 01:22:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQlCu-0004MB-53
	for gcvg-git-2@plane.gmane.org; Wed, 03 Feb 2016 01:22:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755165AbcBCAV7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2016 19:21:59 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:58257 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751982AbcBCAV6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2016 19:21:58 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 279F740223;
	Tue,  2 Feb 2016 19:21:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nsbaWJa6qBUjz51zA978RWqr4Ak=; b=OayjBm
	3rS8pKEA51lT7r7gv8r/epbEq/iUeCSW6RI6ED2Bnp6XK7H3guIRIp8ufP4NM5WD
	STHXEdTO6WwtuPsZLXXIatXG41j623joHHr1sijUrz410tSWW3JpdvNJamZH4eGg
	jCtUhtvJ2yzWjPJczs6rI6MrP6fjPugiKo/TY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EEvyp3VAmr/xq6sL1ixZUcTAbQRrm5fb
	hb/BxXb/pwc92F0Ys1+zRkZPdL8/JKfOR/7So+2gvJhhyrv//yMs1PN8jtstRI0u
	NCUVk2XJviWBE2c0409WYcN+3wU6HIu5jIC4yMKbyFQqSJwjfTFpK0sl8+kjwOz2
	eRVazU1J2d8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1F10340222;
	Tue,  2 Feb 2016 19:21:57 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 968C040221;
	Tue,  2 Feb 2016 19:21:56 -0500 (EST)
In-Reply-To: <1454455961-10640-1-git-send-email-dennis@kaarsemaker.net>
	(Dennis Kaarsemaker's message of "Wed, 3 Feb 2016 00:32:41 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 222ABCD4-CA0C-11E5-BF0B-04C16BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285320>

Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:

> +	if (revs->reflog_info) {
> +		/*
> +		 * The reflog iterator gets confused when fed things that don't
> +		 * have reflogs. Help it along a bit
> +		 */
> +		if (strchr(arg, '@') != arg &&

Is this merely an expensive way to write *arg != '@', or is there
something else I am missing?

> +		    !dwim_ref(arg, strchrnul(arg, '@')-arg, sha1, &dotdot))
> +			die("only refs can have reflogs");

Is "foo@23" a forbidden branch name?

Is this looking for a dotdot?  If you are introducing a new scope,
you can afford to invent a variable with a name that reflects its
purpose.

Style: a binary operation like '-' (subtract) have SP on both sides
of it.

> +		if(!reflog_exists(dotdot))

Style: one SP between a syntactic keyword like 'if' and opening
parenthesis is required.

I have a suspicion that in your final "fixed" code, it may be a
better design not to let the command line argument for "-g"
processing pass through this function at all.

For example, what should "git log -g master next" do?  Merge two
reflog entries in chronological order and show each of them as if
they are thrown at "git show" one by one?  Does that mesh well with
other options like "--date-order/--topo-order"?

For another example, what should "git log -g master..next" do?

Or "git log -g master^^^"?

These are merely a few example inputs I can think of off in 5
seconds and I think none of the above makes much sense, but parsing
these is the primary purpose of this function.

So, I dunno.  I gave a few "coding" comments, but I am not sure if
you are touching the right codepath in the first place.
