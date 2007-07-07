From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [PATCH] revision: allow selection of commits that do not match a
 pattern
Date: Sat, 07 Jul 2007 22:22:00 +0200
Message-ID: <20070707202200.GF1528MdfPADPa@greensroom.kotnet.org>
References: <20070707153001.GA10408MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0707071724410.4093@racer.site>
 <20070707165208.GC1528MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0707071831300.4093@racer.site>
 <20070707184224.GE1528MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0707071957370.4093@racer.site>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jul 07 22:22:14 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7GnB-0006VU-1m
	for gcvg-git@gmane.org; Sat, 07 Jul 2007 22:22:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754228AbXGGUWF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jul 2007 16:22:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753812AbXGGUWF
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jul 2007 16:22:05 -0400
Received: from smtp16.wxs.nl ([195.121.247.7]:40423 "EHLO smtp16.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753787AbXGGUWC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jul 2007 16:22:02 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by smtp16.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006)) with SMTP id
 <0JKT0068YSKPSH@smtp16.wxs.nl> for git@vger.kernel.org; Sat,
 07 Jul 2007 22:22:01 +0200 (CEST)
Received: (qmail 29763 invoked by uid 500); Sat, 07 Jul 2007 20:22:00 +0000
In-reply-to: <Pine.LNX.4.64.0707071957370.4093@racer.site>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51840>

On Sat, Jul 07, 2007 at 08:35:35PM +0100, Johannes Schindelin wrote:
> Why not keep it "add_grep", and do a
> 
> 	struct grep_opt **filter = negated ? 
> 		&revs->grep_neg_filter : &revs->grep_filter;
> 
> Hm? You avoid an extra function that way.

[..]
> 
> The parsing for "!" is again duplicated in add_message_grep(). Why not put 
> it into add_grep(), and do
> 
> 	negated = *pattern == '!';
> 	sprintf(pat, "%s^%s %s%s", negated ? "!" : "", field, prefix, 
> 		pattern + negated);
> 
> instead? No need to change the signature of add_grep(), and all callers 
> get the '!' feature for free.

I can do these things, but they don't exactly improve readability, IMHO.

> > @@ -1249,6 +1277,10 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
> >  		compile_grep_patterns(revs->grep_filter);
> >  	}
> >  
> > +	if (revs->grep_neg_filter) {
> > +		compile_grep_patterns(revs->grep_neg_filter);
> > +	}
> > +
> 
> Please lose the "{" and "}".

I may still need them for doing something with all_match...

> > @@ -1329,11 +1361,14 @@ static int rewrite_parents(struct rev_info *revs, struct commit *commit)
> >  
> >  static int commit_match(struct commit *commit, struct rev_info *opt)
> >  {
> > -	if (!opt->grep_filter)
> > -		return 1;
> > -	return grep_buffer(opt->grep_filter,
> > +	return (!opt->grep_filter ||
> > +		grep_buffer(opt->grep_filter,
> > +			   NULL, /* we say nothing, not even filename */
> > +			   commit->buffer, strlen(commit->buffer))) &&
> > +	       (!opt->grep_neg_filter ||
> > +		!grep_buffer(opt->grep_neg_filter,
> >  			   NULL, /* we say nothing, not even filename */
> > -			   commit->buffer, strlen(commit->buffer));
> > +			   commit->buffer, strlen(commit->buffer)));
> >  }
> 
> Urgh! That's not nice on my eyes.

You prefer

	if (opt->grep_filter && !grep_buffer(opt->grep_filter,
			   NULL, /* we say nothing, not even filename */
			   commit->buffer, strlen(commit->buffer)))
	       return 0;
	if (opt->grep_neg_filter && grep_buffer(opt->grep_neg_filter,
			   NULL, /* we say nothing, not even filename */
			   commit->buffer, strlen(commit->buffer)));
	       return 0;
       return 1;

?

> Also, I suspect that the semantics are not yet clear, what should happen 
> if all_match is unset.

So what are the semantics of all_match without negated matches?
It doesn't seem to be documented in git-rev-list.txt.

> BTW I suspect that a better way than having two filter lists is 
> demonstrated in builtin-grep.c.

Could you be a bit more specific?
If you're talking about the GREP_NOT thing, then AFAICS that is line based
and I want these things to be commit based.  That is I want to select
commits with either a or no lines that match a given pattern and not
commits that have a line that matches some patterns and not some others.

skimo
