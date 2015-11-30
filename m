From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] push: add recurseSubmodules config option
Date: Mon, 30 Nov 2015 10:31:26 -0800
Message-ID: <xmqqa8pv8hkx.fsf@gitster.mtv.corp.google.com>
References: <1447680294-13395-1-git-send-email-mac@mcrowe.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Mike Crowe <mac@mcrowe.com>
X-From: git-owner@vger.kernel.org Mon Nov 30 19:31:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a3TEb-0007tD-8P
	for gcvg-git-2@plane.gmane.org; Mon, 30 Nov 2015 19:31:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754260AbbK3Sb3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2015 13:31:29 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:58837 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753984AbbK3Sb2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Nov 2015 13:31:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 287502E10F;
	Mon, 30 Nov 2015 13:31:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Vk33XRgRfwWvOnbLUWDE2lb2JrQ=; b=fk8vNT
	Qcb8dqXoNuav9jNmyW2yQD7ig/psfAsNdg5hjPpN7HU3ggMpIpic0mfCsOz+3UaJ
	Kk2ICtU8/ugWKqCLas/67/TzHfHl4CKcP8IXZCHUoOOYxJOX4ZBJNStH0z4GCiXB
	1mFH2unrcBh79it9orqusoSZOhjuGSRCh3AT4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IwR2e6yc71HoEkM4ewJPQiIwdFZZr9rF
	qP4Hwdwusl+YYF+wrVwd5iI9OI+EX8isqlSFg+gfRMQNzqF5aFxqQfVbo6baOwEB
	gFtz3eGf687M74F63Svu3pvCvdOzzjuCXKWK3DgOuHQ89wU0YD7nB+Fjdd4uxlm+
	sOEMeLLPuNU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1FEDA2E10E;
	Mon, 30 Nov 2015 13:31:28 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 7F6E32E10D;
	Mon, 30 Nov 2015 13:31:27 -0500 (EST)
In-Reply-To: <1447680294-13395-1-git-send-email-mac@mcrowe.com> (Mike Crowe's
	message of "Mon, 16 Nov 2015 13:24:54 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 91697530-9790-11E5-9B6E-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281808>

Mike Crowe <mac@mcrowe.com> writes:

> diff --git a/builtin/push.c b/builtin/push.c
> index 3bda430..dfced74 100644
> --- a/builtin/push.c
> +++ b/builtin/push.c
> @@ -9,6 +9,7 @@
>  #include "transport.h"
>  #include "parse-options.h"
>  #include "submodule.h"
> +#include "submodule-config.h"
>  #include "send-pack.h"
>  
>  static const char * const push_usage[] = {
> @@ -20,7 +21,7 @@ static int thin = 1;
>  static int deleterefs;
>  static const char *receivepack;
>  static int verbosity;
> -static int progress = -1;
> +static int progress = -1, recurse_submodules = RECURSE_SUBMODULES_DEFAULT;

One variable per line, please.  Especially when the two variables do
not have anything to do with each other, and do not have any logical
similarity between them.

> @@ -452,22 +453,15 @@ static int do_push(const char *repo, int flags)
>  static int option_parse_recurse_submodules(const struct option *opt,
>  				   const char *arg, int unset)
>  {
> -	int *flags = opt->value;
> +	int *recurse_submodules = opt->value;
>  
> -	if (*flags & (TRANSPORT_RECURSE_SUBMODULES_CHECK |
> -		      TRANSPORT_RECURSE_SUBMODULES_ON_DEMAND))
> +	if (*recurse_submodules != RECURSE_SUBMODULES_DEFAULT)
>  		die("%s can only be used once.", opt->long_name);

The usual convention thoughout Git user experience is "the last one
wins" (both in the configuration and in the command line options).
Is there a good reason to deviate from that here?
