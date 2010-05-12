From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: Advice on choosing git
Date: Wed, 12 May 2010 13:04:19 +0400
Message-ID: <20100512090418.GM14069@dpotapov.dyndns.org>
References: <4BEA4B46.6010009@smartmediacorp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Noah Silverman <noah@smartmediacorp.com>
X-From: git-owner@vger.kernel.org Wed May 12 11:04:32 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OC7rj-0002bK-Ju
	for gcvg-git-2@lo.gmane.org; Wed, 12 May 2010 11:04:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754352Ab0ELJE0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 May 2010 05:04:26 -0400
Received: from ey-out-2122.google.com ([74.125.78.24]:10602 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753929Ab0ELJEY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 May 2010 05:04:24 -0400
Received: by ey-out-2122.google.com with SMTP id d26so82229eyd.19
        for <git@vger.kernel.org>; Wed, 12 May 2010 02:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=wmOL5kXY9YW29nniIA1h8/a8AOlniZ4rnbjzWDh+BJU=;
        b=LwdqY+gkumpaTUvJstbgkGt868nR24aiPL1p6x/yxHEuRmJxe3AyjM5+5tlFjLjtZI
         1b7PwWwjkFIg+1vho7EWbIozy29P3ZsFYh26sf1ZWsjZDlIjLYsASIZgeWSWhEZvZAh6
         TE73REJzM/tcxXoKkiqxbEhOs3RIGl8Fy/zZc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=JUFniza5Vs0eM+WuRwztxyqV55fuCBgKrabp9nLGyu8lr7zmSnRl0ucuXerEXK+fSP
         tLIybGS12qnBOR01vMiib7pq3PcSUZSNg4Z0GINOQy7f4uo6B+BP2VF8TeQwZJhEADDf
         4n7xlHZ4VGXqpTqOsUBEA9XmA9kS2htBBGosA=
Received: by 10.103.125.13 with SMTP id c13mr4284085mun.81.1273655061954;
        Wed, 12 May 2010 02:04:21 -0700 (PDT)
Received: from localhost (ppp85-141-232-209.pppoe.mtu-net.ru [85.141.232.209])
        by mx.google.com with ESMTPS id j10sm29086099mue.48.2010.05.12.02.04.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 12 May 2010 02:04:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4BEA4B46.6010009@smartmediacorp.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146933>

On Tue, May 11, 2010 at 11:31:34PM -0700, Noah Silverman wrote:
> 
> 1) Size.  THIS IS MY MAIN CONCERN - If I want to sync my home, office,
> and server Document directories.  From what I have read, I will
> effectively have multiple copies of each item on my hard drive, thus
> eating up a lot of space (One of the "working file"and several in the
> .git directory.)

Usually, Git is more efficient in disk space than other DVCS, because
it uses packages to store files. In each package contains deltified
and then gzip data, and this deltification is done not only relatively
to direct ancestor but potentially any suitable candidate (there is some
heuristic to find best). But when you add a new file to the repository
then it is stored just gzip compressed inside .gzip/objects. Such files
are often referred as "loose" in Git documentation. When you have a lot
of loose objects then the garbage collector is activated and packs them
together. Obviously, you can run "git gc" that manually, or to configure
the condition what means too many loose objects.

Even those files that are stored as loose objects is never transfered
separately over network. When you pull or push, all required objects are
packed together in a single package, and this package is sent to the
other side. So, on the other side they will never stored as separate
files. But each push/pull can create a new package, if you have too many
small packages, git-gc will combine them into a single package.

However, if you have huge multi-media files, I am not sure how Git is
good at handling them. There were some improvements to Git recently,
and there is a clone of git that specifically focuses on this problem:
http://caca.zoy.org/wiki/git-bigfile
but I don't know much about it.

> several full versions of it on my machine.  This could be a problem for
> a directory with 100GB or more, especially on a laptop with limited hard
> drive space.  I know Subversion is a dirty word around here, but it
> seemed to only annotate and send the changes

Actually, Subversion is very inefficient in space usage (at least,
when I used it last time). I had a repository where subversion checkout
took much more space than git working tree and the whole repository with
all history combine! Obviously, a centralized VCS do not have to store
the whole history on each client, which saves space, but having the
whole history with you is very handy, and also it avoids the situation
where you have a single point of failure.

BTW, git allows to do a shallow clone to save space by not storying the
whole history (only the specified number of revisions), but I have never
used this feature, and it has some limitations.

> 
> 2) Sub-directory selection.  On my laptop, I only want a few
> sub-directories to be synced up.  I don't need my whole document tree,
> but just a few directories of things I work on.

Synchronization works on what you committed in your repository. At
this level, directories are completely irrelevant. Probably, you
want to have a separate repository for each sub-directory that you
want to synchronize separately, and then you can bundle them together
using git-submodules mechanism or trivial shell script that will
synchronize all of them.

In fact, the basic concept of Git is to treat a single repository
as whole. So, if you have some pieces that are irrelevant, it is
better to store them in separate repositories. It will improve
speed and possible disk usage, because deltifying will have easy
time to find related files, so compression will be better.

> 
> Bazaar also looks like a possible option, but I'm not sure it handles
> drive usage better.  Their website has a lengthy manifesto about how
> they're better than Git, but I don't have enough experience with either
> to make an informed decision.

Well, this manifesto sounds like written by a marketing guy, and it
compares Bazaar to rather old version of Git... So I am not going to
comment on it.

In fact, any meaningful comparison has to consider your workflow. Git
targets fully distributed workflow, which may even have hierarchy of
repositories, while Bazaar focus around more centralized solution and
close to what you have with Subversion. So, people who got used to a
centralized VCS may find Bazaar easier at the beginning, but IMHO,
Git is more flexible and when you learn basic principles everything
feels very natural.

In any case, your main concern was the size of the repository, and
even this marketing piece from Bazaar admits that Git is better at
saving disk space.

Here you can see some comparison of a repository size for Git,
Mercurial, Bazaar:
http://vcscompare.blogspot.com/2008/06/git-mercurial-bazaar-repository-size.html



Dmitry
