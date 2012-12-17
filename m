From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] git-clean: Display more accurate delete messages
Date: Mon, 17 Dec 2012 13:40:03 -0800
Message-ID: <7vsj74jr2k.fsf@alter.siamese.dyndns.org>
References: <1355743765-17549-1-git-send-email-zoltan.klinger@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Zoltan Klinger <zoltan.klinger@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 17 22:40:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TkiQG-0002cT-BZ
	for gcvg-git-2@plane.gmane.org; Mon, 17 Dec 2012 22:40:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753287Ab2LQVkI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2012 16:40:08 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48041 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752646Ab2LQVkH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2012 16:40:07 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6A6BB9F99;
	Mon, 17 Dec 2012 16:40:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=K+mYI6FuxWCYvDyftV9Je9L1YpY=; b=vVcy18
	Kf1qiEwNC8ARw94Ajn5dWwCKI7/s8WwtYbWxPugEmMTALIUdwTJr/lqos4ZtAFxm
	GuJYqw9DO/3ia4BRC6LOlaunWw8ilJf5pwqQ2PzGTUc4Dwmrld63ZcObVM1IOJka
	ad8Kyr1ZMDxmGf6yGgqlDqpC69N3/dlBnIc0c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KSnzgR2TYRoR7K9G+Drr5uANGquXRt8h
	nZSUKSENdlDoSk/mFZ9wfUwsMiISU4ezyHU7LTX9gensWPlhf0eiiiFgJrNqxEK4
	mW4ibSAZiJ6SSrihhdKYoSHK86/jeZLKAmDpzzdcCt14ds8RLsqda5a4AjZ98Om8
	LsW2b+41a2o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 571C19F98;
	Mon, 17 Dec 2012 16:40:06 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 848F39F95; Mon, 17 Dec 2012
 16:40:05 -0500 (EST)
In-Reply-To: <1355743765-17549-1-git-send-email-zoltan.klinger@gmail.com>
 (Zoltan Klinger's message of "Mon, 17 Dec 2012 22:29:25 +1100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 522ADB52-4892-11E2-A10A-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211706>

Zoltan Klinger <zoltan.klinger@gmail.com> writes:

> +static void print_filtered(const char *msg, struct string_list *lst)
> +{
> +	int i;
> +	char *name;
> +	char *dir = 0;
> +
> +	sort_string_list(lst);
> +
> +	for (i = 0; i < lst->nr; i++) {
> +		name = lst->items[i].string;
> +		if (dir == 0 || strncmp(name, dir, strlen(dir)) != 0)
> +			printf("%s %s\n", msg, name);
> +		if (name[strlen(name) - 1] == '/')
> +			dir = name;
> +	}
> +}

Here, prefixcmp() may be easier to read than strncmp().  We tend to
prefer writing comparison with zero like this:

	if (!dir || prefixcmp(name, dir))
		...

but I think we can go either way.

My reading of the above is that "lst" after sorting is expected to
have something like:

	a/
        a/b/
	a/b/to-be-removed
        a/to-be-removed

and we first show "a/", remember that prefix in "dir", not show
"a/b/" because it matches prefix, but still update the prefix to
"a/b/", not show "a/b/to-be-removed", and because "a/to-be-removed"
does not match the latest prefix, it is now shown.  Am I confused???

> @@ -150,43 +170,45 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
>  		if (S_ISDIR(st.st_mode)) {
>  			strbuf_addstr(&directory, ent->name);
>  			qname = quote_path_relative(directory.buf, directory.len, &buf, prefix);
> -			if (show_only && (remove_directories ||
> -			    (matches == MATCHED_EXACTLY))) {
> -				printf(_("Would remove %s\n"), qname);
> -			} else if (remove_directories ||
> -				   (matches == MATCHED_EXACTLY)) {
> -				if (!quiet)
> -					printf(_("Removing %s\n"), qname);
> -				if (remove_dir_recursively(&directory,
> -							   rm_flags) != 0) {
> -					warning(_("failed to remove %s"), qname);
> -					errors++;
> -				}
> -			} else if (show_only) {
> -				printf(_("Would not remove %s\n"), qname);
> -			} else {
> -				printf(_("Not removing %s\n"), qname);
> +			if (remove_directories || (matches == MATCHED_EXACTLY)) {
> +				remove_dir_recursively_with_dryrun(&directory, rm_flags, dry_run,
> +						&dels, &skips, &errs, prefix);
>  			}

Moving the above logic to a single helper function makes sense, but
can we name it a bit more concisely?  Also this helper feels very
specific to "clean"---does it need to go to dir.[ch], I have to
wonder.

Other than the above two points, the resulting builtin/clean.c looks
much more nicely structured than before.

I am not very much pleased by the change to dir.[ch] in this patch,
though.

> +static void append_dir_name(struct string_list *dels, struct string_list *skips,
> +		struct string_list *errs, char *name, const char * prefix, int failed, int isdir)
> +{
> +	struct strbuf quoted = STRBUF_INIT;
> +
> +	quote_path_relative(name, strlen(name), &quoted, prefix);
> +	if (isdir && quoted.buf[strlen(quoted.buf) -1] != '/')
> +		strbuf_addch(&quoted, '/');
> +
> +	if (skips)
> +		string_list_append(skips, quoted.buf);
> +	else if (!failed && dels)
> +		string_list_append(dels, quoted.buf);
> +	else if (errs)
> +		string_list_append(errs, quoted.buf);
> +}

The three lists dels/skips/errs are mostly mutually exclusive (the
caller knows which one to throw the element in) except that failed
controls which one between dels or errs is used.

That's an ugly interface, I have to say.  I think the quote-path
part should become a separate helper function to be used by the
callers of this function, and the callers should stuff the path to
the list they want to put the element in.  That will eliminate the
need for this ugliness.

Also, didn't you make remove_dir_recursively() excessively leaky by
doing this?  The string in quoted is still created, even though the
caller passes NULL to all the lists.

Thanks.
