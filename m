From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH] WIP: git notes copy --stdin
Date: Mon, 15 Feb 2010 02:25:52 +0100
Message-ID: <201002150225.52953.johan@herland.net>
References: <cover.1266164150.git.trast@student.ethz.ch>
 <0b241a335d71bdf56a07a712cb5506e1b1e1db6f.1266183704.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-15
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Feb 15 02:26:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ngpis-0005Xf-V3
	for gcvg-git-2@lo.gmane.org; Mon, 15 Feb 2010 02:26:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752220Ab0BOBZ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Feb 2010 20:25:58 -0500
Received: from smtp.getmail.no ([84.208.15.66]:41797 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751969Ab0BOBZ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Feb 2010 20:25:57 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KXU006MSZZ8VP90@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Mon, 15 Feb 2010 02:25:56 +0100 (MET)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KXU002FJZZ5G710@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Mon, 15 Feb 2010 02:25:56 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2010.2.15.11233
User-Agent: KMail/1.13.0 (Linux/2.6.32-ARCH; KDE/4.4.0; x86_64; ; )
In-reply-to: <0b241a335d71bdf56a07a712cb5506e1b1e1db6f.1266183704.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139955>

On Sunday 14 February 2010, Thomas Rast wrote:
> This implements a 'git notes copy --stdin' mode suitable to read the
> data fed to the post-rewrite hook.
> ---
> 
> Ok, so I changed my mind and decided to implement the "make it
> built-in and configurable" way.  This helper should work.  I spent
> some time trying to refactor cmd_notes() into something that can
> nicely handle commands that do not fit the normal scheme, but
> eventually was too tired to continue and just crafted it in the
> existing code in the right place.
> 
> If nobody beats me to it I'll pick this up later this week, but
> tomorrow will be too busy to even think about it.
> 
> 
>  builtin-notes.c |   56
> +++++++++++++++++++++++++++++++++++++++++++++++++++++++ 1 files changed,
> 56 insertions(+), 0 deletions(-)
> 
> diff --git a/builtin-notes.c b/builtin-notes.c
> index 123ecad..3cd9e45 100644
> --- a/builtin-notes.c
> +++ b/builtin-notes.c
> @@ -278,6 +278,52 @@ int commit_notes(struct notes_tree *t, const char
> *msg) return 0;
>  }
> 
> +int notes_copy_from_stdin(int force)
> +{
> +	struct strbuf buf = STRBUF_INIT;
> +	struct notes_tree *t;
> +
> +	init_notes(NULL, NULL, NULL, 0);
> +	t = &default_notes_tree;

As you say, cmd_notes() should be refactored, so that you don't have to 
duplicate all of this (and some of the below stuff).

> +	while (strbuf_getline(&buf, stdin, '\n') != EOF) {
> +		unsigned char from_obj[20], to_obj[20];
> +		struct strbuf **split;
> +		const unsigned char *note;
> +
> +		split = strbuf_split(&buf, ' ');
> +		if (!split[0] || !split[1])
> +			die("Malformed input line: '%s'.", buf.buf);
> +		strbuf_rtrim(split[0]);
> +		strbuf_rtrim(split[1]);
> +		if (get_sha1(split[0]->buf, from_obj))
> +			die("Failed to resolve '%s' as a valid ref.", split[0]->buf);
> +		if (get_sha1(split[1]->buf, to_obj))
> +			die("Failed to resolve '%s' as a valid ref.", split[1]->buf);
> +
> +		note = get_note(t, from_obj);
> +		if (!force) {
> +			const unsigned char *existing_note = get_note(t, to_obj);
> +			if (existing_note) {
> +				error("Cannot copy notes. Found existing notes for object"
> +				      " %s. Use '-f' to overwrite existing notes",
> +				      sha1_to_hex(to_obj));
> +				return 1;
> +			}
> +		}
> +
> +		if (note)
> +			add_note(t, to_obj, note, combine_notes_overwrite);
> +		else
> +			remove_note(t, to_obj);
> +
> +		strbuf_list_free(split);
> +	}
> +
> +	commit_notes(t, "Notes added by 'git notes copy'");

We (this goes for the existing commit_notes() call in cmd_notes() as well) 
should either check the return value for commit_notes(), or (since it 
currently only returns 0) we should change commit_notes() to void instead of 
int. Actually, the correct solution is probably to "return error()" instead 
of "die()" inside commit_notes(), and then check the return value.

> +	return 0;
> +}
> +
>  int cmd_notes(int argc, const char **argv, const char *prefix)
>  {
>  	struct notes_tree *t;
> @@ -301,6 +347,7 @@ int cmd_notes(int argc, const char **argv, const char
> *prefix) OPT_CALLBACK('C', "reuse-message", &msg, "OBJECT",
>  			   "reuse specified note object", parse_reuse_arg),
>  		OPT_BOOLEAN('f', "force", &force, "replace existing notes"),
> +		OPT_BOOLEAN(0, "stdin", &force, "read objects from stdin"),

Why are you setting &force from "--stdin"?

> @@ -351,6 +398,15 @@ int cmd_notes(int argc, const char **argv, const
> char *prefix)
> 
>  	if (copy) {
>  		const char *from_ref;
> +		if (stdin) {

I don't think this is intended. Isn't stdin (the standard input FILE *) 
_always_ true?

> +			if (argc > 2) {
> +				error("too few parameters");
> +				usage_with_options(git_notes_usage, options);
> +			} else {
> +				retval = notes_copy_from_stdin(force);
> +				goto end;
> +			}
> +		}
>  		if (argc < 3) {
>  			error("too few parameters");
>  			usage_with_options(git_notes_usage, options);

The patch needs to add code that barfs if "--stdin" is used with any 
subcommand other than "copy".

Of course, the patch also needs documentation and tests, but I guess you 
knew that... ;)


I like the intent of this patch, although it needs more work before it's 
finished.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
