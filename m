From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] all: new command used for multi-repo operations
Date: Tue, 22 Jan 2013 22:52:52 -0800
Message-ID: <7vtxq8ie63.fsf@alter.siamese.dyndns.org>
References: <1358889019-4554-1-git-send-email-hjemli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 23 07:53:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxuCz-0004ju-AF
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jan 2013 07:53:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752980Ab3AWGw4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2013 01:52:56 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34797 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750856Ab3AWGwz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2013 01:52:55 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C2D5BBD27;
	Wed, 23 Jan 2013 01:52:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=39Um1+ZNisMGgdy1soUPpTm0Zd0=; b=Fg2eh0
	ikXiRX0rFO6M+L2P3/3RnINjyUf68ZNVztkKe0pOoo8zs/8kh9c8whmKUt8gH4ZM
	X0EQ1xu6zcfQS8NoTNJKUWOpafhI0iIhYIK5yMCdYnQH4A4PBHEKYsNjf2RQiGjm
	YDKWVzqG5JqBjvvdMSRKr9EkjqwL0YdQWovAM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KJ0N++Vn0Zj31hZu1ykGm1AlEOVPN9+/
	bCUZHhew/aBLi6HEqCGdTR5NhAD9sQdQBdHkuhxhllnJVPGHxp9V70FZRpO4CZAp
	wB9Ef1gg9+xB3H+jINjxWZrErLK5qcYuzQ8vwDHFFlbrM17hIKjF2HliLbaT0Zcx
	N4yWu70tzlE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B872EBD26;
	Wed, 23 Jan 2013 01:52:54 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1F54DBD24; Wed, 23 Jan 2013
 01:52:54 -0500 (EST)
In-Reply-To: <1358889019-4554-1-git-send-email-hjemli@gmail.com> (Lars
 Hjemli's message of "Tue, 22 Jan 2013 22:10:19 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 830E5722-6529-11E2-9B75-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214292>

Lars Hjemli <hjemli@gmail.com> writes:

> +static struct option builtin_all_options[] = {
> +	OPT_BOOLEAN('c', "clean", &only_clean, N_("only show clean repositories")),
> +	OPT_BOOLEAN('d', "dirty", &only_dirty, N_("only show dirty repositories")),
> +	OPT_END(),
> +};

If you were to go in the OPT_SET_INT route, that would give users
the usual "last one wins" semantics, e.g.

	$ git for-each-repo --clean --dirty

will look for only dirty repositories.  For completeness, we would
probably want "all" to defeat either of them, i.e.

	$ git for-each-repo --clean --all

> +static int walk(struct strbuf *path, int argc, const char **argv)
> +{
> +	DIR *dir;
> +	struct dirent *ent;
> +	size_t len;
> +
> +	dir = opendir(path->buf);
> +	if (!dir)
> +		return errno;
> +	strbuf_addstr(path, "/");
> +	len = path->len;
> +	while ((ent = readdir(dir))) {
> +		if (!strcmp(ent->d_name, ".") || !strcmp(ent->d_name, ".."))
> +			continue;
> +		if (!strcmp(ent->d_name, ".git")) {

This only looks for the top of working tree.  Have you considered if
this "iterate over directories and list git repositories in them"
may be useful for collection of bare repositories, and if it is, how
to go about implementing the discovery process?

> +		if (ent->d_type != DT_DIR)
> +			continue;

I think this is wrong.

On platforms that need a NO_D_TYPE_IN_DIRENT build, your compilation
may fail here (you would need to lstat() it yourself).  See how
dir.c does this without ugly #ifdef's in the code, especially around
the use of get_dtype() and DTYPE() macro.
