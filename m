From: Jeff King <peff@peff.net>
Subject: Re: move files between disparate repos and maintain version history
Date: Mon, 2 Mar 2009 23:13:00 -0500
Message-ID: <20090303041300.GA18136@coredump.intra.peff.net>
References: <0d8965bb-e2ed-4f49-b323-c110f605ae2c@33g2000yqm.googlegroups.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: davetron5000 <davetron5000@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 03 05:14:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeM1g-0004UJ-I5
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 05:14:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753596AbZCCENL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2009 23:13:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752415AbZCCENK
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Mar 2009 23:13:10 -0500
Received: from peff.net ([208.65.91.99]:53127 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752720AbZCCENJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Mar 2009 23:13:09 -0500
Received: (qmail 12125 invoked by uid 107); 3 Mar 2009 04:13:07 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 02 Mar 2009 23:13:07 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 02 Mar 2009 23:13:00 -0500
Content-Disposition: inline
In-Reply-To: <0d8965bb-e2ed-4f49-b323-c110f605ae2c@33g2000yqm.googlegroups.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111991>

On Mon, Mar 02, 2009 at 12:30:58PM -0800, davetron5000 wrote:

> So, is there a way I can move a file between two git repositories,
> maintaining the change history?  I guess it would be something like
> "apply all patches that this file was involved in, but ONLY apply the
> ones affecting this file, to the new repo, then delete from the old"?

Yes, that's more or less how you would do it. There are actually two
separate issues, and each has two possible solutions.

Issue 1 is moving the history to the new repo.

One solution is, as you guessed, to export as patches and import into
the new repo:

  cd /path/to/app
  git format-patch --stdout --root -- <path> >~/patches
  cd /path/to/core
  git am ~/patches

where <path> can be a file, directory, or a list of either or both.
This should work fine if the history of that path is linear, since a
list of patches is, by definition, linear. You can see the "shape" of
the history with:

  cd /path/to/app
  gitk -- <path>

The other solution is to actually rewrite a version of git history that
sees only those paths, then merge it in. That will retain the actual
shape of the history. You can do this using "git filter-branch":

  cd /path/to/app
  # we do our work on a temporary branch
  git branch just-path
  # the actual filter; note you could do more than just grep here
  # if you wanted to munge the pathnames
  git filter-branch --index-filter '
    git ls-files -s | grep path |
      GIT_INDEX_FILE="$GIT_INDEX_FILE.new" git update-index --index-info &&
    mv "$GIT_INDEX_FILE.new" "$GIT_INDEX_FILE"
  ' --prune-empty just-path

  # you can inspect just-path at this point with "gitk just-path"
  cd /path/to/core
  # and then pull it into core's history
  git pull /path/to/app just-path

The second issue is what you want to have happen in the "app"
repository. Presumably you no longer want the moved files there. You
_could_ filter-branch to pretend as if they were always in "core" and
never in "app". But that is probably not a good idea because:

  1. You are rewriting history, which will make merging more complex for
     your users.

  2. You may be breaking historical builds which expect the files to be
     there in the past.

So I think you're probably best to just remove them with a new commit
and have the duplicated history in both.

-Peff

PS I think you might be able to replace the filter-branch invocation
with a fast-export / fast-import pipeline, but I haven't tried.
