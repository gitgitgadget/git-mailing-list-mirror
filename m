From: Shawn Bohrer <shawn.bohrer@gmail.com>
Subject: Re: [PATCH] git clean: Don't automatically remove directories when
	run within subdirectory
Date: Mon, 14 Apr 2008 12:06:43 -0500
Message-ID: <20080414170643.GA10548@mediacenter>
References: <85fxtvj6y8.fsf_-_@lupus.strangled.net> <1208130578-24748-1-git-send-email-shawn.bohrer@gmail.com> <7v8wzgaoqy.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: jobh@broadpark.no, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 14 19:28:04 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlSAz-00054a-El
	for gcvg-git-2@gmane.org; Mon, 14 Apr 2008 19:09:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756649AbYDNRHf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Apr 2008 13:07:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756371AbYDNRHf
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Apr 2008 13:07:35 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:58449 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752359AbYDNRHe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Apr 2008 13:07:34 -0400
Received: by yw-out-2324.google.com with SMTP id 5so726499ywb.1
        for <git@vger.kernel.org>; Mon, 14 Apr 2008 10:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        bh=dbBlOCU/R480hZvV+UnnpBAmubhoEFNQmom34H5g0S8=;
        b=BDTC7cZu7+9AqbBy08xQyKe1QVonip95mdnoQv3Ke0LF1+pPFTpOu/B8LWEIKLkJT3Uvg2gCvcfLfE+6P5Puojd3NT6DbQ3JspIoliOIbCyD0nL1q/Ct8RJthFFjR/PHGwoXzkRpkvoFpwsqp7UEYm7Fs0Us9hF/pa4HFrkPw90=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=Ip1GXgf9MvHmN5yvRj+Sk0eG5AQ5y4RR4G2aHnSoV6ndeWsv/sjUvBmoYpksplA8l9BQTtkLhA59NCzzC0AVZ+ND2x4vDyTqltNjMy9otobbzs2OfIDpG18VznYY/JViRFYPerg4O6TFL7t16rUtRkkyzY9B7Wd/4sjqIfpN1F0=
Received: by 10.151.114.6 with SMTP id r6mr6408247ybm.84.1208192829053;
        Mon, 14 Apr 2008 10:07:09 -0700 (PDT)
Received: from @ ( [70.112.149.232])
        by mx.google.com with ESMTPS id a42sm100844rne.15.2008.04.14.10.06.53
        (version=SSLv3 cipher=OTHER);
        Mon, 14 Apr 2008 10:07:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v8wzgaoqy.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79519>

On Mon, Apr 14, 2008 at 12:18:13AM -0700, Junio C Hamano wrote:
> Shawn Bohrer <shawn.bohrer@gmail.com> writes:
> > -		int len, pos, matches;
> > +		int len, pos;
> > +		int matches = 0;
> >  		struct cache_entry *ce;
> >  		struct stat st;
> 
> Initialization of "matches" seems to be an independent clean-up.  Although
> it forces the initialization in the codepath that do not need the value of
> matches, that is not a big deal --- right?

Yes this is an independent clean-up.  I can't see any harm in forcing
the initializtion.

> > -			matches = match_pathspec(pathspec, ent->name, ent->len,
> > +			matches = match_pathspec(pathspec, ent->name, len,
> >  						 baselen, seen);
> > -		} else {
> > -			matches = 0;
> >  		}
> 
> And the essential change (fix) is to send len which could be shorter than
> ent->len because we have stripped '/' here, plus the one in match_one()
> that now allows name[] that is not NUL terminated.

Yep, I'll add that to the changelog.

> > -			if (show_only && (remove_directories || matches)) {
> > +			if (show_only && (remove_directories || (matches >= 2))) {
> >  				printf("Would remove %s\n", qname);
> > -			} else if (remove_directories || matches) {
> > +			} else if (remove_directories || (matches >= 2)) {
> 
> These magic numbers are bad.  Please update it to use symbolic constants.

Agreed I'll send an updated patch later tonight.  One additional thought
though.  2 is MATCHED_FNMATCH which worries me a little because I think
this would mean 'git clean -f *' will also remove directories (I haven't
tried though).  Perhaps this should really be 3 MATCHED_EXACTLY just to
be safe.  Does anyone have opinions either way?

--
Shawn
