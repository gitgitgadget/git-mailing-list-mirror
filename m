From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 02/11] Support showing notes from more than one notes
 tree
Date: Mon, 22 Feb 2010 17:47:40 -0800
Message-ID: <7vsk8sn2o3.fsf@alter.siamese.dyndns.org>
References: <cover.1266885599.git.trast@student.ethz.ch>
 <3dbcdcf1a364d14968c07e99564acb232c6a5c43.1266885599.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>,
	Johan Herland <johan@herland.net>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Feb 23 02:48:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Njjsa-0000kw-8t
	for gcvg-git-2@lo.gmane.org; Tue, 23 Feb 2010 02:48:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753267Ab0BWBrz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2010 20:47:55 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:39064 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752667Ab0BWBrx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 20:47:53 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7558C9CA9F;
	Mon, 22 Feb 2010 20:47:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=8GLDOVynJ/YiMydMYu9rwoc2w2Y=; b=GuY53wA0l4+Ud06e0JB2Jkp
	gAdFwKGueTKd1C9Bzlj1txVuEXcmweTy6Kx/UmydV0zcgR9DYAEwzoH/SJGSI6Xp
	IX8U1M8hp6AGJQMQIBXqui5u4IagUxDVdMtjzeAiN1ZuuZKcHwkiGSSqU5Qs7MXQ
	GEFpE47Eawy0IWA8X4y0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=Zrjn8JJKdoVtjVE4EJUxVGdb6x6gvA2H/Ig4qDHgGx0ydqdtD
	VLb0XPkevuyz/LbYjrPq5IC/TggoP2BxdC+afnI4nPlnHG7/6oqVSTnspzUKnBKE
	+5vK8fqXqHrwBj0MLQh0PtFJD1dl3Vz5HHkX8/7xQVOmDQNp4Ni7VYN3G0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 325219CA9E;
	Mon, 22 Feb 2010 20:47:48 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B64A49CA9B; Mon, 22 Feb
 2010 20:47:42 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 71EA1D5E-201D-11DF-9DF1-D83AEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140762>

Thomas Rast <trast@student.ethz.ch> writes:

> Changes since v4:
> * introduce --show-notes=<ref> and --[no-]standard-notes

Nicer, much nicer.

> * remove NOTES_SHOW_HEADER_WITH_REF distinction

Note that there is a leftover caller that uses the symbol without noticing
that it has been retired.  I'll fix it up locally when I queue the series
to 'pu'.

> * parse config even if we don't care about it

Parsing is good, and not reading trees is very good.

It is silly to put yourself down after doing both of these very well by
saying "even if we don't care about it"---you obviously do care about
making it earier for other people to build on top of your code.  Otherwise
you would have left the code unchanged from the previous round ;-).

> diff --git a/notes.c b/notes.c
> index 3ba3e6d..ee54a42 100644
> --- a/notes.c
> +++ b/notes.c
> @@ -5,6 +5,8 @@
>  #include "utf8.h"
>  #include "strbuf.h"
>  #include "tree-walk.h"
> +#include "string-list.h"
> +#include "refs.h"
>  
>  /*
>   * Use a non-balancing simple 16-tree structure with struct int_node as
> @@ -68,6 +70,9 @@ struct non_note {
>  
>  struct notes_tree default_notes_tree;
>  
> +struct string_list display_notes_refs;
> +struct notes_tree **display_notes_trees;

Unlike default_notes_tree, the above two can become static, as you made
the new logic better contained to this file and accessible only via
accessor functions.

> @@ -828,6 +833,76 @@ int combine_notes_ignore(unsigned char *cur_sha1,
> ...
> +static const char *default_notes_ref()

I'll s/_ref()/_ref(void)/ here.

> diff --git a/notes.h b/notes.h
> index bad03cc..7650254 100644
> --- a/notes.h
> +++ b/notes.h
> @@ -198,4 +198,22 @@ int for_each_note(struct notes_tree *t, int flags, each_note_fn fn,
>  void format_note(struct notes_tree *t, const unsigned char *object_sha1,
>  		struct strbuf *sb, const char *output_encoding, int flags);
>  
> +
> +struct string_list;
> +
> +struct display_notes_opt
> +{
> +	int suppress_default_notes : 1;
> +	struct string_list *extra_notes_refs;
> +};
> +
> +void init_display_notes(struct display_notes_opt *opt);
> +void format_display_notes(const unsigned char *object_sha1,
> +			  struct strbuf *sb, const char *output_encoding, int flags);
> +

As you are retiring format_note() as a public interface, and instead
making format_display_notes() as the primary API for the callers, the
former should be made static to notes.c along with the large comment
describing how to call it.  It may also be worth telling people how to
call this new public interface with similar comment here.

> @@ -1096,8 +1096,8 @@ void pretty_print_commit(enum cmit_fmt fmt, const struct commit *commit,
>  		strbuf_addch(sb, '\n');
>  
>  	if (context->show_notes)
> -		format_note(NULL, commit->object.sha1, sb, encoding,
> -			    NOTES_SHOW_HEADER | NOTES_INDENT);
> +		format_display_notes(commit->object.sha1, sb, encoding,
> +				     NOTES_SHOW_HEADER_WITH_REF | NOTES_INDENT);

I'll s/_WITH_REF// here.

> diff --git a/revision.c b/revision.c
> index 29721ec..d6e842e 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -1191,9 +1192,29 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
>  	} else if (!strcmp(arg, "--show-notes")) {
>  		revs->show_notes = 1;
>  		revs->show_notes_given = 1;
> +	} else if (!prefixcmp(arg, "--show-notes=")) {
> +		struct strbuf buf = STRBUF_INIT;
> +		revs->show_notes = 1;
> +		revs->show_notes_given = 1;
> +		if (!revs->notes_opt.extra_notes_refs)
> +			revs->notes_opt.extra_notes_refs = xcalloc(1, sizeof(struct string_list));
> +		if (!prefixcmp(arg+13, "refs/"))
> +			/* happy */;
> +		else if (!prefixcmp(arg+13, "notes/"))
> +			strbuf_addstr(&buf, "refs/");
> +		else
> +			strbuf_addstr(&buf, "refs/notes/");
> +		strbuf_addstr(&buf, arg+13);
> +		string_list_append(strbuf_detach(&buf, NULL),
> +				   revs->notes_opt.extra_notes_refs);

Nice; multiple --show-notes=... will accumulate in the order given.  I
knew you won't be stupid to make this a colon separated string, but I had
to double check ;-).
