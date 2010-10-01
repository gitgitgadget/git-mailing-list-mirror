From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v2 1/2] sh-setup: Write a new require_clean_work_tree
 function
Date: Fri, 1 Oct 2010 10:27:16 +0530
Message-ID: <20101001045713.GE20098@kytes>
References: <1285877017-8060-1-git-send-email-artagnon@gmail.com>
 <1285877017-8060-2-git-send-email-artagnon@gmail.com>
 <7v4od7hsqt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Joshua Jensen <jjensen@workspacewhiz.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 01 06:58:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1XhZ-0007Ts-57
	for gcvg-git-2@lo.gmane.org; Fri, 01 Oct 2010 06:58:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751214Ab0JAE6W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Oct 2010 00:58:22 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:43189 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750864Ab0JAE6V (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Oct 2010 00:58:21 -0400
Received: by iwn5 with SMTP id 5so3343402iwn.19
        for <git@vger.kernel.org>; Thu, 30 Sep 2010 21:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=RCtuGyuGzyoAtQnAWxH1erF2fj7Alywvp4C5zXlWA24=;
        b=GJ1uxEbxuqq3xbsgJuOVfjc4qJecudiF0UxNedd/eBY8+KoeAz71i6zyQsT28J54ZN
         uHHRw55DJmmVnoVdHUqARbXtaxtgZiEdH/hjz2L4CVnM/Ojz9XJ/Y9HFpdyA5oy4GWjo
         5Nj2EkcDY1h9TziaJJl0HDgNq3pZPcTeDNyys=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=lh4KUuUFB+BJCu7IpWjHJ2vq6It6vTeJr6ERbPvbS5JQr87QSlMkmpEwwQ/v3UF5O/
         Z34hcubkyZP9A6Sq3HE/MWq0+8+kQre7dCJAeEPYsCa7RXFPTXmwIt6CvyQPPkQn0PJC
         Sx6VaozO9+PTGKzbJwWOnCMZKu3ceRYUaa3yQ=
Received: by 10.231.150.7 with SMTP id w7mr5030378ibv.14.1285909100305;
        Thu, 30 Sep 2010 21:58:20 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id g31sm714904ibh.22.2010.09.30.21.58.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 30 Sep 2010 21:58:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v4od7hsqt.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157729>

Hi Junio,

Thanks for the review.

Junio C Hamano writes:
> > Write a new require_clean_work_tree function to error out when
> > unstaged changes are present in the working tree and (optionally)
> > uncommitted changes in the index.
> >
> > Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
> > Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> 
> Please don't do this in-body "Cc:"; it is meaningless.

Oh. What I intended to say was that Matthieu reviewed my previous
iteration- should I just put that information in the cover letter or
is there some other notation I should use? I can't use "Reviewed-by"
either because he only reviewed the previous iteration- not this one.

> > ---
> >  git-sh-setup.sh |   28 ++++++++++++++++++++++++++++
> >  1 files changed, 28 insertions(+), 0 deletions(-)
> >
> > diff --git a/git-sh-setup.sh b/git-sh-setup.sh
> > index 6131670..215ec33 100644
> > --- a/git-sh-setup.sh
> > +++ b/git-sh-setup.sh
> > @@ -145,6 +145,34 @@ require_work_tree () {
> >  	die "fatal: $0 cannot be used without a working tree."
> >  }
> >  
> > +require_clean_work_tree () {
> > +	# Update the index
> > +	git update-index -q --ignore-submodules --refresh
> > +	err=0
> > +
> > +	# Disallow unstaged changes in the working tree
> > +	if ! git diff-files --quiet --ignore-submodules --
> 
> What is that trailing double-dash about?

Hm, I think I got confused between the options that git-diff-index and
git-diff-files take. I'll get rid of this in the next iteration.

> > +	then
> > +		echo >&2 "cannot $1: you have unstaged changes."
> > +		git diff-files --name-status -r --ignore-submodules -- >&2
> > +		err=1
> > +	fi
> > +
> > +	# Disallow uncommitted changes in the index
> > +	if ! git diff-index --cached --quiet HEAD --ignore-submodules --
> 
> Do not write HEAD there that sets a wrong example; the command line
> arguments are flag-options, revs, double-dash and pathspec.

Ok. I suppose `git diff-index --cached --quiet --ignore-submodules
HEAD --` is better. Should I keep the double-dash or is it
unnecessary?

> Contrary to what your proposed log message says, I do not see anything
> "optional" in the way how this check is done here...  What is going on?

Oops, sorry about that -- it's a slightly dated log message: While
writing the patch, I thought I'd be clever and pass a `$2` to make
this optional, but decided against it later.

> Unfortunately we cannot judge if unconditional check is the right thing to
> do without looking at the callers; why did you make this into two-patch
> series?

Oh, ok. I'll make it a single patch in the next iteration.

> Mental note before reviewing the second patch: do all callers want the
> same "both working tree and index are spiffy clean" check?

Not necessarily, but I figured that many of them want it.

> > +	then
> > +		echo >&2 "cannot $1: your index contains uncommitted changes."
> > +		git diff-index --cached --name-status -r --ignore-submodules HEAD -- >&2
> > +		err=1
> > +	fi
> > +
> > +	if [ $err = 1 ]
> > +	then
> > +	    echo >&2 "Please commit or stash them."
> > +	    exit 1
> > +	fi
> > +}
> 
> Mental note before reviewing the second patch: warning/error messages from
> this codepath are all written without warning: or error: prefixes.

As you've pointed out in the second patch, it's probably not a good
idea to print out the advice here.

-- Ram
