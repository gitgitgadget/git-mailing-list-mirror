From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] git remote add: allow re-adding remotes with the
 same URL
Date: Tue, 23 Dec 2014 14:25:36 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1412231425220.21312@s15462909.onlinehome-server.info>
References: <20141216021900.50095.24877@random.io> <cover.1419267895.git.johannes.schindelin@gmx.de> <9c0c693efe68b1c0b080c14104bb6c5f7bf74097.1419267895.git.johannes.schindelin@gmx.de> <xmqq1tnrbmn1.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: anapsix@random.io, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 23 14:25:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3PT8-0002TW-0j
	for gcvg-git-2@plane.gmane.org; Tue, 23 Dec 2014 14:25:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932240AbaLWNZl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Dec 2014 08:25:41 -0500
Received: from mout.gmx.net ([212.227.15.19]:58532 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932162AbaLWNZl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Dec 2014 08:25:41 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx003) with ESMTPSA (Nemesis) id 0MUoiS-1YOD2y3zq8-00Y6tm;
 Tue, 23 Dec 2014 14:25:36 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <xmqq1tnrbmn1.fsf@gitster.dls.corp.google.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:DzR7bFO2KFjVGqgMwTUz4wCrR1AH9jpveetKOaeYnFIb3KE4Bkz
 b2RWKAvbKE6DpaB5Cl98OfngKJQ6DKvmEGSAWy5ap26RLRsk7vedEWLZNdiQICY4UzWSIFf
 xFJPBizt/QjtjDCW9dbMfux+eFt7iOz9ePHHxfkKKcVfYfK6+yQ9ka5gX3YkTl9V/HVSoZM
 HRbijXsvuvJOaliZM3+KQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261733>

Hi Junio,

On Mon, 22 Dec 2014, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > When adding a remote, we make sure that the remote does not exist
> > already.
> >
> > For convenience, we allow re-adding remotes with the same URLs.
> > This also handles the case that there is an "[url ...] insteadOf"
> > setting in the config.
> >
> > It might seem like a mistake to compare against remote->url[0] without
> > verifying that remote->url_nr >=1, but at this point a missing URL has
> > been filled by the name already, therefore url_nr cannot be zero.
> >
> > Noticed by Anastas Dancha.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  builtin/remote.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/builtin/remote.c b/builtin/remote.c
> > index 46ecfd9..9168c83 100644
> > --- a/builtin/remote.c
> > +++ b/builtin/remote.c
> > @@ -180,7 +180,8 @@ static int add(int argc, const char **argv)
> >  	url = argv[1];
> >  
> >  	remote = remote_get(name);
> > -	if (remote && (remote->url_nr > 1 || strcmp(name, remote->url[0]) ||
> > +	if (remote && (remote->url_nr > 1 || (strcmp(name, remote->url[0]) &&
> > +				strcmp(url, remote->url[0])) ||
> >  			remote->fetch_refspec_nr))
> >  		die(_("remote %s already exists."), name);
> 
> When we need to fold an overlong line, it is easier to read if the
> line is folded at an operator with higher precedence, i.e. this line
> 
>         if (A && (B || (C && D) || E))
> 
> folded like this
> 
>         if (A && (B || (C &&
>                    D) ||
>             E))
> 
> is harder to read than when folded like this
> 
>         if (A && (B ||
>                   (C && D) ||
>                    E))
> 
> So, it is an error if we have "remote" and if
> 
>  (1) URL for the remote is defined already twice or more; or
>  (2) we are adding a nickname (i.e. not a URL) and it is different
>      from what we already have; or
>  (3) we already have fetch_refspec
> 
> The way I read the log message's rationale was that this is to allow
> replacing an existing remote's URL; wouldn't checking the existence
> of fetch_refspec go against that goal?
> 
> Puzzled.  Either the code is wrong or I am mislead by the
> explanation in the log.

I hope v2 addresses your concerns.

Ciao,
Dscho
