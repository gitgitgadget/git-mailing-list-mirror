From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: found a resource leak in file builtin-fast-export.c
Date: Thu, 9 Jul 2009 15:01:46 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0907091500420.4339@intel-tinevez-2-302>
References: <20090709075728.137880@gmx.net> <200907091031.43494.trast@student.ethz.ch> <alpine.DEB.1.00.0907091302520.4339@intel-tinevez-2-302> <200907091324.17643.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin Ettl <ettl.martin@gmx.de>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Jul 09 15:01:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOtG9-0008WS-39
	for gcvg-git-2@gmane.org; Thu, 09 Jul 2009 15:01:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757420AbZGINBu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2009 09:01:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756453AbZGINBu
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jul 2009 09:01:50 -0400
Received: from mail.gmx.net ([213.165.64.20]:51377 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756380AbZGINBt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2009 09:01:49 -0400
Received: (qmail invoked by alias); 09 Jul 2009 13:01:47 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp017) with SMTP; 09 Jul 2009 15:01:47 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+VWE0JlheVLLX2meCj2Spo+rTIke1EMDdRMOqfAz
	vo0ocrzhFNU/WQ
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <200907091324.17643.trast@student.ethz.ch>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122972>

Hi,

On Thu, 9 Jul 2009, Thomas Rast wrote:

> Johannes Schindelin wrote:
> > On Thu, 9 Jul 2009, Thomas Rast wrote:
> > 
> > > Martin Ettl wrote:
> > > > -	if (ferror(f) || fclose(f))
> > > > +	if (ferror(f))
> > > >  		error("Unable to write marks file %s.", file);
> > > > +  	fclose(f);
> > > 
> > > You no longer check the error returned by fclose().  This is
> > > important, because the FILE* API may buffer writes, and a write error
> > > may only become apparent when fclose() flushes the file.
> > 
> > Indeed.  A better fix would be to replace the || by a |, but this must be 
> > accompanied by a comment so it does not get removed due to overzealous 
> > compiler warnings.
> 
> Are you allowed to do that?  IIRC using | no longer guarantees that
> ferror() is called before fclose(), and my local 'man 3p fclose' says
> that
> 
>        After the call to fclose(), any use of stream results in
>        undefined behavior.

Good point.  So we really need something like

	err = ferror(f);
	err |= fclose(f); /* call fclose() even if there was an error */
	if (err)
		error...

Ciao,
Dscho
