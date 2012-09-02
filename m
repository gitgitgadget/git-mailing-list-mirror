From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH 6/9] For each exclude pattern, store information about where it came from
Date: Sun, 2 Sep 2012 18:00:26 +0100
Organization: OPDS
Message-ID: <997D30474124498FBFBA89C2E20F7773@PhilipOakley>
References: <1346544731-938-1-git-send-email-git@adamspiers.org> <1346544731-938-7-git-send-email-git@adamspiers.org>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, "Jeff King" <peff@peff.net>,
	=?iso-8859-1?Q?Nguy=3Fn_Th=E1i_Ng=3Fc_Duy?= <pclouds@gmail.com>
To: "Adam Spiers" <git@adamspiers.org>,
	"git list" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Sep 02 19:01:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T8DXy-0003Fi-Gv
	for gcvg-git-2@plane.gmane.org; Sun, 02 Sep 2012 19:01:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754246Ab2IBRA3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Sep 2012 13:00:29 -0400
Received: from out1.ip02ir2.opaltelecom.net ([62.24.128.238]:38687 "EHLO
	out1.ip02ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754204Ab2IBRA3 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Sep 2012 13:00:29 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AnkSADGQQ1BZ8rU+/2dsb2JhbAA7CotErlkBAQEBgQCBCIIbBQEBBAEIAQEdEREFCAEBIQUGAgMFAgEDDgMDAQEBCiUUAQQYAgYHDwgGAQcLCAIBAgMBDASHZgoHuiOLDRAlCGZpGxkHgQqCcmADiBuFQ4kPjwaCZA
X-IronPort-AV: E=Sophos;i="4.80,356,1344207600"; 
   d="scan'208";a="402196552"
Received: from host-89-242-181-62.as13285.net (HELO PhilipOakley) ([89.242.181.62])
  by out1.ip02ir2.opaltelecom.net with SMTP; 02 Sep 2012 18:00:26 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204667>

From: "Adam Spiers" <git@adamspiers.org>
Sent: Sunday, September 02, 2012 1:12 AM
Subject: [PATCH 6/9] For each exclude pattern, store information about 
where it came from


> For exclude patterns read in from files, the filename is stored 
> together
> with the corresponding line number (counting starting at 1).

Is there a way to identify the config core.excludesfile if present? i.e. 
that it is from that config variable, rather than directory traversal.

This came up in a recent 
http://stackoverflow.com/questions/12199150/effective-gitignore-and-clean-strategy/12205852#12205852 
discussion.

>
> For exclude patterns provided on the command line, the sequence number
> is negative, with counting starting at -1, so for example the 2nd
> pattern provided via --exclude would be numbered -2.  This allows any
> future consumers of that data to easily distinguish between exclude
> patterns from files vs. from the CLI.
>
> Signed-off-by: Adam Spiers <git@adamspiers.org>
> ---
> builtin/clean.c    |  2 +-
> builtin/ls-files.c |  3 ++-
> dir.c              | 25 +++++++++++++++++++------
> dir.h              |  5 ++++-
> 4 files changed, 26 insertions(+), 9 deletions(-)
>
> diff --git a/builtin/clean.c b/builtin/clean.c
> index 0c7b3d0..f618231 100644
> --- a/builtin/clean.c
> +++ b/builtin/clean.c
> @@ -99,7 +99,7 @@ int cmd_clean(int argc, const char **argv, const 
> char *prefix)
>
>  for (i = 0; i < exclude_list.nr; i++)
>  add_exclude(exclude_list.items[i].string, "", 0,
> -     &dir.exclude_list[EXC_CMDL]);
> +     &dir.exclude_list[EXC_CMDL], "--exclude option", -(i+1));
>
>  pathspec = get_pathspec(prefix, argv);
>
> diff --git a/builtin/ls-files.c b/builtin/ls-files.c
> index 31b3f2d..420ff40 100644
> --- a/builtin/ls-files.c
> +++ b/builtin/ls-files.c
> @@ -35,6 +35,7 @@ static int error_unmatch;
> static char *ps_matched;
> static const char *with_tree;
> static int exc_given;
> +static int exclude_args = 0;
>
> static const char *tag_cached = "";
> static const char *tag_unmerged = "";
> @@ -423,7 +424,7 @@ static int option_parse_exclude(const struct 
> option *opt,
>  struct exclude_list *list = opt->value;
>
>  exc_given = 1;
> - add_exclude(arg, "", 0, list);
> + add_exclude(arg, "", 0, list, "--exclude option", --exclude_args);
>
>  return 0;
> }
> diff --git a/dir.c b/dir.c
> index 3d438c3..ac8c838 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -311,7 +311,7 @@ static int no_wildcard(const char *string)
> }
>
> void add_exclude(const char *string, const char *base,
> - int baselen, struct exclude_list *el)
> + int baselen, struct exclude_list *el, const char *src, int srcpos)
> {
>  struct exclude *x;
>  size_t len;
> @@ -341,6 +341,8 @@ void add_exclude(const char *string, const char 
> *base,
>  x->base = base;
>  x->baselen = baselen;
>  x->flags = flags;
> + x->src = src;
> + x->srcpos = srcpos;
>  if (!strchr(string, '/'))
>  x->flags |= EXC_FLAG_NODIR;
>  x->nowildcardlen = simple_length(string);
> @@ -393,7 +395,7 @@ int add_excludes_from_file_to_list(const char 
> *fname,
>     int check_index)
> {
>  struct stat st;
> - int fd, i;
> + int fd, i, lineno = 1;
>  size_t size = 0;
>  char *buf, *entry;
>
> @@ -436,8 +438,9 @@ int add_excludes_from_file_to_list(const char 
> *fname,
>  if (buf[i] == '\n') {
>  if (entry != buf + i && entry[0] != '#') {
>  buf[i - (i && buf[i-1] == '\r')] = 0;
> - add_exclude(entry, base, baselen, el);
> + add_exclude(entry, base, baselen, el, fname, lineno);
>  }
> + lineno++;
>  entry = buf + i + 1;
>  }
>  }
> @@ -472,8 +475,10 @@ static void prep_exclude(struct dir_struct *dir, 
> const char *base, int baselen)
>      !strncmp(dir->basebuf, base, stk->baselen))
>  break;
>  dir->exclude_stack = stk->prev;
> - while (stk->exclude_ix < el->nr)
> - free(el->excludes[--el->nr]);
> + while (stk->exclude_ix < el->nr) {
> + struct exclude *exclude = el->excludes[--el->nr];
> + free(exclude);
> + }
>  free(stk->filebuf);
>  free(stk);
>  }
> @@ -500,7 +505,15 @@ static void prep_exclude(struct dir_struct *dir, 
> const char *base, int baselen)
>  memcpy(dir->basebuf + current, base + current,
>         stk->baselen - current);
>  strcpy(dir->basebuf + stk->baselen, dir->exclude_per_dir);
> - add_excludes_from_file_to_list(dir->basebuf,
> +
> + /* dir->basebuf gets reused by the traversal, but we
> + * need fname to remain unchanged to ensure the src
> + * member of each struct exclude correctly back-references
> + * its source file.
> + */
> + char *fname = strdup(dir->basebuf);
> +
> + add_excludes_from_file_to_list(fname,
>         dir->basebuf, stk->baselen,
>         &stk->filebuf, el, 1);
>  dir->exclude_stack = stk;
> diff --git a/dir.h b/dir.h
> index 1b4f9dc..81efee4 100644
> --- a/dir.h
> +++ b/dir.h
> @@ -31,6 +31,9 @@ struct exclude_list {
>  int baselen;
>  int to_exclude;
>  int flags;
> + const char *src;
> + int srcpos; /* counting starts from 1 for line numbers in ignore 
> files,
> +        and from -1 decrementing for patterns from CLI (--exclude) */
>  } **excludes;
> };
>
> @@ -123,7 +126,7 @@ extern int add_excludes_from_file_to_list(const 
> char *fname, const char *base, i
>    char **buf_p, struct exclude_list *el, int check_index);
> extern void add_excludes_from_file(struct dir_struct *, const char 
> *fname);
> extern void add_exclude(const char *string, const char *base,
> - int baselen, struct exclude_list *el);
> + int baselen, struct exclude_list *el, const char *src, int srcpos);
> extern void free_excludes(struct exclude_list *el);
> extern int file_exists(const char *);
>
> -- 
> 1.7.12.155.ge5750d5.dirty
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
> -----
> No virus found in this message.
> Checked by AVG - www.avg.com
> Version: 2012.0.2197 / Virus Database: 2437/5240 - Release Date: 
> 09/01/12
> 
