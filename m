From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 2/2] grep Added --blame so that grep can show result tagged
   with blame entries
Date: Mon, 09 Mar 2009 22:22:39 +0100
Message-ID: <49B5889F.9060902@lsrfire.ath.cx>
References: <49B517A3.9050209@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: pi song <pi.songs@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 09 22:24:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgmxJ-0002Rt-MY
	for gcvg-git-2@gmane.org; Mon, 09 Mar 2009 22:24:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753766AbZCIVWq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2009 17:22:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753655AbZCIVWp
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Mar 2009 17:22:45 -0400
Received: from india601.server4you.de ([85.25.151.105]:37798 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752988AbZCIVWo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2009 17:22:44 -0400
Received: from [10.0.1.101] (p57B7F24E.dip.t-dialin.net [87.183.242.78])
	by india601.server4you.de (Postfix) with ESMTPSA id 8A5262F8063;
	Mon,  9 Mar 2009 22:22:41 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <49B517A3.9050209@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112745>

pi song schrieb:
> This part:-
> 1) Implementation & man for grep --blame option

I read the list via Gmane and I can't find patch 1/2.  But if this here
is part 1, perhaps there is no "1/2"?

> 
> Signed-off-by: Pi Song <pi.songs@gmail.com>
> ---
> Documentation/git-grep.txt |    5 ++
> builtin-grep.c             |   10 ++++-
> grep.c                     |   98
> ++++++++++++++++++++++++++++++++++++-------
> grep.h                     |    1 +
> 4 files changed, 96 insertions(+), 18 deletions(-)
> 
> diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
> index 553da6c..23dae7f 100644
> --- a/Documentation/git-grep.txt
> +++ b/Documentation/git-grep.txt
> @@ -18,6 +18,7 @@ SYNOPSIS
>        [-z | --null]
>        [-c | --count] [--all-match]
>        [-A <post-context>] [-B <pre-context>] [-C <context>]
> +       [-b | --blame ]

Your mailer seems to have butchered all tabs.  There is a paragraph in
Documentation/SubmittingPatches about Gmail; seeing your email address I
think it might interest you.

>        [-f <file>] [-e] <pattern>
>        [--and|--or|--not|(|)|-e <pattern>...] [<tree>...]
>        [--] [<path>...]
> @@ -105,6 +106,10 @@ OPTIONS
>     Instead of showing every matched line, show the number of
>     lines that match.
> 
> +-b::
> +--blame::
> +    Show blame of every matched line and context
> +

Sounds interesting and useful.

> -[ABC] <context>::
>     Show `context` trailing (`A` -- after), or leading (`B`
>     -- before), or both (`C` -- context) lines, and place a
> diff --git a/builtin-grep.c b/builtin-grep.c
> index 3f12ba3..c6cffa0 100644
> --- a/builtin-grep.c
> +++ b/builtin-grep.c
> @@ -630,6 +630,11 @@ int cmd_grep(int argc, const char **argv, const
> char *prefix)
>             opt.word_regexp = 1;
>             continue;
>         }
> +                if (!strcmp("-b", arg) ||
> +            !strcmp("--blame", arg)) {
> +            opt.include_blame = 1;
> +            continue;
> +        }
>         if (!prefixcmp(arg, "-A") ||
>             !prefixcmp(arg, "-B") ||
>             !prefixcmp(arg, "-C") ||
> diff --git a/grep.c b/grep.c
> index 062b2b6..0514384 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -1,3 +1,4 @@
> +#include "blame.h"
> #include "cache.h"
> #include "grep.h"
> #include "xdiff-interface.h"
> @@ -252,14 +253,17 @@ static int word_char(char ch)
> }
> 
> static void show_line(struct grep_opt *opt, const char *bol, const char
> *eol,
> -              const char *name, unsigned lno, char sign)
> +              const char *name, unsigned lno, char sign,
> +                      char sign2, char* suspect)
> {
>     if (opt->null_following_name)
>         sign = '\0';
>     if (opt->pathname)
>         printf("%s%c", name, sign);
> +        if ((opt->include_blame) && (suspect!=NULL))
> +        printf("%s%c", suspect);
>     if (opt->linenum)
> -        printf("%d%c", lno, sign);
> +        printf("%d%c", lno, sign2);
>     printf("%.*s\n", (int)(eol-bol), bol);
> }

Please be aware of recent changes to that code to add match coloring (in
next and pu).  Could you please rebase your changes on top of next?

> 
> @@ -442,6 +446,14 @@ static int match_line(struct grep_opt *opt, char
> *bol, char *eol,
>     return 0;
> }
> 
> +static int setup_revision_by_revId(char *revId, struct rev_info *revs)
> +{
> +    const char *args[] = {"grep", revId};
> +    init_revisions(revs, NULL);
> +    setup_revisions(2, args, revs, NULL);
> +    return 1 ;
> +};
> +
> static int grep_buffer_1(struct grep_opt *opt, const char *name,
>              char *buf, unsigned long size, int collect_hits)
> {
> @@ -457,6 +469,7 @@ static int grep_buffer_1(struct grep_opt *opt, const
> char *name,
>     int binary_match_only = 0;
>     const char *hunk_mark = "";
>     unsigned count = 0;
> +        int blame_calculated = 0 ;
>     enum grep_context ctx = GREP_CONTEXT_HEAD;
> 
>     if (buffer_is_binary(buf, size)) {
> @@ -477,6 +490,8 @@ static int grep_buffer_1(struct grep_opt *opt, const
> char *name,
>     if (opt->pre_context || opt->post_context)
>         hunk_mark = "--\n";
> 
> +        /* List of blame tags */
> +        struct blame_tag *blame_tags  = NULL;

Please put declarations at the start of a block to make the code
compatible with older (non-C99) compilers.

>     while (left) {
>         char *eol, ch;
>         int hit;
> @@ -505,6 +520,35 @@ static int grep_buffer_1(struct grep_opt *opt,
> const char *name,
>                 return 0;
>             goto next_line;
>         }
> +
> +                /* Calculate blame if necessary */
> +                if (hit && opt->include_blame && !blame_calculated)
> +                {

Style:
	if (condition) {
	
> +                    struct blame_stat blame_stat ;
> +                    struct rev_info revs;
> +                    char filename[128] ;
> +                    char revId[41] ;
> +                    char *splitterPtr ;
> +                   +                    if ((splitterPtr=strstr(name,
> ":")) != NULL)
> +                    {
> +                        strcpy(filename, splitterPtr + 1) ;
> +                        strncpy(revId, name, splitterPtr - name) ;
> +                        revId[40] = '\0' ;
> +                        setup_revision_by_revId(revId, &revs) ;
> +                    }
> +                    else
> +                    {

Style:
	} else {

> +                        const char *args[] = {};
> +                        strcpy(filename, name) ;
> +                        init_revisions(&revs, NULL);
> +                        setup_revisions(0, args, &revs, NULL);
> +                    }
> +
> +                    blame_tags = retrieve_blame_tags(&revs,
> &blame_stat, filename) ;

retrieve_blame_tags() doesn't exist currently, so I guess it is
introduced in patch 1/2.

> +                    blame_calculated = 1 ;
> +                }
> +
>         if (hit) {
>             count++;
>             if (opt->status_only)
> @@ -533,30 +577,47 @@ static int grep_buffer_1(struct grep_opt *opt,
> const char *name,
>                     from = last_shown + 1;
>                 if (last_shown && from != last_shown + 1)
>                     fputs(hunk_mark, stdout);
> -                while (from < lno) {
> +
> +                                /* This prints the precontext*/
> +                while (from < lno)
> +                                {

Style:
	while (condition) {

>                     pcl = &prev[lno-from-1];
>                     show_line(opt, pcl->bol, pcl->eol,
> -                          name, from, '-');
> +                          name, from, ':', '-',
> +                                                  blame_tags==NULL?
> +                                                  NULL:
> blame_tags[from-1].author);
>                     from++;
>                 }
>                 last_shown = lno-1;
>             }
>             if (last_shown && lno != last_shown + 1)
>                 fputs(hunk_mark, stdout);
> -            if (!opt->count)
> -                show_line(opt, bol, eol, name, lno, ':');
> +
> +            if (!opt->count) {
> +                                /* The matching line */
> +                                show_line(opt, bol, eol, name, lno,
> +                                          ':', ':',
> +                                        blame_tags==NULL?
> +                                        NULL:blame_tags[lno-1].author);
> +                        }
> +                           last_shown = last_hit = lno;
>         }
> -        else if (last_hit &&
> -             lno <= last_hit + opt->post_context) {
> -            /* If the last hit is within the post context,
> -             * we need to show this line.
> -             */
> -            if (last_shown && lno != last_shown + 1)
> -                fputs(hunk_mark, stdout);
> -            show_line(opt, bol, eol, name, lno, '-');
> -            last_shown = lno;
> -        }
> +                else if (last_hit && lno <= last_hit + opt->post_context)
> +                {
> +                            /* If the last hit is within the post context,
> +                             * we need to show this line.
> +                             */
> +                            if (last_shown && lno != last_shown + 1)
> +                                    fputs(hunk_mark, stdout);
> +
> +                            show_line(opt, bol, eol, name, lno, ':', '-',
> +                                     blame_tags==NULL?
> +                                     NULL:blame_tags[lno-1].author);
> +                           +                            last_shown = lno;
> +                }
> +
>         if (opt->pre_context) {
>             memmove(prev+1, prev,
>                 (opt->pre_context-1) * sizeof(*prev));
> @@ -572,6 +633,11 @@ static int grep_buffer_1(struct grep_opt *opt,
> const char *name,
>         lno++;
>     }
> 
> +        if (blame_calculated)
> +        {
> +                free(blame_tags) ;
> +        }
> +

Style:
	if (condition)
		single_line_expression;

>     free(prev);
>     if (collect_hits)
>         return 0;
> diff --git a/grep.h b/grep.h
> index 5102ce3..2e12e03 100644
> --- a/grep.h
> +++ b/grep.h
> @@ -79,6 +79,7 @@ struct grep_opt {
>     int regflags;
>     unsigned pre_context;
>     unsigned post_context;
> +        unsigned include_blame;
> };
> 
> extern void append_grep_pattern(struct grep_opt *opt, const char *pat,
> const char *origin, int no, enum grep_pat_token t);
