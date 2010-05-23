From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH] setup: do not change to work tree prematurely
Date: Sun, 23 May 2010 11:14:42 +0200
Message-ID: <20100523091442.GA8128@localhost>
References: <20100523000719.GA32380@localhost>
 <20100523013539.GA14403@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?iso-8859-1?B?RnLpZOlyaWMgQnJp6HJl?= <fbriere@fbriere.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 23 11:14:57 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OG7Go-0003VN-HJ
	for gcvg-git-2@lo.gmane.org; Sun, 23 May 2010 11:14:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753014Ab0EWJOu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 May 2010 05:14:50 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:58119 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751441Ab0EWJOs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 May 2010 05:14:48 -0400
Received: by fxm5 with SMTP id 5so1780576fxm.19
        for <git@vger.kernel.org>; Sun, 23 May 2010 02:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=u5L8pLxP6YZNzINEsxIXkQk2/4Q9APD1W5I6UVzEkcc=;
        b=JKCdfviYnyhf0cXJ+hCA4NwwzQvoxDJTY2JJFhOfDQbKrC6Qgg47KV5LCJIgJUoX37
         2iSYJ6f36cvdCHAgNuXDs8Vn5MqNCWSmm4w1CsSb77MZUr2GvvuL1MESU7ttlTwEE9jU
         hHd34sybwMDBstt7sUCX2ifhQP+niiJrrFf5o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:bcc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=atO1p7GxMWTwYkY2PGhWv2k1dloB4SqXUKW/tHFNjfNQgatWrtifI1ODCGNK5iULRY
         er72gxN+qsSNkdz8KHmDR1SReOZ24v58HuXN8dt5XrrXpGB9R7KUwuNdCxt1DxDkcb2L
         cyoY7KOl88rkRGExKJoErNq1+14xFunz6z6R4=
Received: by 10.223.100.141 with SMTP id y13mr3567188fan.15.1274606087208;
        Sun, 23 May 2010 02:14:47 -0700 (PDT)
Received: from darc.lan (p549A5187.dip.t-dialin.net [84.154.81.135])
        by mx.google.com with ESMTPS id z12sm13679309fah.9.2010.05.23.02.14.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 23 May 2010 02:14:46 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1OG7Gc-0003z3-PI; Sun, 23 May 2010 11:14:42 +0200
Content-Disposition: inline
In-Reply-To: <20100523013539.GA14403@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147559>

On Sat, May 22, 2010 at 08:35:39PM -0500, Jonathan Nieder wrote:

> Without your patch applied, I get
> 
>  $ cd .git
>  $ git --work-tree=/tmp/git symbolic-ref HEAD
>  refs/heads/hello
> 
> I should have done the following instead:
> 
>  $ worktree=$(pwd)
>  $ cd .git
>  $ git --work-tree="$worktree" symbolic-ref HEAD
>  fatal: ref HEAD is not a symbolic ref

Thanks

> > +char *get_relative_path(char *cwd, const char *dir)
> 
> Looks reasonable.  Should be const char *cwd.

That is not possible, because we return a pointer to cwd plus an
offset, which will be subsequently modified by strcat().

> > diff --git a/setup.c b/setup.c
> > index 5716d90..67b5122 100644
> > --- a/setup.c
> > +++ b/setup.c
> > @@ -524,14 +524,18 @@ const char *setup_git_directory(void)
> > 	const char *retval = setup_git_directory_gently(NULL);
> >  
> >  	/* If the work tree is not the default one, recompute prefix */
> >  	if (inside_work_tree < 0) {
> 
> If I understand correctly, you made two changes here:
> 
>  - interpret GIT_WORK_TREE and friends relative to .git instead of
>    the original cwd (by not calling chdir(retval) before
>    get_git_work_tree())

Oops

>  - make setup_git_directory stay in the last directory searched for a
>    .git directory instead of chdir-ing into the toplevel of the work tree.
>
> Are these safe changes to make?

Indeed, if you put it that way, this change does not look good.
Maybe I'll have a look at Nguyen's patches.

> diff --git a/t/t1501-worktree.sh b/t/t1501-worktree.sh
> index 9df3012..93bf92c 100755
> --- a/t/t1501-worktree.sh
> +++ b/t/t1501-worktree.sh

Thanks
