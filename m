From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] help.c: use SHELL_PATH instead of hard-coded "/bin/sh"
Date: Sat, 07 Mar 2015 23:52:31 -0800
Message-ID: <xmqq61acsz7k.fsf@gitster.dls.corp.google.com>
References: <38be9195b966a027cb050e5a1b47526@74d39fa044aa309eaea14b9f57fe79c>
	<0ebc0373b21c75fa88adb5aefd098e9@74d39fa044aa309eaea14b9f57fe79c>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git mailing list <git@vger.kernel.org>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 08 08:54:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUW2P-0003up-R8
	for gcvg-git-2@plane.gmane.org; Sun, 08 Mar 2015 08:54:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751210AbbCHHwe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Mar 2015 03:52:34 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54774 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750978AbbCHHwe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2015 03:52:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4FD3637789;
	Sun,  8 Mar 2015 03:52:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7gQa64m73L9TXbUPyI4ArkXxOvs=; b=C25gw1
	OaB/TeBSUQ0qvCOx0HcBxop2rcf1Ci4ubMBlSaKyTVPppxKai5UVt/wwt77KMtAO
	Q9SXAFY8KkFgzHkWF+sCJVr1Q6iAXoOEOqVAOCQ7Inas8RAIhMqXLQJcNERV6RkC
	IDb9ZwXwztBWLM7CVMd7QmbHIkYQhtNOiIvhg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hYrkR/dgulcwNDzpqqsYpbShKyhDd+K/
	jeckTBBSO/aC6lmPYIORc8GNxzGyG+r0ZGhqf0VoDNvQ10oaGGwvsRxROK7hxBjI
	SVEhbLENBiAzIlI+TGWJG+Xj7HAeMJenrR43r68n9Zd3fjZ8p5yOCvDQpC7FVIJ3
	ouLBlh/UFrM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 490E437788;
	Sun,  8 Mar 2015 03:52:33 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C843637787;
	Sun,  8 Mar 2015 03:52:32 -0400 (EDT)
In-Reply-To: <0ebc0373b21c75fa88adb5aefd098e9@74d39fa044aa309eaea14b9f57fe79c>
	(Kyle J. McKay's message of "Sat, 7 Mar 2015 21:08:00 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 13DAAA30-C568-11E4-A494-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265037>

"Kyle J. McKay" <mackyle@gmail.com> writes:

> If the user has set SHELL_PATH in the Makefile then we
> should respect that value and use it.
>
> Signed-off-by: Kyle J. McKay <mackyle@gmail.com>
> ---
>  builtin/help.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/help.c b/builtin/help.c
> index 6133fe49..2ae8a1e9 100644
> --- a/builtin/help.c
> +++ b/builtin/help.c
> @@ -171,7 +171,7 @@ static void exec_man_cmd(const char *cmd, const char *page)
>  {
>  	struct strbuf shell_cmd = STRBUF_INIT;
>  	strbuf_addf(&shell_cmd, "%s %s", cmd, page);
> -	execl("/bin/sh", "sh", "-c", shell_cmd.buf, (char *)NULL);
> +	execl(SHELL_PATH, SHELL_PATH, "-c", shell_cmd.buf, (char *)NULL);

It is a common convention to make the first argument the command
name without its path, and this change breaks that convention.

Does it matter, or would it break something?  I recall that some
implementations of shell (e.g. "bash") change their behaviour
depending on how they are invoked (e.g. "ln -s bash /bin/sh" makes
it run in posix mode) but I do not know if they do so by paying
attention to their argv[0].  There might be other fallouts I do not
think of offhand here.

I do not have an objection to what these patches want to do, though.

Thanks.

>  	warning(_("failed to exec '%s': %s"), cmd, strerror(errno));
>  }
>  
> ---
