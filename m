From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [long] worktree setup cases
Date: Wed, 20 Oct 2010 14:07:09 -0500
Message-ID: <20101020190709.GB10537@burratino>
References: <20101020085859.GA13135@do>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, fbriere@fbriere.net, drizzd@aon.at,
	575917@bugs.debian.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 20 21:10:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8e3v-0002dL-4F
	for gcvg-git-2@lo.gmane.org; Wed, 20 Oct 2010 21:10:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754531Ab0JTTKy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Oct 2010 15:10:54 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:40911 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753291Ab0JTTKx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Oct 2010 15:10:53 -0400
Received: by wwf26 with SMTP id 26so1547293wwf.1
        for <git@vger.kernel.org>; Wed, 20 Oct 2010 12:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=TY5YwUYxWKQLZYieibYMSF6PI5TN1kspijpWtmoMF84=;
        b=FaS85bi21C86oXIytMSwmNFzTV5RMkyJJlgtXArNqfCR1KhiAxkAqoTcn6K5XVptwm
         mnIOHJgWXxIcDQ3rmDX+vH3+8mGv4baC3FuQSc+sYPNhAXgMkj+vDm/NMKqbTYw83sZn
         NUlQwz0d2w4GbCEtdNJCCLEmtkzCiaF+Wuwbo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=hiVK4KjXilYc2N89it7yhOzCXnbGEr9rXh6l/qEqD3Y66SiB9LBjUASnCtRV4UzuN8
         pHQgjPo4kMPge6zn+lEMoIYuSWe+ksPs5aVohjtYfkTlkCHYFihnjGw/8HR87XZjnFyv
         zwuRA+PhETy5ld+HwokMz4zceWc2VvX+3B3io=
Received: by 10.216.239.200 with SMTP id c50mr8634332wer.63.1287601852297;
        Wed, 20 Oct 2010 12:10:52 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id e56sm419019wer.22.2010.10.20.12.10.50
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 20 Oct 2010 12:10:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101020085859.GA13135@do>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159423>

Nguyen Thai Ngoc Duy wrote:

> 1. When .git is a file and contains a relative path, I assume it is
>    relative to .git file's parent directory.  read_gitfile_gently()
>    function will make the path absolute, but it depends on (maybe
>    wrong) cwd.

Yep.

> 2. Relative path is preferred over absolute path.

I'm tempted to say: let's use absolute paths where it's more
convenient.  They can be changed to relative paths as an afterthought
after the bugs are gone.

Relative paths have two big advantages over absolute paths,
which are avoiding path traversal overhead and allowing paths
longer than PATH_MAX.  Supporting the latter consistently
would presumably require using openat() and co, though.

> 3. core.worktree is overidden by GIT_WORK_TREE

Yeah.

> So there are 2^5 = 32 cases in total. Let's look at them one by
> one.

Thanks!  To summarize (and make sure I understand correctly):
anything not following the below rules is a bug, yes?

A. Weird cases.

 - using a .git file is just like setting GIT_DIR;
 - setting core.worktree is just like setting GIT_WORK_TREE.

B. Repository search.

 - if GIT_DIR was set explicitly, GIT_WORK_TREE defaults to
   "." (for legacy reasons).

 - otherwise, if original cwd was under repository, it will not
   prompt a search for work tree, even if the repo happens
   to be named ".git" or core.bare is false.  That is, in
   this case, GIT_WORK_TREE defaults to unset.

 - otherwise, if original cwd was under a directory containing
   repository as ".git", GIT_WORK_TREE defaults to that
   directory (i.e., parent to .git dir).

 - otherwise, there is no repository.  GIT_DIR is unset,
   GIT_WORK_TREE defaults to unset.

C. Working directory and prefix

 - if GIT_WORK_TREE is still unset after repository search,
   stay in the original cwd, prefix = NULL.

 - if original cwd is inside worktree, chdir to toplevel,
   prefix = path to original cwd.

 - otherwise, stay in the original cwd, prefix = NULL.

D. User-supplied relative paths.

 - path in .git file is relative to containing directory
 - path in GIT_DIR is relative to original cwd
 - paths in GIT_WORK_TREE and core.worktree are relative to
   $GIT_DIR
 - paths passed to git commands are generally relative to
   original cwd

E. Internally used relative paths.

 - all paths are relative to current cwd.
