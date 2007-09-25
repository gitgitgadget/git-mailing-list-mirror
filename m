From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Use "" instead of "<unknown>" for placeholders
Date: Tue, 25 Sep 2007 11:25:37 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709251120120.28395@racer.site>
References: <20070921101420.GD22869@mageo.cz> <Pine.LNX.4.64.0709211146090.28395@racer.site>
 <20070921110646.GA9072@mageo.cz> <Pine.LNX.4.64.0709211207070.28395@racer.site>
 <20070921140500.GB9072@mageo.cz> <7vk5qjixqy.fsf@gitster.siamese.dyndns.org>
 <46F4D815.5050602@mageo.cz> <20070925094320.GN22869@mageo.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michal Vitecek <fuf@mageo.cz>
X-From: git-owner@vger.kernel.org Tue Sep 25 12:26:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ia7cw-00083U-5m
	for gcvg-git-2@gmane.org; Tue, 25 Sep 2007 12:26:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751752AbXIYK0o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2007 06:26:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751755AbXIYK0o
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Sep 2007 06:26:44 -0400
Received: from mail.gmx.net ([213.165.64.20]:40208 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751738AbXIYK0n (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2007 06:26:43 -0400
Received: (qmail invoked by alias); 25 Sep 2007 10:26:41 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp027) with SMTP; 25 Sep 2007 12:26:41 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+YBI5PdHKYpJt7QkgTD7UIBRCxDwudIdZPiWhFZv
	oSwisjRx5DXYLk
X-X-Sender: gene099@racer.site
In-Reply-To: <20070925094320.GN22869@mageo.cz>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59108>

Hi,

On Tue, 25 Sep 2007, Michal Vitecek wrote:

>  Hello again,
> 
> Michal Vitecek wrote:
> > Junio C Hamano wrote:
> >>>>>>> I made it because I want to use my own pretty format which currently 
> >>>>>>> only allows '%s' for subject and '%b' for body. But '%b' is 
> >>>>>>> substituted with <undefined> if the body is "missing" which I 
> >>>>>>> obviously don't like :)
> >>>>>> Then you should fix %b not to show "<undefined>".
> >>>>>  I'll do it if it is okay. Shall I do the same for the other
> >>>>>  placeholders as well?
> >>>> Yeah.  Don't know why I did it that way.
> >>>  Here comes the big patch :)
> >> Now, this breaks t6006 which needs this patch.
> >
> > Oops - I'm sorry about that. I ran the test suite (1.5.3.1) but it failed 
> > in 2 tests before the patch and in 2 tests after it so I considered it 
> > okay.
> >
> >> Looking at this patch, I am not sure if your change is really a
> >> desirable one --- shouldn't it be removing the line itself, not
> >> just <unknown> token?
> >
> > This sounds as the best solution. I'll look into it. Thanks for your time.
> 
>  Here comes the patch. I hope it will be ok this time :) Thanks.
> 
>  Don't use "<unknown>" for unknown values of placeholders and suppress
>  printing of empty user formats.
> 
> ---

Please move the discussion which should not be in the commit message 
_after_ the "---".

> diff --git a/builtin-rev-list.c b/builtin-rev-list.c
> index 3894633..1de981d 100644
> --- a/builtin-rev-list.c
> +++ b/builtin-rev-list.c
> @@ -85,7 +85,8 @@ static void show_commit(struct commit *commit)
>  		pretty_print_commit(revs.commit_format, commit, ~0,
>  				    &buf, &buflen,
>  				    revs.abbrev, NULL, NULL, revs.date_mode);
> -		printf("%s%c", buf, hdr_termination);
> +                if (strlen(buf))
> +                    printf("%s%c", buf, hdr_termination);

We use tabs for indentation, not spaces.

Also, instead of the expensive "strlen(buf)", you rather want to check "if 
(*buf)".

> diff --git a/log-tree.c b/log-tree.c
> index a642371..5653332 100644
> --- a/log-tree.c
> +++ b/log-tree.c
> @@ -298,7 +299,8 @@ void show_log(struct rev_info *opt, const char *sep)
>  	if (opt->show_log_size)
>  		printf("log size %i\n", len);
>  
> -	printf("%s%s%s", msgbuf, extra, sep);
> +        if (strlen(msgbuf))
> +            printf("%s%s%s", msgbuf, extra, sep);

Again, "if (*msgbuf)" is way more efficient.

Ciao,
Dscho
