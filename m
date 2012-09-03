From: Konstantin Khomoutov <flatworm@users.sourceforge.net>
Subject: Re: Clone to an SSH destination
Date: Mon, 3 Sep 2012 15:47:32 +0400
Message-ID: <20120903154732.5fb50b173fa51db8300624b3@domain007.com>
References: <alpine.LFD.2.01.1209031059480.4753@sys880.ldn.framestore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Mark Hills <Mark.Hills@framestore.com>
X-From: git-owner@vger.kernel.org Mon Sep 03 13:48:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T8V8L-0006Uk-VF
	for gcvg-git-2@plane.gmane.org; Mon, 03 Sep 2012 13:48:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756362Ab2ICLrw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Sep 2012 07:47:52 -0400
Received: from mailhub.007spb.ru ([84.204.203.130]:37849 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756335Ab2ICLrw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Sep 2012 07:47:52 -0400
Received: from programmer.Domain007.com (programmer.domain007.com [192.168.2.100])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with SMTP id q83BlWTB031297;
	Mon, 3 Sep 2012 15:47:34 +0400
In-Reply-To: <alpine.LFD.2.01.1209031059480.4753@sys880.ldn.framestore.com>
X-Mailer: Sylpheed 3.2.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204688>

On Mon, 3 Sep 2012 11:21:43 +0100 (BST)
Mark Hills <Mark.Hills@framestore.com> wrote:

> How do I clone a repo _to_ a new repo over SSH? I tried:
> 
>   cd xx
>   git clone --bare . gitserver:/scm/xx.git
>   git clone --bare . ssh://gitserver/scm/xx.git
>
> This does not have the expected result, and instead a local path of
> the given name is created (eg. a 'gitserver:' directory)

No, `git clone` is intended to work with your local machine.
And I can't really imagine how it would work in a way you want.

> This seems to be a FAQ, but the only answer I can find (Google) is to 
> login to the server and create the repo, setup a remote and push to
> it. 
> This is quite cumbersome; we have a large team of devs who use a
> simple 'git clone' to an NFS directory, but we wish to retire NFS
> access.
> 
> Is there a technical limiation preventing clone-to-ssh, or just
> something waiting to be implemented?

I think this is more a conceptual issue: such a "remote cloning" would
mean *creation* of a repository as part of the process.  I'm not aware
of any [D]VCS system which would routinely allow such a thing: usually
the creation of a repository is an "administrative" act, which is
distinct from regular (push/fetch) access to that repository.

gitolite kind of implements this ("wild repos") [1], you could look if
it suits your needs.

Now back to your problem.

If you have NFS access, you can probably do proper cloning using NFS:
1) Export via NFS the directory in which you want your resulting
   bare repository located.
2) Do simple *local* clone (using paths accessed by NFS):
   git clone --bare /path/to/source/repo /path/to/destination/repo
3) Do certain fixups in the destination repo, if needed, then
   access it normally via SSH (or whatever protocol you prefer).

If you don't want to do this, then revert to a normal two-step
procedure:
1) Log into the server, create a repo by hand:
   git init --bare /path/to/repo
2) Push everything relevant from a source repo there:
   cd /path/to/local/repo
   git remote add origin ssh://gitserver/scm/xx.git
   git push origin refs/*:refs/*

Step (1) may depends on what server-side solution your need; for
instance, in gitolite you would be configuring a new repo in the
configuration file in your local clone of the gitolite admin repo and
pushing your changes to the server.

1. http://sitaramc.github.com/gitolite/wild.html
