From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Fix remote_get so it will return NULL when no remote is
 found.
Date: Thu, 5 Jun 2008 14:26:30 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806051415000.21190@racer>
References: <1212670091.30293.3.camel@omicron.ep.petrobras.com.br>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Victor Bogado da Silva Lins <victor@bogado.net>
X-From: git-owner@vger.kernel.org Thu Jun 05 15:29:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4FWN-0004BB-3H
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 15:28:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754696AbYFEN16 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 09:27:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754657AbYFEN16
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 09:27:58 -0400
Received: from mail.gmx.net ([213.165.64.20]:46669 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754630AbYFEN15 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 09:27:57 -0400
Received: (qmail invoked by alias); 05 Jun 2008 13:27:55 -0000
Received: from unknown (EHLO racer.local) [128.177.17.254]
  by mail.gmx.net (mp051) with SMTP; 05 Jun 2008 15:27:55 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+IeRoktlOIQR13Opyejdv2yJtVAdikHWG2LARiCa
	IcQES9Vk2aU5TM
X-X-Sender: gene099@racer
In-Reply-To: <1212670091.30293.3.camel@omicron.ep.petrobras.com.br>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83927>

Hi,

[nice to go to sleep and see a patch in the morning]

On Thu, 5 Jun 2008, Victor Bogado da Silva Lins wrote:

> >>From 0cf45f264cf7f1b3aa3a8875109fbf4c03d56126 Mon Sep 17 00:00:00 2001
> From: Victor Bogado <victor@bogado.net>
> Date: Thu, 5 Jun 2008 09:36:41 -0300
> Subject: [PATCH] Fix remote_get so it will return NULL when no remote is
> found.

Please imitate what you see on this list, especially by the Git regulars.  
They never include these headers.

> remote_get should return NULL when there is no remote with that name, at 
> least this is what remote.c's rm() function seems to think. As this is a 
> reasonable assumption, and it seems that the function remote_get is 
> acutally trying to do this, I fixed the test so it will test if the URL 
> is equal to the name of the remote.

This is a bit vague, a bit wrong, and it has the subjective "I" in it.  
remote_get() _is_ assumed to return NULL when no remote with that name was 
found.

And the function was fixed (3rd person, passive).  At least that is how I 
remember most of the rest of git.git's commit messages.

> diff --git a/remote.c b/remote.c
> index 91e3b11..62b3611 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -598,7 +598,7 @@ struct remote *remote_get(const char *name)
>  	}
>  	if (!ret->url)
>  		add_url_alias(ret, name);
> -	if (!ret->url)
> +	if (!strcmp(*ret->url,ret->name))
>  		return NULL;

Hmm.  That sounds very dangerous, using a pointer without checking that it 
is NULL.

Besides, I think that the add_url_alias(ret, name) above is at 
fault.  Not the alias part about it, though.  This used to be an add_url() 
from the conception of remote.c, but then it was only used for fetching.

I think the proper solution is to add a parameter, or a function, to force 
NULL if the remote did not exist.

Of course, this involves a careful review of the existing callers, to find 
out which ones rely on getting a newly created remote when none was found.

In any case, thank you very much for finding that bug (the if() I pointed 
out was in remote.c from the very beginning, even then never being 
triggered).

Ciao,
Dscho
