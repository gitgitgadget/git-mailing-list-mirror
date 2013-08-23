From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-commit: search author pattern against mailmap
Date: Fri, 23 Aug 2013 10:44:03 -0700
Message-ID: <xmqqbo4opajg.fsf@gitster.dls.corp.google.com>
References: <1377265711-11492-1-git-send-email-apelisse@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 23 19:44:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCvPP-0006mn-Ap
	for gcvg-git-2@plane.gmane.org; Fri, 23 Aug 2013 19:44:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756068Ab3HWRoP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Aug 2013 13:44:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42901 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756067Ab3HWRoL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Aug 2013 13:44:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 043C63B9CC;
	Fri, 23 Aug 2013 17:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7zP8anKzigSSutLLxwPDC7PiTSo=; b=vBbeot
	1J9eggiIbWH0vCZXCz9TZFtv3H1CSIKjLFMSkerwvSvnMnS8+PPV+rny1B6GhwEE
	Apojt3xeGvjLqS+yAM8GPLFo6r+qOEb2fFssBrIb4bPErj3EPGUMK42hC+F27apx
	KYvfEfLzkXcMGGOtr52n2AWfnZuM787MoTDYI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Fe1qIGbPPb6BF2oJTEyuhiZQCSkZpW1Z
	kLZr/8tscdx4+p7hoDzqT8OrutkvBE0ZnYcQ3K6aSGrRL6cRiP3HkTRXzMXH9GZh
	Ui5bEfBCYkcqcNYvftq4/DQ0rNGLFH7mcORscxVKnQ7eN8L4XUBxED3InaEl13xz
	MQ+N7ajvUZ0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E53093B9CB;
	Fri, 23 Aug 2013 17:44:10 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3EC7F3B9C8;
	Fri, 23 Aug 2013 17:44:10 +0000 (UTC)
In-Reply-To: <1377265711-11492-1-git-send-email-apelisse@gmail.com> (Antoine
	Pelisse's message of "Fri, 23 Aug 2013 15:48:31 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 9DD2138E-0C1B-11E3-9A41-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232816>

Antoine Pelisse <apelisse@gmail.com> writes:

> When committing for someone else, using the --author option, it can be
> nice to use the mailmap file to find the correct name spelling and email
> address.
>
> Currently, you would have to find the correct mapping in mailmap file
> first, and then use the full ident form when committing.
>
> Let's allow git-commit to find if an entry exists in mailmap file for
> that pattern, and use that instead.
>
> Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
> ---
> Hi,
> I would use that feature at work where I happen to commit some work for
> other colleagues, while we heavily rely on mailmap file to have decent indents.
>
> On the other hand, I'm kind of embarrassed to add this new option to
> git-commit.

My initial reaction was "Why should something as important as 'git
commit' should be playing a guessing-game?" ;-) and I am kind of
ashamed to have added 146ea068 (git commit --author=$name: look
$name up in existing commits, 2008-08-26) and then am embarrased to
have completely forgotten about it. I never use the feature myself.

But for that old and established "--author parameter that does not
use the standard format guesses" feature to be useful, I agree that
it should honor the mailmap.

I wonder if it would hurt anybody if we made this unconditional, not
even with "--no-mailmap" override? Opinions?

>
>  Documentation/git-commit.txt |  6 +++++-
>  builtin/commit.c             | 16 +++++++++++++++-
>  2 files changed, 20 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
> index 1a7616c..9e3fe04 100644
> --- a/Documentation/git-commit.txt
> +++ b/Documentation/git-commit.txt
> @@ -12,7 +12,7 @@ SYNOPSIS
>  	   [--dry-run] [(-c | -C | --fixup | --squash) <commit>]
>  	   [-F <file> | -m <msg>] [--reset-author] [--allow-empty]
>  	   [--allow-empty-message] [--no-verify] [-e] [--author=<author>]
> -	   [--date=<date>] [--cleanup=<mode>] [--[no-]status]
> +	   [--use-mailmap] [--date=<date>] [--cleanup=<mode>] [--[no-]status]
>  	   [-i | -o] [-S[<keyid>]] [--] [<file>...]
>
>  DESCRIPTION
> @@ -131,6 +131,10 @@ OPTIONS
>  	commit by that author (i.e. rev-list --all -i --author=<author>);
>  	the commit author is then copied from the first such commit found.
>
> +--use-mailmap::
> +	When used with `--author=<author>`, match the <author> pattern
> +	against mapped name and email. See linkgit:git-shortlog[1].
> +
>  --date=<date>::
>  	Override the author date used in the commit.
>
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 10acc53..fbd0664 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -30,6 +30,7 @@
>  #include "column.h"
>  #include "sequencer.h"
>  #include "notes-utils.h"
> +#include "mailmap.h"
>
>  static const char * const builtin_commit_usage[] = {
>  	N_("git commit [options] [--] <pathspec>..."),
> @@ -87,6 +88,7 @@ static enum {
>  } commit_style;
>
>  static const char *logfile, *force_author;
> +static int mailmap;
>  static const char *template_file;
>  /*
>   * The _message variables are commit names from which to take
> @@ -945,13 +947,24 @@ static const char *find_author_by_nickname(const char *name)
>  	av[++ac] = buf.buf;
>  	av[++ac] = NULL;
>  	setup_revisions(ac, av, &revs, NULL);
> +	if (mailmap) {
> +		revs.mailmap = xcalloc(1, sizeof(struct string_list));
> +		read_mailmap(revs.mailmap, NULL);
> +	}
>  	prepare_revision_walk(&revs);
>  	commit = get_revision(&revs);
>  	if (commit) {
>  		struct pretty_print_context ctx = {0};
> +		const char *format;
> +
> +		if (mailmap)
> +			format = "%aN <%aE>";
> +		else
> +			format = "%an <%ae>";
> +
>  		ctx.date_mode = DATE_NORMAL;
>  		strbuf_release(&buf);
> -		format_commit_message(commit, "%an <%ae>", &buf, &ctx);
> +		format_commit_message(commit, format, &buf, &ctx);
>  		return strbuf_detach(&buf, NULL);
>  	}
>  	die(_("No existing author found with '%s'"), name);
> @@ -1428,6 +1441,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>  		OPT_GROUP(N_("Commit message options")),
>  		OPT_FILENAME('F', "file", &logfile, N_("read message from file")),
>  		OPT_STRING(0, "author", &force_author, N_("author"), N_("override author for commit")),
> +		OPT_BOOLEAN(0, "use-mailmap", &mailmap, N_("Use mailmap file when searching for author")),
>  		OPT_STRING(0, "date", &force_date, N_("date"), N_("override date for commit")),
>  		OPT_CALLBACK('m', "message", &message, N_("message"), N_("commit message"), opt_parse_m),
>  		OPT_STRING('c', "reedit-message", &edit_message, N_("commit"), N_("reuse and edit message from specified commit")),
> --
> 1.8.4.rc4.1.g0d8beaa.dirty
