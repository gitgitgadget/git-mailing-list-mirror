From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC 1/3] Alternates API: Untangle the interface
Date: Wed, 30 Mar 2011 15:28:43 -0700
Message-ID: <7v1v1omeec.fsf@alter.siamese.dyndns.org>
References: <7vlizwmm4o.fsf@alter.siamese.dyndns.org>
 <3c6b883f-8860-4da2-b328-d912019a4145-mfwitten@gmail.com>
 <522d5a8a-a674-40bd-91bf-b5b8f88e0f78-mfwitten@gmail.com>
 <cover.1301521243.git.mfwitten@gmail.com>
 <a0e5204fe8c03b3b6af2150198bad51f86b126c4.1301521243.git.mfwitten@gmail.com>
 <3c357acd119aa836f6cd3298d62cc5098f4c053c.1301521244.git.mfwitten@gmail.com>
 <5ed7886ec5e12c8e3a5f45d19625a4f5d2cdd38a.1301521243.git.mfwitten@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 31 00:28:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q53sn-0002v9-Du
	for gcvg-git-2@lo.gmane.org; Thu, 31 Mar 2011 00:28:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755767Ab1C3W2w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2011 18:28:52 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:64215 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751044Ab1C3W2v (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2011 18:28:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 50C6F50A7;
	Wed, 30 Mar 2011 18:30:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FJPHldCpTyvnC9GVeOPX3ejHmaU=; b=BCgPtg
	ahmh53EJcxstczXO+oAvKMquxXz7H8w+zXwoNBhMRimDyWxi5kN/+F9nXSvJE9sF
	v/C4efR91B6lGDPsJg/Dxpz1MPovQowZGXtop9GqPJkEnhCxLVGZ2RHR6iWTQFFG
	re8Hq0555IsZ5BVcZfchIclPShN48xs+uDwmg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=s77OJGpPPukFCD4cxr2k/qd9DIEBmQFy
	pXxtg5oamRNZAUnwpuUJX4kbiZ63TztwCzB+y7CtcVfP5Gj3u7I03ojmbSl48n7R
	O0HzU7Xgv7nhf7qCnEqoyfoDM7R4pfcts/+z72UBub05eUZDJBJY2ynCmfUEIODj
	9EGyN76nbXo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2F81A50A6;
	Wed, 30 Mar 2011 18:30:37 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 4322C50A5; Wed, 30 Mar 2011
 18:30:34 -0400 (EDT)
In-Reply-To: <5ed7886ec5e12c8e3a5f45d19625a4f5d2cdd38a.1301521243.git.mfwitten@gmail.com>
 (Michael Witten's message of "Wed, 30 Mar 2011 20:43:18 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 55B60BF2-5B1D-11E0-923D-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170432>

Michael Witten <mfwitten@gmail.com> writes:

> diff --git a/transport.c b/transport.c
> index a02f79a..c61723f 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -1190,14 +1190,13 @@ literal_copy:
>  	return xstrdup(url);
>  }
>  
> -int refs_from_alternate_cb(struct alternate_object_database *e, void *cb)
> +int refs_from_alternate_cb(struct alternate_object_database *e, alternate_ref_fn ref_fn)
>  {

Adding an extra "fn" is Ok, but I'd rather not to see removal of generic
callback data pointer if the _only_ reason you are doing so is "currently
nobody uses it".

Besides, I see "a function pointer and a data pointer cannot be held in a
single variable" as an academic mental mastu^wexercise that is useless in
real life.  Are there real platforms that matter where (void *) cannot
hold a pointer to a function?
