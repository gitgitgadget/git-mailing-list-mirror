From: David Rientjes <rientjes@cs.washington.edu>
Subject: Re: [PATCH 1/3] diff --stat: allow custom diffstat output width.
Date: Tue, 26 Sep 2006 20:11:25 -0700 (PDT)
Message-ID: <Pine.LNX.4.64N.0609262001460.520@attu4.cs.washington.edu>
References: <7vr6xyjal0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Adrian Bunk <bunk@stusta.de>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Wed Sep 27 05:14:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSPsq-0001C7-Ij
	for gcvg-git@gmane.org; Wed, 27 Sep 2006 05:14:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932333AbWI0DOu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Sep 2006 23:14:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932338AbWI0DOu
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Sep 2006 23:14:50 -0400
Received: from mx1.cs.washington.edu ([128.208.5.52]:64389 "EHLO
	mx1.cs.washington.edu") by vger.kernel.org with ESMTP
	id S932333AbWI0DOt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Sep 2006 23:14:49 -0400
Received: from attu4.cs.washington.edu (attu4.cs.washington.edu [128.208.1.140])
	by mx1.cs.washington.edu (8.13.7/8.13.7/1.6) with ESMTP id k8R3BPvH019774
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 26 Sep 2006 20:11:25 -0700
	(envelope-from rientjes@cs.washington.edu)
Received: from localhost (rientjes@localhost)
	by attu4.cs.washington.edu (8.13.7/8.13.7/Submit/1.2) with ESMTP id k8R3BPVA001392;
	Tue, 26 Sep 2006 20:11:25 -0700
	(envelope-from rientjes@cs.washington.edu)
X-Authentication-Warning: attu4.cs.washington.edu: rientjes owned process doing -bs
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vr6xyjal0.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27862>

On Tue, 26 Sep 2006, Junio C Hamano wrote:

> +static void show_graph(char ch, int cnt)
> +{
> +	if (!cnt)
> +		return;
> +	while (cnt--)
> +		putchar(ch);
> +}
> +

'if (cnt <= 0)' or 'while (cnt-- > 0)' is a better API./

> +static void show_stats(struct diffstat_t* data, struct diff_options *options)
>  {
>  	int i, len, add, del, total, adds = 0, dels = 0;
> -	int max, max_change = 0, max_len = 0;
> +	int max_change = 0, max_len = 0;
>  	int total_files = data->nr;
> +	int width, name_width;
>  
>  	if (data->nr == 0)
>  		return;
>  
> +	width = options->stat_width ? options->stat_width : 80;
> +	name_width = options->stat_name_width ? options->stat_name_width : 50;
> +
> +	/* Sanity: give at least 5 columns to the graph,
> +	 * but leave at least 10 columns for the name.
> +	 */
> +	if (width < name_width + 15) {
> +		if (25 < name_width)
> +			name_width = width - 15;
> +		else
> +			width = name_width + 15;
> +	}
> +

Constants go on the right side of comparison expressions.

> +	/* Find the longest filename and max number of changes */
>  	for (i = 0; i < data->nr; i++) {
>  		struct diffstat_file *file = data->files[i];
> +		int change = file->added + file->deleted;
> +
> +		if (0 < (len = quote_c_style(file->name, NULL, NULL, 0))) {
> +			char *qname = xmalloc(len + 1);
> +			quote_c_style(file->name, qname, NULL, 0);
> +			free(file->name);
> +			file->name = qname;
> +		}

Same.

> @@ -623,27 +664,34 @@ static void show_stats(struct diffstat_t
>  			goto free_diffstat_file;
>  		}
>  
> +		/*
> +		 * scale the add/delete
> +		 */
>  		add = added;
>  		del = deleted;
>  		total = add + del;
>  		adds += add;
>  		dels += del;
>  
> -		if (max_change > 0) {
> -			total = (total * max + max_change / 2) / max_change;
> -			add = (add * max + max_change / 2) / max_change;
> +		if (max_change < width)
> +			;
> +		else {
> +			total = scale_linear(total, width, max_change);
> +			add = scale_linear(add, width, max_change);
>  			del = total - add;
>  		}

if (max_change >= width)

> diff --git a/diff.h b/diff.h
> index b60a02e..e06d0f4 100644
> --- a/diff.h
> +++ b/diff.h
> @@ -69,6 +69,9 @@ struct diff_options {
>  	const char *stat_sep;
>  	long xdl_opts;
>  
> +	int stat_width;
> +	int stat_name_width;
> +

Can you use unsigned char here instead?

		David
