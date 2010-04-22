From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/RFD] wt-status: take advice.statusHints seriously
Date: Thu, 22 Apr 2010 00:48:42 -0700
Message-ID: <7v39yo53mt.fsf@alter.siamese.dyndns.org>
References: <b3168027365b78d47f5b95fc02f7853749075a33.1271861247.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Apr 22 09:49:07 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4r9f-0002W5-PG
	for gcvg-git-2@lo.gmane.org; Thu, 22 Apr 2010 09:49:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752691Ab0DVHsw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Apr 2010 03:48:52 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:58871 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752014Ab0DVHsv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Apr 2010 03:48:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B173A19A2;
	Thu, 22 Apr 2010 03:48:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=H601S+lsKbEcSc5PeDOanLWmCBo=; b=UnYsqa
	mRLckNLX0zL3gwYrUX5sXTn3/5V1s386IlTML6vg/WomA8f6Bt5F/cXUukkBGgWi
	EcUCDy9Ba2eeK8fkEDB0ZBPP4nbWuEYa5ecHhC08xwu6p7JQYhmch2ic3sMjRs1g
	HLla3VWYR+frzKzSWVMKcrZL4xrHcrDIknhsk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Y+mh/SVeFl+eHq37y0gJlnukJCRrFHIb
	0BREA+byNTdNd91ZVbiDSeZ3oxuP8NbZ1uIu7ipzjbYNhnWGaouFB4+ItOEA7PX7
	b/Wc2V03pVDIJhjGtE5ILqTQavShYdFWFc+Zj+b5j0T11Vfo9LYl2jX5xURASYzF
	8GtgeYd/3cU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8CA3519A0;
	Thu, 22 Apr 2010 03:48:46 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F02AA199C; Thu, 22 Apr
 2010 03:48:43 -0400 (EDT)
In-Reply-To: <b3168027365b78d47f5b95fc02f7853749075a33.1271861247.git.git@drmicha.warpmail.net> (Michael J. Gruber's message of "Wed\, 21 Apr 2010 16\:47\:51 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7B447DC4-4DE3-11DF-BD6A-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145507>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Currently, status gives a lot of hints even when advice.statusHints is
> false. Change this so that all hints depend on the config varaible.
>
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
>  wt-status.c |   12 ++++++------
>  1 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/wt-status.c b/wt-status.c
> index 8ca59a2..38076ee 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -625,7 +625,7 @@ void wt_status_print(struct wt_status *s)
>  	if (s->show_untracked_files)
>  		wt_status_print_untracked(s);
>  	else if (s->commitable)
> -		 fprintf(s->fp, "# Untracked files not listed (use -u option to show untracked files)\n");
> +		 fprintf(s->fp, "# Untracked files not listed%s\n", advice_status_hints ? " (use -u option to show untracked files)" : "");

This is a good change, but because you are losing the grep-ability with
this patch (i.e. "grep -e 'not listed (use -u'" no longer works), I'd
prefer to see this long line split into:

		 fprintf(s->fp, "# Untracked files not listed%s\n",
			advice_status_hints
			? " (use -u option to show untracked files)" : "");

Likewise for all the other changes.                        

Thanks.
