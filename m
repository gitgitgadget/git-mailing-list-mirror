From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] Introduce remove_dir_recursively()
Date: Fri, 28 Sep 2007 13:35:21 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709281323300.28395@racer.site>
References: <Pine.LNX.4.64.0709280602580.28395@racer.site>
 <Pine.LNX.4.64.0709280606350.28395@racer.site> <7v8x6rqhwy.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 28 14:36:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IbF5C-0007xf-Hb
	for gcvg-git-2@gmane.org; Fri, 28 Sep 2007 14:36:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753082AbXI1Mgb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2007 08:36:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753077AbXI1Mgb
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Sep 2007 08:36:31 -0400
Received: from mail.gmx.net ([213.165.64.20]:58358 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752383AbXI1Mga (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2007 08:36:30 -0400
Received: (qmail invoked by alias); 28 Sep 2007 12:36:29 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp042) with SMTP; 28 Sep 2007 14:36:29 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+bngcwUCOb4kFzRKxHPBD36NrTtb1OCojTBQae4o
	cU3mQIw+2zUnic
X-X-Sender: gene099@racer.site
In-Reply-To: <7v8x6rqhwy.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59388>

Hi,

On Fri, 28 Sep 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > +int remove_dir_recursively(char *path, int len, int only_empty)
> > +{
> > ...
> > +		namlen = strlen(e->d_name);
> > +		if (len + namlen > PATH_MAX ||
> > +				!memcpy(path + len, e->d_name, namlen) ||
> > +				(path[len + namlen] = '\0') ||
> > +				lstat(path, &st))
> > +			; /* fall thru */
> > +		else if (S_ISDIR(st.st_mode)) {
> > +			if (!remove_dir_recursively(path, len + namlen,
> > +						only_empty))
> > +				continue; /* happy */
> > +		} else if (!only_empty &&
> > +				len + namlen + 1 < PATH_MAX &&
> > +				!unlink(path))
> > +			continue; /* happy, too */
> > +
> > +		/* path too long, stat fails, or non-directory still exists */
> > +		ret = -1;
> > +		break;
> 
> Is it only me who finds the first if () condition way too
> convoluted and needs to read three times to convince oneself
> that it is doing a sane thing?
> 
> Please, especially...
> 
>  * For $DEITY's sake, memcpy() returns pointer to dst which you
>    know is not NULL. so !memcpy() is always false here, which
>    might be _convenient_ for you and the compiler but not for
>    a human reader of the code who needs to blink twice wondering
>    if you meant !memcmp().
> 
>  * Same for (path[] = '\0'), wondering if it is misspelled
>    (path[] == '\0').

Okay, will fix (with an evil goto).

BTW it just hit me that this magic reliance on a buffer of size PATH_MAX 
is not good at all.  It even hit _me_ while developing that series.

So I'll change that to a strbuf, too.  (Which will fix the convoluted 
logic quite some, incidentally.)

Ciao,
Dscho
