From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] git-patch-id: do not trip over "no newline" markers
Date: Wed, 16 Feb 2011 12:05:57 -0800
Message-ID: <7vwrkziw2i.fsf@alter.siamese.dyndns.org>
References: <4D5BF73E.50002@drmicha.warpmail.net>
 <144f7a4824abecaf87f862ed9e60587456128b41.1297875236.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Feb 16 21:06:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ppndg-0000yD-Gt
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 21:06:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754221Ab1BPUGL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Feb 2011 15:06:11 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:45931 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753757Ab1BPUGJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Feb 2011 15:06:09 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5ADB63A32;
	Wed, 16 Feb 2011 15:07:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=K8smRBOsKWOiuSt6Is0XJoadJnU=; b=xC15VK
	6WdJM5+Q1yJVIBK/GjAaAv2E5h51igE1XFhkEnTrJzHKo5c69oYVdoE1wASfHQ7E
	P1yW/ateyCkI2DeALz+usx6l+feuLr23imdBhG6/q6SRcO0DIUSzKbEaaJ9YlAid
	8Om7VPvaeMIpYBzKI86L6mKqdnonHmoea/j/s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YLOEmrL0EkIyTB9ajLI580GxAkO3CvmE
	1KrryIXhZ6WZZh4/8VmnMmop++djzMKqIyoLnEvyKc9gr0GglZT4iKXfA7Sb+hT9
	19TA31gizU5LCCVZwOwvsPpGMkyuVaFyrfQZ2EGOn4BnGgpJyxaXRFxqo6Y/jVQM
	vqeSvrasxWI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 29C6C3A2E;
	Wed, 16 Feb 2011 15:07:09 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C0EF03A2D; Wed, 16 Feb 2011
 15:07:04 -0500 (EST)
In-Reply-To: <144f7a4824abecaf87f862ed9e60587456128b41.1297875236.git.git@drmicha.warpmail.net> (Michael J. Gruber's message of "Wed\, 16 Feb 2011 17\:55\:38 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 55975AA8-3A08-11E0-B465-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166997>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Currently, patch-id trips over our very own diff extension for marking
> the absence of newline at EOF.
>
> Fix it. (Ignore it, it's whitespace.)
>
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
>  builtin/patch-id.c  |    2 ++
>  t/t4204-patch-id.sh |    2 +-
>  2 files changed, 3 insertions(+), 1 deletions(-)
>
> diff --git a/builtin/patch-id.c b/builtin/patch-id.c
> index 5125300..653d958 100644
> --- a/builtin/patch-id.c
> +++ b/builtin/patch-id.c
> @@ -73,6 +73,8 @@ int get_one_patchid(unsigned char *next_sha1, git_SHA_CTX *ctx)
>  			p += 7;
>  		else if (!memcmp(line, "From ", 5))
>  			p += 5;
> +		else if (!memcmp(line, "\\ No newline at end of file", 27))
> +			continue;

Good spotting, except that this string is a bit too specific to git and
GNU diff run in the C or ??_en locales.  An early draft of "git apply"
used to have the same string but the string was removed before the command
was released to the wild with a lot weaker condition (grep for "l10n" in
builtin/apply.c).
