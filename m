From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/WIP PATCH 1/3] teach config parsing to read from strbuf
Date: Sun, 24 Feb 2013 21:54:43 -0800
Message-ID: <7v4nh13plo.fsf@alter.siamese.dyndns.org>
References: <cover.1361751905.git.hvoigt@hvoigt.net>
 <6c69068b4e6a72a2cca5dc6eaffa9982032a7f2a.1361751905.git.hvoigt@hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <jens.lehmann@web.de>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Mon Feb 25 06:55:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9r1s-0003hU-LJ
	for gcvg-git-2@plane.gmane.org; Mon, 25 Feb 2013 06:55:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751714Ab3BYFyr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2013 00:54:47 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58346 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751447Ab3BYFyr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2013 00:54:47 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 50D209162;
	Mon, 25 Feb 2013 00:54:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BOHl2eOjLBsH5mlvZXkEN9Jt4/0=; b=nBzhS8
	mUw7h+RneFehiz9CiROC3cb4yU3KvkhneF3yXnBeNuRguGm7SR2uhXeJ+rnriz1W
	ZILgGeK8rf3HsqmXr0YYithfX+Fn2B5TQsF0A9lltyEjGXvqhsMHMPBfaMtDs6EH
	zF9IgpFutpfH8yxFWzFbxJBCElT+shRz+fvkI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iTljl9JXYWnYmX58ooGX89MBTpgPL504
	YgTo35wT6nuvVWqlzVYIdxCTDY2FGW6l/8CfWSMUjal3avFTLt0QQjYJ+9ShxXrD
	duh3zD4SZJ9OdI3rxteDOKZaQRrdPryy2wntDn9tFue0PnQXZO9spVx4dtp87d/4
	xj4SOKzrH4w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 466DC9161;
	Mon, 25 Feb 2013 00:54:46 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AFECD9160; Mon, 25 Feb 2013
 00:54:45 -0500 (EST)
In-Reply-To: <6c69068b4e6a72a2cca5dc6eaffa9982032a7f2a.1361751905.git.hvoigt@hvoigt.net>
 (Heiko Voigt's message of "Mon, 25 Feb 2013 02:04:18 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DB6F74B4-7F0F-11E2-9CCD-27D12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217033>

Heiko Voigt <hvoigt@hvoigt.net> writes:

> diff --git a/config.c b/config.c
> index aefd80b..f995e98 100644
> --- a/config.c
> +++ b/config.c
> @@ -13,6 +13,9 @@
>  typedef struct config_file {
>  	struct config_file *prev;
>  	FILE *f;
> +	int is_strbuf;
> +	struct strbuf *strbuf_contents;
> +	int strbuf_pos;
>  	const char *name;
>  	int linenr;
>  	int eof;

The idea to allow more kinds of sources specified for "config_file"
structure is not bad per-se, but whenever you design an enhancement
to something that currently supports only on thing to allow taking
another kind, please consider what needs to be done by the next
person who adds the third kind.  That would help catch design
mistakes early.  For example, will the "string-list" (I am not
saying use of string-list makes sense as the third kind; just as an
example off the top of my head) source patch add

	int is_string_list;
        struct string_list *string_list_contents;

fields to this structure?  Sounds insane for at least two reasons:

 * if both is_strbuf and is_string_list are true, what should
   happen?

 * is there a good reason to waste storage for the three fields your
   patch adds when sring_list strage (or FILE * storage for that
   matter) is used?

The helper functions like config_fgetc() and config_ftell() sounds
like you are going in the right direction but may want to do the
OO-in-C in a similar way transport.c does, keeping a pointer to a
structure of methods, but I didn't read the remainder of this patch
very carefully enough to comment further.
