From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 3/3] push: teach --recurse-submodules the on-demand
 option
Date: Mon, 13 Feb 2012 19:34:37 -0800
Message-ID: <7v7gzq9jg2.fsf@alter.siamese.dyndns.org>
References: <20120213092541.GA15585@t1405.greatnet.de>
 <20120213093008.GD15585@t1405.greatnet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Fredrik Gustafsson <iveqy@iveqy.com>,
	Jens Lehmann <jens.lehmann@web.de>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Tue Feb 14 04:34:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rx9AD-0006Im-53
	for gcvg-git-2@plane.gmane.org; Tue, 14 Feb 2012 04:34:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757366Ab2BNDel (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Feb 2012 22:34:41 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41608 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752115Ab2BNDek (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Feb 2012 22:34:40 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D559876D8;
	Mon, 13 Feb 2012 22:34:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=naSfUxvaDknFfhahuw5dVQyAN48=; b=ZfTEXo
	EQqkZH/rywa/hjJddS9mltf1Eq74pWkdPZxHsE/KoWnL1rTz1f9t2ONHoGr62Eex
	y/eNmG8gAIoG42EfQgp9bgsary1yGmyJlSz6f3oL5pzOlWjAUpaM/jzEOLBMq+2c
	8Ha///n88gdShFyYLV+eUQGpIO0pIMxL88SgU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nTjD3ZqsPZthmee5N7a57GKsAChysOx2
	pOVd4PH83048138BD4S255gFGDVPRpoXq8dRWu9QFEba3v1YA0OeFbk0MFUXvLPe
	bqu4xAT/gHQyAKAM4v16Zvmiwl6sSVqbCbw8J0lYEMTagiheoVu9jm4q09cRz7E7
	NaGeyKlWO0Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CA88276D7;
	Mon, 13 Feb 2012 22:34:39 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5864076D6; Mon, 13 Feb 2012
 22:34:39 -0500 (EST)
In-Reply-To: <20120213093008.GD15585@t1405.greatnet.de> (Heiko Voigt's
 message of "Mon, 13 Feb 2012 10:30:08 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D31FA972-56BC-11E1-B89C-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190699>

Heiko Voigt <hvoigt@hvoigt.net> writes:

> diff --git a/submodule.c b/submodule.c
> index 3c714c2..ff0cfd8 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -411,6 +411,54 @@ int check_submodule_needs_pushing(unsigned char new_sha1[20],
>  	return needs_pushing->nr;
>  }
>  
> +static int push_submodule(const char *path)
> +{
> +	if (add_submodule_odb(path))
> +		return 1;
> +
> +	if (for_each_remote_ref_submodule(path, has_remote, NULL) > 0) {
> +		struct child_process cp;
> +		const char *argv[] = {"push", NULL};
> +
> +		memset(&cp, 0, sizeof(cp));
> +		cp.argv = argv;
> +		cp.env = local_repo_env;
> +		cp.git_cmd = 1;
> +		cp.no_stdin = 1;
> +		cp.dir = path;
> +		if (run_command(&cp))
> +			return 0;
> +		close(cp.out);
> +	}
> +
> +	return 1;
> +}

Hmm, this makes me wonder if we fire subprocesses and have them run in
parallel (to a reasonably limited parallelism), it might make the overall
user experience more pleasant, and if we did the same on the fetching
side, it would be even nicer.

We would need to keep track of children and after firing a handful of them
we would need to start waiting for some to finish and collect their exit
status before firing more, and at the end we would need to wait for the
remaining ones and find how each one of them did before returning from
push_unpushed_submodules().  If we were to do so, what are the missing
support we would need from the run_command() subsystem?

> +int push_unpushed_submodules(unsigned char new_sha1[20], const char *remotes_name)
> +{
> +	int i, ret = 1;
> +	struct string_list needs_pushing;
> +
> +	memset(&needs_pushing, 0, sizeof(struct string_list));
> +	needs_pushing.strdup_strings = 1;
> +
> +	if (!check_submodule_needs_pushing(new_sha1, remotes_name, &needs_pushing))
> +		return 1;
> +
> +	for (i = 0; i < needs_pushing.nr; i++) {
> +		const char *path = needs_pushing.items[i].string;
> +		fprintf(stderr, "Pushing submodule '%s'\n", path);
> +		if (!push_submodule(path)) {
> +			fprintf(stderr, "Unable to push submodule '%s'\n", path);
> +			ret = 0;
> +		}
> +	}
