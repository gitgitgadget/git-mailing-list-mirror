From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] sha1: clean pointer arithmetic
Date: Wed, 12 Sep 2012 11:37:31 -0700
Message-ID: <7vd31rcck4.fsf@alter.siamese.dyndns.org>
References: <cover.1347442430.git.ydroneaud@opteya.com>
 <20dce012a57900b61e51c0e0d8dfb5573693010e.1347442430.git.ydroneaud@opteya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Yann Droneaud <ydroneaud@opteya.com>
X-From: git-owner@vger.kernel.org Wed Sep 12 20:37:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBrom-0005F6-03
	for gcvg-git-2@plane.gmane.org; Wed, 12 Sep 2012 20:37:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754736Ab2ILShg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Sep 2012 14:37:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59069 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752828Ab2ILShf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Sep 2012 14:37:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 042829AC5;
	Wed, 12 Sep 2012 14:37:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0KwfKq882A7E0iFxm2R9HRkHIds=; b=MkYgF6
	XtFEZWUmoCkQOHjYvFGEBAzZWb1fE0Yt8v30URVHpPK5O74CnAS68hTbxCDwL7A+
	tIT4DXtfDuhY/gEYJYp6Tun/3oiYLucjpoLMKDFSaGERSHiqAYYtA7xCmTDJpmkw
	29LS1xSBcWAGQoKDfvRGYOeO1/Q2jimH1nwp0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bMT5LWE3Am+TQEjazDAG5MMaCXi4ZcQ3
	AYoiGWpDN91w4nemDNewpYoN5T/AZS/EFl+5C3YKhu0E0qyOd6gFdxFnmPM8N67D
	BfNUyic8zJA1YTLKdzF/BQyEF79SdvwoytKM9vKUUttJOWtt9lSR2bUTMGrfLdi5
	FFtkm83mtc0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E717C9AC3;
	Wed, 12 Sep 2012 14:37:34 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B4A769AC1; Wed, 12 Sep 2012
 14:37:32 -0400 (EDT)
In-Reply-To: <20dce012a57900b61e51c0e0d8dfb5573693010e.1347442430.git.ydroneaud@opteya.com> (Yann Droneaud's message of "Wed, 12 Sep 2012 12:21:13 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EA21B1AE-FD08-11E1-A9F0-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205322>

Yann Droneaud <ydroneaud@opteya.com> writes:

> One memcpy() argument is computed from a pointer added to an integer:
> eg. int + pointer. It's unusal.
> Let's write it in the correct order: pointer + offset.

Meh.

Both are correct.  Aren't ctx->w[lenW] and lenW[ctx-w] both correct,
even?


>
> Signed-off-by: Yann Droneaud <ydroneaud@opteya.com>
> ---
>  block-sha1/sha1.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/block-sha1/sha1.c b/block-sha1/sha1.c
> index c1af112..a7c4470 100644
> --- a/block-sha1/sha1.c
> +++ b/block-sha1/sha1.c
> @@ -246,7 +246,7 @@ void blk_SHA1_Update(blk_SHA_CTX *ctx, const void *data, unsigned long len)
>  		unsigned int left = 64 - lenW;
>  		if (len < left)
>  			left = len;
> -		memcpy(lenW + (char *)ctx->W, data, left);
> +		memcpy((char *)ctx->W + lenW, data, left);
>  		lenW = (lenW + left) & 63;
>  		if (lenW)
>  			return;
