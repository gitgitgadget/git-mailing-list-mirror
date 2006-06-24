From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/7] Merge with_raw, with_stat and summary variables to
 output_format
Date: Sat, 24 Jun 2006 22:52:25 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606242219320.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060624201843.a5b4f7b9.tihirvon@gmail.com>
 <20060624202153.1001a66c.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 24 22:52:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuF7H-0000mJ-1J
	for gcvg-git@gmane.org; Sat, 24 Jun 2006 22:52:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933084AbWFXUw2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Jun 2006 16:52:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933391AbWFXUw2
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jun 2006 16:52:28 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:56282 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S933084AbWFXUw1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jun 2006 16:52:27 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id 0306B2377;
	Sat, 24 Jun 2006 22:52:26 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id EB10E236E;
	Sat, 24 Jun 2006 22:52:25 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id CDBD020E5;
	Sat, 24 Jun 2006 22:52:25 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Timo Hirvonen <tihirvon@gmail.com>
In-Reply-To: <20060624202153.1001a66c.tihirvon@gmail.com>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22547>

Hi,

thank you very much for doing the extra step and using the original 
constant names. I appreciate that.

On Sat, 24 Jun 2006, Timo Hirvonen wrote:

> @@ -818,17 +817,12 @@ void show_combined_diff(struct combine_d
>  	struct diff_options *opt = &rev->diffopt;
>  	if (!p->len)
>  		return;
> -	switch (opt->output_format) {
> -	case DIFF_FORMAT_RAW:
> -	case DIFF_FORMAT_NAME_STATUS:
> -	case DIFF_FORMAT_NAME:
> +	if (opt->output_format & (DIFF_FORMAT_RAW |
> +				  DIFF_FORMAT_NAME |
> +				  DIFF_FORMAT_NAME_STATUS)) {
>  		show_raw_diff(p, num_parent, rev);
> -		return;
> -	case DIFF_FORMAT_PATCH:
> +	} else if (opt->output_format & DIFF_FORMAT_PATCH) {

Not that it matters, but this "else" could go. (Otherwise,  "--raw -p" 
would be the same as "--raw", right?)

>  		show_patch_diff(p, num_parent, dense, rev);
> -		return;
> -	default:
> -		return;
>  	}
>  }

> @@ -856,19 +846,18 @@ void diff_tree_combined(const unsigned c
> [...]
>  
> -		if (do_diffstat && rev->loginfo)
> -			show_log(rev, rev->loginfo,
> -				 opt->with_stat ? "---\n" : "\n");
> +		if (opt->output_format & DIFF_FORMAT_DIFFSTAT && rev->loginfo)
> +			show_log(rev, rev->loginfo, "---\n");
>  		diff_flush(&diffopts);
> -		if (opt->with_stat)
> +		if (opt->output_format & DIFF_FORMAT_DIFFSTAT)
>  			putchar('\n');
>  	}

Just a remark: this hunk actually changes behaviour. "with_stat" meant 
that the stat was prepended before something like a patch, and therefore a 
separator was needed. If you pass only "--stat", the separator will be 
printed anyway now.

> diff --git a/diff.c b/diff.c
> index f358546..bfed79c 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -1372,23 +1372,27 @@ int diff_setup_done(struct diff_options 
>  	    (0 <= options->rename_limit && !options->detect_rename))
>  		return -1;
>  
> +	if (options->output_format & DIFF_FORMAT_NO_OUTPUT)
> +		options->output_format = 0;
> +
> +	if (options->output_format & (DIFF_FORMAT_NAME |
> +				      DIFF_FORMAT_NAME_STATUS |
> +				      DIFF_FORMAT_CHECKDIFF |
> +				      DIFF_FORMAT_NO_OUTPUT))

The DIFF_FORMAT_NO_OUTPUT here makes no sense (if it was set, you unset it 
above).

> @@ -1671,15 +1674,17 @@ const char *diff_unique_abbrev(const uns
> [...]
>  
>  static void diff_flush_raw(struct diff_filepair *p,
> -			   int line_termination,
> -			   int inter_name_termination,
> -			   struct diff_options *options,
> -			   int output_format)
> +			   struct diff_options *options)
>  {
>  	int two_paths;
>  	char status[10];
>  	int abbrev = options->abbrev;
>  	const char *path_one, *path_two;
> +	int inter_name_termination = '\t';
> +	int line_termination = options->line_termination;
> +
> +	if (!line_termination)
> +		inter_name_termination = 0;

<nit type=minor>
	This should be part of patch 1/7.
</nit>

> @@ -2041,55 +2028,61 @@ static void diff_summary(struct diff_fil
> [...]
>  
> -	if (options->with_raw) {
> +	if (output_format & (DIFF_FORMAT_RAW |
> +			     DIFF_FORMAT_NAME |
> +			     DIFF_FORMAT_NAME_STATUS |
> +			     DIFF_FORMAT_CHECKDIFF)) {
>  		for (i = 0; i < q->nr; i++) {
>  			struct diff_filepair *p = q->queue[i];
> -			flush_one_pair(p, DIFF_FORMAT_RAW, options, NULL);
> +			if (check_pair_status(p))
> +				flush_one_pair(p, options);

This is a very nice cleanup.

>  	}
> -	if (options->with_stat) {
> +
> +	if (output_format & DIFF_FORMAT_DIFFSTAT) {
> +		struct diffstat_t *diffstat;
> +
> +		diffstat = xcalloc(sizeof (struct diffstat_t), 1);
> +		diffstat->xm.consume = diffstat_consume;
>  		for (i = 0; i < q->nr; i++) {
>  			struct diff_filepair *p = q->queue[i];
> -			flush_one_pair(p, DIFF_FORMAT_DIFFSTAT, options,
> -				       diffstat);
> +			if (check_pair_status(p))
> +				diff_flush_stat(p, options, diffstat);

Again, very nice.

>  		}
>  		show_stats(diffstat);
>  		free(diffstat);

Why not go the full nine yards, and make diffstat not a pointer, but the 
struct itself? You would avoid calloc()ing and free()ing. (Of course, 
instead of calloc()ing you have to memset() it to 0.)

> +	if (output_format & DIFF_FORMAT_PATCH) {
> +		if (output_format & (DIFF_FORMAT_DIFFSTAT |
> +				     DIFF_FORMAT_SUMMARY)) {
> +			if (options->stat_sep)
> +				fputs(options->stat_sep, stdout);
> +			else
> +				putchar(options->line_termination);

Are we sure we do not want something like

	if (output_format / DIFF_FORMAT_DIFFSTAT > 1)
		/* output separator */

after each format (this example being after the diffstat), the condition 
being: if there is still an output format to come, add the separator?

All in all, I like this patch.

Ciao,
Dscho
