From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/6] wrapper: move is_empty_file() from builtin/am.c
Date: Wed, 15 Jun 2016 11:12:08 -0700
Message-ID: <xmqqh9cu724n.fsf@gitster.mtv.corp.google.com>
References: <20160607205454.22576-1-pranit.bauva@gmail.com>
	<20160615140026.10519-1-pranit.bauva@gmail.com>
	<20160615140026.10519-4-pranit.bauva@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com,
	chriscool@tuxfamily.org, larsxschneider@gmail.com,
	sunshine@sunshineco.com, tboegi@web.de
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 15 20:12:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bDFIW-0008EU-8X
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jun 2016 20:12:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751884AbcFOSMM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jun 2016 14:12:12 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54766 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750751AbcFOSMM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jun 2016 14:12:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7780F21205;
	Wed, 15 Jun 2016 14:12:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xJxO45CzYL2+6OJ9bLi1HN2S0LM=; b=Z2dxo5
	VZpMRpKZ1PvJghcVOg3bK8cc2FxjpZ0JrHSO9B/TAzCPWzHQGxZfEZ1RG2mibZG6
	rGPTOpBG7CQq/MSsGDAobsoknM96jNXUW2heeOE8lT1eqDl/hlFxlOkMo4f6o+Sy
	YddjyKC++WZKzNOdZfJbjYzHGiHjSCYXNmL58=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VR7HibNmxI8EunyiOp7rwHAjmBz2viu8
	IAqbi86kPia5V7/k0GJUN1Ipw0zeQRblT97TqtRFJuxlSLAJdgIHfLzuPg6LqoEI
	gCbbve3k06tX83U/G8o96ZQSbRWrJ04zcFDqV7KziKCZcqAe4r+1n8/3ZKvF2Wvf
	oueHYaDB9gM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6F32721201;
	Wed, 15 Jun 2016 14:12:10 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E8301211FE;
	Wed, 15 Jun 2016 14:12:09 -0400 (EDT)
In-Reply-To: <20160615140026.10519-4-pranit.bauva@gmail.com> (Pranit Bauva's
	message of "Wed, 15 Jun 2016 19:30:23 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: AD460946-3324-11E6-9668-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297384>

Pranit Bauva <pranit.bauva@gmail.com> writes:

> diff --git a/builtin/am.c b/builtin/am.c
> index 3dfe70b..84f21d0 100644
> --- a/builtin/am.c
> +++ b/builtin/am.c
> @@ -30,22 +30,6 @@
>  #include "mailinfo.h"
>  
>  /**
> - * Returns 1 if the file is empty or does not exist, 0 otherwise.
> - */
> -static int is_empty_file(const char *filename)
> -{
> -	struct stat st;
> -
> -	if (stat(filename, &st) < 0) {
> -		if (errno == ENOENT)
> -			return 1;
> -		die_errno(_("could not stat %s"), filename);
> -	}
> -
> -	return !st.st_size;
> -}
> -

This is perfectly fine in the context of "git am", but as a public
function that is called is_empty_file(), callers can come from two
camps.  One is like the caller of this function in "am" where an
empty and a missing file are treated equivalently.  The other would
want to act differently.

Renaming it "is-empty-or-missing" is necessary in order to make it
clear that this helper function is not targetted for the latter
callers.
