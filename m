From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] all: new command used for multi-repo operations
Date: Tue, 22 Jan 2013 14:01:18 -0800
Message-ID: <7vmww0nahd.fsf@alter.siamese.dyndns.org>
References: <1358889019-4554-1-git-send-email-hjemli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 22 23:01:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Txlui-0001eM-CM
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jan 2013 23:01:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752874Ab3AVWBZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2013 17:01:25 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35428 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754632Ab3AVWBV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2013 17:01:21 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E08C6B316;
	Tue, 22 Jan 2013 17:01:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jATEV8dZHUo3vhJvIlTRuIYEQys=; b=yYVndt
	kG0r4D4fZAjdrGaUw+6axsaHVmUXytJN4iUVmSvMd5jCRcOflyPO1C25JywUu6nu
	5RmAvCN7+E5edQvnpveR2Mrlxvh2glsXqIsN4hpV1TPAtRYmDOyYM0MtEo+TP9ax
	jafBSuPWrk+XOLcmngEma4Ge4wQiGH+NCOlAc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PWzTitaQkITUOYQjem7wj2UdljmSa8uA
	V9xCWpTWZvdanG6apZDS1J2OW1PlzaclRqIqOXc1f0pqv0jRVA5LJ+JW9ALP5K7J
	kazxYujNT4eoS+g5pg5TiMvF/mQYDg7YdkRZ4D8r4Dp/hotQBDKp00sGZhvZpVML
	yrCm5qAielM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D4AC9B315;
	Tue, 22 Jan 2013 17:01:20 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 22544B312; Tue, 22 Jan 2013
 17:01:20 -0500 (EST)
In-Reply-To: <1358889019-4554-1-git-send-email-hjemli@gmail.com> (Lars
 Hjemli's message of "Tue, 22 Jan 2013 22:10:19 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 40C20CDC-64DF-11E2-97C2-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214254>

Lars Hjemli <hjemli@gmail.com> writes:

> diff --git a/builtin/all.c b/builtin/all.c
> new file mode 100644
> index 0000000..ee9270d
> --- /dev/null
> +++ b/builtin/all.c
> @@ -0,0 +1,105 @@
> +/*
> + * "git all" builtin command.
> + *
> + * Copyright (c) 2013 Lars Hjemli <hjemli@gmail.com>
> + */
> +#include "cache.h"
> +#include "color.h"
> +#include "builtin.h"
> +#include "run-command.h"
> +#include "parse-options.h"
> +
> +static int only_dirty;
> +static int only_clean;
> +char root[PATH_MAX];
> +
> +static const char * const builtin_all_usage[] = {
> +	N_("git all [options] [cmd]"),
> +	NULL
> +};
> +
> +static struct option builtin_all_options[] = {
> +	OPT_BOOLEAN('c', "clean", &only_clean, N_("only show clean repositories")),
> +	OPT_BOOLEAN('d', "dirty", &only_dirty, N_("only show dirty repositories")),
> +	OPT_END(),
> +};

Shouldn't this be more like OPT_SET_INT() on a same variable that is
initialized to "all"?  Alternatively you could validate the input
and die when both are given.

> +int cmd_all(int argc, const char **argv, const char *prefix)
> +{
> +	struct strbuf path = STRBUF_INIT;
> +
> +	if (!getcwd(root, sizeof(root)))
> +		return 1;
> +
> +	argc = parse_options(argc, argv, prefix, builtin_all_options,
> +			     builtin_all_usage, PARSE_OPT_STOP_AT_NON_OPTION);
> +
> +	unsetenv(GIT_DIR_ENVIRONMENT);
> +	unsetenv(GIT_WORK_TREE_ENVIRONMENT);

Don't you need to clear other variables whose uses are closely tied
to a single repository, like GIT_INDEX_FILE, etc.?

I suspect that explicitly exporting GIT_DIR and GIT_WORK_TREE (and
nothing else) in handle_repo() to the location you discovered before
you run the per-repository command via run_command_v_opt(), might be
a better alternative.  The user could be sharing objects in all
repositories by permanently setting GIT_OBJECT_DIRECTORY to a single
place.

> diff --git a/command-list.txt b/command-list.txt
> index 7e8cfec..f955895 100644
> --- a/command-list.txt
> +++ b/command-list.txt
> @@ -1,6 +1,7 @@
>  # List of known git commands.
>  # command name				category [deprecated] [common]
>  git-add                                 mainporcelain common
> +git-all                                 mainporcelain
>  git-am                                  mainporcelain
>  git-annotate                            ancillaryinterrogators
>  git-apply                               plumbingmanipulators

I am not very interested in this topic in the first place, but this
does not (at least not yet) sound like a main Porcelain to me.

"all" may be a word other people may want to use to call collections
of things other than "Git repositories", and that use may turn out
to be more useful in general.  A name that makes it clear that this
is about "repositories", i.e. along the lines of "git for-each-repo"
or something, would be a better name that does not squat on such a
short and sweet name.
