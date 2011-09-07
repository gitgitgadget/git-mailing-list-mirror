From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/1] sha1_file: normalize alt_odb path before
 comparing and storing
Date: Wed, 07 Sep 2011 11:46:20 -0700
Message-ID: <7vk49k2nsz.fsf@alter.siamese.dyndns.org>
References: <1315391867-31277-1-git-send-email-Hui.Wang@windriver.com>
 <1315391867-31277-2-git-send-email-Hui.Wang@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, <tali@admingilde.org>
To: Wang Hui <Hui.Wang@windriver.com>
X-From: git-owner@vger.kernel.org Wed Sep 07 20:46:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1N8n-0002MN-Fi
	for gcvg-git-2@lo.gmane.org; Wed, 07 Sep 2011 20:46:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756639Ab1IGSqY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Sep 2011 14:46:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65201 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752194Ab1IGSqY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Sep 2011 14:46:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0249E4B50;
	Wed,  7 Sep 2011 14:46:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=U+nufiTbYVZM6MrjgqyUs9pyz3Q=; b=bPhwWZ
	tM6bpXZDTzmbxd9gzE8rdO5M/MZPeyyuLoio0OxoYhsa+nKcFugKmHluQ3trZogN
	ZDJDSpsA05UeqAUujZyNJPagml8zfrPBRfZKkldgI6LtGd5ZWfPpwNd671KJ7s0n
	uDTT/Krw8HZXrx7St2ybdrLTbgRtux/ej/1HA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IL0TEm2BQI2N7g15c95R40nBN8ziK4Nc
	+4A0veAmG8nrRoKfFcQ2gFMPw6YVlg/vG/Ymnd39uGvIvA24EdnO13F/xAjlDJSI
	AmjM2xWRU7GmTBFFubWMuTZk7Zkub+Me4EdU/hE6Qbg5WGhsMZFuGsrtFmi1MWp1
	5FHxtFdaf5c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EE4874B4F;
	Wed,  7 Sep 2011 14:46:22 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 52F3A4B4E; Wed,  7 Sep 2011
 14:46:22 -0400 (EDT)
In-Reply-To: <1315391867-31277-2-git-send-email-Hui.Wang@windriver.com> (Wang
 Hui's message of "Wed, 7 Sep 2011 18:37:47 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AE912B0C-D981-11E0-AF02-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180897>

Wang Hui <Hui.Wang@windriver.com> writes:

> From: Hui Wang <Hui.Wang@windriver.com>
>
> When it needs to compare and add an alt object path to the
> alt_odb_list, we normalize this path first since comparing normalized
> path is easy to get correct result.
>
> Use strbuf to replace some string operations, since it is cleaner and
> safer.

Thanks, will queue.

> diff --git a/sha1_file.c b/sha1_file.c
> index f7c3408..fa2484b 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -248,27 +248,27 @@ static int link_alt_odb_entry(const char * entry, int len, const char * relative
> ...
> +	/* Drop the last '/' from path can make memcmp more accurate */
> +	if (pathbuf.buf[pfxlen-1] == '/')
> +		pfxlen -= 1;

By the way, I do not necessarily agree with the above comment. As long as
you consistently strip the trailing slashes from all directory paths, or
you consistently leave a single trailing slash after all directory paths,
you can get accurate comparison either way.

	Side note: I tend to prefer keeping a single trailing slash when I
	know what we are talking about is a directory in general, because
	you do not have to worry about the corner case near the root.
	Compare ('/' and '/bin/') vs ('/' and '/bin').

In this particular case, the real reason you want to remove the trailing
slash is that the invariants of ent->base[] demands it (after all, it
places another slash immediately after it), and making pathbuf.buf[] an
empty string (i.e. pfxlen == 0) would still be OK to represent an
alternate object store at the root level (this function assigns '/' at
ent->base[pfxlen] immediately before returning, and that '/' names the
root directory).

> +	entlen = pfxlen + 43; /* '/' + 2 hex + '/' + 38 hex + NUL */
> +	ent = xmalloc(sizeof(*ent) + entlen);
> +	memcpy(ent->base, pathbuf.buf, pfxlen);
> +	strbuf_release(&pathbuf);
>  
>  	ent->name = ent->base + pfxlen + 1;
>  	ent->base[pfxlen + 3] = '/';
