From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH] Respect crlf attribute even if core.autocrlf has not been set
Date: Thu, 24 Jul 2008 20:53:35 +0400
Message-ID: <20080724165335.GW2925@dpotapov.dyndns.org>
References: <alpine.DEB.1.00.0807222255450.8986@racer> <7vy73tihl6.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0807230203350.8986@racer> <7vej5kfs0w.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 24 18:55:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KM45g-0006if-80
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 18:54:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752443AbYGXQxm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 12:53:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752205AbYGXQxm
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 12:53:42 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:13563 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753345AbYGXQxl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 12:53:41 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1447810fgg.17
        for <git@vger.kernel.org>; Thu, 24 Jul 2008 09:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=VxcfTA3hig2gqwzqUtEV8xtxd0MPkKFvZPi1fck9lwY=;
        b=RvgVrsXe4IVKRShovjT4UxGwC/cATj9+5grWlQtQ/gVfyqcDm8LIHcpdy/7nTVwF+O
         Wl06tIZO20qBEf3SBFUu5dAML4hM4vhXVzq3wbfSqEjYdZx51X3C7U/EGpiuPPqRsrL8
         55HV/AT4Yf6NQ4nM0wKxDCWBbmi1ejO2jO2LE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=bsGTpQpXehtpvKuNURxym82+iSRs+EzohzwokP/QSafi9b0da+PTGTayjpRfvn5+Ig
         a3JdBw2tIIvw4mUdcNHB+Zr6RSE6jlyM9LGHRjos9SwbKY5o9s5beYfoKZO0Dylc5KGm
         WjfuXcylEHxMPy8GW/PlwYqyzMDoF5OjrpSxE=
Received: by 10.86.70.11 with SMTP id s11mr1011232fga.79.1216918419280;
        Thu, 24 Jul 2008 09:53:39 -0700 (PDT)
Received: from localhost ( [85.140.170.251])
        by mx.google.com with ESMTPS id d6sm6586309fga.2.2008.07.24.09.53.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 24 Jul 2008 09:53:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vej5kfs0w.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89908>

On Wed, Jul 23, 2008 at 10:07:43AM -0700, Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > However, if you want to avoid CRs to _enter_ the repository, when you have 
> > a lot of binary files tracked, you _do_ want to force all repositories to 
> > crlf=input.
> 
> If you are on a sane system, you do not even want to pay the price of
> conversion. 

If you do not have CRLF then there will be no conversion, so you pay only
the price of check. The relative cost of that check obviously depends on
what other operations are. I believe that the worst case for this check
will be when there is no other operations, just re-reading files, so I
did:

# touch all files to force git re-read them...
git ls-files | xargs touch
time git status

Here is the average based on 3 attempts:
0.232s with autocrlf=false
0.265s with autocrlf=input (14% increase)

Of course, without touching files, git-status will take the same time in
both cases (about 0.026s in my testing), and touching all files not very
interesting from the practical point of view.

So, I decided to do something more practical, like applying 100 patches.
Here are my results:

         false     input
         ------   -------
         7.409s   7.603s
         7.592s   7.239s
         7.617s   7.402s
         ------   -------
Average: 7.539s   7.415s

autocrlf=input turned out to be even slightly faster, but the difference
is not statistically significant.

So, though it is obvious that autocrlf=input clearly adds some overhead,
I believe it is negligable in most practical cases as there are much
more expensive operations. And you can always turn autocrlf off, if you
are sure that you never have files with the wrong line ending.

> Only people on systems with CRLF line endings should pay the
> price (because your aim is to convert on such systems).

Unfortunately, it is not so clearly cut. Some people may work on Unix
but share files with Windows using network shares or emails.

> Are we throwing
> that out of the window when the project decides to use gitattributes?

I am not sure that I understand your question. In any case, Dscho's
patch did not change the default, so it did not penalize anyone except
explicitly asked about that by setting crlf on some files. I would like
also to notice that setting crlf on some files (in contrast to unsetting
it!) is rarely necessary in practice if all users have sane settings for
autocrlf.

> 
> How about setting autocrlf automatically on mingw/msys/cygwin versions,
> perhaps via templates or a patch to init-db?  Would that, combined with
> user education, be a viable alternative?

Perhaps, it is good compromise for now, considering that Windows users
have most troubles with that... I really don't mind seeing 'input' as
default on other platforms, but I won't insist on that.


Dmitry
