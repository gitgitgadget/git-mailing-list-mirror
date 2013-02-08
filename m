From: Jeff King <peff@peff.net>
Subject: Re: [Request] Git export with hardlinks
Date: Fri, 8 Feb 2013 04:58:19 -0500
Message-ID: <20130208095819.GA17220@sigill.intra.peff.net>
References: <201302061619.07765.thomas@koch.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Thomas Koch <thomas@koch.ro>
X-From: git-owner@vger.kernel.org Fri Feb 08 10:59:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3kjP-0002VF-9r
	for gcvg-git-2@plane.gmane.org; Fri, 08 Feb 2013 10:58:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758522Ab3BHJ6b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2013 04:58:31 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:42127 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752623Ab3BHJ63 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2013 04:58:29 -0500
Received: (qmail 27909 invoked by uid 107); 8 Feb 2013 09:59:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 08 Feb 2013 04:59:55 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Feb 2013 04:58:19 -0500
Content-Disposition: inline
In-Reply-To: <201302061619.07765.thomas@koch.ro>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215770>

On Wed, Feb 06, 2013 at 04:19:07PM +0100, Thomas Koch wrote:

> I'd like to script a git export command that can be given a list of already 
> exported worktrees and the tree SHA1s these worktrees correspond too. The git 
> export command should then for every file it wants to export lookup in the 
> existing worktrees whether an identical file is already present and in that 
> case hardlink to the new export location instead of writing the same file 
> again.
> 
> Use Case: A git based web deployment system that exports git trees to be 
> served by a web server. Every new deployment is written to a new folder. After 
> the export the web server should start serving new requests from the new 
> folder.
> 
> It might be possible that this is premature optimization. But I'd like to 
> learn more Python and dulwich by hacking this.
> 
> Do you have any additional thoughts or use cases about this?

If you can handle losing the generality of N deployments, you can do it
in a few lines of shell.

Let's assume for a moment that you keep two trees at any given time:
the existing tree being used, and the tree you are setting up to deploy.
To save space, you want the new deployment to reuse (via hardlinks) as
many of the files from the old deployment as possible.

So imagine you have a bare repository storing the actual data:

  $ git clone --bare /some/test/repo repo.git
  $ du -sh *
  49M     repo.git

and then you have one deployment you've set up previously by checking
out the repo contents:

  $ export GIT_DIR=$PWD/repo.git
  $ mkdir old
  $ (cd old && GIT_WORK_TREE=$PWD git checkout HEAD)
  $ du -sh *
  24M     old
  49M     repo.git

So a full checkout is 24M. For the next deploy, we'll start by asking
"cp" to duplicate the old, using hard links:

  $ cp -rl old new
  $ du -sh *
  24M     new
  768K    old
  49M     repo.git

and we use hardly any extra space (it should just be directory inodes).
And now we can ask git to make "new" look like some other commit. It
will only touch files which have changed, so the rest remain hardlinked,
and we use only a small amount of extra space:

  $ (cd new && GIT_WORK_TREE=$PWD git checkout HEAD~10)
  $ du -sh *
  24M     new
  1.3M    old
  49M     repo.git

Now you point your deployment at "new", and you are free to leave "old"
sitting around or remove it at your leisure. You save space while the
two co-exist, and you saved the I/O of copying any files from "old" to
"new".

This breaks down, of course, if you want to keep N trees around and
hard-link to whichever one has the content you want. For that you'd have
to write some custom code.

-Peff
