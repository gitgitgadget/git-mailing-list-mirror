From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] install_branch_config: simplify verbose diagnostic logic
Date: Tue, 11 Mar 2014 12:56:01 -0700
Message-ID: <xmqqiorkpl0u.fsf@gitster.dls.corp.google.com>
References: <1394544412-28409-1-git-send-email-pawlo@aleg.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Pawe=C5=82?= Wawruch <pawlo@aleg.pl>
X-From: git-owner@vger.kernel.org Tue Mar 11 20:56:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNSml-0005QZ-HX
	for gcvg-git-2@plane.gmane.org; Tue, 11 Mar 2014 20:56:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755629AbaCKT4V convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Mar 2014 15:56:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64102 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755452AbaCKT4O convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Mar 2014 15:56:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DC43D743E0;
	Tue, 11 Mar 2014 15:56:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=C+ZhUJAbRwkZ
	gCxyP+k1F7JKrPM=; b=TyMDwXd5ItoGZ7DxIk6RXXGbGnuz67qFv+tWGbD5d9+W
	twrCVtcx5/NMRt9rJvj79fZjc0w0hwqihmo8jotM5SSOR6eJOWppoJWAZZaeUCiq
	KsDq9IbysDNR2IYvguJn3pNVR5vw9Hz4ysZ/RdUqA9ePym3It2wHrnVwvwEf3Y8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=rDW3LL
	PEhjtRflSgfCl0LcFD8AyyuBespU/YMWjnwpPb8NJcSBE5/nM6mECc4Q/z090DFP
	1xemCZag8zx48hvlhQy5YOQnc7gFNZdjOQdipxw+ZPIqBLFOLXS4RzlM4O5KGDR0
	WZdvnNo1KOvF+/X7Fcn6mBFbGvdMtyy5t4or8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C755D743DF;
	Tue, 11 Mar 2014 15:56:13 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DFEB9743D1;
	Tue, 11 Mar 2014 15:56:10 -0400 (EDT)
In-Reply-To: <1394544412-28409-1-git-send-email-pawlo@aleg.pl>
 (=?utf-8?Q?=22Pawe=C5=82?=
	Wawruch"'s message of "Tue, 11 Mar 2014 14:26:52 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 31847648-A957-11E3-83DA-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243886>

Pawe=C5=82 Wawruch <pawlo@aleg.pl> writes:

> Replace the chain of if statements with table of strings.
>
> Signed-off-by: Pawe=C5=82 Wawruch <pawlo@aleg.pl>
> ---
> I changed the commit message. Logic of table has changed. To make it =
more
> clear I added three dimensions of the table.=20

I am not sure if the message is "diagnostic"; it looks more like
reminder text to me.


> diff --git a/branch.c b/branch.c
> index 723a36b..741551a 100644
> --- a/branch.c
> +++ b/branch.c
> @@ -53,6 +53,21 @@ void install_branch_config(int flag, const char *l=
ocal, const char *origin, cons
>  	int remote_is_branch =3D starts_with(remote, "refs/heads/");
>  	struct strbuf key =3D STRBUF_INIT;
>  	int rebasing =3D should_setup_rebase(origin);
> +	const char *message[][2][2] =3D {{{
> +			N_("Branch %s set up to track remote branch %s from %s by rebasin=
g."),
> +			N_("Branch %s set up to track remote branch %s from %s."),
> +		},{
> +			N_("Branch %s set up to track local branch %s by rebasing."),
> +			N_("Branch %s set up to track local branch %s."),
> +		}},{{
> +			N_("Branch %s set up to track remote ref %s by rebasing."),
> +			N_("Branch %s set up to track remote ref %s."),
> +		},{
> +			N_("Branch %s set up to track local ref %s by rebasing."),
> +			N_("Branch %s set up to track local ref %s.")
> +	}}};

I almost agree with the above use of a strange brace opening/closing
convention in order to reduce the indentation levels [*1*]
but then perhaps the above can be dedented even further?

> +	const char *message[][2][2] =3D {{{
> +		N_("Branch %s set up to track remote branch %s from %s by rebasing=
=2E"),
> +		N_("Branch %s set up to track remote branch %s from %s."),
> +		}, {
> +		N_("Branch %s set up to track local branch %s by rebasing."),
> +		N_("Branch %s set up to track local branch %s."),
> +		}}, {{
> +		N_("Branch %s set up to track remote ref %s by rebasing."),
> +		N_("Branch %s set up to track remote ref %s."),
> +		}, {
> +		N_("Branch %s set up to track local ref %s by rebasing."),
> +		N_("Branch %s set up to track local ref %s.")
> +	}}};


> +	const char *name =3D remote_is_branch ? remote : shortname;
> +	int message_number;

Do you still need this variable after making it a multi-dimentional
array?


[Footnote]

*1* i.e. otherwise we would need something like

	message[][][] =3D {
				{
					{
                                        	...,
                                                ...
					},
					{
                                        	...,
                                                ...
					},
				},
                                ...
			};
