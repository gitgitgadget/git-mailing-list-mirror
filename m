From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add `log.decorate' configuration variable.
Date: Tue, 16 Feb 2010 19:16:59 -0800
Message-ID: <7v635wimac.fsf@alter.siamese.dyndns.org>
References: <alpine.LNX.2.00.1002171239430.2477@vqena.qenxr.bet.am>
 <7vljespt2l.fsf@alter.siamese.dyndns.org>
 <alpine.LNX.2.00.1002171427080.3414@vqena.qenxr.bet.am>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steven Drake <sdrake@xnet.co.nz>
X-From: git-owner@vger.kernel.org Wed Feb 17 04:17:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhaPv-0003vc-9K
	for gcvg-git-2@lo.gmane.org; Wed, 17 Feb 2010 04:17:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933944Ab0BQDRN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2010 22:17:13 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:47569 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933920Ab0BQDRL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 22:17:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2A5A49AD71;
	Tue, 16 Feb 2010 22:17:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=V1QaJolmUF/IMxj/h8q+futELco=; b=FuwVkl
	wHcCYnisHJCVkeLIPMYC11rRXzdUXj8/AX9QQRVlGoD3HkqRHAZ6N0QIMJZVcARB
	fGckqAmVnCZBSwrUq1A/nkPoOOsGZdD6jLPSlSE8Y/0BHb6dwdVlVJ8v00sFYRDx
	PiS9AZvr9Ykz1/q33xAKskcxNEp/xmKFbTfE0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=r9YZeN3/+aphqKQEiDlOxa/Cnou4LhDG
	K/xQ55MJQFt4HDOS5Ef9BB1aQLWjvnmVHVrYc8fccKy2H7Otgc9ET5EFzUE7lsny
	2Sp5rMOODn49HX2UxTNP6zaNAShm5MU6OjyHIVfSip9nuZGSyNqhatNsEeAf4Fx7
	3JrGyCjQ8NQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0729D9AD6C;
	Tue, 16 Feb 2010 22:17:05 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CF24D9AD6A; Tue, 16 Feb
 2010 22:17:01 -0500 (EST)
In-Reply-To: <alpine.LNX.2.00.1002171427080.3414@vqena.qenxr.bet.am> (Steven
 Drake's message of "Wed\, 17 Feb 2010 15\:04\:21 +1300 \(NZDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: EC59A49C-1B72-11DF-8691-D83AEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140201>

Steven Drake <sdrake@xnet.co.nz> writes:

> Good point, and looking at the code "log.decorate" only has an affect after
> cmd_log_init() is called, which is call by cmd_whatchanged(), cmd_show(), 
> cmd_log_reflog() and cmd_log() so only those command are affected
> (notably not format-patch).

I was not worried about what your change does.  I am worried about
protecting what the code after your change currently does from future
changes done by other people while you are not actively watching the
patches in flight on this list.

> While on the subject of git_config I think die_bad_config() should be an
> extern (i.e. decleared in cache.h and a static function) so that it could
> be used in git_XXX_config functions for handling error.  Something like:
>
> diff --git a/builtin-log.c b/builtin-log.c
> index f096eea..a41a7bb 100644
> --- a/builtin-log.c
> +++ b/builtin-log.c
> @@ -264,6 +264,8 @@ static int git_log_config(const char *var, const char *value, void *cb)
>  			decoration_style = DECORATE_FULL_REFS;
>  		else if (!strcmp(value, "short"))
>  			decoration_style = DECORATE_SHORT_REFS;
> +		else
> +			die_bad_config(var);

We generally avoid doing this, as we may later want to add different
values to "log.decorate", and keep the older git working as if nothing is
specified, rather than barfing, so that people can access the same
repository, perhaps over NFS, from different machines with varying vintage
of git.
