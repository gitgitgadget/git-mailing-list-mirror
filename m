From: Jeff King <peff@peff.net>
Subject: Re: Unknown software revision
Date: Thu, 10 Feb 2011 18:22:35 -0500
Message-ID: <20110210232235.GC21335@sigill.intra.peff.net>
References: <733D558A-0935-42A8-BA5B-7B97703656F6@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jason Brooks <jasonbbrooks@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 11 00:22:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PnfqT-000169-Ne
	for gcvg-git-2@lo.gmane.org; Fri, 11 Feb 2011 00:22:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757160Ab1BJXWh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Feb 2011 18:22:37 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:57875 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751169Ab1BJXWg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Feb 2011 18:22:36 -0500
Received: (qmail 22477 invoked by uid 111); 10 Feb 2011 23:22:35 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 10 Feb 2011 23:22:35 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Feb 2011 18:22:35 -0500
Content-Disposition: inline
In-Reply-To: <733D558A-0935-42A8-BA5B-7B97703656F6@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166514>

On Thu, Feb 10, 2011 at 02:33:47PM -0800, Jason Brooks wrote:

> I have a software deployment that was copied out of a git repository
> but without the .git directories.  Thus, I have no idea what revision
> this deployment is, so I don't know how to upgrade from git.  Is there a
> method, or script out there that can help me?

Does your set of files match what was in the git tree _exactly_? Or
might there be minor changes, new files, etc?

If it should match exactly, you can figure out what tree git would have
made out of this content:

  git init
  git add .
  git commit -m foo
  tree=`git rev-parse HEAD^{tree}`

And now you can search in the actual git repository for that tree:

  $ git log --pretty=raw -z | perl -0lne 'print $_, "\n" if /^tree '$tree'$/m'

But obviously that is all based on the hashes of the content, so if even
a single byte is missing, added, or different in your deployed copy, you
won't find a match.

In that case, your best bet is probably to script a bunch of diffs and
see which commit ends up closest. I would do something like:

  1. From the deployed version, prepare your best guess about what the
     git directory would have looked like. Put it in a directory
     "deployed".

  2. Now make a git commit from the deployed state:

       cd deployed
       git init
       git add .
       git commit -m 'deployed version'

  3. In the original git repo, fetch the deployed version in so you
     can diff against it.

       cd /path/to/real/git/repo
       git fetch /path/to/deployed master:deployed

  4. Now you can try diffing "deployed" against every commit in the real
     repo and see what comes closest. Here I'll just count up changed
     lines to assign a score to each commit and show the one with the
     fewest changes:

       git rev-list HEAD | while read commit; do
         git diff-tree --numstat $commit deployed |
         perl -ane '$total += $F[0] + $F[1];
                    END { print $total }'
         echo " $commit"
       done | sort -n

The top of the resulting list is the closest commit. Check it out with
"git show" to see if it makes sense.

Hope that helps.

-Peff
