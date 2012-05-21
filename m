From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] git-sh-setup: work around Cygwin path handling
 gotchas
Date: Mon, 21 May 2012 15:24:10 -0700
Message-ID: <7vaa116ulx.fsf@alter.siamese.dyndns.org>
References: <4FB09FF2.70309@viscovery.net>
 <1337191208-21110-1-git-send-email-gitster@pobox.com>
 <1337191208-21110-3-git-send-email-gitster@pobox.com>
 <CAAXzdLW5VYnHc41WZ0id=4Qe17dHSj4+J9tqVvG-PvtpXLmh+Q@mail.gmail.com>
 <7vd364c5kt.fsf@alter.siamese.dyndns.org>
 <4FB58678.1050009@ramsay1.demon.co.uk>
 <7vehqib4kk.fsf@alter.siamese.dyndns.org>
 <4FBA8CD4.3020001@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Penny <svnpenn@gmail.com>, git@vger.kernel.org,
	Johannes Sixt <j.sixt@viscovery.net>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Tue May 22 00:24:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWb1V-0006Fs-8R
	for gcvg-git-2@plane.gmane.org; Tue, 22 May 2012 00:24:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759290Ab2EUWYN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 May 2012 18:24:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55666 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751061Ab2EUWYM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2012 18:24:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0E0348FBA;
	Mon, 21 May 2012 18:24:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8wYIP/7zt1aWcXQp/I+7QIIzjxM=; b=q/39Rw
	0DnvHgYgqCjIgQgOcc/AV+biPO3RkhQg1llHzCI6KoJCPKExESylMg6vKwfE0TAh
	sHSnAMdD4bZoyQHlhyTWAoLWTgVB4p2KCCeIOE8/JoiwN8BDJgz3cqgo03tUWrru
	URl16ykn2mYZBblNG0ltYS0rG64xmjrzypR0Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bvdTd6+WhLS4ZMY0m3gqQXKhtHhcxagp
	/JglkRTELScpAWvOFOaaS2C2Lp5UlE5rHZ73EUD4dyynlC29CSmQWhfwLqg05RPN
	dBR5AUT+rc5fHU/hNf2fhBHVZZmtLQV4SsUmISMzUU37bOm6qAlyPLe3bBxk3wcU
	kxXDsn+S8dk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 027A78FB9;
	Mon, 21 May 2012 18:24:12 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 85E8A8FB8; Mon, 21 May 2012
 18:24:11 -0400 (EDT)
In-Reply-To: <4FBA8CD4.3020001@ramsay1.demon.co.uk> (Ramsay Jones's message
 of "Mon, 21 May 2012 19:43:32 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B0904802-A393-11E1-BD2C-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198143>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

> However, you could imagine adding code to accommodate external windows
> programs. If we limit ourselves to the text editor, for example, I could
> imagine something like the diff attached below to fix up the C based git
> programs. (You would need to make similar changes to the shell and perl
> scripts which launch the text editor).

If you _only_ allow editors that understands windows style paths, your
patch may make sense, but doesn't it break editors that wants only POSIX
style paths?

>
> ATB,
> Ramsay Jones
>
> -- >8 --
> diff --git a/editor.c b/editor.c
> index d834003..cf36e62 100644
> --- a/editor.c
> +++ b/editor.c
> @@ -1,6 +1,9 @@
>  #include "cache.h"
>  #include "strbuf.h"
>  #include "run-command.h"
> +#ifdef __CYGWIN__
> +# include <sys/cygwin.h>
> +#endif
>  
>  #ifndef DEFAULT_EDITOR
>  #define DEFAULT_EDITOR "vi"
> @@ -37,6 +40,12 @@ int launch_editor(const char *path, struct strbuf *buffer, const char *const *en
>  
>  	if (strcmp(editor, ":")) {
>  		const char *args[] = { editor, path, NULL };
> +#ifdef __CYGWIN__
> +		char win32_path[1024];
> +
> +		cygwin_conv_to_full_win32_path(path, win32_path);
> +		args[1] = win32_path;
> +#endif
>  
>  		if (run_command_v_opt_cd_env(args, RUN_USING_SHELL, NULL, env))
>  			return error("There was a problem with the editor '%s'.",
> -- 8< --
