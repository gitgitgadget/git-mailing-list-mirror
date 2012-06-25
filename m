From: Marcin Owsiany <marcin@owsiany.pl>
Subject: Re: [PATCH/RFC] git-svn: don't create master if another head exists
Date: Mon, 25 Jun 2012 08:53:35 +0100
Message-ID: <20120625075335.GN3125@beczulka>
References: <20120624220835.GA4762@beczulka>
 <7v8vfchrmu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 25 10:05:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sj4IU-0004kB-J4
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jun 2012 10:05:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751293Ab2FYIFQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jun 2012 04:05:16 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:44081 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751088Ab2FYIFO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2012 04:05:14 -0400
Received: by weyu7 with SMTP id u7so2596451wey.19
        for <git@vger.kernel.org>; Mon, 25 Jun 2012 01:05:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent
         :x-gm-message-state;
        bh=xWXrbKGcraJAXHlHqYNeJo9jWWn0g+gCmfsi1heIiVI=;
        b=pYUXg5dNaw+51U2ZBZx6dRt+OxOU4bqzSZfRNEKtoa7J8+Oc8+k1gouQjyDSY8RbZh
         ZleoCzomCOAaJuUrw+Gs1MWvPXkRmuFPqxpUhinnllYz0Eb/RqmpgWZsDtbrltXF/uLw
         4e11BeTgcrgZJ9YeyV0rSEZ4XyzND2NKWmOC+Go+zxj9eXQkxKWmgizqlWyznn6RtZNE
         PYzpeAPDjKQ0NvRINecRWGYNM6++w5DmED/kTv/JCfb/aZpR3xz7I0oZKoFbAes+Rad8
         UVIfesUuIuNkiVCBfWt+Q1uAqKYv4XFmeyPCOVNDGtzlAb5g+0eiIRsJnGndIg9JkhwU
         2QBA==
Received: by 10.216.202.14 with SMTP id c14mr6308641weo.63.1340611513210;
        Mon, 25 Jun 2012 01:05:13 -0700 (PDT)
Received: from beczulka (dhcp-172-26-143-156.dub.corp.google.com [172.26.143.156])
        by mx.google.com with ESMTPS id bc2sm31480414wib.0.2012.06.25.01.05.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 25 Jun 2012 01:05:12 -0700 (PDT)
Received: from mowsiany by beczulka with local (Exim 4.71)
	(envelope-from <marcin@owsiany.pl>)
	id 1Sj475-0006em-27; Mon, 25 Jun 2012 08:53:35 +0100
Content-Disposition: inline
In-Reply-To: <7v8vfchrmu.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Gm-Message-State: ALoCoQk6gkp35DSswQi0EOlMrM/Wll+kPLotD45YDb7xlFjM3jqnmuwh6zXuCP7qxg9zGszI9ffw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200558>

On Sun, Jun 24, 2012 at 10:44:57PM -0700, Junio C Hamano wrote:
> Marcin Owsiany <marcin@owsiany.pl> writes:
> 
> > git-svn insists on creating the "master" head (unless it exists) on every
> > "fetch". While it is useful that it gets created initially (users expect this
> > git convention), some users find it annoying that it gets recreated, especially
> > when they would like the git branch names to follow SVN repository branch
> > names. More background in
> > http://thread.gmane.org/gmane.comp.version-control.git/115030
> >
> > Make git-svn skip the "master" creation if there is another head ref pointing
> > to the same place. This means "master" does get created on initial "clone" but
> > does not get recreated once a user deletes it.
> >
> > Signed-off-by: Marcin Owsiany <marcin@owsiany.pl>
> > ---
> >  git-svn.perl |    2 ++
> >  1 files changed, 2 insertions(+), 0 deletions(-)
> >
> > diff --git a/git-svn.perl b/git-svn.perl
> > index 0b074c4..90f3d06 100755
> > --- a/git-svn.perl
> > +++ b/git-svn.perl
> > @@ -1613,6 +1613,8 @@ sub post_fetch_checkout {
> >  	}
> >  
> >  	my $valid_head = verify_ref('HEAD^0');
> > +	my @heads_commits = eval { command(qw(show-ref --heads --hash)) };
> > +	return if $valid_head and grep { $_ eq $valid_head } @heads_commits;
> 
> This is strange.  Much earlier in the code there is this use of
> master.
> 
>     sub post_fetch_checkout {
>             return if $_no_checkout;
>             my $gs = $Git::SVN::_head or return;
>             return if verify_ref('refs/heads/master^0');
> 
> If your goal is to get rid of "master" (because you have a different
> branch that serves the role of the primary branch), shouldn't this
> code be killed?  Otherwise, if you have a stray "master" that you
> are not even using, you would end up skipping checkout for your true
> primary branch, no?

This is my first attempt at modifying git code and I don't pretend to
understand everything this function does. Even less obvious to me is why
it does that. E.g. "return if ($valid_head || ..." - skips the checkout
if HEAD was pointing at tip of _any_ branch, right? But why?

So I'm just trying to change as little as possible.

-- 
Marcin Owsiany <marcin@owsiany.pl>              http://marcin.owsiany.pl/
GnuPG: 2048R/02F946FC  35E9 1344 9F77 5F43 13DD  6423 DBF4 80C6 02F9 46FC

"Every program in development at MIT expands until it can read mail."
                                                              -- Unknown
