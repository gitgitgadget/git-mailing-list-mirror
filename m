From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 4/4] Add a --cover-letter option to format-patch
Date: Mon, 18 Feb 2008 13:19:21 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802181245270.30505@racer.site>
References: <alpine.LNX.1.00.0802171335520.5816@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Feb 18 14:20:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JR5un-0002q4-7O
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 14:20:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756345AbYBRNTf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 08:19:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756002AbYBRNTf
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 08:19:35 -0500
Received: from mail.gmx.net ([213.165.64.20]:41859 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754027AbYBRNTd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 08:19:33 -0500
Received: (qmail invoked by alias); 18 Feb 2008 13:19:31 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp007) with SMTP; 18 Feb 2008 14:19:31 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19Zk7QVXoVZe5vseJJPE/KR2wOVAa4ul7P14Uz5Na
	qY9i2UPsibUbKi
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LNX.1.00.0802171335520.5816@iabervon.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74281>

Hi,

On Sun, 17 Feb 2008, Daniel Barkalow wrote:

> diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
> index 651efe6..53e6d2e 100644
> --- a/Documentation/git-format-patch.txt
> +++ b/Documentation/git-format-patch.txt
> @@ -17,6 +17,7 @@ SYNOPSIS
>                     [--in-reply-to=Message-Id] [--suffix=.<sfx>]
>                     [--ignore-if-in-upstream]
>                     [--subject-prefix=Subject-Prefix]
> +                   [--cover-letter]
>  		   [ <since> | <revision range> ]

Since you are already there, and it is really a small change, why not fix 
the whitespace?

> diff --git a/builtin-log.c b/builtin-log.c
> index 867cc13..bfefb67 100644
> --- a/builtin-log.c
> +++ b/builtin-log.c
> @@ -14,6 +14,7 @@
>  #include "reflog-walk.h"
>  #include "patch-ids.h"
>  #include "refs.h"
> +#include "run-command.h"
>  
>  static int default_show_root = 1;
>  static const char *fmt_patch_subject_prefix = "PATCH";
> @@ -452,74 +453,77 @@ static int git_format_config(const char *var, const char *value)
>  }
>  
>  
> +static const char *get_oneline_for_filename(struct commit *commit,
> +		int keep_subject)
> +{
> +	static char filename[PATH_MAX];
> +	char *sol;
> +	int len = 0;
> +
> +	sol = strstr(commit->buffer, "\n\n");
> +	if (!sol)
> +		filename[0] = '\0';
> +	else {
> +		int j, space = 0;
> +
> +		sol += 2;
> +		/* strip [PATCH] or [PATCH blabla] */
> +		if (!keep_subject && !prefixcmp(sol, "[PATCH")) {
> +			char *eos = strchr(sol + 6, ']');
> +			if (eos) {
> +				while (isspace(*eos))
> +					eos++;
> +				sol = eos;
> +			}
> +		}
> +
> +		for (j = 0; len < sizeof(filename) &&
> +				sol[j] && sol[j] != '\n'; j++) {
> +			if (istitlechar(sol[j])) {
> +				if (space) {
> +					filename[len++] = '-';
> +					space = 0;
> +				}
> +				filename[len++] = sol[j];
> +				if (sol[j] == '.')
> +					while (sol[j + 1] == '.')
> +						j++;
> +			} else
> +				space = 1;
> +		}
> +		while (filename[len - 1] == '.'
> +		       || filename[len - 1] == '-')
> +			len--;
> +		filename[len] = '\0';
> +	}
> +	return filename;
> +}

Where has the FORMAT_PATCH_NAME_MAX handling gone?  See c06d2daa(Limit 
filename for format-patch)...

BTW it is not only because format-patch would fail.  The maximum length 
was chosen such that it does not clutter the window when ls'ing the files.

> @@ -590,6 +594,74 @@ static void gen_message_id(struct rev_info *info, char *base)
>  	info->message_id = strbuf_detach(&buf, NULL);
>  }
>  
> +static void make_cover_letter(struct rev_info *rev,
> +		int use_stdout, int numbered, int numbered_files,
> +			      struct commit *origin, struct commit *head)
> +{
> +	const char *committer;
> +	const char *origin_sha1, *head_sha1;
> +	const char *argv[7];
> +	const char *subject_start = NULL;
> +	const char *body = "*** SUBJECT HERE ***\n\n\n*** BLURB HERE ***\n";
> +	const char *msg;
> +	const char *extra_headers = rev->extra_headers;
> +	struct strbuf sb;
> +	const char *encoding = "utf-8";
> +
> +	if (rev->commit_format != CMIT_FMT_EMAIL)
> +		die("Cover letter needs email format");
> +
> +	if (!use_stdout && reopen_stdout(numbered_files ?
> +				NULL : "cover-letter", 0, rev->total))
> +		return;
> +
> +	origin_sha1 = sha1_to_hex(origin ? origin->object.sha1 : null_sha1);
> +	head_sha1 = sha1_to_hex(head->object.sha1);
> +
> +	write_email_headers(rev, head_sha1, &subject_start, &extra_headers);
> +
> +	committer = git_committer_info(0);
> +
> +	msg = body;
> +	strbuf_init(&sb, 0);
> +	add_user_info(NULL, CMIT_FMT_EMAIL, &sb, committer, DATE_RFC2822,
> +		      encoding);
> +	pp_title_line(CMIT_FMT_EMAIL, &msg, &sb, subject_start, extra_headers,
> +		      encoding, 0);
> +	pp_remainder(CMIT_FMT_EMAIL, &msg, &sb, 0);
> +	printf("%s\n", sb.buf);
> +
> +	strbuf_release(&sb);
> +
> +	/*
> +	 * We can only do diffstat with a unique reference point, and
> +	 * log is a bit tricky, so just skip it.
> +	 */
> +	if (!origin)
> +		return;
> +
> +	argv[0] = "shortlog";
> +	argv[1] = head_sha1;
> +	argv[2] = "--not";
> +	argv[3] = origin_sha1;

Should this not output a complete shortlog, if the user said

	git format-patch --root --cover-letter HEAD

Hmm?

> +	argv[4] = NULL;
> +	fflush(stdout);
> +	run_command_v_opt(argv, RUN_GIT_CMD);
> +
> +	argv[0] = "diff";
> +	argv[1] = "--stat";
> +	argv[2] = "--summary";
> +	argv[3] = head_sha1;
> +	argv[4] = "--not";
> +	argv[5] = origin_sha1;

Likewise.

> +	argv[6] = NULL;
> +	fflush(stdout);
> +	run_command_v_opt(argv, RUN_GIT_CMD);
> +
> +	fflush(stdout);
> +	printf("\n");
> +}
> +
>  static const char *clean_message_id(const char *msg_id)
>  {
>  	char ch;
> @@ -775,6 +851,25 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>  		 * get_revision() to do the usual traversal.
>  		 */
>  	}
> +	if (cover_letter) {
> +		/* remember the range */
> +		int negative_count = 0;
> +		int i;
> +		for (i = 0; i < rev.pending.nr; i++) {
> +			struct object *o = rev.pending.objects[i].item;
> +			if (o->flags & UNINTERESTING) {
> +				origin = (struct commit *)o;
> +				negative_count++;
> +			} else
> +				head = (struct commit *)o;
> +		}
> +		/* Multiple origins don't work for diffstat. */
> +		if (negative_count > 1)
> +			origin = NULL;

Oh, and here it gets interesting.  If you say

	git format-patch --cover-letter ^commit1 ^commit2 HEAD

then origin will be set to NULL, and in the diffstat, instead of showing 
_no_ diffstat, you show the same as if no negative ref was given (which 
_should_ show a diff against the empty tree, but shows nothing currently).

So I suggest changing "origin" to a commit_list, and have cover-letter 
_not_ output a diffstat if more than one commits were given.

Or as many diffstats.  Whatever.

> +		/* We can't generate a cover letter without any patches */
> +		if (!head)
> +			return 0;

Should this not

			return error("You want a cover letter for what,"
				"exactly?");

Hmm?

> @@ -801,9 +896,18 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>  		numbered = 1;
>  	if (numbered)
>  		rev.total = total + start_number - 1;
> -	rev.add_signoff = add_signoff;
>  	if (in_reply_to)
>  		rev.ref_message_id = clean_message_id(in_reply_to);
> +	if (cover_letter) {
> +		if (thread) {
> +			gen_message_id(&rev, "cover");
> +		}

These curly brackets are sure distracting.

> +		make_cover_letter(&rev, use_stdout, numbered, numbered_files,
> +				  origin, head);
> +		total++;
> +		start_number--;
> +	}
> +	rev.add_signoff = add_signoff;

Why not sign off the cover letter, too?

BTW I had to chew over the thread handling quite a few minutes... maybe 
you want to add a test for --cover-letter --thread, just to make sure it 
does not get broken (and of course, to prove that it works with your 
patches).

Thanks,
Dscho
