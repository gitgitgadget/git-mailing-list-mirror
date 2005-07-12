From: Junio C Hamano <junkio@cox.net>
Subject: Re: Why is there no git-update-cache --modified (aka I give up)
Date: Tue, 12 Jul 2005 01:14:24 -0700
Message-ID: <7v7jfwbfvj.fsf@assigned-by-dhcp.cox.net>
References: <20050712055218.GA18192@buici.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marc Singer <elf@buici.com>
X-From: git-owner@vger.kernel.org Tue Jul 12 10:15:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DsFui-0003GL-OD
	for gcvg-git@gmane.org; Tue, 12 Jul 2005 10:14:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261250AbVGLIO2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jul 2005 04:14:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261253AbVGLIO2
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jul 2005 04:14:28 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:49333 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S261250AbVGLIO0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2005 04:14:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050712081424.IQFN17043.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 12 Jul 2005 04:14:24 -0400
To: git@vger.kernel.org
In-Reply-To: <20050712055218.GA18192@buici.com> (Marc Singer's message of "Mon, 11 Jul 2005 22:52:18 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Marc Singer <elf@buici.com> writes:

>   # git-diff-cache HEAD
>
> is really nice.  But, do I really have to invoke git-update-cache with
> every modified file?  I could write a script to cul the filenames from
> git-diff-cache, but I'm having a hard time believing that that is how
> others are preparing their commits.

Me too.  By the way, I think you mean diff-files not
diff-cache.

I'd like to know how others do it, since this was the
first thing I automated when I started using GIT.  Having clear
distinction between cache (aka index file) and work tree files
and making user concious decision of when to and when not to
register/update index is what is quite different in GIT from
CVS, SVN and friends [*1*], and while I appreciate its
flexibility, it often ends up to be simply more typing (and to
certain degree more thinking which is not a bad thing) to the
user [*2*].

This snippet is essentially what I do to match the cache with
the current work tree [*3*]:

	case "$(git-ls-files --unmerged | sed -e 1q)" in
	?*)
		echo >&2 You have unmerged files and cannot commit.
        	exit 1
		;;
	esac
	git-update-cache --refresh >/dev/null
	git-diff-files |
        sed -e 's/.*	//' |
	xargs -r git-update-cache --add --remove --

[Footnote]

*1* I vaguely recall reading somewhere that GIT is not the first
SCM to have these three (not two) levels.  Usual two-level SCM
needs to only move between your hackery and what's in the repo,
and words like "committing" and "checking in" are used
interchangeably, while the other three level SCM (I do not
remember which one I read about) gives distinct meaning to these
two words.  Can anybody tell me which SCM I am talking about?

*2* The commit flow in GIT is three level thing.  You have HEAD
version (a commit with an associated tree already in the object
database that you have checked out and started with), you have
cache, and you have files in your work tree.  Checking out is to
match cache and work tree to HEAD; update-cache is to match
cache to work tree; and committing is to create a new commit
that matches the cache and make it your HEAD.  Roughly speaking,
diff-* brothers are about comparing these three stages:

 - diff-files compares cache and work tree
 - diff-cache compares commit and cache, or commit and work tree
 - diff-tree compares two commits

*3* I do not officially do Porcelain ;-), but the script I use
is slightly different from the one quoted above.  It uses
"git-diff-files -z" and a helper program to handle filenames
with TAB in them.
