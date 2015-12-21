From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] create_symref: use existing ref-lock code
Date: Mon, 21 Dec 2015 12:50:28 -0800
Message-ID: <xmqq8u4nfrvv.fsf@gitster.mtv.corp.google.com>
References: <20151220072637.GA22102@sigill.intra.peff.net>
	<20151220073414.GD30662@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Dec 21 21:50:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aB7Pf-0001ZR-4B
	for gcvg-git-2@plane.gmane.org; Mon, 21 Dec 2015 21:50:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751166AbbLUUub (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Dec 2015 15:50:31 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:63564 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750812AbbLUUua (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Dec 2015 15:50:30 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3D32A3440F;
	Mon, 21 Dec 2015 15:50:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=X2okCF77NRS0P4yWwAboMmJEi+o=; b=F06IQr
	XhI+KKVDgiBWDLu9D/3gbCgLkaIAyoy3epKHj+thKIV0V6gvY9wKk8TQe4iL62h+
	glfyWhoc2RUeyr4xac9lsCLFgksdXN4RcTOD4+UZHqS9wz4Tt15C1XvHXaC33Axf
	SV0gtDUNivhtJoMMoiBcNJBMDqXpRsCAdDysE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IGYXqNY+CXmF4jrfUWKqvRLQJwT889ev
	Snv5jQUa93m1cTHtvL+2K0IuiQtGnGOZJKouvFW0tj/MZd2hgeuaTjSLSoADYJt1
	EDr9J3GBmRg+hyjEmguXqrnPCCCvlAeIUMio+cLCuPDQyqKS+OMvjDEkpnlA9FQE
	ECnNNPKPFBY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 34FBD3440E;
	Mon, 21 Dec 2015 15:50:30 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id AC3933440C;
	Mon, 21 Dec 2015 15:50:29 -0500 (EST)
In-Reply-To: <20151220073414.GD30662@sigill.intra.peff.net> (Jeff King's
	message of "Sun, 20 Dec 2015 02:34:14 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 786A93D0-A824-11E5-A573-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282817>

Jeff King <peff@peff.net> writes:

>  #ifndef NO_SYMLINK_HEAD
> -	if (prefer_symlink_refs) {
> -		unlink(ref_path);
> -		if (!symlink(target, ref_path))
> -			goto done;

I see that the original was sloppy (most certainly my bad) ...

> +	char *ref_path = get_locked_file_path(lock->lk);
> +	unlink(ref_path);

... and you inherited that.  I see a few seemingly related helpers
in wrapper.c, but none looks useful in this context X-<.

    if (unlink_or_warn(ref_path))
    	return -1;

is close enough, but it still lets the caller fallback to textual
symref.

> +	ret = symlink(target, ref_path);
> +	free(ref_path);
> +
> +	if (ret)
>  		fprintf(stderr, "no symlink - falling back to symbolic ref\n");
> -	}
>  #endif
> +	return ret;
> +}
>  
> -	len = snprintf(buf, sizeof(buf), "ref: %s\n", target);
> -...
> -	free(lockpath);
> -
> -#ifndef NO_SYMLINK_HEAD
> -	done:
> -#endif

This huge block is worth removing ;-)  Thanks.
