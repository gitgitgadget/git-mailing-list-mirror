From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] rev-parse: honor --quiet when asking for reflog dates that do not exist
Date: Thu, 18 Sep 2014 09:07:23 -0700
Message-ID: <xmqqr3z8q5dw.fsf@gitster.dls.corp.google.com>
References: <1410928530-21595-1-git-send-email-davvid@gmail.com>
	<1410928530-21595-2-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Jon Seymour <jon.seymour@gmail.com>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Fabian Ruch <bafain@gmail.com>, Johannes Sixt <j6t@kdbg.org>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 18 18:07:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XUeF1-0007aP-Tg
	for gcvg-git-2@plane.gmane.org; Thu, 18 Sep 2014 18:07:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932239AbaIRQH1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Sep 2014 12:07:27 -0400
Received: from smtp.pobox.com ([208.72.237.35]:60255 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932211AbaIRQH0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Sep 2014 12:07:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CB1A03AE40;
	Thu, 18 Sep 2014 12:07:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=LdE0uoWPEaVK0l5hARlKreKnycs=; b=DpiKw4
	xIyAvYXXPPUsKtQVNq1WCNPpDvvj74hr9hdmzD7sSiHxOsPhV73VyMH9js+yFaU6
	KvCVyIxDYMCT3iVTgz6Nh4GSx2eeKQKCRerQV66f0MbGcYn+AQo1RcUJzXERp2+0
	Bi0QTYqGMn13vkTtCKGo3wu3gIYY1pgkh6no4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=brlDLSmie6GnXEipmxyFmHtqoQ2zDNdg
	/3DuT3BXRLuIspinDoBFCuk09hXc8LztZIqUm8nfGeuQB5rKuC7+ycdrAdH55kws
	iKP/+kFgctsYHwXsAwjFQNIL480D8BPEK8fi1wqmpGFJrAmNM60NaQQOPnsTQd82
	V0nWrKg5WtY=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B37F83AE3C;
	Thu, 18 Sep 2014 12:07:25 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E7E563AE3B;
	Thu, 18 Sep 2014 12:07:24 -0400 (EDT)
In-Reply-To: <1410928530-21595-2-git-send-email-davvid@gmail.com> (David
	Aguilar's message of "Tue, 16 Sep 2014 21:35:30 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E121274A-3F4D-11E4-8B54-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257262>

David Aguilar <davvid@gmail.com> writes:

> Subject: Re: [PATCH 2/2] rev-parse: honor --quiet when asking for reflog dates that do not exist
> ...
> Make rev-parse --verify --quiet ref@{1.year.ago} when the reflog
> does not go back that far succeed silently with --quiet.
> ...
> +test_expect_success 'succeeds silently when using -q with invalid dates' '

These phrases may invite confusion and misunderstanding.  These
dates on which you do not know where the tip of the ref was are not
necessarily "do not exist", "does not go back that far", or "invalid".

You may have pruned old entries for a long running branch.  It is
just you no longer have records that go that far enough.

We would be able to tell two cases apart if we really wanted to by
looking at the oldest reflog entry.  If it records a creation of the
ref, then the ref did not exist back then and the reflog does not go
back that far.  It may not be a bad idea to turn the current warning
to an error in that case.  And if the oldest entry knows where the
ref used to point at, then we have expired older entries.  We can
continue giving the "oldest known" as before with a warning.

But that would be a separate issue.

> +	ref=$(git rev-parse HEAD) &&
> +	: >.git/logs/refs/test3 &&
> +	git update-ref -m "message for refs/test3" refs/test3 "$ref" &&
> +	git rev-parse -q --verify refs/test3@{1.year.ago} >actual 2>error &&
> +	test_must_be_empty error &&
> +	echo "$ref" >expect &&
> +	test_cmp expect actual
> +'
> +
>  test_expect_success 'no stdout output on error' '
>  	test -z "$(git rev-parse --verify)" &&
>  	test -z "$(git rev-parse --verify foo)" &&
