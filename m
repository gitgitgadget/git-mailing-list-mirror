From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] --stat: ensure at least one '-' for deletions, and one
 '+' for additions
Date: Thu, 28 Sep 2006 21:14:40 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0609281942360.14200@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0609281735040.14200@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v1wpvvrww.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 28 21:14:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GT1LK-0000xj-EA
	for gcvg-git@gmane.org; Thu, 28 Sep 2006 21:14:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161021AbWI1TOn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Sep 2006 15:14:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161022AbWI1TOn
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Sep 2006 15:14:43 -0400
Received: from mail.gmx.de ([213.165.64.20]:7629 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1161021AbWI1TOm (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Sep 2006 15:14:42 -0400
Received: (qmail invoked by alias); 28 Sep 2006 19:14:40 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp037) with SMTP; 28 Sep 2006 21:14:40 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v1wpvvrww.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28037>

Hi,

On Thu, 28 Sep 2006, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > diff --git a/diff.c b/diff.c
> > index 98c29bf..53c30bd 100644
> > --- a/diff.c
> > +++ b/diff.c
> > @@ -640,9 +640,12 @@ const char mime_boundary_leader[] = "---
> >  static int scale_linear(int it, int width, int max_change)
> >  {
> >  	/*
> > -	 * round(width * it / max_change);
> > +	 * make sure that at least one '-' is printed if there were deletions,
> > +	 * and likewise for '+'.
> >  	 */
> > -	return (it * width * 2 + max_change) / (max_change * 2);
> > +	if (max_change < 2)
> > +		return it;
> > +	return ((it - 1) * (width - 1) + max_change - 1) / (max_change - 1);
> >  }
> 
> This does not feel right.  Maybe the first conditional is to see 
> if it is less than 2, not max_change?

No, it is very much a mathematical constraint: we are going to divide by 
(max_change - 1), which is 0 or -1 in said cases. In _both_ cases, "it" 
happens to be what we actually want. (Okay, in reality we should check for 
width > 0, but I think width == 0 would not make _any_ sense.)

> But think about the case where width=7, max_change=10, 5
> lines are added and 5 lines are removed.
> 
> The original makes total 7 to use full width, and gives 4 pluses
> and 3 minuses, which is not quite right when your eyes notice
> that they are not of equal length, but it makes it to use the
> full width.  I think this version gives 3 pluses and minuses,
> and does not use the full width.

That is right.

However, I would argue it's actually an improvement. If you have as many 
additions as deletions, there should be an equal number of '-' and '+'.

After all, the integer number of symbols is just an approximation anyway.

Ciao,
Dscho
