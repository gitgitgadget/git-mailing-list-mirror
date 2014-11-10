From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv4 5/9] builtin/notes: Simplify early exit code in add()
Date: Mon, 10 Nov 2014 12:36:13 -0800
Message-ID: <xmqqmw7y94jm.fsf@gitster.dls.corp.google.com>
References: <1415536255-19961-1-git-send-email-johan@herland.net>
	<1415536255-19961-6-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mackyle@gmail.com, jhf@trifork.com,
	sunshine@sunshineco.com
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Nov 10 21:36:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XnvhJ-0003pd-1g
	for gcvg-git-2@plane.gmane.org; Mon, 10 Nov 2014 21:36:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751855AbaKJUgU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2014 15:36:20 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50682 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751594AbaKJUgR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2014 15:36:17 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 388C21CF52;
	Mon, 10 Nov 2014 15:36:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=myVWtVlxzZhLZrsE3z5rwibB33A=; b=rVGivJ
	Is1221Za0GROa8OxMHh2twGI+KKmfcvuej/o0oFIp43N2i+ObMUUEmWYIjZPpcjW
	pU+/zac7x0nSL0kyXIMT/khYWWMFkcNeSeKUC5Xc4T2fucNKhjVVzFDBhfaZJcin
	Go3IUIj6Ritl/xwAshVUcR493Ij/NtlocYFMY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fgkOnuXT3mUf/4YIKVjoReYX4tMJ6wRe
	miG2vGW7wGLQxJeNjK9xnRmnAyMc6rE6tuWf4v/HIR1sH/R7uJKkqEVXQmPUwBVX
	llijcLVs4YMMJ19oc+9n0Tl6G+kt7loMjKl9EyM3HW4dHFKSTSvKOGVxkKOSBGUE
	sW6QQ9hF8Fk=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2D9811CF4D;
	Mon, 10 Nov 2014 15:36:15 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A24F71CF47;
	Mon, 10 Nov 2014 15:36:14 -0500 (EST)
In-Reply-To: <1415536255-19961-6-git-send-email-johan@herland.net> (Johan
	Herland's message of "Sun, 9 Nov 2014 13:30:51 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 370E741A-6919-11E4-A957-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johan Herland <johan@herland.net> writes:

> Signed-off-by: Johan Herland <johan@herland.net>
> ---
>  builtin/notes.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/builtin/notes.c b/builtin/notes.c
> index 1017472..f1480cf 100644
> --- a/builtin/notes.c
> +++ b/builtin/notes.c
> @@ -399,7 +399,7 @@ static int append_edit(int argc, const char **argv, const char *prefix);
>  
>  static int add(int argc, const char **argv, const char *prefix)
>  {
> -	int retval = 0, force = 0;
> +	int force = 0;
>  	const char *object_ref;
>  	struct notes_tree *t;
>  	unsigned char object[20], new_note[20];
> @@ -441,6 +441,8 @@ static int add(int argc, const char **argv, const char *prefix)
>  
>  	if (note) {
>  		if (!force) {
> +			free_note_data(&d);
> +			free_notes(t);
>  			if (!d.given) {

It looks a bit strange to refer to d.given after calling a function
that sounds as if it is meant to clear what is recorded in and to
invalidate &d; yes, I can read the implementation to see that
d.given keeps its stale value, but that is something other people
may want to "clean up" later and this reference to d.given will get
in the way when that happens.

At this point of the code, it makes sense to free t in preparation
to either switching to append codepath or erroring out, but does &d
have anything in it already to necessitate its freeing?

>  				/*
>  				 * Redirect to "edit" subcommand.
> @@ -450,14 +452,11 @@ static int add(int argc, const char **argv, const char *prefix)
>  				 * therefore still in argv[0-1].
>  				 */
>  				argv[0] = "edit";
> -				free_note_data(&d);
> -				free_notes(t);
>  				return append_edit(argc, argv, prefix);
>  			}
> -			retval = error(_("Cannot add notes. Found existing notes "
> +			return error(_("Cannot add notes. Found existing notes "
>  				       "for object %s. Use '-f' to overwrite "
>  				       "existing notes"), sha1_to_hex(object));
> -			goto out;
>  		}
>  		fprintf(stderr, _("Overwriting existing notes for object %s\n"),
>  			sha1_to_hex(object));
> @@ -474,9 +473,8 @@ static int add(int argc, const char **argv, const char *prefix)
>  	snprintf(logmsg, sizeof(logmsg), "Notes %s by 'git notes %s'",
>  		 is_null_sha1(new_note) ? "removed" : "added", "add");
>  	commit_notes(t, logmsg);
> -out:
>  	free_notes(t);
> -	return retval;
> +	return 0;
>  }
>  
>  static int copy(int argc, const char **argv, const char *prefix)
