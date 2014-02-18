From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rev-parse: fix --resolve-git-dir argument handling
Date: Tue, 18 Feb 2014 12:42:02 -0800
Message-ID: <xmqq61ocdug5.fsf@gitster.dls.corp.google.com>
References: <5301C4B4.5070503@thequod.de>
	<65ea2c8ce4f0d60f0d93f730aac50183ba63bd1c.1392626780.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Daniel Hahler <genml+git-2014@thequod.de>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Tue Feb 18 21:42:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFrV0-00023n-Id
	for gcvg-git-2@plane.gmane.org; Tue, 18 Feb 2014 21:42:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751277AbaBRUme (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Feb 2014 15:42:34 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44811 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751099AbaBRUmd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Feb 2014 15:42:33 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B5AF36D3A9;
	Tue, 18 Feb 2014 15:42:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=M9kiB5PpbNdKJOTZ/p1cZLA7TcY=; b=Tag34E
	FLlcP2MJicFVJdlR6EvzOZ+sMCiXt11dzSmFwzyujZ/DizoCqdfyIrlo6xcIJToD
	qDzOUbnsu6atY+vFCLUnD4ANJofLQ7aoMFjP35rEgFpXZDRCkokA+bjD3DK/9U76
	sMYZuD1oa3PcG6IShFht0VCf+zdzXjyXtrzXM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KYBO6AQCrzJey1ryaHKgMmwn7qMLqaXD
	w70k29BXyTiACe4UY5Tu9gB4PDyb1B2QCD5hySub56bR/K/ltXmuILNoz+THGYRG
	JxpVBton87/6YQqE5eFwHyUEeP+gKAs4AmTPHUEBxPXgIVtZ4twks2yTJzd8KR88
	kySzLFSBGOM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C86836D3A2;
	Tue, 18 Feb 2014 15:42:31 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A110B6D36F;
	Tue, 18 Feb 2014 15:42:09 -0500 (EST)
In-Reply-To: <65ea2c8ce4f0d60f0d93f730aac50183ba63bd1c.1392626780.git.john@keeping.me.uk>
	(John Keeping's message of "Mon, 17 Feb 2014 08:46:20 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 29CA31D4-98DD-11E3-91AE-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242352>

John Keeping <john@keeping.me.uk> writes:

> There are two problems here:
>
> 1) If no argument is provided, then the command segfaults
> 2) The argument is not consumed, so there will be excess output
>
> Fix both of these in one go by restructuring the handler for this
> option.
>
> Reported-by: Daniel Hahler <genml+git-2014@thequod.de>
> Signed-off-by: John Keeping <john@keeping.me.uk>
> ---

Looks sensible; thanks.

>  builtin/rev-parse.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
> index aaeb611..645cc4a 100644
> --- a/builtin/rev-parse.c
> +++ b/builtin/rev-parse.c
> @@ -738,9 +738,12 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
>  				continue;
>  			}
>  			if (!strcmp(arg, "--resolve-git-dir")) {
> -				const char *gitdir = resolve_gitdir(argv[i+1]);
> +				const char *gitdir;
> +				if (++i >= argc)
> +					die("--resolve-git-dir requires an argument");
> +				gitdir = resolve_gitdir(argv[i]);
>  				if (!gitdir)
> -					die("not a gitdir '%s'", argv[i+1]);
> +					die("not a gitdir '%s'", argv[i]);
>  				puts(gitdir);
>  				continue;
>  			}
