From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/7] Merge with_raw, with_stat and summary variables to
 output_format
Date: Sun, 25 Jun 2006 01:20:33 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606250113280.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060624201843.a5b4f7b9.tihirvon@gmail.com>
 <20060624202153.1001a66c.tihirvon@gmail.com>
 <Pine.LNX.4.63.0606242219320.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <20060625005654.627e176b.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 25 01:20:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuHQl-0001rc-BZ
	for gcvg-git@gmane.org; Sun, 25 Jun 2006 01:20:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751154AbWFXXUg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Jun 2006 19:20:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751177AbWFXXUg
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jun 2006 19:20:36 -0400
Received: from mail.gmx.net ([213.165.64.21]:5614 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751154AbWFXXUf (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Jun 2006 19:20:35 -0400
Received: (qmail invoked by alias); 24 Jun 2006 23:20:34 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp010) with SMTP; 25 Jun 2006 01:20:34 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Timo Hirvonen <tihirvon@gmail.com>
In-Reply-To: <20060625005654.627e176b.tihirvon@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22552>

Hi,

On Sun, 25 Jun 2006, Timo Hirvonen wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> 
> > On Sat, 24 Jun 2006, Timo Hirvonen wrote:
> > 
> > > @@ -818,17 +817,12 @@ void show_combined_diff(struct combine_d
> > >  	struct diff_options *opt = &rev->diffopt;
> > >  	if (!p->len)
> > >  		return;
> > > -	switch (opt->output_format) {
> > > -	case DIFF_FORMAT_RAW:
> > > -	case DIFF_FORMAT_NAME_STATUS:
> > > -	case DIFF_FORMAT_NAME:
> > > +	if (opt->output_format & (DIFF_FORMAT_RAW |
> > > +				  DIFF_FORMAT_NAME |
> > > +				  DIFF_FORMAT_NAME_STATUS)) {
> > >  		show_raw_diff(p, num_parent, rev);
> > > -		return;
> > > -	case DIFF_FORMAT_PATCH:
> > > +	} else if (opt->output_format & DIFF_FORMAT_PATCH) {
> > 
> > Not that it matters, but this "else" could go. (Otherwise,  "--raw -p" 
> > would be the same as "--raw", right?)
> 
> Just tested, ./git log -p --raw displays both raw and patch.  I think it
> works because I changed diff_tree_combined() to use show_raw_diff() and
> show_patch_diff() directly.
> 
> It feels 'wrong' to check flags and then call a function which checks
> the flags again.  This combined diff stuff is confusing.

Sorry for not checking the result, but just the patch. I also find this 
behaviour confusing. Junio?

> > > +	int inter_name_termination = '\t';
> > > +	int line_termination = options->line_termination;
> > > +
> > > +	if (!line_termination)
> > > +		inter_name_termination = 0;
> > 
> > <nit type=minor>
> > 	This should be part of patch 1/7.
> > </nit>
> 
> That clean up was possible only after I made other changes to the code,
> I think.  At least it wasn't obvious when I wrote 1/7.

It is just a minor nit, I do not think it is necessary to change the 
patch.

> > >  		show_stats(diffstat);
> > >  		free(diffstat);
> > 
> > Why not go the full nine yards, and make diffstat not a pointer, but the 
> > struct itself? You would avoid calloc()ing and free()ing. (Of course, 
> > instead of calloc()ing you have to memset() it to 0.)
> 
> I was blind :)

;-) In my experience, after staring at the code too long, you turn blind. 
This is why I like a second pair of eyeballs so much.

> > > +	if (output_format & DIFF_FORMAT_PATCH) {
> > > +		if (output_format & (DIFF_FORMAT_DIFFSTAT |
> > > +				     DIFF_FORMAT_SUMMARY)) {
> > > +			if (options->stat_sep)
> > > +				fputs(options->stat_sep, stdout);
> > > +			else
> > > +				putchar(options->line_termination);
> > 
> > Are we sure we do not want something like
> > 
> > 	if (output_format / DIFF_FORMAT_DIFFSTAT > 1)
> > 		/* output separator */
> > 
> > after each format (this example being after the diffstat), the condition 
> > being: if there is still an output format to come, add the separator?
> 
> I'm not sure what you mean.
> 
> It outputs separator between (diffstat and/or summary) and patch.
> There's no separator between diffstat and summary or raw and diffstat.
> Should there be one?

IMHO there should be one.

> Thanks for your comments.  Should I patch the patch or send a fixed one?

I cannot speak for Junio, but I think an additional patch to clean things 
up would be the way to go.

Ciao,
Dscho
