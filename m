From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] diff --color-words -U0: fix the location of hunk
 headers
Date: Thu, 29 Oct 2009 14:27:18 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0910291425010.3687@felix-maschine>
References: <1256732672-11817-1-git-send-email-markus.heidelberg@web.de> <1256732672-11817-4-git-send-email-markus.heidelberg@web.de> <alpine.DEB.1.00.0910291144170.3687@felix-maschine> <200910291222.42598.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Markus Heidelberg <markus.heidelberg@web.de>
X-From: git-owner@vger.kernel.org Thu Oct 29 14:27:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3V2L-0005Fs-3z
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 14:27:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752571AbZJ2N1W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2009 09:27:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752244AbZJ2N1W
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Oct 2009 09:27:22 -0400
Received: from mail.gmx.net ([213.165.64.20]:38949 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752139AbZJ2N1V (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2009 09:27:21 -0400
Received: (qmail invoked by alias); 29 Oct 2009 13:27:25 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO [10.1.35.45]) [141.5.11.5]
  by mail.gmx.net (mp071) with SMTP; 29 Oct 2009 14:27:25 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/Ca29gAJfC/3ZGL9XrDAOXRD7/jIcTcV3cxmcfqH
	vfi9y6okyiKkhd
X-X-Sender: johannes@felix-maschine
In-Reply-To: <200910291222.42598.markus.heidelberg@web.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131591>

Hi,

On Thu, 29 Oct 2009, Markus Heidelberg wrote:

> Johannes Schindelin, 29.10.2009:
> > 
> > 	I would strongly prefer this fix instead of your 2/3 and 3/3.
> > 
> >  diff.c                |    6 ++++++
> >  t/t4034-diff-words.sh |    2 +-
> >  2 files changed, 7 insertions(+), 1 deletions(-)
> > 
> > diff --git a/diff.c b/diff.c
> > index 51b5dbb..4eafaf5 100644
> > --- a/diff.c
> > +++ b/diff.c
> > @@ -656,6 +656,12 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
> >  	for (i = 0; i < len && line[i] == '@'; i++)
> >  		;
> >  	if (2 <= i && i < len && line[i] == ' ') {
> > +		/* flush --color-words even for --unified=0 */
> > +		if (ecbdata->diff_words &&
> > +		    (ecbdata->diff_words->minus.text.size ||
> > +		     ecbdata->diff_words->plus.text.size))
> > +			diff_words_show(ecbdata->diff_words);
> > +
> >  		ecbdata->nparents = i - 1;
> >  		len = sane_truncate_line(ecbdata, line, len);
> >  		emit_line(ecbdata->file,
> 
> This seems to apply before commit b8d9c1a (diff.c: the builtin_diff()
> deals with only two-file comparison, 2009-09-03).

Yes, sorry, for some reason I worked on a machine where I do not work from 
junio's next, but my own fork (which is outdated due to lack of time).

> Indeed my initial fix was in the same fashion:
> 
> @@ -772,6 +772,15 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
>         }
> 
>         if (line[0] == '@') {
> +               if (ecbdata->diff_words) {
> +                       /*
> +                        * The content of the previous hunk, necessary for
> +                        * 0-context.
> +                        */
> +                       if (ecbdata->diff_words->minus.text.size ||
> +                           ecbdata->diff_words->plus.text.size)
> +                               diff_words_show(ecbdata->diff_words);
> +               }
>                 len = sane_truncate_line(ecbdata, line, len);
>                 find_lno(line, ecbdata);
>                 emit_line(ecbdata->file,
> 
> But then I thought I should not put the diff output from --color-words
> into the block that deals with the hunk header, but save another place
> where diff_words_show() is called.

I found this paragraph, as well as the patches 2/3 and 3/3, hard to 
follow.

And besides, flushing in that block is the correct thing to do.  The 
function diff_words_show() is a function for that exact purpose.

Ciao,
Dscho
