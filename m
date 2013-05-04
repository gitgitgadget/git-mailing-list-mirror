From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2] remove the impression of unexpectedness when access
 is denied
Date: Fri, 3 May 2013 20:10:01 -0700
Message-ID: <20130504031001.GA3734@elie.Belkin>
References: <20120610182310.GB2427@book.hvoigt.net>
 <20120611190207.GA20889@sigill.intra.peff.net>
 <20120614071259.GA51076@book.hvoigt.net>
 <7v395xg6oh.fsf@alter.siamese.dyndns.org>
 <20120614203712.GA51783@book.hvoigt.net>
 <20120619182449.GA99957@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Sat May 04 05:10:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UYSrr-0005oO-Jl
	for gcvg-git-2@plane.gmane.org; Sat, 04 May 2013 05:10:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763464Ab3EDDKM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 May 2013 23:10:12 -0400
Received: from mail-pb0-f49.google.com ([209.85.160.49]:44332 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758921Ab3EDDKK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 May 2013 23:10:10 -0400
Received: by mail-pb0-f49.google.com with SMTP id rp8so1187755pbb.36
        for <git@vger.kernel.org>; Fri, 03 May 2013 20:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=XSCBt0DLgVXpLqWS5McJioUhzYc9Y/6+gqCrD9HcY4M=;
        b=WCfogQk5wLoGvopt8nGOKJnKYD2/QWDTW9m/qx/PH8JO0Bp4qCNWEWrSMEP0Cd3SF6
         Pi6qmgjsPnlNmmnOMVkzK94b/XP4qwl99CE0SG+DYLmeoVyt7GHgwKRmaV08STjxyivV
         J02Ja84C7vHeXQv9a56pCVB57ZGUywwX6QRMot+k+t42C//Gs83FUdaSJrBaLk0MLps3
         3aWq5qkKz53ZyasSXBA+qeEPHI/cI89XIS8sL2fPuZvWOtA1xyVHYjCzXtFKoirk0PGK
         NzJ6Yg64dgNtmPU7HXCwePBQHN7OlTb4/yR3vIAn5Tq00A9iTm9ybTDTuVVBb5e6rZep
         r0OQ==
X-Received: by 10.68.231.65 with SMTP id te1mr16490482pbc.98.1367637009787;
        Fri, 03 May 2013 20:10:09 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPSA id iy2sm13963895pbb.31.2013.05.03.20.10.07
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 03 May 2013 20:10:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120619182449.GA99957@book.hvoigt.net>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223351>

Hi,

Heiko Voigt wrote:

> --- a/connect.c
> +++ b/connect.c
> @@ -49,6 +49,16 @@ static void add_extra_have(struct extra_have_objects *extra, unsigned char *sha1
>  	extra->nr++;
>  }
>  
> +static void die_initial_contact(int got_at_least_one_head)
> +{
> +	if (got_at_least_one_head)
> +		die("The remote end hung up upon initial contact");
> +	else
> +		die("Could not read from remote repository.\n\n"
> +		    "Please make sure you have the correct access rights\n"
> +		    "and the repository exists.");
> +}
[...]

I ran into this message for the first time today.

 $ git fetch --all
 Fetching origin
 remote: Counting objects: 368, done.
[...]
 Fetching gitk
 fatal: Could not read from remote repository.

 Please make sure you have the correct access rights
 and the repository exists.
 error: Could not fetch gitk
 Fetching debian
 Fetching pape
[...]

The "gitk" remote refers to git://git.kernel.org/pub/scm/gitk/gitk.
Using ls-remote to contact it produces the same result.  The message
is correct: the repository does not exist.

Impressions:

 * Looking at "Could not read", it is not clear what could not read
   and why.  GIT_TRACE_PACKET tells me the interaction was

	me> git-upload-pack /pub/scm/gitk/gitk\0host=git.kernel.org\0
	them> (hangup)

   Would it make sense for the server to send an "ERR" packet to give
   a more helpful diagnosis?

 * The spacing and capitalization is odd and makes it not flow well
   with the rest of the output.  I suspect it would be easier to read
   with the error separated from hints:

	Fetching gitk
	fatal: the remote server sent an empty response
	hint: does the repository exist?
	hint: do you have the correct access rights?
	error: Could not fetch gitk
	Fetching debian

   If a server is misconfigured and just decides to send an empty
   response for no good reason, the output would still be true.

 * The error message is the same whether the server returned no
   response or an incomplete pkt-line.  Maybe in the latter case it
   should print the "hung up unexpectedly" thing.

Thoughts?

Jonathan
