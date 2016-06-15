From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] verify-tag: allow to verify signed blob objects
Date: Wed, 15 Jun 2016 11:39:29 -0700
Message-ID: <xmqq8ty670v2.fsf@gitster.mtv.corp.google.com>
References: <a6557333316c6f7996fa54eebc75abdf988ed9f9.1465991212.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Jun 15 20:39:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bDFiz-0005AL-W1
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jun 2016 20:39:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752739AbcFOSje (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jun 2016 14:39:34 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58377 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751907AbcFOSjd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jun 2016 14:39:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 31EDA2533C;
	Wed, 15 Jun 2016 14:39:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wxempbO+5YT9rXgQCZ7e2HWkLAs=; b=hOuP7K
	4aVT2nZ5Ruayezdef9hhLA7DhJNWWhi/zmnHzXkobAPPNC2cta6pvIfb0r4Iqfzb
	vp90x6wXT+pvpIXrer8rKzlygcukTS6FogAWbkvNikpTJjuJX5/GNMO9m5on53X9
	raia1J6ttD5MyrSOibvfkI9vDA4oX5NCoLKgc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=D4V/sPdk8PL1eEmKz2AUrYUIS4z0CHh9
	1zow/OZmFXu3g5Cp8CzBw6I+FGm9Y8C4iwnvktPkKPTWU1MU0JOhdfqOaxy6a+5K
	BYTojpEQSNab2Mfc1uzHcNS8LnEeqxxkXoVysUidvjUJwzdZVIigQ1MJdlafjULI
	VrVSxLkRacU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2B2DF2533B;
	Wed, 15 Jun 2016 14:39:32 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A163A2533A;
	Wed, 15 Jun 2016 14:39:31 -0400 (EDT)
In-Reply-To: <a6557333316c6f7996fa54eebc75abdf988ed9f9.1465991212.git.git@drmicha.warpmail.net>
	(Michael J. Gruber's message of "Wed, 15 Jun 2016 13:51:54 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7FC519EA-3328-11E6-8156-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297388>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> diff --git a/tag.c b/tag.c
> index d1dcd18..d5f090b 100644
> --- a/tag.c
> +++ b/tag.c
> @@ -39,7 +39,7 @@ int gpg_verify_tag(const unsigned char *sha1, const char *name_to_report,
>  	int ret;
>  
>  	type = sha1_object_info(sha1, NULL);
> -	if (type != OBJ_TAG)
> +	if ((type != OBJ_TAG) && ((type != OBJ_BLOB) || !(flags & GPG_VERIFY_BLOB)))
>  		return error("%s: cannot verify a non-tag object of type %s.",
>  				name_to_report ?
>  				name_to_report :

The double negation is very hard to read.  I wonder

	if ((type != OBJ_TAG) &&
            !((type == OBJ_BLOB) && (flags & GPG_VERIFY_BLOB)))

is easier to follow?  "It is not a tag object, and it's not like we
were asked to verify blob and the user gave us a blob, either, so
let's complain" is easier to follow, at least for me.

Or even

	if ((flags & GPG_VERIFY_BLOB) && (type != OBJ_BLOB))
               	"you told me to check blob but didn't give me one";
	} else if (type != OBJ_TAG)
		"you didn't give me a tag";
