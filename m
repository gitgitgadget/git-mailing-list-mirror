From: Kyle Hayes <kyle@marchex.com>
Subject: Re: [patch] fixup GECOS handling
Date: Fri, 22 Apr 2005 09:16:39 -0700
Organization: Marchex Inc.
Message-ID: <1114186599.31076.409.camel@axer.marchex.com>
References: <1113820589.16288.5.camel@nosferatu.lan>
	 <1113827713.5286.13.camel@localhost.localdomain>
	 <1114179795.29271.18.camel@nosferatu.lan>
Reply-To: kyle@marchex.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing Lists <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 22 18:13:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DP0lm-0002IK-1q
	for gcvg-git@gmane.org; Fri, 22 Apr 2005 18:12:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262054AbVDVQRO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Apr 2005 12:17:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262056AbVDVQRO
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Apr 2005 12:17:14 -0400
Received: from peer.sef.marchex.com ([66.150.8.204]:21765 "HELO
	nosecone.marchex.com") by vger.kernel.org with SMTP id S262054AbVDVQQl
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2005 12:16:41 -0400
Received: (qmail 68733 invoked from network); 22 Apr 2005 16:16:39 -0000
Received: from unknown (HELO axer.marchex.com) (10.101.11.64)
  by nosecone.marchex.com with SMTP; 22 Apr 2005 16:16:39 -0000
To: azarah@nosferatu.za.org
In-Reply-To: <1114179795.29271.18.camel@nosferatu.lan>
X-Mailer: Evolution 2.0.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, 2005-04-22 at 16:23 +0200, Martin Schlemmer wrote:
> Hi,
> 
> This still applies - any reason for not doing this?

Seems like this will break on certain kinds of data.  See below.

>         if (!pw)
>                 die("You don't exist. Go away!");
>         realgecos = pw->pw_gecos;
> +       /* The name is seperated from the room no., tel no, etc via [,;] */
> +       if (strchr(realgecos, ','))
> +               *strchr(realgecos, ',') = 0;
> +       else if (strchr(realgecos, ';'))
> +               *strchr(realgecos, ';') = 0;
>         len = strlen(pw->pw_name);
>         memcpy(realemail, pw->pw_name, len);
>         realemail[len] = '@';

Suppose that the GECOS field is:

Hayes, Kyle; Room 42; 424-424-4242; foo bar baz...

You'll search for the first comma, find it, truncate my name to "Hayes",
and continue.

I have seen this kind of GECOS in larger environments where the
individual users are not the ones that administrate their machines.
Using the LastName, FirstName style of name is not rare. 

I think you want something like this (not tested):

char *comma,*semi;

comma = strchr(realgecos,',');
semi  = strchr(realgecos,';');

if(comma)
	if(semi)
		/* lastname, firstname; room #; phone # format */
		*semi  = 0;
	else
		*comma = 0;
else if(semi)
	*semi = 0;

(hopefully Evolution won't trash the indentation...)

Best,
Kyle

-- 
Kyle Hayes <kyle@marchex.com>
Marchex Inc.

