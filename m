From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v14 04/16] Refactor quote_path_relative, remove unused params
Date: Mon, 24 Jun 2013 12:15:39 -0700
Message-ID: <7vd2rb8gmc.fsf@alter.siamese.dyndns.org>
References: <cover.1372087065.git.worldhello.net@gmail.com>
	<c7b9df81fad6a5b87400ae7beb6e6c2b7d48a67b.1372087065.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 24 21:15:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrCEs-0000Fm-9o
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 21:15:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751264Ab3FXTPm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 15:15:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58881 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750954Ab3FXTPl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 15:15:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5249E2B669;
	Mon, 24 Jun 2013 19:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ohv0XKe+r2Iwa3ZKU+JO513ZwkY=; b=cHsMts
	zM4zQnHM4r/R6ueDzp2HhTfupSIHW83h2GP+kyTOaGt4YUUthtaS80ZPgBXF6nt0
	T8MJuA5pKQ8QlflqIwKbTUhmxwG3GPmqyVyWVq2d8zRIz74KAjOnfvvN3lhSv1Ya
	9mAn7llc27jgsU+17sKZj0W37DW7VHYuDLwkE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kyH5dpV8w7lkEplllXpnPTG+0Vl36TMA
	8ywh6jXaH/Dvo5XKaHVJiSbzi1vwqAcvvrJ1w3Gv+ELtX/oGf+pNT9kIy1vKc8P6
	11JKGS9X3NLNSyMzMltSxNs0xMOkvOpZmTBr4/77yFHAyXbJ/JfKxR6xgQxKJt3a
	5qqI/ebagpo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 424092B668;
	Mon, 24 Jun 2013 19:15:41 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A19282B666;
	Mon, 24 Jun 2013 19:15:40 +0000 (UTC)
In-Reply-To: <c7b9df81fad6a5b87400ae7beb6e6c2b7d48a67b.1372087065.git.worldhello.net@gmail.com>
	(Jiang Xin's message of "Mon, 24 Jun 2013 23:21:28 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 75920F52-DD02-11E2-A5B5-9B86C9BC06FA-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228901>

Jiang Xin <worldhello.net@gmail.com> writes:

> After substitute path_relative() in quote.c with relative_path() from
> path.c, parameters (such as len and prefix_len) are obsolete in function
> quote_path_relative(). Remove unused parameters and change the order of
> parameters for quote_path_relative() function.
> ...
> diff --git a/builtin/clean.c b/builtin/clean.c
> index 04e39..f77f95 100644
> --- a/builtin/clean.c
> +++ b/builtin/clean.c
> @@ -262,7 +262,7 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
>  				if (remove_dirs(&directory, prefix, rm_flags, dry_run, quiet, &gone))
>  					errors++;
>  				if (gone && !quiet) {
> -					qname = quote_path_relative(directory.buf, directory.len, &buf, prefix);
> +					qname = quote_path_relative(directory.buf, prefix, &buf);
>  					printf(dry_run ? _(msg_would_remove) : _(msg_remove), qname);

This one needed a bit closer look to make sure directory.len is
already pointing at the end of directory.buf (it is) to verify that
this is a safe conversion.  Everywhere else we lost either -1 or
strlen() of the string we feed quote_path() and quote_path_relative()
so they look fine.
