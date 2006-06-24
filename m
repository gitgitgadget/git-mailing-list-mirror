From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/5] Rework diff options
Date: Fri, 23 Jun 2006 23:55:57 -0700
Message-ID: <7vodwj11qa.fsf@assigned-by-dhcp.cox.net>
References: <20060624003315.804a1796.tihirvon@gmail.com>
	<20060624005252.c694e421.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 24 08:56:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fu23x-0001VS-42
	for gcvg-git@gmane.org; Sat, 24 Jun 2006 08:56:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932909AbWFXG4B (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Jun 2006 02:56:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932919AbWFXG4A
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jun 2006 02:56:00 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:30594 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S932909AbWFXGz7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jun 2006 02:55:59 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060624065558.JPAW1341.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 24 Jun 2006 02:55:58 -0400
To: Timo Hirvonen <tihirvon@gmail.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22487>

Timo Hirvonen <tihirvon@gmail.com> writes:

> diff --git a/builtin-diff.c b/builtin-diff.c
> index 99a2f76..372894a 100644
> --- a/builtin-diff.c
> +++ b/builtin-diff.c
> @@ -56,15 +56,15 @@ static int builtin_diff_files(struct rev
>  	    3 < revs->max_count)
>  		usage(builtin_diff_usage);
>  	if (revs->max_count < 0 &&
> -	    (revs->diffopt.output_format == DIFF_FORMAT_PATCH))
> +	    (revs->diffopt.output_fmt & OUTPUT_FMT_PATCH))
>  		revs->combine_merges = revs->dense_combined_merges = 1;
>  	/*
>  	 * Backward compatibility wart - "diff-files -s" used to
>  	 * defeat the common diff option "-s" which asked for
> -	 * DIFF_FORMAT_NO_OUTPUT.
> +	 * OUTPUT_FMT_NONE
>  	 */
> -	if (revs->diffopt.output_format == DIFF_FORMAT_NO_OUTPUT)
> -		revs->diffopt.output_format = DIFF_FORMAT_RAW;
> +	if (revs->diffopt.output_fmt & OUTPUT_FMT_NONE)
> +		revs->diffopt.output_fmt = OUTPUT_FMT_RAW;
>  	return run_diff_files(revs, silent);
>  }

We do not have to remove this now, but I think we can remove
this "backward compatibility wart" sometime in the next round;
Cogito has been fixed not to use this.

> @@ -110,7 +110,7 @@ static int builtin_diff_b_f(struct rev_i
>  	while (1 < argc) {
>  		const char *arg = argv[1];
>  		if (!strcmp(arg, "--raw"))
> -			revs->diffopt.output_format = DIFF_FORMAT_RAW;
> +			revs->diffopt.output_fmt |= OUTPUT_FMT_RAW;
>  		else
>  			usage(builtin_diff_usage);
>  		argv++; argc--;

I see later in the series you taught low-level diff_opt_parse
about --raw switch, which is good.

> diff --git a/builtin-log.c b/builtin-log.c
> index 5a8a50b..e4a6385 100644
> --- a/builtin-log.c
> +++ b/builtin-log.c
> @@ -26,8 +26,8 @@ static int cmd_log_wc(int argc, const ch
>  	if (rev->always_show_header) {
>  		if (rev->diffopt.pickaxe || rev->diffopt.filter) {
>  			rev->always_show_header = 0;
> -			if (rev->diffopt.output_format == DIFF_FORMAT_RAW)
> -				rev->diffopt.output_format = DIFF_FORMAT_NO_OUTPUT;
> +			if (rev->diffopt.output_fmt & OUTPUT_FMT_RAW)
> +				rev->diffopt.output_fmt |= OUTPUT_FMT_NONE;
>  		}
>  	}

The original code is saying "For git-log command (i.e. when
always-show-header is on), if the command line did not override
but ended up asking for diff only because it wanted to do -S or
--diff-filter, do not show any diff" which is quite an opaque
logic.

> diff --git a/combine-diff.c b/combine-diff.c
> index 64b20cc..d0d8d01 100644
> --- a/combine-diff.c
> +++ b/combine-diff.c
> @@ -878,13 +867,13 @@ void diff_tree_combined(const unsigned c
>  			num_paths++;
>  	}
>  	if (num_paths) {
> -		if (opt->with_raw) {
> -			int saved_format = opt->output_format;
> -			opt->output_format = DIFF_FORMAT_RAW;
> +		if (opt->output_fmt & OUTPUT_FMT_RAW) {
> +			int saved_fmt = opt->output_fmt;
> +			opt->output_fmt |= OUTPUT_FMT_RAW;
>  			for (p = paths; p; p = p->next) {
>  				show_combined_diff(p, num_parent, dense, rev);
>  			}
> -			opt->output_format = saved_format;
> +			opt->output_fmt = saved_fmt;
>  			putchar(opt->line_termination);
>  		}
>  		for (p = paths; p; p = p->next) {

The code needs to run show_combined_diff twice, once for raw
output and another for normal output, since the processing
needed to be done in show_combined_diff are quite different
between the case where you emit raw diff (in which case you do
not combine at the hunk level) and normal diff (in which case
you do).  Since your modified show_combined_diff checks FMT_RAW
first, I suspect it would not make any difference if it is ORing
OUTPUT_FMT_RAW into output_fmt or assignment.  In fact, since
the bit is already on when the if () statement is taken, I think
you can lose the whole saved_fmt business, and just say
something like this here:

		if (opt->output_fmt & OUTPUT_FMT_RAW) {
			for (p = paths; p; p = p->next) {
				show_combined_diff(p, num_parent, dense, rev);
			}
			putchar(opt->line_termination);
		}

But I think the other side needs to drop OUTPUT_FMT_RAW bit,
since around ll. 817 in combine-diff.c you show_raw_diff() if
OUTPUT_FMT_RAW bit is on regardless of the OUTPUT_FMT_PATCH bit.

> diff --git a/diff.c b/diff.c
> index 1db0285..6eb7db0 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -203,7 +203,7 @@ static void emit_rewrite_diff(const char
>  static int fill_mmfile(mmfile_t *mf, struct diff_filespec *one)
>  {
>  	if (!DIFF_FILE_VALID(one)) {
> -		mf->ptr = ""; /* does not matter */
> +		mf->ptr = (char *)""; /* does not matter */
>  		mf->size = 0;
>  		return 0;
>  	}
> @@ -395,7 +395,7 @@ static void show_stats(struct diffstat_t
>  	}
>  
>  	for (i = 0; i < data->nr; i++) {
> -		char *prefix = "";
> +		const char *prefix = "";
>  		char *name = data->files[i]->name;
>  		int added = data->files[i]->added;
>  		int deleted = data->files[i]->deleted;
> @@ -917,7 +917,7 @@ int diff_populate_filespec(struct diff_f
>  			err_empty:
>  				err = -1;
>  			empty:
> -				s->data = "";
> +				s->data = (char *)"";
>  				s->size = 0;
>  				return err;
>  			}
> @@ -1408,7 +1411,7 @@ int diff_setup_done(struct diff_options 
>  	return 0;
>  }
>  
> -int opt_arg(const char *arg, int arg_short, const char *arg_long, int *val)
> +static int opt_arg(const char *arg, int arg_short, const char *arg_long, int *val)
>  {
>  	char c, *eq;
>  	int len;
> @@ -1720,16 +1722,12 @@ static void diff_flush_raw(struct diff_f
>  		free((void*)path_two);
>  }
>  
> -static void diff_flush_name(struct diff_filepair *p,
> -			    int inter_name_termination,
> -			    int line_termination)
> +static void diff_flush_name(struct diff_filepair *p, int line_termination)
>  {
>  	char *path = p->two->path;
>  
>  	if (line_termination)
>  		path = quote_one(p->two->path);
> -	else
> -		path = p->two->path;
>  	printf("%s%c", path, line_termination);
>  	if (p->two->path != path)
>  		free(path);

These are all good changes but I would have liked to see them as
a separate series.

> @@ -1371,23 +1371,26 @@ int diff_setup_done(struct diff_options 
>  	    (0 <= options->rename_limit && !options->detect_rename))
>  		return -1;
>  
> +	if (options->output_fmt & OUTPUT_FMT_NONE)
> +		options->output_fmt = 0;
> +
> +	if (options->output_fmt & (OUTPUT_FMT_NAME |
> +				   OUTPUT_FMT_CHECKDIFF |
> +				   OUTPUT_FMT_NONE))
> +		options->output_fmt &= ~(OUTPUT_FMT_RAW |
> +					 OUTPUT_FMT_DIFFSTAT |
> +					 OUTPUT_FMT_SUMMARY |
> +					 OUTPUT_FMT_PATCH);
> +

Maybe doing the same for --name-status?  I wonder if the --name,
--name-status and --check should be mutually exclusive.  What
happens when you specify more than one of them?

> +/* Same as output_fmt = 0 but we know that -s flag was given
> + * and we should not give default value to output_fmt.
> + */
> +#define OUTPUT_FMT_NONE		0x0080

This is a very good comment to tell the reader what is going on.
I appreciate it.

> diff --git a/revision.c b/revision.c
> index b963f2a..4ad2272 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -852,8 +852,8 @@ int setup_revisions(int argc, const char
>  	if (revs->combine_merges) {
>  		revs->ignore_merges = 0;
>  		if (revs->dense_combined_merges &&
> -		    (revs->diffopt.output_format != DIFF_FORMAT_DIFFSTAT))
> -			revs->diffopt.output_format = DIFF_FORMAT_PATCH;
> +		   !(revs->diffopt.output_fmt & OUTPUT_FMT_DIFFSTAT))
> +			revs->diffopt.output_fmt |= OUTPUT_FMT_PATCH;
>  	}
>  	revs->diffopt.abbrev = revs->abbrev;
>  	diff_setup_done(&revs->diffopt);

This tells it to default to patch format unless we are asked to
do diffstat only, in which case we just show stat without patch.
The new logic seems to be fishy.

Whew, now it's quite a lot of changes.  How to proceed from
here?  My rather selfish preference is:

 - "git-merge not add -p when asking for --summary --stat" is an
   obvious fix that is independently applicable to "master", so
   I took it already.

 - could I ask you to redo a patch to do only the clean-up part
   first, so that I can accept it for either "next" or "master".

 - Then after I take the clean-up, could you rebase four
   remainder patches ("Rework diff options" to "Add --patch
   option for diff-*") on the result?  The patches this round
   are already split quite well in that the first one does the
   enum to bit conversion and the latter three cleans things up
   (all of which I like a lot).  As Johannes suggested, it might
   be easier to review if they reused the same preprocessor
   symbols instead of renaming them.  I'd take them for "next".
