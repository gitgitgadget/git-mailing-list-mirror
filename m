From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH mm/mv-file-to-no-such-dir-with-slash] mv: let 'git mv file no-such-dir/' error out on Windows, too
Date: Thu, 09 Jan 2014 14:42:04 -0800
Message-ID: <xmqq7ga8aibn.fsf@gitster.dls.corp.google.com>
References: <1386059524-14442-1-git-send-email-Matthieu.Moy@imag.fr>
	<52CD7DE8.6070101@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org,
	Duy Nguyen <pclouds@gmail.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Thu Jan 09 23:42:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W1OJC-0004yC-1s
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jan 2014 23:42:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751741AbaAIWmM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jan 2014 17:42:12 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58151 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750882AbaAIWmK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jan 2014 17:42:10 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CF46E6225D;
	Thu,  9 Jan 2014 17:42:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pFgGjh6E3BQ6GIbDSCYSYzVfmMs=; b=U4pJJq
	//APUlcFEweentce5IvISvy8aEHLSy/uZpibLS+7qNxvp0dOGY7aBG0BiubeSk+l
	IfnBYnoo+X0Z5wl20jQfy/xktWPqhi+443JuKVw7seSLRYhpdZUbXyCPLkCVjaXt
	RfN13HNSA474vFttbyD279C3MDtkV+XiI9yhk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pQADg4I1O2U2WQjEQGdSgVFozn30IXti
	vBM2X7xv0UHoWGzAAIATHglPrMLw0o8UzWu+5wpFPNBR08xeilNnjcqUUoZ6sN5Q
	aLIJYO90t6RMz3IvnR6QEd7kRaIxhN0OAug/5MScyL3tmknStN1nuRvHpw/f9++O
	Opob2tvReYY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AEF646225C;
	Thu,  9 Jan 2014 17:42:09 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BF5FD62259;
	Thu,  9 Jan 2014 17:42:08 -0500 (EST)
In-Reply-To: <52CD7DE8.6070101@kdbg.org> (Johannes Sixt's message of "Wed, 08
	Jan 2014 17:33:44 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 45ABD790-797F-11E3-B7D0-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240281>

Johannes Sixt <j6t@kdbg.org> writes:

> The previous commit c57f628 (mv: let 'git mv file no-such-dir/' error out)
> relies on that rename("src", "dst/") fails if directory dst does not
> exist (note the trailing slash). This does not work as expected on Windows:
> This rename() call is successful. Insert an explicit check for this case.

Could you care to explain "Successful how" a bit here?  Do we see
no-such-dir mkdir'ed and then no-such-dir/file created?  Do we see
file moved to a new file whose name is no-such-dir/?  I am guessing
that it would be the latter, but if that is the case we would need
at least an air-quote around "successful".

> This changes the error message from
>
>    $ git mv file no-such-dir/
>    fatal: renaming 'file' failed: Not a directory
>
> to
>
>    $ git mv file no-such-dir/
>    fatal: destination directory does not exist, source=file, destination=no-such-dir/
>
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
>  builtin/mv.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/builtin/mv.c b/builtin/mv.c
> index 08fbc03..21c46d1 100644
> --- a/builtin/mv.c
> +++ b/builtin/mv.c
> @@ -214,6 +214,8 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>  			}
>  		} else if (string_list_has_string(&src_for_dst, dst))
>  			bad = _("multiple sources for the same target");
> +		else if (is_dir_sep(dst[strlen(dst) - 1]))
> +			bad = _("destination directory does not exist");
>  		else
>  			string_list_insert(&src_for_dst, dst);
