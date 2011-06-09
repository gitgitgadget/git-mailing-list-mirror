From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fetch: do not leak a refspec
Date: Wed, 08 Jun 2011 17:20:46 -0700
Message-ID: <7vaadr26u9.fsf@alter.siamese.dyndns.org>
References: <87vcwgxf3q.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Thu Jun 09 02:21:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUSzc-0006r5-4T
	for gcvg-git-2@lo.gmane.org; Thu, 09 Jun 2011 02:21:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751481Ab1FIAU4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 20:20:56 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:53848 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751156Ab1FIAUy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 20:20:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id F199753FF;
	Wed,  8 Jun 2011 20:23:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TwIlOOCrrufbLSk588ueS3loTPU=; b=vLOVan
	8ghu2tfDrdq3pOFq91k70f6tcD7IgfJy0XTjNe/lb+GhDZWenPHPrgXGBX/gkv0n
	poKfolH0OwsQsJmrYPqNn3tU14E6phclVlkO8tJixqLmG10p77K7vlfTb0AuevtH
	uUXefculWvMSpWy9J9Xcs+LNibHe1x7uIG2V0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LVwy0rTDMNzZGwKiZhRQlXYjDbXTP93b
	2KztjdKCtdthgbEwi2J93Dj3z8+yfO2rWTaMaSPVgN+dl3K3eAMCLJTKcXqwd+96
	jTPBOYZRhWn4PEf7b0qyaXsPLw5Jcv66G9EicUyamix82VOoDuEx1+JFmpqL/H0j
	wTP8sytHVtA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C3CFD53FE;
	Wed,  8 Jun 2011 20:23:00 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id CDF4253FD; Wed,  8 Jun 2011
 20:22:57 -0400 (EDT)
In-Reply-To: <87vcwgxf3q.fsf@rho.meyering.net> (Jim Meyering's message of
 "Wed, 08 Jun 2011 22:06:33 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A2192C16-922E-11E0-96BD-C8CFB7AE1C3C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175477>

Jim Meyering <jim@meyering.net> writes:

> Signed-off-by: Jim Meyering <meyering@redhat.com>
> ---
> Coverity spotted this.

Thanks, will apply, but it seems that Coverity does not know or care that
this codepath is used only once in the process and the process immediately
exits after the small leak that we didn't bother spending two extra lines
to plug, which is kind of sad.

>  builtin/fetch.c |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index f9c41da..93c9938 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -875,6 +875,7 @@ static int fetch_one(struct remote *remote, int argc, const char **argv)
>  {
>  	int i;
>  	static const char **refs = NULL;
> +	struct refspec *refspec;
>  	int ref_nr = 0;
>  	int exit_code;
>
> @@ -915,8 +916,9 @@ static int fetch_one(struct remote *remote, int argc, const char **argv)
>
>  	sigchain_push_common(unlock_pack_on_signal);
>  	atexit(unlock_pack);
> -	exit_code = do_fetch(transport,
> -			parse_fetch_refspec(ref_nr, refs), ref_nr);
> +	refspec = parse_fetch_refspec(ref_nr, refs);
> +	exit_code = do_fetch(transport, refspec, ref_nr);
> +	free(refspec);
>  	transport_disconnect(transport);
>  	transport = NULL;
>  	return exit_code;
> --
> 1.7.6.rc0.293.g40857
