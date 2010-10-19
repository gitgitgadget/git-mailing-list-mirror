From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: RFC: [PATCH] ignore SIGINT&QUIT while waiting for external
 command
Date: Tue, 19 Oct 2010 20:31:24 +0400
Message-ID: <20101019163124.GB8065@dpotapov.dyndns.org>
References: <20101019045300.GA18043@gnu.kitenet.net>
 <AANLkTi=tvyzyz2xpezufHLFc44HDbtMibkhNEvYxPB2g@mail.gmail.com>
 <20101019115943.GA8065@dpotapov.dyndns.org>
 <20101019133236.GA804@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
	Joey Hess <joey@kitenet.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 19 18:39:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8FDV-0007Cd-6y
	for gcvg-git-2@lo.gmane.org; Tue, 19 Oct 2010 18:39:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755842Ab0JSQjE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Oct 2010 12:39:04 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:38609 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753402Ab0JSQjD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Oct 2010 12:39:03 -0400
Received: by pzk3 with SMTP id 3so415208pzk.19
        for <git@vger.kernel.org>; Tue, 19 Oct 2010 09:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=03OTQ/ob21nNsE/coAHspmtubs49yLBAp2WOyCXuMz8=;
        b=j2qgCHSu8qlQpQ7iRg1JzmCi7NItvXGLpEnVSqS+Euk4u9k2SXXaXKSe1KJbHZWQLv
         WCeajdIkUdzKtAFNu5CbOCVsTYW+XPG52vf9EzASmwHx0RcbUSRpqgjtPErV34VahrOb
         8yvQao1ytGZDqkWVYadWDTB+csQ+OpBVQn2ag=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=DZ/8jrazZ0Q0pGE5RwEcjVHKF8SQjVEwQoeAE0jCb+dcw34xvEoANyfjDqGzUOH5Ju
         tF4D40Z3dircGhX3nJI3arX+YKaMwqsYdfUzlQnvadkXyHoc7+xbqe/aK2eeFM+CvvWW
         60HNlReqP5s2HdLX/65322EJZQGbkPbVD2eq0=
Received: by 10.14.119.132 with SMTP id n4mr4060430eeh.4.1287505888402;
        Tue, 19 Oct 2010 09:31:28 -0700 (PDT)
Received: from localhost (ppp91-76-16-175.pppoe.mtu-net.ru [91.76.16.175])
        by mx.google.com with ESMTPS id q51sm10365025eeh.16.2010.10.19.09.31.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 19 Oct 2010 09:31:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101019133236.GA804@sigill.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159338>

On Tue, Oct 19, 2010 at 09:32:36AM -0400, Jeff King wrote:
> 
>   2. Why do we want to do it only for the proxy-command case? If I have
>      a long-running external diff or merge helper, for example, what
>      should happen on SIGINT? Should we exit with the child still
>      potentially running, or should we actually be reaping the child
>      properly?

Probably, it should be done in other cases too. However, I am not sure
if it should be done unconditionally. For instance, when we run a pager,
I don't think we should ignore the signals just because we started a
pager.

I agree that silent_exec_failure is not the best flag for that -- I was
just trying to make minimal changes to the existing behavior, and if
this flag is set, you seem always want to ignore these signals, but
there are some other cases too as you pointed above.

Now, I think we should always ignore these signals when run_command() is
used (similar to system()), but do not mask signals if start_command()
is used (or make it optional by adding a new flag).

> 
> we will overwrite the function pushed in the sigchain_push with a stale
> handler. I think you could just replace your signal() calls with:
> 
>   sigchain_push(SIGINT, SIG_IGN);
>   ...
>   sigchain_pop(SIGINT);

Yes, it is certainly better. I was not aware about these functions.


Dmitry
