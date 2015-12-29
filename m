From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 08/10] dir: simplify untracked cache "ident" field
Date: Tue, 29 Dec 2015 14:32:58 -0800
Message-ID: <xmqqsi2kga1x.fsf@gitster.mtv.corp.google.com>
References: <1451372974-16266-1-git-send-email-chriscool@tuxfamily.org>
	<1451372974-16266-9-git-send-email-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Torsten =?utf-8?Q?B=C3=B6gersh?= =?utf-8?Q?ausen?= 
	<tboegi@web.de>, Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 29 23:33:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aE2pH-0004uT-6P
	for gcvg-git-2@plane.gmane.org; Tue, 29 Dec 2015 23:33:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753839AbbL2WdD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2015 17:33:03 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:59816 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752743AbbL2WdB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2015 17:33:01 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9C9C93830C;
	Tue, 29 Dec 2015 17:33:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=k0qztsUfWXitHcri65q+773qNO4=; b=Q6Hafy
	+PbxrtAoDCk4Dq5BiQ5Gwm1r33pNnxtE81IDBs90dVjFtz7yY68b+YUO/xZdsify
	rCcbqSheTWgxUW9bM/+9Br0DCwEhUE74xpTD4YufMIK4VfMlhPpoKcYSSr/YCvZp
	E0uNzN4q1y+fRScc7iD81KO0T/bPghI1EVcaE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=C9Ijc83V4alqnHgZwljnlS6N7C9GJgFi
	BCXnO64WtDYqGjLGQFFYsRtyIZqHtUZ+Tf5xiMQHjQiN1mPoQUcEln6Dww3m1dr8
	cy0FRUTs2oZph5EzFPIsiZS1TDiRJ12d/ksBSQgrK93geUM90MvfumT5EjG4cdgq
	rE8H0zwsezE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 908BD3830B;
	Tue, 29 Dec 2015 17:33:00 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E43203830A;
	Tue, 29 Dec 2015 17:32:59 -0500 (EST)
In-Reply-To: <1451372974-16266-9-git-send-email-chriscool@tuxfamily.org>
	(Christian Couder's message of "Tue, 29 Dec 2015 08:09:32 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1D957AC0-AE7C-11E5-A69D-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283154>

Christian Couder <christian.couder@gmail.com> writes:

> -static int ident_in_untracked(const struct untracked_cache *uc)
> +static int ident_current_location_in_untracked(const struct untracked_cache *uc)
>  {
> -	const char *end = uc->ident.buf + uc->ident.len;
> -	const char *p   = uc->ident.buf;
> +	struct strbuf cur_loc = STRBUF_INIT;
> +	int res = 0;
>  
> -	for (p = uc->ident.buf; p < end; p += strlen(p) + 1)
> -		if (!strcmp(p, get_ident_string()))
> -			return 1;
> -	return 0;
> +	/*
> +	 * Previous git versions may have saved many strings in the
> +	 * "ident" field, but it is insane to manage many locations,
> +	 * so just take care of the first one.
> +	 */
> +
> +	strbuf_addf(&cur_loc, "Location %s, system ", get_git_work_tree());
> +
> +	if (starts_with(uc->ident.buf, cur_loc.buf))
> +		res = 1;
> +
> +	strbuf_release(&cur_loc);
> +
> +	return res;
>  }

The ", system " part looks funny.  I think I know what you are
trying to do, though.

If the path to the working tree has ", system " as a substring,
I wonder if funny things may happen with this starts_with()?
