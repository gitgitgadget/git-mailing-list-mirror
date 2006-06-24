From: Timo Hirvonen <tihirvon@gmail.com>
Subject: Re: [PATCH 2/7] Merge with_raw, with_stat and summary variables to
 output_format
Date: Sun, 25 Jun 2006 00:56:54 +0300
Message-ID: <20060625005654.627e176b.tihirvon@gmail.com>
References: <20060624201843.a5b4f7b9.tihirvon@gmail.com>
	<20060624202153.1001a66c.tihirvon@gmail.com>
	<Pine.LNX.4.63.0606242219320.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 24 23:57:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuG7i-0001Ru-20
	for gcvg-git@gmane.org; Sat, 24 Jun 2006 23:57:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964848AbWFXV47 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Jun 2006 17:56:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964851AbWFXV47
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jun 2006 17:56:59 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:6283 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S964848AbWFXV46 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jun 2006 17:56:58 -0400
Received: by nf-out-0910.google.com with SMTP id m19so421070nfc
        for <git@vger.kernel.org>; Sat, 24 Jun 2006 14:56:57 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=TRpeS/6ysB/c7pMGo0tg6OI47WssLKpsG1eU3sK+xbUD/rxZaTCTRKGhiVEbKvzPhN6GLryAXr8C49/12f03EMkUOjaO/dPnxBYaOEQIXZXnRAxv8R1lbt8qaqTIaEfUB1OVqeSqDe+xbPQLTFEqGzA0lBnR1J81o/gH1wS+jIA=
Received: by 10.49.54.13 with SMTP id g13mr3666811nfk;
        Sat, 24 Jun 2006 14:56:56 -0700 (PDT)
Received: from garlic.home.net ( [82.128.229.197])
        by mx.gmail.com with ESMTP id y24sm4419320nfb.2006.06.24.14.56.56;
        Sat, 24 Jun 2006 14:56:56 -0700 (PDT)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0606242219320.29667@wbgn013.biozentrum.uni-wuerzburg.de>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.18; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22549>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:

> Hi,
> 
> thank you very much for doing the extra step and using the original 
> constant names. I appreciate that.
> 
> On Sat, 24 Jun 2006, Timo Hirvonen wrote:
> 
> > @@ -818,17 +817,12 @@ void show_combined_diff(struct combine_d
> >  	struct diff_options *opt = &rev->diffopt;
> >  	if (!p->len)
> >  		return;
> > -	switch (opt->output_format) {
> > -	case DIFF_FORMAT_RAW:
> > -	case DIFF_FORMAT_NAME_STATUS:
> > -	case DIFF_FORMAT_NAME:
> > +	if (opt->output_format & (DIFF_FORMAT_RAW |
> > +				  DIFF_FORMAT_NAME |
> > +				  DIFF_FORMAT_NAME_STATUS)) {
> >  		show_raw_diff(p, num_parent, rev);
> > -		return;
> > -	case DIFF_FORMAT_PATCH:
> > +	} else if (opt->output_format & DIFF_FORMAT_PATCH) {
> 
> Not that it matters, but this "else" could go. (Otherwise,  "--raw -p" 
> would be the same as "--raw", right?)

Just tested, ./git log -p --raw displays both raw and patch.  I think it
works because I changed diff_tree_combined() to use show_raw_diff() and
show_patch_diff() directly.

It feels 'wrong' to check flags and then call a function which checks
the flags again.  This combined diff stuff is confusing.

> > @@ -856,19 +846,18 @@ void diff_tree_combined(const unsigned c
> > [...]
> >  
> > -		if (do_diffstat && rev->loginfo)
> > -			show_log(rev, rev->loginfo,
> > -				 opt->with_stat ? "---\n" : "\n");
> > +		if (opt->output_format & DIFF_FORMAT_DIFFSTAT && rev->loginfo)
> > +			show_log(rev, rev->loginfo, "---\n");
> >  		diff_flush(&diffopts);
> > -		if (opt->with_stat)
> > +		if (opt->output_format & DIFF_FORMAT_DIFFSTAT)
> >  			putchar('\n');
> >  	}
> 
> Just a remark: this hunk actually changes behaviour. "with_stat" meant 
> that the stat was prepended before something like a patch, and therefore a 
> separator was needed. If you pass only "--stat", the separator will be 
> printed anyway now.

You are right, it now prints --- when it should print empty line.

> > +	int inter_name_termination = '\t';
> > +	int line_termination = options->line_termination;
> > +
> > +	if (!line_termination)
> > +		inter_name_termination = 0;
> 
> <nit type=minor>
> 	This should be part of patch 1/7.
> </nit>

That clean up was possible only after I made other changes to the code,
I think.  At least it wasn't obvious when I wrote 1/7.

> >  		show_stats(diffstat);
> >  		free(diffstat);
> 
> Why not go the full nine yards, and make diffstat not a pointer, but the 
> struct itself? You would avoid calloc()ing and free()ing. (Of course, 
> instead of calloc()ing you have to memset() it to 0.)

I was blind :)

> > +	if (output_format & DIFF_FORMAT_PATCH) {
> > +		if (output_format & (DIFF_FORMAT_DIFFSTAT |
> > +				     DIFF_FORMAT_SUMMARY)) {
> > +			if (options->stat_sep)
> > +				fputs(options->stat_sep, stdout);
> > +			else
> > +				putchar(options->line_termination);
> 
> Are we sure we do not want something like
> 
> 	if (output_format / DIFF_FORMAT_DIFFSTAT > 1)
> 		/* output separator */
> 
> after each format (this example being after the diffstat), the condition 
> being: if there is still an output format to come, add the separator?

I'm not sure what you mean.

It outputs separator between (diffstat and/or summary) and patch.
There's no separator between diffstat and summary or raw and diffstat.
Should there be one?


Thanks for your comments.  Should I patch the patch or send a fixed one?
I'm currently too tired to write any code.

-- 
http://onion.dynserv.net/~timo/
