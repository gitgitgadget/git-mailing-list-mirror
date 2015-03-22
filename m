From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] Add a new option 'merges' to revision.c
Date: Sun, 22 Mar 2015 16:31:23 -0700
Message-ID: <xmqqoankbodw.fsf@gitster.dls.corp.google.com>
References: <1427048921-28677-1-git-send-email-koosha@posteo.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Koosha Khajehmoogahi <koosha@posteo.de>
X-From: git-owner@vger.kernel.org Mon Mar 23 00:31:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZpL9-0005kk-Ei
	for gcvg-git-2@plane.gmane.org; Mon, 23 Mar 2015 00:31:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752620AbbCVXb1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2015 19:31:27 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53962 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752190AbbCVXb0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2015 19:31:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8188B4239E;
	Sun, 22 Mar 2015 19:31:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=84DUZYVZ/gnGFo7w7obpcCFBcII=; b=LooyvX
	Ba4nTbE5+rqQV+q6suB/9rtHibMrMl3oOhKUwuLHGE9RnRszW9JgtGXusQqkOUF8
	aKrPfwqqORxZqHN1CR4ladepyas7mVVe+BmsdAagUXCtfaVqM6rtqDFAxPmDsDMP
	pSKLmB8pVNyyIyZerPXCmEFtv4gbH0FPxCj2w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tbRjtMpHuIX8LFnNCUtpROaga7kIjMQG
	JDRlf72/mgZfJtL4kKXjgDD6/yyG4y8KdeQs/JjGZ4YcZwOiNGH9R54x+sqcoXyk
	md5MTZSPfW80x3jqlwG8rVbifC25gT3xu7yphmuyScaPLMZigV5ILwOpvno85Eer
	t13PX2uO8SI=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7A5B64239D;
	Sun, 22 Mar 2015 19:31:25 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F06DB4239C;
	Sun, 22 Mar 2015 19:31:24 -0400 (EDT)
In-Reply-To: <1427048921-28677-1-git-send-email-koosha@posteo.de> (Koosha
	Khajehmoogahi's message of "Sun, 22 Mar 2015 19:28:37 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8E395C02-D0EB-11E4-8202-6DD39F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266106>

Koosha Khajehmoogahi <koosha@posteo.de> writes:

> @@ -1800,9 +1817,14 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
>  		revs->show_all = 1;
>  	} else if (!strcmp(arg, "--remove-empty")) {
>  		revs->remove_empty_trees = 1;
> +	} else if (starts_with(arg, "--merges=")) {
> +		if (parse_merges_opt(revs, arg + 9))
> +			die("unknown option: %s", arg);

This one makes sense to me (so does what the parse_merges_opt()
does).

>  	} else if (!strcmp(arg, "--merges")) {
> +		revs->max_parents = -1;
>  		revs->min_parents = 2;

But is this change warranted?  An existing user who is not at all
interested in the new --merges= option may be relying on the fact
that "--merges" does not affect the value of max_parents and she can
say "log --max-parents=2 --merges" to see only the two-way merges,
for example.  This change just broke her, and I do not see why it is
a good thing.

>  	} else if (!strcmp(arg, "--no-merges")) {
> +		revs->min_parents = 0;
>  		revs->max_parents = 1;

Likewise.
