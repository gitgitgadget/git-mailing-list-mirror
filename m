From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] [RFC] Add a new config. option for skipping merges in git-log
Date: Mon, 16 Mar 2015 10:53:43 -0700
Message-ID: <xmqqpp88rfq0.fsf@gitster.dls.corp.google.com>
References: <5506E751.8010506@posteo.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>
To: Koosha Khajehmoogahi <koosha@posteo.de>
X-From: git-owner@vger.kernel.org Mon Mar 16 18:53:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXZD6-0004J5-Ob
	for gcvg-git-2@plane.gmane.org; Mon, 16 Mar 2015 18:53:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754742AbbCPRxs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2015 13:53:48 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52453 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754706AbbCPRxr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Mar 2015 13:53:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8CD9E3F729;
	Mon, 16 Mar 2015 13:53:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LPVz/t+TzGpST9DIrYWXnNQQF6M=; b=pE77/2
	zA9KdRFUCa6Hoq329Iy3nZ6bDONIFOU/r8LNvoIxvzH4TeMlRVEvBHvjMcyuBuqB
	u4ZyLUo+pUKpaiP++Mnwk6IPhsIw1d5kRmFf8LctpTPTK9C/JdDqnF5dvh4gpsOY
	/X6W5LNYZcAr7MA4qrarS57o5FmSwGyjp0uwQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=H35ccDIOSVVdIK5a/qn6jwvKek2Na2qi
	qKMCI5ugPNWl/JpYdPNpnS5Pp3Z2BpXUFQhx4Va/AQbid0tuXW/sLPXpjz3++GBB
	u3Feei5u3umBb8uLGGSStPXSRSQzC2+azvSqScPPWy8DV5g1pr23JmdsP8Uny9kg
	/qO4cgxRbvQ=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8612E3F728;
	Mon, 16 Mar 2015 13:53:46 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C27EF3F725;
	Mon, 16 Mar 2015 13:53:45 -0400 (EDT)
In-Reply-To: <5506E751.8010506@posteo.de> (Koosha Khajehmoogahi's message of
	"Mon, 16 Mar 2015 15:23:13 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6453EE60-CC05-11E4-8336-A2259F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265582>

Koosha Khajehmoogahi <koosha@posteo.de> writes:

> This patch adds a 'showmerges' config. option for git-log.
> This option determines whether the log should contain merge
> commits or not. In essence, if this option is set to false,
> git-log will be run as 'git-log --no-merges'.
>
> To force git-log to show merges even if 'log.showmerges' is
> set, we use --include-merges command line option.

Yuck.

I agree that there is currently no way to revert the setting that is
touched by --merges and --no-merges back to the default, but I think
the right way to fix that is by streamlining these two options,
instead of piling yet another kludge --include-merges on top.

When we think about possible "canned" selection modes:

 (do we show merge commits?) * (do we show non-merge commits?)

we have four combinations.  Answering the above two questions with
No/No would end up showing nothing, which is meaningless, so that
leaves us three choices (of course, the user could choose to futz
directly with min/max-parents to select only Octopus merges, but
that is a more advanced/exotic usage).

Wouldn't it make more sense to spell which selection mode the user
wants with:

	git log --merges=<selection-mode>

by naming the three meaningful selection modes with short and sweet
names?  Perhaps

    default? show? both? -- show both merge commits and non-merge commits
    only -- show only merge commits
    skip -- show only non-merge commits

or something?

Now, as I always say, I am not great at naming things, so do not
take these names as the final suggestion, but I think you got the
idea.

Of course, then the traditional "--merges" option can be kept as a
short-hand for "--merges=only", and "--no-merges" would become a
short-hand for "--merges=skip".

Once we have done that streamlining of the command line options, it
will naturally follow that "log.merges = show | only | skip" would
be a useful configuration option.

I doubt we need an extra bit in rev_info to implement such a syntax
sugar.

> diff --git a/revision.h b/revision.h
> index 0ea8b4e..f496472 100644
> --- a/revision.h
> +++ b/revision.h
> @@ -145,6 +145,7 @@ struct rev_info {
>  	unsigned int	track_linear:1,
>  			track_first_time:1,
>  			linear:1;
> +	unsigned int force_show_merges:1;
>  
>  	enum date_mode date_mode;
