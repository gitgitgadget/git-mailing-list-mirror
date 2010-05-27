From: Marko Kreen <markokr@gmail.com>
Subject: Re: [PATCH] compat: Add another rudimentary poll() emulation
Date: Thu, 27 May 2010 16:29:53 +0300
Message-ID: <AANLkTil_dqbXChKpMJ_ZFTuNrF8tQRwJd5j4SkLOaPaJ@mail.gmail.com>
References: <1274948384-167-1-git-send-email-abcd@gentoo.org>
	<1274948384-167-2-git-send-email-abcd@gentoo.org>
	<20100527101043.GA4390@progeny.tock>
	<AANLkTikYa2vq4PrKrO2QIkHVxYqbhUZRw42kQq875FNT@mail.gmail.com>
	<AANLkTikezlVaX8ARkRw8kEk9wL9RL_5I6X3vK83nzFUl@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Jonathan Callen <abcd@gentoo.org>, git@vger.kernel.org,
	mduft@gentoo.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Johannes Sixt <j6t@kdbg.org>,
	msysGit <msysgit@googlegroups.com>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Thu May 27 15:30:00 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHd9r-0008E5-Q0
	for gcvg-git-2@lo.gmane.org; Thu, 27 May 2010 15:30:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755342Ab0E0N3z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 May 2010 09:29:55 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:45894 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755125Ab0E0N3y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 May 2010 09:29:54 -0400
Received: by gwaa12 with SMTP id a12so1940647gwa.19
        for <git@vger.kernel.org>; Thu, 27 May 2010 06:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=TTwh9KbbWdRYV7D6Sdf+Pz+oCi9jz+CBI+MhOOOqIbE=;
        b=vZFMGnqUVHupVYEDF7l7eJDwiYARy+lUde8wHLrKJXoLXz50qGi5twh74qJphb6QDx
         1Ct7WKCDH+mRIwVmNFTVwjLxEuXONW1l7OMnBs0m7PDp2UqZBq1kpP0t9J8ijt9yASy6
         WKZBJw51f1JfB4UjIzFleEB5o9fLalh3Svf8Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=SWPKWAjfFdgqSFrtLF6y3fmJI2hh5SZr6jPrssX3IrpQUWXIgxG/pqTCPxiVjS34zM
         hekqJNpbsNfK9y13ALSRUEdL0eCmdN3eZPknd5/jB8gxS/rxVbKL81gU2Aw7v/sT1z5e
         aQg+6nQp4GjOxi8+KSnDNQZR3MTbLbR3bqKKM=
Received: by 10.150.66.15 with SMTP id o15mr109169yba.435.1274966993080; Thu, 
	27 May 2010 06:29:53 -0700 (PDT)
Received: by 10.151.48.11 with HTTP; Thu, 27 May 2010 06:29:53 -0700 (PDT)
In-Reply-To: <AANLkTikezlVaX8ARkRw8kEk9wL9RL_5I6X3vK83nzFUl@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147853>

On 5/27/10, Erik Faye-Lund <kusmabite@googlemail.com> wrote:
> On Thu, May 27, 2010 at 1:00 PM, Erik Faye-Lund
>  <kusmabite@googlemail.com> wrote:
>  > On Thu, May 27, 2010 at 12:10 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>  >> Implement the subset of poll() semantics needed by git in terms of
>  >> select(), for use by the Interix port.  Inspired by commit 6ed807f
>  >> (Windows: A rudimentary poll() emulation, 2007-12-01).
>  >>
>  >
>  > A possible problem with this approach is that the maximum number of
>  > file descriptors poll can handle limited by RLIMIT_NOFILE, whereas the
>  > maximum number of file descriptors select can handle is limited by
>  > FD_SETSIZE.
>  >
>  > I don't think this is a big problem in reality, though - both values
>  > seem to be pretty high in most implementations. And IIRC git-daemon is
>  > the only one who needs more than 2, and it doesn't even check
>  > RLIMIT_NOFILE.
>  >
>
>
> To be clear: I think this strategy is the best option (at least for
>  non-Windows, where select() might be our only option).
>
>  But perhaps you should include a check along the lines of this:
>
>  if (nfds > FD_SETSIZE)
>         return errno = EINVAL, error("poll: nfds must be below %d", FD_SETSIZE);
>
>  Just so we can know when the code fails :)

Well, per your own FD_SET example, the FD_SETSIZE on windows
means different thing than FD_SETSIZE on old-style bitmap-based
select() implementation.

On Unix, it's max fd number + 1, on windows it's max count.

Thus on windows the nfds can safely be larger than FD_SETSIZE,
assuming the actual count is smaller.



RLIMIT_NOFILE - I don't see why it is relevant here, as you
get error on open() when you cross the limit.  So how can you
pass more than that meny fds to select()/poll()?

-- 
marko
