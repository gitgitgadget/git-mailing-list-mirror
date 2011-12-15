From: Jeff King <peff@peff.net>
Subject: Re: process committed files in post-receive hook
Date: Thu, 15 Dec 2011 02:23:01 -0500
Message-ID: <20111215072301.GC1327@sigill.intra.peff.net>
References: <loom.20111210T111457-837@post.gmane.org>
 <4EE94783.1010805@gmail.com>
 <4EE95523.9030702@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Neal Kreitzinger <nkreitzinger@gmail.com>, git@vger.kernel.org
To: Hao Wang <billhao@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 15 08:23:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rb5ep-0005KQ-6z
	for gcvg-git-2@lo.gmane.org; Thu, 15 Dec 2011 08:23:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757295Ab1LOHXF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Dec 2011 02:23:05 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:50359
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755702Ab1LOHXE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Dec 2011 02:23:04 -0500
Received: (qmail 6149 invoked by uid 107); 15 Dec 2011 07:29:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 15 Dec 2011 02:29:45 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Dec 2011 02:23:01 -0500
Content-Disposition: inline
In-Reply-To: <4EE95523.9030702@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187194>

On Wed, Dec 14, 2011 at 06:02:11PM -0800, Hao Wang wrote:

> Thank you all for providing the options. Just so you know I finally
> went with Alexey's suggestion. I used 'git show' to get both a list
> of files in a directory and the content of each file. It works great
> on a bare repository so there is no need to check out a copy on the
> server.

If you are scripting, we usually encourage the use of "plumbing"
commands whose output is guaranteed not to change ("show" is a
"porcelain" command intended to be used by end-users, and it's possible
that its behavior might change from version to version).

The plumbing command to get a directory listing for a tree is "git
ls-tree" (try the "--name-only" option for terse output, and use "-z" if
you want to be robust in the face of filenames with funny characters).

> # get a list of rule files using git show
> def getRuleFileList(rev):
>     # run git show
>     p = subprocess.Popen(['git', 'show', rev], stdout=subprocess.PIPE)
>     p.wait()
>     if p.returncode != 0: return None # error
> 
>     # parse output
>     i = 0
>     filelist = []
>     for line in p.stdout.readlines():
>         filelist.append(line)
>     p.stdout.close()
>     return filelist

Doesn't this put "tree HEAD:foo", as printed by "git show", at the top
of your filelist? Another reason to use ls-tree.

> # read the content of a file
> def readfile(rev):
>     # run git show
>     p = subprocess.Popen(['git', 'show', rev], stdout=subprocess.PIPE)
>     p.wait()
>     if p.returncode != 0: return None # error
>     return p.stdout.read()

The plumbing for this is "git cat-file blob ...".

-Peff
