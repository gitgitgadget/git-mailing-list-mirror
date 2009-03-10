From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH/RFC] recv_sideband: Band #2 always goes to stderr
Date: Tue, 10 Mar 2009 16:07:29 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903101605460.14295@intel-tinevez-2-302>
References: <cover.1236639280u.git.johannes.schindelin@gmx.de> <e2b19f6c7c50e5b0a652c40b0d8e4947134ed669.1236639280u.git.johannes.schindelin@gmx.de> <49B61377.90103@viscovery.net> <49B61703.8030602@viscovery.net> <20090310144646.GQ11989@spearce.org>
 <49B680F7.4040103@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	gitster@pobox.com, Peter Harris <git@peter.is-a-geek.org>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Nicolas Pitre <nico@cam.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Mar 10 16:10:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lh3Zs-0002TH-QY
	for gcvg-git-2@gmane.org; Tue, 10 Mar 2009 16:09:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754992AbZCJPHf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2009 11:07:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754287AbZCJPHe
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Mar 2009 11:07:34 -0400
Received: from mail.gmx.net ([213.165.64.20]:36421 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754069AbZCJPHe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2009 11:07:34 -0400
Received: (qmail invoked by alias); 10 Mar 2009 15:07:31 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp014) with SMTP; 10 Mar 2009 16:07:31 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+SQzFN7qmS36TxCMTcoHqNzKVd/ywleh7X4qjqca
	FRPIxr8oNbzNdv
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <49B680F7.4040103@viscovery.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112825>

Hi,

On Tue, 10 Mar 2009, Johannes Sixt wrote:

> Shawn O. Pearce schrieb:
> > Johannes Sixt <j.sixt@viscovery.net> wrote:
> >> diff --git a/sideband.c b/sideband.c
> >> index cca3360..a706ac8 100644
> >> --- a/sideband.c
> >> +++ b/sideband.c
> >> @@ -50,8 +49,8 @@ int recv_sideband(const char *me, int in_stream, int out, int err)
> >>  		switch (band) {
> >>  		case 3:
> >>  			buf[pf] = ' ';
> >> -			buf[pf+1+len] = '\n';
> >> -			safe_write(err, buf, pf+1+len+1);
> >> +			buf[pf+1+len] = '\0';
> >> +			fprintf(stderr, "%s\n", buf);
> > 
> > Can't you instead do:
> > 
> > 	fprintf(stderr, "%.*s\n", buf, pf + len);
> > 
> > like you do...
> > 
> >> @@ -95,12 +94,13 @@ int recv_sideband(const char *me, int in_stream, int out, int err)
> >>  					memcpy(save, b + brk, sf);
> >>  					b[brk + sf - 1] = b[brk - 1];
> >>  					memcpy(b + brk - 1, suffix, sf);
> >> -					safe_write(err, b, brk + sf);
> >> +					fprintf(stderr, "%.*s", brk + sf, b);
> >>  					memcpy(b + brk, save, sf);
> >>  					len -= brk;
> >>  				} else {
> >>  					int l = brk ? brk : len;
> >> -					safe_write(err, b, l);
> >> +					if (l > 0)
> >> +						fprintf(stderr, "%.*s", l, b);
> > 
> > here?
> 
> I deliberatly avoided "%.*s" in the former hunk (1) because of the posts
> that we had yesterday about potentially misbehaved fprintf in the case
> where the precision is 0;

Didn't that turn out to be a false alarm?

> and (2) because it was so easy to avoid it. I don't think we need 
> ultimate performance in this case, and I also consider the plain "%s\n" 
> more readable.
> 
> That said, the second hunk is really only the minimal change and I'd 
> like to rewrite it to get rid of the memcpy stuff. It is really not 
> needed once fprintf is in the game. But that's a separate patch.

I think, indeed, that you can avoid the memcpy() by using %.*s.  The 
private buffer is only used to make sure that the text is written in one 
go anyway (i.e. that two sidebands messages are not written to the same 
line because they use multiple calls to fprintf()/fwrite() per line), 
right?

Ciao,
Dscho
