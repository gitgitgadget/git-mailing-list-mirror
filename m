From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 4/5] Log ref updates made by fetch.
Date: Fri, 19 May 2006 00:56:10 -0700
Message-ID: <7vodxuih2d.fsf@assigned-by-dhcp.cox.net>
References: <20060519072926.GE22257@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 19 09:56:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgzqN-000290-7A
	for gcvg-git@gmane.org; Fri, 19 May 2006 09:56:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932147AbWESH4N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 May 2006 03:56:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932160AbWESH4N
	(ORCPT <rfc822;git-outgoing>); Fri, 19 May 2006 03:56:13 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:40152 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932147AbWESH4M (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 May 2006 03:56:12 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060519075611.DOBW9215.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 19 May 2006 03:56:11 -0400
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060519072926.GE22257@spearce.org> (Shawn Pearce's message of
	"Fri, 19 May 2006 03:29:26 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20335>

Shawn Pearce <spearce@spearce.org> writes:

> diff --git a/refs.c b/refs.c
> index 31cf276..d3ddc82 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -142,6 +142,8 @@ static int do_for_each_ref(const char *b
>  			namelen = strlen(de->d_name);
>  			if (namelen > 255)
>  				continue;
> +			if (namelen>5 && !strcmp(de->d_name+namelen-5,".lock"))
> +				continue;
>  			memcpy(path + baselen, de->d_name, namelen+1);
>  			if (stat(git_path("%s", path), &st) < 0)
>  				continue;

Now this got me worried.  Until now I did not realize that we
are clobbering refnames that ends with ".lock" if another ref
with the name without ".locK" is updated.  Because we do not
forbid a name that ends with ".lock" to be used as a refname,
this is an accident waiting to happen.

Not your fault, though.  It was like this ever since the initial
version of refs.c was accepted by Linus.

We could do one of two things: officially forbid any refname
that ends with ".lock", or fix the lockfile naming convention.

Nobody should be relying on what the actual lockfile-to-be-
renamed-to-become-the-real-file is called.  I suspect we would
want to fix refs.c::ref_lock_file_name() to use a name that
would never be used as a refname.

We could make it begin with ".", so the lock file for the master
".git/refs/heads/master" would become ".git/refs/heads/.master",
for example.  That way, we cannot clobber a valid unrelated ref
(".master" is not a valid ref name), and as an added bonus, you
do not even have to have the above hunk.

Hmm?
