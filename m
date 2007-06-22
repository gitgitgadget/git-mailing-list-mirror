From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] diffcore-rename: favour identical basenames
Date: Fri, 22 Jun 2007 11:22:09 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706221042551.4059@racer.site>
References: <20070621030622.GD8477@spearce.org>
 <alpine.LFD.0.98.0706202031200.3593@woody.linux-foundation.org>
 <Pine.LNX.4.64.0706211248420.4059@racer.site> <20070621131915.GD4487@coredump.intra.peff.net>
 <Pine.LNX.4.64.0706220214250.4059@racer.site> <20070622054142.GA7699@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	govindsalinas <govindsalinas@yahoo.com>, gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 22 12:22:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1gHZ-0001DE-IQ
	for gcvg-git@gmane.org; Fri, 22 Jun 2007 12:22:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751417AbXFVKWS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Jun 2007 06:22:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751232AbXFVKWS
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jun 2007 06:22:18 -0400
Received: from mail.gmx.net ([213.165.64.20]:51170 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751375AbXFVKWR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jun 2007 06:22:17 -0400
Received: (qmail invoked by alias); 22 Jun 2007 10:22:15 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp053) with SMTP; 22 Jun 2007 12:22:15 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1//Vsp44i3/SruDI2AtwWOpUVGWyaWGrYI46nW5KD
	Sy9xSqcILZXERh
X-X-Sender: gene099@racer.site
In-Reply-To: <20070622054142.GA7699@coredump.intra.peff.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50686>

Hi,

On Fri, 22 Jun 2007, Jeff King wrote:

> On Fri, Jun 22, 2007 at 02:14:43AM +0100, Johannes Schindelin wrote:
> 
> > @@ -313,20 +297,24 @@ void diffcore_rename(struct diff_options *options)
> >  			if (rename_dst[i].pair)
> >  				continue; /* dealt with an earlier round */
> >  			for (j = 0; j < rename_src_nr; j++) {
> > -				int k;
> > +				int k, distance;
> >  				struct diff_filespec *one = rename_src[j].one;
> >  				if (!is_exact_match(one, two, contents_too))
> >  					continue;
> >  
> > +				distance = levenshtein(one->path, two->path);
> >  				/* see if there is a basename match, too */
> >  				for (k = j; k < rename_src_nr; k++) {
> 
> This loop can start at k = j+1, since otherwise we are just checking
> rename_src[j] against itself.

Right.

> > +int levenshtein(const char *string1, const char *string2)
> > +{
> > +	int len1 = strlen(string1), len2 = strlen(string2);
> > +	int *row1 = xmalloc(sizeof(int) * (len2 + 1));
> > +	int *row2 = xmalloc(sizeof(int) * (len2 + 1));
> > +	int i, j;
> > +
> > +	for (j = 1; j <= len2; j++)
> > +		row1[j] = j;
> 
> This loop must start at j=0, not j=1; otherwise you have an undefined
> value in row1[0], which gets read when setting row2[1], and you get
> a totally meaningless distance (I got -1209667248 on my test case!).

Sorry for that. I originally had an xcalloc in there, and did not look at 
that loop afterwards.

And I completely forgot that on my laptop (on which I did this patch), I 
had forgotten to add

	ALL_CFLAGS += -DXMALLOC_POISON=1

to config.mak.

Ciao,
Dscho
