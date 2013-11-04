From: Johan Herland <johan@herland.net>
Subject: Re: [RFC/PATCH] Add interpret-trailers builtin
Date: Mon, 4 Nov 2013 02:01:05 +0100
Message-ID: <CALKQrgdJ6d2SVWNQGa6d-eLYPAL-C21=tCyJczCDExLQRfq=jA@mail.gmail.com>
References: <20131103211731.15716.95056.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git mailing list <git@vger.kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Nov 04 02:01:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vd8Xg-0007F3-Py
	for gcvg-git-2@plane.gmane.org; Mon, 04 Nov 2013 02:01:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751485Ab3KDBBQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Nov 2013 20:01:16 -0500
Received: from mail12.copyleft.no ([188.94.218.224]:55736 "EHLO
	mail12.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750979Ab3KDBBP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Nov 2013 20:01:15 -0500
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail12.copyleft.no with esmtp (Exim 4.76)
	(envelope-from <johan@herland.net>)
	id 1Vd8XX-0003MC-5c
	for git@vger.kernel.org; Mon, 04 Nov 2013 02:01:11 +0100
Received: from mail-pa0-f41.google.com ([209.85.220.41])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1Vd8XW-0003VP-17
	for git@vger.kernel.org; Mon, 04 Nov 2013 02:01:10 +0100
Received: by mail-pa0-f41.google.com with SMTP id rd3so6297231pab.14
        for <git@vger.kernel.org>; Sun, 03 Nov 2013 17:01:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=jjlyPN444l8VuWIBkzMeKNzP8vqT7Z3oHmBIhBDa0fI=;
        b=LDZxaB98F0aO6rWQbj9yMNNDNqs7AHiE3Cu9kG7rubODISyRKjjbzNr98QzrvvFA1p
         4Q+RbABkkMXEP0akqsmmscnH0EmeLodf6R4cWA+/6fv4ZCYuyDJekKfZXoqNk7tGPTQq
         j6Toc/u4Zb584vvrR0EZFpFMBCadg1L2QCVBi8bTWn4sglSDfmnrS4VRHlsSiPUfRcWD
         8nMWthV+ZqKgRo6btVhGAU+2miFQQDWJJWuqbMu02y5iMXKa6//EeeZIgdHBFqJJgFh7
         PSqszQ5nJnDMgvqWfaD0ZVEzBDeDtWRZuqTYSU85vOP3dLzsG7O/eqCTVyD2HccepTVB
         Ojig==
X-Received: by 10.66.158.196 with SMTP id ww4mr15282372pab.57.1383526865777;
 Sun, 03 Nov 2013 17:01:05 -0800 (PST)
Received: by 10.70.24.226 with HTTP; Sun, 3 Nov 2013 17:01:05 -0800 (PST)
In-Reply-To: <20131103211731.15716.95056.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237281>

On Sun, Nov 3, 2013 at 10:17 PM, Christian Couder
<chriscool@tuxfamily.org> wrote:
> This RFC patch shows the work in progress to implement a new
> command:

First of all: Thanks for working on this! This looks like a really
good start. Plenty of comments below (mostly either to learn myself,
or to check what alternatives you've considered), but overall, I'm
happy about where this is going.

>         git interpret-trailers

Pesonally, I'd rather name it "git process-footers", since I think
"process" better captures the two-way functionality of this program
(both parsing/interpreting _and_ generating/writiing), and I believe
I'm not alone in preferring "footer" over "trailer". That said, this
is certainly bikeshedding territory, and I am not the one writing the
code, so feel free to ignore.

> 1) Rational:

s/Rational/Rationale/

>
> This command should help with RFC 822 style headers, called
> "trailers", that are found at the end of commit messages.

As has been asked earlier in this discussion, we should probably
specify explicitly what we _mean_ with "RFC822-style"
headers/footers/trailers, and exactly how closely we follow the actual
RFC... E.g. do we make use of the linebreaking rules? encoding
handling? etc... We may want to take a more relaxed approach (after
all, we're not including a complete RFC822/RFC2822 implementation),
but we should at least state so, and possibly how/why we do so.

> For a long time, these trailers have become a de facto standard
> way to add helpful information into commit messages.
>
> Until now git commit has only supported the well known
> "Signed-off-by: " trailer, that is used by many projects like
> the Linux kernel and Git.
>
> It is better to implement features for these trailers in a new
> command rather than in builtin/commit.c, because this way the
> prepare-commit-msg and commit-msg hooks can reuse this command.
>
> 2) Current state:
>
> Currently the usage string of this command is:
>
> git interpret-trailers [--trim-empty] [--infile=file] [<token[=value]>...]

--trim-empty will remove empty footers given on the command-line? Or
in the infile? or both? I think I'm fine with both, but I wonder if
there is a use case for treating the two types of empty footers
separately...

> The following features are implemented:
>         - the result is printed on stdout
>         - the [<token[=value]>...] arguments are interpreted
>         - a commit message passed using the "--infile=file" option is interpreted

If the output is written to stdout, then why is not the input taken
from stdin? Or vice versa: why not --outfile?

>         - the "trailer.<token>.value" options in the config are interpreted

This is the default value of the footer if not further specified on
the command-line?

> The following features are planned but not yet implemented:
>         - some documentation
>         - more tests
>         - the "trailer.<token>.if_exist" config option
>         - the "trailer.<token>.if_missing" config option

Not sure what these two options will do, or what kind of values they take...

>         - the "trailer.<token>.command" config option

I guess the value of .command is executed to generate the default
content of the footer?

> 3) Notes:
>
> * "trailer" seems better than "commitTrailer" as the config key because
> it looks like all the config keys are lower case and "committrailer" is not
> very readable.

As stated above, I prefer "footer" over "trailer"...

> * "trailer.<token>.value" looks better than "trailer.<token>.trailer", so
> I chose the former.
>
> * Rather than only one "trailer.<token>.style" config option, it seems
> better to me to have both "trailer.<token>.if_exist" and
> "trailer.<token>.if_missing".
>
> * I might send a patch series instead of just one big patch when there will
> be fewer big changes in the code.

Maybe at least split in two:
 - One patch to deal with the administrivia of adding a new command.
 - One (or more) patch(es) to introduce the logic/functionality of the
new command.

> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  .gitignore                    |   1 +
>  Makefile                      |   1 +
>  builtin.h                     |   1 +
>  builtin/interpret-trailers.c  | 284 ++++++++++++++++++++++++++++++++++++++++++
>  git.c                         |   1 +
>  strbuf.c                      |   7 ++
>  strbuf.h                      |   1 +
>  t/t7513-interpret-trailers.sh | 101 +++++++++++++++
>  8 files changed, 397 insertions(+)
>  create mode 100644 builtin/interpret-trailers.c
>  create mode 100755 t/t7513-interpret-trailers.sh
>
> diff --git a/.gitignore b/.gitignore
> index 66199ed..e6cf15b 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -73,6 +73,7 @@
>  /git-index-pack
>  /git-init
>  /git-init-db
> +/git-interpret-trailers
>  /git-instaweb
>  /git-log
>  /git-lost-found
> diff --git a/Makefile b/Makefile
> index af847f8..96441f1 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -937,6 +937,7 @@ BUILTIN_OBJS += builtin/hash-object.o
>  BUILTIN_OBJS += builtin/help.o
>  BUILTIN_OBJS += builtin/index-pack.o
>  BUILTIN_OBJS += builtin/init-db.o
> +BUILTIN_OBJS += builtin/interpret-trailers.o
>  BUILTIN_OBJS += builtin/log.o
>  BUILTIN_OBJS += builtin/ls-files.o
>  BUILTIN_OBJS += builtin/ls-remote.o
> diff --git a/builtin.h b/builtin.h
> index b56cf07..88c2999 100644
> --- a/builtin.h
> +++ b/builtin.h
> @@ -71,6 +71,7 @@ extern int cmd_hash_object(int argc, const char **argv, const char *prefix);
>  extern int cmd_help(int argc, const char **argv, const char *prefix);
>  extern int cmd_index_pack(int argc, const char **argv, const char *prefix);
>  extern int cmd_init_db(int argc, const char **argv, const char *prefix);
> +extern int cmd_interpret_trailers(int argc, const char **argv, const char *prefix);
>  extern int cmd_log(int argc, const char **argv, const char *prefix);
>  extern int cmd_log_reflog(int argc, const char **argv, const char *prefix);
>  extern int cmd_ls_files(int argc, const char **argv, const char *prefix);
> diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
> new file mode 100644
> index 0000000..2bcd480
> --- /dev/null
> +++ b/builtin/interpret-trailers.c
> @@ -0,0 +1,284 @@
> +/*
> + * Builtin "git interpret-trailers"
> + *
> + * Copyright (c) 2013 Christian Couder <chriscool@tuxfamily.org>
> + *
> + */
> +
> +#include "cache.h"
> +#include "builtin.h"
> +#include "parse-options.h"
> +#include "strbuf.h"
> +
> +static const char * const git_interpret_trailers_usage[] = {
> +       N_("git interpret-trailers [--trim-empty] [--infile=file] [<token[=value]>...]"),
> +       NULL
> +};
> +
> +static void parse_arg(struct strbuf *tok, struct strbuf *val, const char *arg)

When discussing RFC822-style headers (or in our case,
footer/trailers), one often talks about a "field" which consists of a
"field name" and a "field value" (or "field body"). I propose that we
use the same naming convention in our code.

Here, I assume 'tok' is the field name, and 'val' is the field value.
Maybe rename to "name" and "value", respectively?

> +{
> +       char *end = strchr(arg, '=');
> +       if (!end)
> +               end = strchr(arg, ':');

So both '=' (preferred) and ':' are accepted as field/value
separators. That's ok for the command-line, I believe.

> +       if (end) {
> +               strbuf_add(tok, arg, end - arg);
> +               strbuf_trim(tok);
> +               strbuf_addstr(val, end + 1);
> +               strbuf_trim(val);
> +       } else {
> +               strbuf_addstr(tok, arg);
> +               strbuf_trim(tok);
> +       }
> +}
> +
> +static struct string_list trailer_list;
> +
> +enum style_if_exist { DONT_REPEAT, OVERWRITE, REPEAT };

>From the enum values, I assume that these declare the desired behavior
when there are two (or more?) or the same footer (i.e. same "field
name"). However, it's not (yet) obvious to me in which order they are
processed. There are several opportunities for multiple instances of
the same "field name":

 - Two (or more) occurences in the infile
 - Two (or more) occurences on the command line
 - One occurence in the infile, and one of the command line

It is not obvious to me in which order these are processed, or which
of those cases constitute a duplicate/repetition, hence it's not clear
to me what the result will be when e.g. using OVERWRITE. Also not sure
what DONT_REPEAT means, and if/how it's different from OVERWRITE.
Instead, I suggest we should specify clearly:

 1. In which order are the footers processed
 2. What constitutes a repetition/duplicate (IMHO all of the above three cases)
 3. Better enum names that are easily understood given the rules in #1
and #2, I suggest:

enum handle_duplicates { KEEP_FIRST, KEEP_LAST, KEEP_ALL };

> +enum style_if_missing { DONT_APPEND, APPEND };

enum handle_missing { SKIP, INCLUDE }; ?

> +struct trailer_info {
> +       char *value;

Is this the field _name_ or field _value_?

> +       char *command;

I assume this is only used when trailer.<token>.command is used?

> +       enum style_if_exist style_exist;
> +       enum style_if_missing style_missing;
> +};
> +
> +static int git_trailer_config(const char *key, const char *value, void *cb)
> +{
> +       if (!prefixcmp(key, "trailer.")) {
> +               const char *orig_key = key;
> +               char *name;
> +               struct string_list_item *item;
> +               struct trailer_info *info;
> +               enum { VALUE, COMMAND, IF_EXIST, IF_MISSING } type;
> +
> +               key += 8;
> +               if (!suffixcmp(key, ".value")) {
> +                       name = xstrndup(key, strlen(key) - 6);
> +                       type = VALUE;
> +               } else if (!suffixcmp(key, ".command")) {
> +                       name = xstrndup(key, strlen(key) - 8);
> +                       type = COMMAND;
> +               } else if (!suffixcmp(key, ".if_exist")) {
> +                       name = xstrndup(key, strlen(key) - 9);
> +                       type = IF_EXIST;
> +               } else if (!suffixcmp(key, ".if_missing")) {
> +                       name = xstrndup(key, strlen(key) - 11);
> +                       type = IF_MISSING;
> +               } else
> +                       return 0;
> +
> +               item = string_list_insert(&trailer_list, name);
> +
> +               if (!item->util)
> +                       item->util = xcalloc(sizeof(struct trailer_info), 1);
> +               info = item->util;
> +               if (type == VALUE) {
> +                       if (info->value)
> +                               warning(_("more than one %s"), orig_key);
> +                       info->value = xstrdup(value);
> +               } else if (type == IF_EXIST) {

Consider splitting the parsing of values -> enums into helper
functions, to make this function shorter and its logic more easily
followed.

> +                       if (!strcasecmp("dont_repeat", value)) {
> +                               info->style_exist = DONT_REPEAT;
> +                       } else if (!strcasecmp("overwrite", value)) {
> +                               info->style_exist = OVERWRITE;
> +                       } else if (!strcasecmp("repeat", value)) {
> +                               info->style_exist = REPEAT;
> +                       } else
> +                               warning(_("unknow value '%s' for key '%s'"), value, orig_key);

s/unknow/unknown/

> +               } else if (type == IF_MISSING) {
> +                       if (!strcasecmp("dont_append", value)) {
> +                               info->style_missing = DONT_APPEND;
> +                       } else if (!strcasecmp("append", value)) {
> +                               info->style_missing = APPEND;
> +                       } else
> +                               warning(_("unknow value '%s' for key '%s'"), value, orig_key);
> +               } else {
> +                       if (info->command)
> +                               warning(_("more than one %s"), orig_key);
> +                       info->command = xstrdup(value);
> +               }
> +       }
> +       return 0;
> +}
> +
> +static size_t alnum_len(const char *buf, size_t len) {
> +       while (--len >= 0 && !isalnum(buf[len]));
> +       return len + 1;
> +}
> +
> +static void apply_config(struct strbuf *tok, struct strbuf *val, struct trailer_info *info)
> +{
> +       if (info->value) {
> +               strbuf_reset(tok);
> +               strbuf_addstr(tok, info->value);
> +       }
> +       if (info->command) {
> +       }

I guess this if-block might be filled by a later commit, but is there
any reason to have the empty block in this commit?

> +}
> +
> +static void apply_config_list(struct strbuf *tok, struct strbuf *val)
> +{
> +       int j, tok_alnum_len = alnum_len(tok->buf, tok->len);

So tok_alnum_len is the length of the initial run of alphanumeric
characters in tok (i.e. does not include '-'?)

> +
> +       for (j = 0; j < trailer_list.nr; j++) {

We're iterating through the footers we found in infile?

> +               struct string_list_item *item = trailer_list.items + j;
> +               struct trailer_info *info = item->util;
> +               if (!strncasecmp(tok->buf, item->string, tok_alnum_len) ||
> +                   !strncasecmp(tok->buf, info->value, tok_alnum_len)) {

What is held in item->string? and what is held in info->value, and why
are _both_ being compared to (the initial run of alphanumerics in)
tok?

> +                       apply_config(tok, val, info);
> +                       break;
> +               }
> +       }
> +}
> +
> +static struct strbuf **read_input_file(const char *infile)
> +{
> +       struct strbuf sb = STRBUF_INIT;
> +
> +       if (strbuf_read_file(&sb, infile, 0) < 0)
> +               die_errno(_("could not read input file '%s'"), infile);
> +
> +       return strbuf_split(&sb, '\n');
> +}
> +
> +/*
> + * Return the the (0 based) index of the first trailer line
> + * or the line count if there are no trailers.
> + */
> +static int find_trailer_start(struct strbuf **lines)
> +{
> +       int count, start, empty = 1;
> +
> +       /* Get the line count */
> +       for (count = 0; lines[count]; count++);
> +
> +       /*
> +        * Get the start of the trailers by looking starting from the end
> +        * for a line with only spaces before lines with one ':'.
> +        */

This means that if the footers end up in multiple paragraphs, like this:

    Tested-by: foo
    Reviewed-by: bar

    Signed-off-by: xyzzy
    Signed-off-by: zyxxy

then only the latter of these two sections will be considered? What
about instead looking for the last line (i.e. first line from bottom)
that neither (a) contains ':' or (b) consists solely of zero or more
whitespace (blank lines)? Maybe also want to tighten rule (a) to only
match lines that consist of a single word (i.e. no inter-word spaces)
before the ':' (i.e. something like "^\s*[a-zA-Z0-9-]+\s*:" in
regexp-speak).

That's all I had time for now. Hopefully, I'll have some more time to
continue the review later.


Hope this helps,

...Johan

> +       for (start = count - 1; start >= 0; start--) {
> +               if (strbuf_isspace(lines[start])) {
> +                       if (empty)
> +                               continue;
> +                       return start + 1;
> +               }
> +               if (strchr(lines[start]->buf, ':')) {
> +                       if (empty)
> +                               empty = 0;
> +                       continue;
> +               }
> +               return count;
> +       }
> +
> +       return empty ? count : start + 1;
> +}
> +
> +static void print_tok_val(const char *tok_buf, size_t tok_len,
> +                         const char *val_buf, size_t val_len)
> +{
> +       char c = tok_buf[tok_len - 1];
> +       if (isalnum(c))
> +               printf("%s: %s\n", tok_buf, val_buf);
> +       else if (isspace(c) || c == '#')
> +               printf("%s%s\n", tok_buf, val_buf);
> +       else
> +               printf("%s %s\n", tok_buf, val_buf);
> +}
> +
> +static void process_input_file(const char *infile,
> +                              struct string_list *tok_list,
> +                              struct string_list *val_list)
> +{
> +       struct strbuf **lines = read_input_file(infile);
> +       int start = find_trailer_start(lines);
> +       int i;
> +
> +       /* Output non trailer lines as is */
> +       for (i = 0; lines[i] && i < start; i++) {
> +               printf("%s", lines[i]->buf);
> +       }
> +
> +       /* Process trailer lines */
> +       for (i = start; lines[i]; i++) {
> +               struct strbuf tok = STRBUF_INIT;
> +               struct strbuf val = STRBUF_INIT;
> +               parse_arg(&tok, &val, lines[i]->buf);
> +               string_list_append(tok_list, strbuf_detach(&tok, NULL));
> +               string_list_append(val_list, strbuf_detach(&val, NULL));
> +       }
> +}
> +
> +int cmd_interpret_trailers(int argc, const char **argv, const char *prefix)
> +{
> +       const char *infile = NULL;
> +       int trim_empty = 0;
> +       int i;
> +       struct string_list tok_list = STRING_LIST_INIT_NODUP;
> +       struct string_list val_list = STRING_LIST_INIT_NODUP;
> +       char *applied_arg;
> +
> +       struct option options[] = {
> +               OPT_BOOL(0, "trim-empty", &trim_empty, N_("trim empty trailers")),
> +               OPT_FILENAME(0, "infile", &infile, N_("use message from file")),
> +               OPT_END()
> +       };
> +
> +       argc = parse_options(argc, argv, prefix, options,
> +                            git_interpret_trailers_usage, 0);
> +
> +       git_config(git_trailer_config, NULL);
> +
> +       /* Print the non trailer part of infile */
> +       if (infile) {
> +               process_input_file(infile, &tok_list, &val_list);
> +               applied_arg = xcalloc(tok_list.nr, 1);
> +       }
> +
> +       for (i = 0; i < argc; i++) {
> +               struct strbuf tok = STRBUF_INIT;
> +               struct strbuf val = STRBUF_INIT;
> +               int j, seen = 0;
> +
> +               parse_arg(&tok, &val, argv[i]);
> +
> +               apply_config_list(&tok, &val);
> +
> +               /* Apply the trailer arguments to the trailers in infile */
> +               for (j = 0; j < tok_list.nr; j++) {
> +                       struct string_list_item *tok_item = tok_list.items + j;
> +                       struct string_list_item *val_item = val_list.items + j;
> +                       int tok_alnum_len = alnum_len(tok.buf, tok.len);
> +                       if (!strncasecmp(tok.buf, tok_item->string, tok_alnum_len)) {
> +                               tok_item->string = xstrdup(tok.buf);
> +                               val_item->string = xstrdup(val.buf);
> +                               seen = 1;
> +                               applied_arg[j] = 1;
> +                               break;
> +                       }
> +               }
> +
> +               /* Print the trailer arguments that are not in infile */
> +               if (!seen && (!trim_empty || val.len > 0))
> +                       print_tok_val(tok.buf, tok.len, val.buf, val.len);
> +
> +               strbuf_release(&tok);
> +               strbuf_release(&val);
> +       }
> +
> +       /* Print the trailer part of infile */
> +       for (i = 0; i < tok_list.nr; i++) {
> +               struct strbuf tok = STRBUF_INIT;
> +               struct strbuf val = STRBUF_INIT;
> +               strbuf_addstr(&tok, tok_list.items[i].string);
> +               strbuf_addstr(&val, val_list.items[i].string);
> +
> +               if (!applied_arg[i])
> +                       apply_config_list(&tok, &val);
> +
> +               if (!trim_empty || val.len > 0)
> +                       print_tok_val(tok.buf, tok.len, val.buf, val.len);
> +       }
> +
> +       return 0;
> +}
> diff --git a/git.c b/git.c
> index cb5208d..9f2eb77 100644
> --- a/git.c
> +++ b/git.c
> @@ -383,6 +383,7 @@ static void handle_internal_command(int argc, const char **argv)
>                 { "index-pack", cmd_index_pack, RUN_SETUP_GENTLY },
>                 { "init", cmd_init_db },
>                 { "init-db", cmd_init_db },
> +               { "interpret-trailers", cmd_interpret_trailers, RUN_SETUP },
>                 { "log", cmd_log, RUN_SETUP },
>                 { "ls-files", cmd_ls_files, RUN_SETUP },
>                 { "ls-remote", cmd_ls_remote, RUN_SETUP_GENTLY },
> diff --git a/strbuf.c b/strbuf.c
> index 1170d01..f9080fa 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -106,6 +106,13 @@ void strbuf_ltrim(struct strbuf *sb)
>         sb->buf[sb->len] = '\0';
>  }
>
> +int strbuf_isspace(struct strbuf *sb)
> +{
> +       char *b;
> +       for (b = sb->buf; *b && isspace(*b); b++);
> +       return !*b;
> +}
> +
>  struct strbuf **strbuf_split_buf(const char *str, size_t slen,
>                                  int terminator, int max)
>  {
> diff --git a/strbuf.h b/strbuf.h
> index 73e80ce..02bff3a 100644
> --- a/strbuf.h
> +++ b/strbuf.h
> @@ -42,6 +42,7 @@ static inline void strbuf_setlen(struct strbuf *sb, size_t len) {
>  extern void strbuf_trim(struct strbuf *);
>  extern void strbuf_rtrim(struct strbuf *);
>  extern void strbuf_ltrim(struct strbuf *);
> +extern int strbuf_isspace(struct strbuf *);
>  extern int strbuf_cmp(const struct strbuf *, const struct strbuf *);
>
>  /*
> diff --git a/t/t7513-interpret-trailers.sh b/t/t7513-interpret-trailers.sh
> new file mode 100755
> index 0000000..5d2f967
> --- /dev/null
> +++ b/t/t7513-interpret-trailers.sh
> @@ -0,0 +1,101 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2013 Christian Couder
> +#
> +
> +test_description='git interpret-trailers'
> +
> +. ./test-lib.sh
> +
> +cat >basic_message <<'EOF'
> +subject
> +
> +body
> +EOF
> +
> +cat >complex_message_body <<'EOF'
> +my subject
> +
> +my body which is long
> +and contains some special
> +chars like : = ? !
> +
> +EOF
> +
> +# Do not remove trailing spaces below!
> +cat >complex_message_trailers <<'EOF'
> +Fixes:
> +Acked-by:
> +Reviewed-by:
> +Signed-off-by:
> +EOF
> +
> +test_expect_success 'without config' '
> +       printf "ack: Peff\nReviewed-by: \nAcked-by: Johan\n" >expected &&
> +       git interpret-trailers "ack = Peff" "Reviewed-by" "Acked-by: Johan" >actual &&
> +       test_cmp expected actual
> +'
> +
> +test_expect_success '--trim-empty without config' '
> +       printf "ack: Peff\nAcked-by: Johan\n" >expected &&
> +       git interpret-trailers --trim-empty "ack = Peff" "Reviewed-by" "Acked-by: Johan" "sob:" >actual &&
> +       test_cmp expected actual
> +'
> +
> +test_expect_success 'with config setup' '
> +       git config trailer.ack.value "Acked-by: " &&
> +       printf "Acked-by: Peff\n" >expected &&
> +       git interpret-trailers --trim-empty "ack = Peff" >actual &&
> +       test_cmp expected actual &&
> +       git interpret-trailers --trim-empty "Acked-by = Peff" >actual &&
> +       test_cmp expected actual &&
> +       git interpret-trailers --trim-empty "Acked-by :Peff" >actual &&
> +       test_cmp expected actual
> +'
> +
> +test_expect_success 'with config setup and = sign' '
> +       git config trailer.ack.value "Acked-by= " &&
> +       printf "Acked-by= Peff\n" >expected &&
> +       git interpret-trailers --trim-empty "ack = Peff" >actual &&
> +       test_cmp expected actual &&
> +       git interpret-trailers --trim-empty "Acked-by= Peff" >actual &&
> +       test_cmp expected actual &&
> +       git interpret-trailers --trim-empty "Acked-by : Peff" >actual &&
> +       test_cmp expected actual
> +'
> +
> +test_expect_success 'with config setup and # sign' '
> +       git config trailer.bug.value "Bug #" &&
> +       printf "Bug #42\n" >expected &&
> +       git interpret-trailers --trim-empty "bug = 42" >actual &&
> +       test_cmp expected actual
> +'
> +
> +test_expect_success 'with commit basic message' '
> +       git interpret-trailers --infile basic_message >actual &&
> +       test_cmp basic_message actual
> +'
> +
> +test_expect_success 'with commit complex message' '
> +       cat complex_message_body complex_message_trailers >complex_message &&
> +       cat complex_message_body >expected &&
> +       printf "Fixes: \nAcked-by= \nReviewed-by: \nSigned-off-by: \n" >>expected &&
> +       git interpret-trailers --infile complex_message >actual &&
> +       test_cmp expected actual
> +'
> +
> +test_expect_success 'with commit complex message and args' '
> +       cat complex_message_body >expected &&
> +       printf "Bug #42\nFixes: \nAcked-by= Peff\nReviewed-by: \nSigned-off-by: \n" >>expected &&
> +       git interpret-trailers --infile complex_message "ack: Peff" "bug: 42" >actual &&
> +       test_cmp expected actual
> +'
> +
> +test_expect_success 'with commit complex message, args and --trim-empty' '
> +       cat complex_message_body >expected &&
> +       printf "Bug #42\nAcked-by= Peff\n" >>expected &&
> +       git interpret-trailers --trim-empty --infile complex_message "ack: Peff" "bug: 42" >actual &&
> +       test_cmp expected actual
> +'
> +
> +test_done
> --
> 1.8.4.1.576.g36ba827.dirty
>



-- 
Johan Herland, <johan@herland.net>
www.herland.net
