From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Git.pm: Don't return 'undef' in vector context.
Date: Sat, 17 Nov 2007 16:19:17 +0100
Message-ID: <200711171619.18141.jnareb@gmail.com>
References: <473D3593.9080806@zwell.net> <fhjl70$db4$1@ger.gmane.org> <473E5E08.2090609@zwell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>, Git Mailing List <git@vger.kernel.org>
To: Dan Zwell <dzwell@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 17 16:19:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ItPSO-0002DJ-Tt
	for gcvg-git-2@gmane.org; Sat, 17 Nov 2007 16:19:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753243AbXKQPTY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Nov 2007 10:19:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752130AbXKQPTY
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Nov 2007 10:19:24 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:52685 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752123AbXKQPTW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Nov 2007 10:19:22 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1050248nfb
        for <git@vger.kernel.org>; Sat, 17 Nov 2007 07:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=DGIfXxcGZC5cVR6f6/oHM/bm/WtVBpKAJ7+85wOaUAM=;
        b=Vl+9ocBuvbuFtvqM3wYCn6rUuPShX9SNbv8wtsWHpdmHtbLSGfV4oDbZFXChmbfRyea8GIAhK1osIvvN/mcEucLQGRgOiA//4090q27zOK7jkqeO39241hHLYdb7hLjdNqoj9rKXb0XTJxarQHSfg/s+IUCUfHunjMxUOEka95s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=lcD9V959PQdAGxLwyXiYA3X7NAQATjtAkQR3UG4UaHpX83+E6uBkKUd+GKDYEpP0sBcALMs0YILubmYiFzQ04reK0SBzaCVdzA29guX87ON0sdJv4A/EUrhGxV1zISiyJ8J6dnXQyDrsCaoSZ4m2iAGqNKejkYoM4kvvZ79fcnU=
Received: by 10.86.68.20 with SMTP id q20mr2974748fga.1195312761270;
        Sat, 17 Nov 2007 07:19:21 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.236.102])
        by mx.google.com with ESMTPS id 12sm4325576fgg.2007.11.17.07.19.19
        (version=SSLv3 cipher=OTHER);
        Sat, 17 Nov 2007 07:19:20 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <473E5E08.2090609@zwell.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65283>

On Saturday, 17 November 2007, Dan Zwell wrote:
> Jakub Narebski wrote:
> > 
> > By the way, what do you think about changing Git.pm config handling
> > to the 'eager' one used currently by gitweb, namely reading all the
> > config to hash, and later getting config values from hash instead of
> > calling git-config? Or at least make it an option?
> > 
> 
> That seems appropriate, though it may be a slight trade-off between 
> complexity and efficiency. I don't think it's strictly necessary, at 
> least for git-add--interactive. 

On one hand it adds a bit of complexity, as you have to check if
config was parsed (and either parse, as it is done now in gitweb,
or perhaps fallback on calling git-config per variable), and you
have to do type checking / conversion to bool and int (size suffixes!)
in Perl, and deal with single-value and multi-value variables.
 
On the other hand I think that error handling will be simplier.

>                                 My experience is that the nine calls to  
> config() (that I am adding) do not slow down the program from a user 
> perspective (though I haven't tested on a slower computer).

The problem is not so much with a slower computer, as operating
systems with inefficient, slow fork implementation, like MS Windows
and (if I remember) correctly MacOS X.

But it is true that the config() performance is needed less for desktop
(commands like git-add--interactive) than for web (gitweb for example).

> The big reason to do it would be if you wanted to convert gitweb to use 
> the standard config() call from Git.pm. Because right now, config() 
> isn't efficient, but it probably doesn't need to be.

There are two reasons against convering gitweb to use Git.pm, at least
for now.

First, it makes installing gitweb harder, as one would have to install
(and perhaps compile) Git.pm to use gitweb. It would add additional
dependency. But perhaps this is not as much a problem as I think...

Second, gitweb code contain in few places pipelines (e.g. tar.gz and
tar.bz2 snapshot pipelines); even if some of them can be eliminated,
some will be added (syntax highlighting in blob view). Git.pm doesn't
as of yet support this...


It would be nice if Git.pm could take advantage of libification project,
and git have fast bindings not only for Python but also for Perl. If I
remember correctly the early attempts to use "git library" directly
were abandoned becaue they were not sufficiently portable, and the
fallback-to-Perl idea was thought too complex to implement...

-- 
Jakub Narebski
Poland
