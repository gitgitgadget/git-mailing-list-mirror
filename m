From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 02/11] Support showing notes from more than one notes
 tree
Date: Mon, 22 Feb 2010 15:20:06 -0800
Message-ID: <7v1vgc26zd.fsf@alter.siamese.dyndns.org>
References: <cover.1266797028.git.trast@student.ethz.ch>
 <d51082ad62153e182298242a2e4b7c3c76000a2e.1266797028.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>,
	Johan Herland <johan@herland.net>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Feb 23 00:20:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjhZh-00017r-4k
	for gcvg-git-2@lo.gmane.org; Tue, 23 Feb 2010 00:20:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754945Ab0BVXUT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2010 18:20:19 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:44640 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754858Ab0BVXUR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 18:20:17 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 635999C450;
	Mon, 22 Feb 2010 18:20:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=Ins5Y6BPPWNR7LiZb6d+mNzQBnA=; b=hzcmS6usXRZqUTZsH37ncwY
	uCGvNXKt9xNKbEaDCkhsUEAHifBsUun92XjJulOWL7zANIYqOnF9m6Q5xScJ5pvh
	q5howXDADjL1TcUN1JYyJ0h+7h1qOhNYCcv6wHbHa0ksYZX9Cq9Bh/kHRty1W8Nc
	1AglyZX82oI5fyfb8WDk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=g2Ui3/yQLD84EXD6aaNglhW9yQchJ41UHVJbcMKQykFtJCfMA
	9UyYvy9z9Q2ebqCIMXWr/1aePCjZFTsY2aYg8Gc4N5dOlDnQ9MrfHgJBvbSMzjTG
	i33q+tJtwTO+xOwkwXKZc+mRULStWdTEdPX5ufz6Qo5TS3/UP4qhjYChyw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 18F189C44F;
	Mon, 22 Feb 2010 18:20:13 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BAA5B9C449; Mon, 22 Feb
 2010 18:20:07 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D3D1D77E-2008-11DF-91AD-D83AEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140737>

Thomas Rast <trast@student.ethz.ch> writes:

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 4c36aa9..a0f2b0f 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -517,7 +517,7 @@ core.notesRef::
>  	after the full SHA-1 of the commit they annotate.
>  +
>  If such a file exists in the given ref, the referenced blob is read, and
> -appended to the commit message, separated by a "Notes:" line.  If the
> +appended to the commit message, separated by a "Notes from <refname>:" line.  If the

Hmm...

> diff --git a/notes.c b/notes.c
> index 3ba3e6d..c480370 100644
> --- a/notes.c
> +++ b/notes.c
> @@ -68,6 +70,9 @@ struct non_note {
>  
>  struct notes_tree default_notes_tree;
>  
> +struct string_list display_notes_refs;
> +struct notes_tree **display_notes_trees;

Do these need to be extern?

> +void string_list_add_refs_from_glob_list(struct string_list *list,
> +					 const char *globs)
> +{
> +	struct strbuf globbuf = STRBUF_INIT;
> +	struct strbuf **split;
> +	int i;
> +
> +	strbuf_addstr(&globbuf, globs);
> +	split = strbuf_split(&globbuf, ':');
> +
> +	for (i = 0; split[i]; i++) {
> +		if (!split[i]->len)
> +			continue;
> +		if (split[i]->buf[split[i]->len-1] == ':')
> +			strbuf_setlen(split[i], split[i]->len-1);
> +		string_list_add_refs_by_glob(list, split[i]->buf);
> +	}

Nice use of strbuf_split().  I wonder if we should automatically add
"refs/" and/or "refs/notes/" when the input is missing the prefix.  I
don't have strong preference myself but the users might make noises.

Either way it needs to be documented in the final version before the
series goes to 'master'.

> +static int notes_display_config(const char *k, const char *v, void *cb)
> +{
> +	/* Warning!  This is currently not executed if
> +	 * GIT_NOTES_DISPLAY_REF is set.  Move the git_config() call
> +	 * outside the test if you add more options. */

Yuck.  If you know what needs to be done, do that before other poeple add
more options, please.

> @@ -1016,7 +1135,18 @@ void format_note(struct notes_tree *t, const unsigned char *object_sha1,
>  	if (msglen && msg[msglen - 1] == '\n')
>  		msglen--;
>  
> -	if (flags & NOTES_SHOW_HEADER)
> +	if (flags & NOTES_SHOW_HEADER_WITH_REF && t->ref) {
> +		const char *ref = t->ref;
> +		if (!strcmp(ref, GIT_NOTES_DEFAULT_REF)) {
> +			strbuf_addstr(sb, "\nNotes:\n");
> +		} else {
> +			if (!prefixcmp(ref, "refs/"))
> +				ref += 5;
> +			if (!prefixcmp(ref, "notes/"))
> +				ref += 6;
> +			strbuf_addf(sb, "\nNotes (%s):\n", ref);
> +		}
> +	} else if (flags & (NOTES_SHOW_HEADER|NOTES_SHOW_HEADER_WITH_REF))
>  		strbuf_addstr(sb, "\nNotes:\n");


It is not clear what the distinction between NOTES_SHOW_HEADER and
NOTES_SHOW_HEADER_WITH_REF.  Does anybody still call this function with
NOTES_SHOW_HEADER alone without NOTES_SHOW_HEADER_WITH_REF?

I expected to see "Notes:\n" regardless of the mode if the notes is coming
from the default refs/notes/commits tree, but it probably is better to say
"Notes (commits):\n" like your patch does.
