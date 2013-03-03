From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] tests: make sure rename pretty print works
Date: Sat, 02 Mar 2013 22:50:34 -0800
Message-ID: <7vehfxc6yt.fsf@alter.siamese.dyndns.org>
References: <7vip5cgjhp.fsf@alter.siamese.dyndns.org>
 <1362235092-16914-1-git-send-email-apelisse@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 03 07:51:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UC2lK-0000VX-A7
	for gcvg-git-2@plane.gmane.org; Sun, 03 Mar 2013 07:51:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752449Ab3CCGui (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Mar 2013 01:50:38 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43239 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752129Ab3CCGuh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Mar 2013 01:50:37 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 27A879DEC;
	Sun,  3 Mar 2013 01:50:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qshf2B8g/z31KlezfZjjC5LhiRY=; b=iWp4n2
	133JNJF72QDGZrI5/VvK9VQBvNk52uyXObfKA5fznpR2RJiAzlsNEusxYhQFc5hI
	2riP1ohW7/A7hPLZMcVKN5fNm9n6spRJ+JeWnKwYhMemm13N4yPR3f9J57lZ560F
	6sPNJP5GoiBnVvjTBo9cGN3v6Wj4uCcPI8/LY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kdFFjdALNoOgeEOIRE1Enb+gs+qL5VqX
	pDszm4/jS7lrNRICZ5eUwqrsecf/sosVFgUFMi3Ea1vocO1FwK0nF48lGL8ZeOGF
	lR9O57B+mpWWdQwunihiQBjcIWeeaBjz5Dr42Z+GCa0LamS+dQDcAtzzZhYFPrEj
	8mfz8u4zxZA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1D0319DEB;
	Sun,  3 Mar 2013 01:50:37 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7BFE49DE5; Sun,  3 Mar 2013
 01:50:36 -0500 (EST)
In-Reply-To: <1362235092-16914-1-git-send-email-apelisse@gmail.com> (Antoine
 Pelisse's message of "Sat, 2 Mar 2013 15:38:12 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A7237F7A-83CE-11E2-B441-7FA22E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217339>

Antoine Pelisse <apelisse@gmail.com> writes:

> Add basic use cases and corner cases tests for
> "git diff -M --summary/stat".
>
> Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
> ---
>  t/t4056-rename-pretty.sh |   54 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 54 insertions(+)
>  create mode 100755 t/t4056-rename-pretty.sh

I wonder if this needs a new test script of its own.

If we anticipate future additions, it would make sense but otherwise
it may be better if we can find an existing one these tests can be
folded into.

> diff --git a/t/t4056-rename-pretty.sh b/t/t4056-rename-pretty.sh
> new file mode 100755
> index 0000000..806046f
> --- /dev/null
> +++ b/t/t4056-rename-pretty.sh
> @@ -0,0 +1,54 @@
> +#!/bin/sh
> +
> +test_description='Rename pretty print
> +
> +'

A single line would be sufficient...

> +test_expect_success common_prefix '
> +	mkdir -p c/d &&
> +	git mv c/b/a c/d/e &&
> +	git commit -m. &&
> +	git show -M --summary >output &&

I guess the unsightly "commit -m." is an attempt to prevent the
later grep from matching log message randomly, but if you test the
output from "git diff -M --stat/summary HEAD^ HEAD" you do not have
to worry about it, no?

Also I wonder if we can verify the filename part in --stat output.

> +	test_i18ngrep "c/{b/a => d/e}" output

We would want to make sure that we do not have random cruft around
the paths, and the byte before that 'c' and after that '}' may want
to be verified.
