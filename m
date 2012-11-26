From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fast-export: Allow pruned-references in mark file
Date: Sun, 25 Nov 2012 20:03:55 -0800
Message-ID: <7vd2z1xb6c.fsf@alter.siamese.dyndns.org>
References: <1353750432-17373-1-git-send-email-apelisse@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 26 05:04:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tcpva-0007Gr-Lt
	for gcvg-git-2@plane.gmane.org; Mon, 26 Nov 2012 05:04:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753904Ab2KZED7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Nov 2012 23:03:59 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59663 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753853Ab2KZED6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2012 23:03:58 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C04159824;
	Sun, 25 Nov 2012 23:03:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5D0nHYMY9pd4Tx9r7y3kKO7StsA=; b=lsm9cc
	gHUbto3Nbmpg+Z3ZIlbFMnbYpAvUlSBtu29A7r+1o0oruMAEB7Zu5y9lPFJsbhxk
	bSc5HX5t0xCQP/GZUu9q069IduYRpge+V7D3xFRQiHaNeft9/4Lzb3e+ZwIAwrEp
	gK1J1dB0FxqkuUbtoBLYaPtxRlMvYwIy5aMlg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ly5bymMYjSNj/W2qJvZp5GVZ2zfpZaoX
	o9tgRvJWbuQIUQUhz/Efd0oVjIIUBUwC7H7EVQhOKR70/fqoZLoyl8mue9cWC7Dd
	IEC18XAWCPGycP5JYd/Ibb5UAiCXBVzkwx8Jkdilx5yxI7zevCZqU0mJAShgOmQo
	28tqMcN+awk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AE0659823;
	Sun, 25 Nov 2012 23:03:57 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0ECB09822; Sun, 25 Nov 2012
 23:03:56 -0500 (EST)
In-Reply-To: <1353750432-17373-1-git-send-email-apelisse@gmail.com> (Antoine
 Pelisse's message of "Sat, 24 Nov 2012 10:47:12 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4CEF2398-377E-11E2-9C90-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210405>

Antoine Pelisse <apelisse@gmail.com> writes:

> fast-export can fail because of some pruned-reference when importing a
> mark file.
>
> The problem happens in the following scenario:
>
>     $ git fast-export --export-marks=MARKS master
>     (rewrite master)
>     $ git prune
>     $ git fast-export --import-marks=MARKS master
>
> This might fail if some references have been removed by prune
> because some marks will refer to non-existing commits.
>
> Let's warn when we have a mark for a commit we don't know.
> Also, increment the last_idnum before, so we don't override
> the mark.

Is this a safe and sane thing to do, and if so why?  Could you
describe that in the log message here?

> Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
> ---
>  builtin/fast-export.c |   11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/fast-export.c b/builtin/fast-export.c
> index 12220ad..141b245 100644
> --- a/builtin/fast-export.c
> +++ b/builtin/fast-export.c
> @@ -607,16 +607,19 @@ static void import_marks(char *input_file)
>  			|| *mark_end != ' ' || get_sha1(mark_end + 1, sha1))
>  			die("corrupt mark line: %s", line);
>  
> +		if (last_idnum < mark)
> +			last_idnum = mark;
> +
>  		object = parse_object(sha1);
> -		if (!object)
> -			die ("Could not read blob %s", sha1_to_hex(sha1));
> +		if (!object) {
> +			warning("Could not read blob %s", sha1_to_hex(sha1));
> +			continue;
> +		}
>  
>  		if (object->flags & SHOWN)
>  			error("Object %s already has a mark", sha1_to_hex(sha1));
>  
>  		mark_object(object, mark);
> -		if (last_idnum < mark)
> -			last_idnum = mark;
>  
>  		object->flags |= SHOWN;
>  	}
