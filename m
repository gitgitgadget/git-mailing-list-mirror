From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] cleans up builtin-mv
Date: Sat, 19 Aug 2006 03:26:39 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0608190323010.28360@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0608172230470.25827@chino.corp.google.com>
 <Pine.LNX.4.63.0608172301520.25827@chino.corp.google.com>
 <Pine.LNX.4.63.0608181137000.28360@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vbqqh96v2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 19 03:26:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GEFbp-0005g4-0t
	for gcvg-git@gmane.org; Sat, 19 Aug 2006 03:26:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161055AbWHSB0m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Aug 2006 21:26:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161104AbWHSB0m
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Aug 2006 21:26:42 -0400
Received: from mail.gmx.de ([213.165.64.20]:62166 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1161055AbWHSB0l (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Aug 2006 21:26:41 -0400
Received: (qmail invoked by alias); 19 Aug 2006 01:26:39 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp038) with SMTP; 19 Aug 2006 03:26:39 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vbqqh96v2.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25704>

Hi,

On Fri, 18 Aug 2006, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > What you cleverly did not mention: It was inside a
> >
> > 	if (!bad &&
> > 		(length = strlen(source[i])) >= 0 &&
> > 		!strncmp(destination[i], source[i], length) &&
> > 		(destination[i][length] == 0 || destination[i][length] == '/'))
> >
> > construct. So, we assign the "length" variable only if we have to. And the 
> > ">= 0" trick is a common one. I could have done
> >
> > 		!strncmp(destination[i], source[i], (length = strlen(source[i])))
> >
> > but even I find that ugly.
> 
> I usually side with you but on this I can't.
> 
> There are 2 ways to generate branch instructions in C.
> 
>  - compound statements specifically designed for expressing
>    control structure: if () ... else ..., for (), while (),
>    switch (), etc.
> 
>  - expressions using conditional operators or logical operators
>    that short circuit: ... ? ... : ..., ... && ... || ...
> 
> The latter form may still be readable even with simple side
> effects inside its terms, but "(l = strlen(s)) >= 0" is done
> solely for the side effect, and its computed value does not have
> anything to do with the logical operation &&.
> 
> THIS IS UGLY.  And do not want to live in a world where this
> ugliness is a "common one", as you put it.

Okay. Probably the explanation is: I do not use git-mv myself, but only 
got annoyed enough by a failing t7001 to rewrite it.

> And this avoiding one call to strlen(source[i]) is unnecessary
> even as an optimization -- you end up calling strlen() on it
> later in the code anyway, as David points out.
> 
> I think this part is far easier to read if you did it like this:
>  
> 		length = strlen(source[i]);
> 		if (lstat(source[i], &st) < 0)
> 			bad = "bad source";
> 		else if (!strncmp(destination[i], source[i], length) &&
> 			 (destination[i][length] == 0 ||
> 			  destination[i][length] == '/'))
> 			bad = "can not move directory into itself";
> 
> 		if (S_ISDIR(st.st_mode)) {
> 			...
> 
> Note that the above is an absolute minimum rewrite.  Other
> things I noticed are:
> 
>  - source[i] and destination[i] are referenced all the time; the
>    code would be easer to read if you had something like this
>    upfront:
> 
>                 /* Checking */
>                 for (i = 0; i < count; i++) {
>                         const char *bad = NULL;
> 			const char *src = source[i];
>                         const char *dst = destination[i];
>                         int srclen = strlen(src);
>                         int dstlen = strlen(dst);
> 
>    You might end up not using dstlen in some cases, but I think
>    this would be far easier to read.  Micro-optimizing by saying
>    "this is used only in this branch of this later if()
>    statement but in that case it is always set in that branch of
>    that earlier if() statement" makes unmaintainably confusing
>    code.
> 
>  - I do not think you need "const char *dir, *dest_dir" inside
>    the "source is directory" branch; I would just use src and dst
>    consistently;

These changes would make the source more readable, yes.

>  - You muck with dest_dir by calling add_slash(dest_dir) but
>    call prefix_path() with dst_len you computed earlier;
>    prefix_path() may know what to do, but is this intended?

That is probably a late night oversight.

If noone else is faster, I will do the requested changes tomorrow.

Ciao,
Dscho
