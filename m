From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 02/25] Convert git_snpath() to strbuf_git_path()
Date: Wed, 19 Feb 2014 15:48:52 -0800
Message-ID: <xmqqeh2y7jff.fsf@gitster.dls.corp.google.com>
References: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
	<1392730814-19656-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 20 00:49:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WGGsx-00060L-96
	for gcvg-git-2@plane.gmane.org; Thu, 20 Feb 2014 00:49:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751845AbaBSXs7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Feb 2014 18:48:59 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43113 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751566AbaBSXs6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Feb 2014 18:48:58 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D67A66E698;
	Wed, 19 Feb 2014 18:48:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=ffDSg1OQZMfn
	MV5PGcYnCbuLpyc=; b=K6yoI0UOgcJ3whGgZAS1QmWvq4CTLJwdHgpEmqU1CAlc
	JJ9xBnEl24wUy9eW8PmWelRodnuwPVt93joAdtQrJ+HyMpmhk13BWILRwmA3MYNP
	DXl3GFJPr7Ftcg/+yIZquSJgvBVOujjSMpsGP+p5oRbfQRaP1d10yFhgl8YRZAM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=x+vfRp
	oesAZ6RkMb3e4rO5LMsmQ4apLksgml2xhZJI2ZNvLwoRwbXvJA2dHgmLALC6pZ78
	tjNIOj/z32P1MrGxP4k4GfLIgo+r+mR61Amo2vbF9+N11SOJsqN9syZ4FzotH0vO
	0nK6p+5pcSC3l9DiBfGMHnXTSQZQBMgVZo1GA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4C9BB6E696;
	Wed, 19 Feb 2014 18:48:57 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 234716E694;
	Wed, 19 Feb 2014 18:48:56 -0500 (EST)
In-Reply-To: <1392730814-19656-3-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Tue, 18
 Feb 2014 20:39:51 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 652DFE16-99C0-11E3-A9C9-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242419>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> @@ -651,14 +653,10 @@ static void update_refs_for_switch(const struct=
 checkout_opts *opts,
>  					new->name);
>  			}
>  		}
> -		if (old->path && old->name) {
> -			char log_file[PATH_MAX], ref_file[PATH_MAX];
> -
> -			git_snpath(log_file, sizeof(log_file), "logs/%s", old->path);
> -			git_snpath(ref_file, sizeof(ref_file), "%s", old->path);
> -			if (!file_exists(ref_file) && file_exists(log_file))
> -				remove_path(log_file);
> -		}
> +		if (old->path && old->name &&
> +		    !file_exists(git_path("%s", old->path)) &&
> +		     file_exists(git_path("logs/%s", old->path)))
> +			remove_path(git_path("logs/%s", old->path));

Hmph.  Is this conversion safe?

This adds three uses of the round-robin path buffer; if a caller of
this function used two or more path buffers obtained from
get_pathname() and expected their contents to remain stable across
the call to this, it will silently break.
