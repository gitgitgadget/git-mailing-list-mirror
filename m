From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] transport: Catch non positive --depth option value
Date: Mon, 18 Nov 2013 08:51:16 -0800
Message-ID: <xmqqzjp1bqm3.fsf@gitster.dls.corp.google.com>
References: <5283A380.9030308@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Andr=C3=A9s_G=2E_Aragoneses?= <knocte@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 18 17:51:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ViS2q-0003O0-Pw
	for gcvg-git-2@plane.gmane.org; Mon, 18 Nov 2013 17:51:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751460Ab3KRQv0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 Nov 2013 11:51:26 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47533 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751199Ab3KRQvU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Nov 2013 11:51:20 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7016B51657;
	Mon, 18 Nov 2013 11:51:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=YQWqO1YjgS/j
	LVRr1bSSQVgeL30=; b=WdeFQWs4F/OLUGe8tEvOB47jX6DwyqH3oqtwR/6weyuK
	TkDpXEC7s3s45fa9Kanr88PPXiVsE73XJ7H/r8IxFP6RCeytuAaGHdqEsOpEvX4h
	Qy42r4Gyek6deXxzy9Kd7Jaos7YAmuDQvY2PMMs/Bw3kzNnrhGUy4lqGeWXel5s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=btY8Oj
	TWjpMlo59/OCyyJljKRl61NCrd4gDu1X0jtDb4k5fkq67lqY3BeMzJz/79W0UiX6
	cc6w7mai3RcdjfbLClgCKPglCy5z0Xm+gY/OotVHIicDMusl7uQa523e+oRRZRbH
	f3iibB+L3yEKLQoJecX2Lr+wULJutt7SCp91E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 494D651656;
	Mon, 18 Nov 2013 11:51:19 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 92B3D51654;
	Mon, 18 Nov 2013 11:51:18 -0500 (EST)
In-Reply-To: <5283A380.9030308@gmail.com> (=?utf-8?Q?=22Andr=C3=A9s?= G.
 Aragoneses"'s message of
	"Wed, 13 Nov 2013 17:06:24 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A54D7CD0-5071-11E3-9C8E-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237990>

"Andr=C3=A9s G. Aragoneses" <knocte@gmail.com> writes:

> Instead of simply ignoring the value passed to --depth
> option when it is zero or negative, now it is caught
> and reported.
>
> This will let people know that they were using the
> option incorrectly (as depth<0 should be simply invalid,
> and under the hood depth=3D=3D0 didn't mean 'no depth' or
> 'no history' but 'full depth' instead).

My initial knee-jerk reaction was: doesn't this change break
existing use to unplug a shallow repository and bring it to a
repository with an unshallow one to disallow depth=3D0, though?

I somehow thought that the code supports unshallowing with --depth=3D0
even though since 4dcb167f (fetch: add --unshallow for turning
shallow repo into complete one, 2013-01-11), the officially
supported way to tell Git to unshallow is with that option.

But apparently that is not the case; I do not think depth=3D=3D0 meant
'full depth' (i.e. "git fetch --depth=3D0" did not unshallow); it was
simply ignored in fetch_pack.c::find_common() and friends.

So I think it should be a safe change to disallow non-positive depth
like this patch does, but the proposed commit log message may need
polishing.

Thanks.

> Signed-off-by: Andres G. Aragoneses <knocte@gmail.com>
> ---
>  transport.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/transport.c b/transport.c
> index 7202b77..edd63eb 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -483,6 +483,8 @@ static int set_git_option(struct
> git_transport_options *opts,
>  			opts->depth =3D strtol(value, &end, 0);
>  			if (*end)
>  				die("transport: invalid depth option '%s'", value);
> +			if (opts->depth < 1)
> +				die("transport: invalid depth option '%s' (non positive)", value=
);
>  		}
>  		return 0;
>  	}
