From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] bundle.c: fix memory leak
Date: Tue, 10 Mar 2015 20:57:30 -0700
Message-ID: <xmqqegowuqxh.fsf@gitster.dls.corp.google.com>
References: <xmqqk2yoxx1u.fsf@gitster.dls.corp.google.com>
	<1426031508-7575-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Mar 11 04:58:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVXm7-00010h-Tg
	for gcvg-git-2@plane.gmane.org; Wed, 11 Mar 2015 04:57:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751053AbbCKD5e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2015 23:57:34 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60796 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750774AbbCKD5c (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2015 23:57:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B111F40A5B;
	Tue, 10 Mar 2015 23:57:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pZepohJZDpid+CJRv1rFG6JGN3I=; b=LRfl1Q
	2wromoxdh+q5NBTK9H4NoGmzoFyX0Z2Bv8hWpH/dg4G2J/IBH7157/taSkwfuNnR
	TCUZGrotm+zSrk6BO/9utTHTnOAvwOyEdWFqY4V3lbbTB90Wt6taZ4rD9VMa9t1O
	7hoHpX70PsROKiiS0DsOjlkvxtb6cMYtsajFA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tbYie2XW9jVbtnDVL8sE5i2BzgsIuWsE
	Ranr2P710vuVs8d4cOQmzr42qmghi/hKbxE3WASGT/iI0bPOGJ7XAmOLeKrrNstJ
	+ei5Kw1VQvnps30YajgtJ1hk2hoB8t6ubplO0XwuVDL52IjDq0A4m/RP4S0ue0Sd
	IFUdwofWfCc=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AAD3140A5A;
	Tue, 10 Mar 2015 23:57:31 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 35AB340A59;
	Tue, 10 Mar 2015 23:57:31 -0400 (EDT)
In-Reply-To: <1426031508-7575-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Tue, 10 Mar 2015 16:51:48 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BDE24790-C7A2-11E4-86C2-A2259F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265294>

Stefan Beller <sbeller@google.com> writes:

> There was one continue statement without an accompanying `free(ref)`.
> Instead of adding that, replace all the free&&continue with a goto
> just after writing the refs, where we'd do the free anyway and then
> reloop.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  bundle.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/bundle.c b/bundle.c
> index 2e2dbd5..f732c92 100644
> --- a/bundle.c
> +++ b/bundle.c
> @@ -334,7 +334,7 @@ static int write_bundle_refs(int bundle_fd, struct rev_info *revs)
>  		if (e->item->flags & UNINTERESTING)
>  			continue;
>  		if (dwim_ref(e->name, strlen(e->name), sha1, &ref) != 1)
> -			continue;
> +			goto skip_write_ref;

Thanks.

I briefly wondered if we need to initialize ref=NULL for this to
work, because dwim_ref() does not need to clear ref when it says
"nothing matches", but the function actually clears it upfront, so
we should be OK.

> ...
> @@ -397,6 +395,7 @@ static int write_bundle_refs(int bundle_fd, struct rev_info *revs)
>  		write_or_die(bundle_fd, " ", 1);
>  		write_or_die(bundle_fd, display_ref, strlen(display_ref));
>  		write_or_die(bundle_fd, "\n", 1);
> + skip_write_ref:
>  		free(ref);
>  	}
