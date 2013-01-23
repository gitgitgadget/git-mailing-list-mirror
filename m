From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] all: new command used for multi-repo operations
Date: Wed, 23 Jan 2013 08:52:43 -0800
Message-ID: <7v622nj0ys.fsf@alter.siamese.dyndns.org>
References: <1358928767-16283-1-git-send-email-hjemli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 23 17:53:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ty3ZU-0007FM-Bl
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jan 2013 17:53:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755483Ab3AWQwq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2013 11:52:46 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57618 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753105Ab3AWQwp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2013 11:52:45 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 52BBCCB7E;
	Wed, 23 Jan 2013 11:52:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HaLqZvvqyM9RPKZr38riS2/EbWI=; b=EElmYI
	vDkV9ZKlsp+czn+BjoaPyOCWcUIg/Mr6uusGbUJS+NemZh9ED2ylTB5DrgmiW9Wk
	BjWVD7ItykhP4QPQpFBS5zQNBR54RDeFnZn08aShjre3W8fFT9iLMOfJJG3ACb/f
	+MDAIZAYHwlWtlDfGq+mgfMo0PBzB+0wQiirE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GehM1n8iHu77InoxANp/DVvOecnGFV3m
	mIF5kSq7utHyBD1HaTTEZSiBK1ULxYG9wlFaqRmPGsOpD+Qtrp2bnRdG8Ujn+bra
	BfP1Wnhyaxce/FRmSaZ/X3CBWsg6plsSU1mVaB0NbcLyCxtHNcUcOf4XuYisntf3
	RfeVNrJKJng=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 43C53CB7D;
	Wed, 23 Jan 2013 11:52:45 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AF035CB7B; Wed, 23 Jan 2013
 11:52:44 -0500 (EST)
In-Reply-To: <1358928767-16283-1-git-send-email-hjemli@gmail.com> (Lars
 Hjemli's message of "Wed, 23 Jan 2013 09:12:47 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4F1E7916-657D-11E2-A146-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214334>

Lars Hjemli <hjemli@gmail.com> writes:

> +static int walk(struct strbuf *path, int argc, const char **argv)
> +{
> +	DIR *dir;
> +	struct dirent *ent;
> +	struct stat st;
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
> +			strbuf_addstr(path, ent->d_name);
> +			setenv(GIT_DIR_ENVIRONMENT, path->buf, 1);
> +			strbuf_setlen(path, len - 1);
> +			setenv(GIT_WORK_TREE_ENVIRONMENT, path->buf, 1);
> +			handle_repo(path->buf, argv);
> +			strbuf_addstr(path, "/");
> +			continue;
> +		}
> +		strbuf_setlen(path, len);
> +		strbuf_addstr(path, ent->d_name);
> +		switch (DTYPE(ent)) {
> +		case DT_UNKNOWN:
> +			/* Use stat() instead of lstat(), since we want to
> +			 * know if we can follow this path into another
> +			 * directory - it's  not important if it's actually
> +			 * a symlink which gets us there.
> +			 */

This is wrong if you are on a platform that does have d_type, no?
It may say it is a symbolic link, and until you stat you wouldn't
know if it may lead to a directory.  You can add "case DT_LNK:" that
behaves the same as DT_UNKNOWN, I think.

> +			if (stat(path->buf, &st) || !S_ISDIR(st.st_mode))
> +				break;
> +			/* fallthrough */
> +		case DT_DIR:
> +			walk(path, argc, argv);
> +			break;
> +		}
> +		strbuf_setlen(path, len);
> +	}

But I still do not think this loop is correct.  In a repository that
has a working tree, you would learn that directory $D has $D/.git in
it, feed $D to handle_repo(), and then descend into $D/.git/objects/,
$D/.git/refs, and other random directories to see if you can find
other repositories.  That is just not right.

If this check were doing something like "The directory $D is worth
handing to handle_repo() if it has all of the following: objects/,
refs/ and HEAD that either points inside refs/ or 40-hex.", then it
would make a lot more sense to me, including the part that goes on
to check sibling directories.  As a bonus side effect, it will give
you a support for bare repositories for free.
