From: Timo Hirvonen <tihirvon@gmail.com>
Subject: Re: [PATCH 2/5] Rework diff options
Date: Sat, 24 Jun 2006 14:29:43 +0300
Message-ID: <20060624142943.2aeda5d2.tihirvon@gmail.com>
References: <20060624003315.804a1796.tihirvon@gmail.com>
	<20060624005252.c694e421.tihirvon@gmail.com>
	<7vodwj11qa.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 24 13:29:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fu6Kl-0003JF-RI
	for gcvg-git@gmane.org; Sat, 24 Jun 2006 13:29:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752216AbWFXL3s (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Jun 2006 07:29:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752217AbWFXL3s
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jun 2006 07:29:48 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:32457 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1752213AbWFXL3r (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jun 2006 07:29:47 -0400
Received: by nf-out-0910.google.com with SMTP id m19so375084nfc
        for <git@vger.kernel.org>; Sat, 24 Jun 2006 04:29:46 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=Sn9mIG8ARfAkrHioeAP457Jq5imu+dT7f7A96nOwjJI37QTWDQmjXfEx+JJbUwgm3gpZLs4BKALsfz8cJTZ3hKzHNhvz0rOy9/Xnvhabc8EZ8OumRU39A00ALbTxk/Q97qTE7yFRbYfajW/y/hpu7sizSobqHiB5d0zqL3Lzfr4=
Received: by 10.48.221.6 with SMTP id t6mr3291314nfg;
        Sat, 24 Jun 2006 04:29:45 -0700 (PDT)
Received: from garlic.home.net ( [82.128.229.197])
        by mx.gmail.com with ESMTP id c1sm3084927nfe.2006.06.24.04.29.45;
        Sat, 24 Jun 2006 04:29:45 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vodwj11qa.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.18; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22506>

Junio C Hamano <junkio@cox.net> wrote:

> > diff --git a/builtin-log.c b/builtin-log.c
> > index 5a8a50b..e4a6385 100644
> > --- a/builtin-log.c
> > +++ b/builtin-log.c
> > @@ -26,8 +26,8 @@ static int cmd_log_wc(int argc, const ch
> >  	if (rev->always_show_header) {
> >  		if (rev->diffopt.pickaxe || rev->diffopt.filter) {
> >  			rev->always_show_header = 0;
> > -			if (rev->diffopt.output_format == DIFF_FORMAT_RAW)
> > -				rev->diffopt.output_format = DIFF_FORMAT_NO_OUTPUT;
> > +			if (rev->diffopt.output_fmt & OUTPUT_FMT_RAW)
> > +				rev->diffopt.output_fmt |= OUTPUT_FMT_NONE;
> >  		}
> >  	}
> 
> The original code is saying "For git-log command (i.e. when
> always-show-header is on), if the command line did not override
> but ended up asking for diff only because it wanted to do -S or
> --diff-filter, do not show any diff" which is quite an opaque
> logic.

I'll just remove this change from the fixed patch 2/5.  New version of
the patch 3/5 should then fix this logic.

> > @@ -1371,23 +1371,26 @@ int diff_setup_done(struct diff_options 
> >  	    (0 <= options->rename_limit && !options->detect_rename))
> >  		return -1;
> >  
> > +	if (options->output_fmt & OUTPUT_FMT_NONE)
> > +		options->output_fmt = 0;
> > +
> > +	if (options->output_fmt & (OUTPUT_FMT_NAME |
> > +				   OUTPUT_FMT_CHECKDIFF |
> > +				   OUTPUT_FMT_NONE))
> > +		options->output_fmt &= ~(OUTPUT_FMT_RAW |
> > +					 OUTPUT_FMT_DIFFSTAT |
> > +					 OUTPUT_FMT_SUMMARY |
> > +					 OUTPUT_FMT_PATCH);
> > +
> 
> Maybe doing the same for --name-status?

Will fix.  Originally I made --name-status imply --name-only but changed
it and forgot to fix this.

> I wonder if the --name,
> --name-status and --check should be mutually exclusive.  What
> happens when you specify more than one of them?

I'll just make it die() then. If it breaks something then the code is
really dumb anyway.

> > diff --git a/revision.c b/revision.c
> > index b963f2a..4ad2272 100644
> > --- a/revision.c
> > +++ b/revision.c
> > @@ -852,8 +852,8 @@ int setup_revisions(int argc, const char
> >  	if (revs->combine_merges) {
> >  		revs->ignore_merges = 0;
> >  		if (revs->dense_combined_merges &&
> > -		    (revs->diffopt.output_format != DIFF_FORMAT_DIFFSTAT))
> > -			revs->diffopt.output_format = DIFF_FORMAT_PATCH;
> > +		   !(revs->diffopt.output_fmt & OUTPUT_FMT_DIFFSTAT))
> > +			revs->diffopt.output_fmt |= OUTPUT_FMT_PATCH;
> >  	}
> >  	revs->diffopt.abbrev = revs->abbrev;
> >  	diff_setup_done(&revs->diffopt);
> 
> This tells it to default to patch format unless we are asked to
> do diffstat only, in which case we just show stat without patch.
> The new logic seems to be fishy.

If we first initialize it to 0 instead of DIFF_FORMAT_RAW and after
command line flags have been parsed, if it still is 0, then default to
DIFF_FORMAT_PATCH.

>  - could I ask you to redo a patch to do only the clean-up part
>    first, so that I can accept it for either "next" or "master".
> 
>  - Then after I take the clean-up, could you rebase four
>    remainder patches ("Rework diff options" to "Add --patch
>    option for diff-*") on the result?  The patches this round
>    are already split quite well in that the first one does the
>    enum to bit conversion and the latter three cleans things up
>    (all of which I like a lot).  As Johannes suggested, it might
>    be easier to review if they reused the same preprocessor
>    symbols instead of renaming them.  I'd take them for "next".

Yes, all this makes sense.

-- 
http://onion.dynserv.net/~timo/
