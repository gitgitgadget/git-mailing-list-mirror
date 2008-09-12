From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/6] submodule.*: Introduce simple C interface for
 submodule lookup by path
Date: Fri, 12 Sep 2008 14:23:51 -0700
Message-ID: <7vsks5njmg.fsf@gitster.siamese.dyndns.org>
References: <20080912210817.31628.69014.stgit@localhost>
 <20080912210857.31628.7605.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri Sep 12 23:25:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KeG8f-0001QN-5x
	for gcvg-git-2@gmane.org; Fri, 12 Sep 2008 23:25:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755931AbYILVYF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2008 17:24:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755876AbYILVYE
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Sep 2008 17:24:04 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:45943 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753496AbYILVYD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2008 17:24:03 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id CA18E7EBCC;
	Fri, 12 Sep 2008 17:24:00 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id C6DD67EBCA; Fri, 12 Sep 2008 17:23:53 -0400 (EDT)
In-Reply-To: <20080912210857.31628.7605.stgit@localhost> (Petr Baudis's
 message of "Fri, 12 Sep 2008 23:08:57 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1DF7B280-8111-11DD-98E9-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95770>

Petr Baudis <pasky@suse.cz> writes:

> +static int gitmodules_worker(const char *key, const char *value, void *info_)

Won't you ever have different kind of work in the future?
find_submodule_by_path(), perhaps?

> +{
> +	struct gitmodules_info *info = info_;
> +	const char *subkey;
> +
> +	if (prefixcmp(key, "submodule."))
> +		return 0;
> +
> +	subkey = strrchr(key, '.');
> +	if (!subkey)
> +		return 0;

This cannot happen; you made sure the thing begins with "submodule."
already.

> +	if (strcmp(subkey, ".path"))
> +		return 0;

This will miss a misconfigured "submodule.path" (two level).

I can understand if this part were:

	subkey = strrchr(key, '.');
        if (!subkey || subkey == key + strlen("submodule.") - 1)
        	return 0;

> +	if (strcmp(value, info->path))
> +		return 0;

This will segfault on a misconfigured:

	[submodule "xyzzy"]
        	path

> +	/* Found the key to change. */
> +	if (info->key) {
> +		error("multiple submodules live at path `%s'", info->path);

Why is this "error()", not "warning()"?

> +		/* The last one is supposed to win. */
> +		free(info->key);
> +	}
> +	info->key = xstrdup(key);
> +	return 0;

Have to wonder if it makes easier for the users if this function kept only
"xyzzy" out of "submodule.xyzzy.path", not the whole thing.  Cannot judge
without actual callers.

> +}
> +
> +char *submodule_by_path(const char *path)
> +{
> +	struct gitmodules_info info = { path, NULL };
> +
> +	config_exclusive_filename = ".gitmodules";
> +	if (git_config(gitmodules_worker, &info))
> +		die("cannot process .gitmodules");
> +	if (!info.key)
> +		die("the submodule of `%s' not found in .gitmodules", path);
> +	config_exclusive_filename = NULL;
> +
> +	return info.key;
> +}
> diff --git a/submodule.h b/submodule.h
> new file mode 100644
> index 0000000..bc74fa0
> --- /dev/null
> +++ b/submodule.h
> @@ -0,0 +1,8 @@
> +#ifndef SUBMODULE_H
> +#define SUBMODULE_H
> +
> +/* Find submodule living at given path in .gitmodules and return the key
> + * of its path config variable (dynamically allocated). */

Style?

> +extern char *submodule_by_path(const char *path);
> +
> +#endif
