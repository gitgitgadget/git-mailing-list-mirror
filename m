From: Max Horn <max@quendi.de>
Subject: remote helper and relative local paths
Date: Fri, 23 Nov 2012 12:02:04 +0100
Message-ID: <605DC086-713B-4986-B1C0-BD2EFF1D636B@quendi.de>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 23 12:02:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tbr1d-0004am-U2
	for gcvg-git-2@plane.gmane.org; Fri, 23 Nov 2012 12:02:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754371Ab2KWLCK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Nov 2012 06:02:10 -0500
Received: from wp256.webpack.hosteurope.de ([80.237.133.25]:59216 "EHLO
	wp256.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754020Ab2KWLCI convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2012 06:02:08 -0500
Received: from fb07-alg-gast1.math.uni-giessen.de ([134.176.24.161]); authenticated
	by wp256.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	id 1Tbr1I-00039X-0R; Fri, 23 Nov 2012 12:02:04 +0100
X-Mailer: Apple Mail (2.1283)
X-bounce-key: webpack.hosteurope.de;max@quendi.de;1353668528;5c5d52ea;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210250>

I noticed a problem with remote helpers which is mainly about convenience, but still annoying enough that I wish it could be resolved; but I'd like some input on what the proper way would be...

Here is the issue: cloning with relative paths is problematic (if not broken) when using remote-helpers, unless one is willing to dive into some (IMHO) gross hacking... To demonstrate what I mean, first consider that cloning a local git repo using relative paths works fine: If the parent dir contains a git repository "git-repo", this works:

  $ git clone ../git-repo git-clone
  Cloning into 'git-clone'...
  done.
  $ cd git-clone && git pull
  Current branch master is up to date.
  $

But when doing the same with a remote helper, it doesn't work; or rather, the initial cloning might work, but we end up with a broken remote.origin.url, as that still contains the relative path, but it no longer can be resolved since the PWD changed. E.g. here is an example using felipe's remote-hg:

  $ git clone hg::../hg-repo git-clone
  Cloning into 'git-clone'...
  $ cd git-clone && git pull
  Traceback (most recent call last):
  [...]
  mercurial.error.RepoError: repository ../hg-repo not found
  $


One problem here is that git cannot resolve the local path in "hg::../hg-repo", because this URL is opaque for git, it's a black-box. Hence the code in "git clone" that would normally take care of this (specifically, get_repo_path() in builtin/clone.c) does not get applied.

Now, it is not difficult to resolve a relative path, and so a remote helper can do this -- but we only can do this while cloning (and then have to store the absolute path / the new URL), because later on, crucial information (the PWD at the time of cloning) is not available anymore.


So I made a hack that does this: In the remote helper, if the URL looks like a local path, and points to a directory containing a .hg subdir (or some variation of that), translate it into an absolute path. Then (and that is the part I feel bad about) invoke
  git config remote.REPOS_ALIAS.url hg::the_computed_absolute_path

This works, but feels like a gross hack to me. In particular, as Felipe pointed out to me: While git is setting the remote.origin.url before invoking the remote helper right now, there is no guarantee for that (at least none that I am aware of). 

So, is there a better way to achieve this that I am overlooking? Or does what I am doing actually seem fine? Or should there be a change to git itself (e.g. a revision to the remote-helper protocol) that helps to take care of that? And how should that look?

One simple idea for the last option would be to add a "sanitize" capability to remote-helpers, which takes a repository URL, and returns a sanitized version, where e.g. local paths have been resolved, and then "git clone" would make use of that to set the remote URL right. But perhaps I am overcomplicating things?


Cheers,
Max