From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 7/9] config parsing options: allow one flag multiple times
Date: Mon, 05 Aug 2013 11:52:45 -0700
Message-ID: <7vk3k0j7gi.fsf@alter.siamese.dyndns.org>
References: <1375530686-2309-1-git-send-email-stefanbeller@googlemail.com>
	<1375530686-2309-8-git-send-email-stefanbeller@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, sunshine@sunshineco.com
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Aug 05 20:52:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6Ptl-0005by-5L
	for gcvg-git-2@plane.gmane.org; Mon, 05 Aug 2013 20:52:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754187Ab3HESwt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Aug 2013 14:52:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39677 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754045Ab3HESws (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Aug 2013 14:52:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3A26436E73;
	Mon,  5 Aug 2013 18:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=x4RaVTepQrHlom+ibklDE2O5Hw0=; b=BFCR/l
	sWwSnQz2goPrAbIYzjRsA9dNJv9Lb6DqLCGpS2Hc0tVLYa6RWtaf7VZbNBv8/rbE
	HSoqcP0KsWfxJRe9Azxn7PgOylrJVUhBG9VuyNPs8YmI4qOpx7GjCY4emgZzb/qF
	K3pdBZeUKagkpGJSaA7xq5qC9k6eYpd2TNFZQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xTSsxxoDkojoWNQOhCNMJHwRE45b4ptY
	FyEWAWFN41gDXZWGdcPWh1xAK8QKv1pigyjh7fih9eDA6DltXcmCdga8m+LIJVtg
	5AqUmHPfB5OCoVOfVhdylxptzpkY0LYCZauOA93e8hv6QiSAllxhgKeJoKEPjXz7
	etgeQCIiUwc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2E52036E72;
	Mon,  5 Aug 2013 18:52:48 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6E2E036E71;
	Mon,  5 Aug 2013 18:52:47 +0000 (UTC)
In-Reply-To: <1375530686-2309-8-git-send-email-stefanbeller@googlemail.com>
	(Stefan Beller's message of "Sat, 3 Aug 2013 13:51:24 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 386C424A-FE00-11E2-B0D9-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231690>

Stefan Beller <stefanbeller@googlemail.com> writes:

> This task emerged from b04ba2bb (parse-options: deprecate OPT_BOOLEAN,
> 2011-09-27).
>
> This commit introduces a change for the users, after this patch
> you can pass one of the config level flags multiple times:
> Before:
> 	$ git config --global --global --list
> 	error: only one config file at a time.
> 	usage: ...
>
> Afterwards this will work. This is due to the following check in the code:
> 	if (use_global_config + use_system_config + use_local_config +
> 	    !!given_config_file + !!given_config_blob > 1) {
> 		error("only one config file at a time.");
> 		usage_with_options(builtin_config_usage, builtin_config_options);
> 	}

Of course, you could further lose that "at most one of them" logic
by using CMDMODE.  That will involve updating the logic that
currently looks at these three variables to look at one enum that
can have 4 states (nothing specified, and one of these three
specified), which will be more involved change, but the resulting
code may become simpler (I didn't try---I am just speculating).

Thanks.

>
> With OPT_BOOL instead of OPT_BOOLEAN the variables use_global_config,
> use_system_config, use_local_config will only have the value 0 if the
> command line option was not passed or 1 no matter how often the
> respective command line option was passed.
>
> Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
> ---



>  builtin/config.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/config.c b/builtin/config.c
> index da12fdb..4ab9e9a 100644
> --- a/builtin/config.c
> +++ b/builtin/config.c
> @@ -50,9 +50,9 @@ static int respect_includes = -1;
>  
>  static struct option builtin_config_options[] = {
>  	OPT_GROUP(N_("Config file location")),
> -	OPT_BOOLEAN(0, "global", &use_global_config, N_("use global config file")),
> -	OPT_BOOLEAN(0, "system", &use_system_config, N_("use system config file")),
> -	OPT_BOOLEAN(0, "local", &use_local_config, N_("use repository config file")),
> +	OPT_BOOL(0, "global", &use_global_config, N_("use global config file")),
> +	OPT_BOOL(0, "system", &use_system_config, N_("use system config file")),
> +	OPT_BOOL(0, "local", &use_local_config, N_("use repository config file")),
>  	OPT_STRING('f', "file", &given_config_file, N_("file"), N_("use given config file")),
>  	OPT_STRING(0, "blob", &given_config_blob, N_("blob-id"), N_("read config from given blob object")),
>  	OPT_GROUP(N_("Action")),
