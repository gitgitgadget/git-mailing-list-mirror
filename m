From: Jeff King <peff@peff.net>
Subject: Re: Merging back from master but keeping a subtree
Date: Sat, 17 Sep 2011 23:37:19 -0400
Message-ID: <20110918033719.GB17977@sigill.intra.peff.net>
References: <87y5xn8v6z.fsf@dod.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 18 05:37:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R58C6-00058l-5P
	for gcvg-git-2@lo.gmane.org; Sun, 18 Sep 2011 05:37:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756295Ab1IRDhW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Sep 2011 23:37:22 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:50899
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753603Ab1IRDhV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Sep 2011 23:37:21 -0400
Received: (qmail 11226 invoked by uid 107); 18 Sep 2011 03:38:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 17 Sep 2011 23:38:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 17 Sep 2011 23:37:19 -0400
Content-Disposition: inline
In-Reply-To: <87y5xn8v6z.fsf@dod.no>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181601>

On Sat, Sep 17, 2011 at 09:49:40AM +0200, Steinar Bang wrote:

> I have a long lived branch that changes a directory and its
> subdirectory, ie. 
>  top/middle/mydirectory
> 
> Now I want to merge in an updated remoterepo/master and keep everything
> from that master, except for mydirectory and its subdirectory, where I
> would like to keep everything from my branch.

Git should generally do that automatically, unless both sides are
changing mydirectory. In which case it will produce conflicts.

Are you sure you really want to just throw out what the other side did
in mydirectory?

> I tried a regular merge, and used
>  git checkout --ours
>  git add
> and 
>  git checkout --theirs
>  git add
> as appropriate on all conflicts.
> 
> But the result didn't build, and the build errors don't make much sense,
> so I think they are caused by "successful" merges giving bad results.

If git was able to auto-merge some files, then they will not be marked
as conflicts in the index. And "git checkout --ours" is about looking in
the index for conflicted entries, and then selecting one side.

I think what you want instead is to do is (assuming you really want to
throw out their side):

  1. Start a merge between them and us:

       git merge --no-commit remoterepo/master

  2. Throw out whatever the merge came up with and make it look like
     their tree:

       git checkout remoterepo/master -- top

  3. Now overwrite their version of mydirectory with what was in your
     branch:

       git checkout HEAD -- top/middle/mydirectory

  4. Commit the resulting tree:

       git commit

-Peff
