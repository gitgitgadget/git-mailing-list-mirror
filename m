From: Jeff King <peff@peff.net>
Subject: Re: Why git silently replaces untracked files?
Date: Fri, 25 Mar 2011 12:58:11 -0400
Message-ID: <20110325165811.GB25851@sigill.intra.peff.net>
References: <1301064754576-6207950.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "igor.mikushkin" <igor.mikushkin@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 17:58:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q3AL6-0003A4-Ix
	for gcvg-git-2@lo.gmane.org; Fri, 25 Mar 2011 17:58:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754369Ab1CYQ6P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2011 12:58:15 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:48730
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754261Ab1CYQ6O (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2011 12:58:14 -0400
Received: (qmail 15268 invoked by uid 107); 25 Mar 2011 16:58:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 25 Mar 2011 12:58:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 25 Mar 2011 12:58:11 -0400
Content-Disposition: inline
In-Reply-To: <1301064754576-6207950.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169998>

On Fri, Mar 25, 2011 at 07:52:34AM -0700, igor.mikushkin wrote:

> Why git silently replaces untracked files?
> 
> # mkdir test.git
> # mkdir 1
> # mkdir 2
> # echo 1 > 1/test
> # echo 2 > 2/test
> # cd test.git
> # git init --bare
> # cd ..
> # git clone test.git
> # cp -r test/.git 1
> # cp -r test/.git 2
> # cd 1
> # git add test
> # git commit -am 1
> # git push origin master
> # cd ../2
> # git pull
> # cat test
> 1
> 
> In my opinion it is wrong behavior.
> I've just lost important file due to it.
> 
> Should not "git pull" fail here?

Ick, definitely it's wrong behavior. The culprit seems to be a special
code path for the initial pull which doesn't merge at all, but calls
read-tree --reset. It should probably be:

diff --git a/git-pull.sh b/git-pull.sh
index a3159c3..fb9e2df 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -253,7 +253,7 @@ esac
 if test -z "$orig_head"
 then
 	git update-ref -m "initial pull" HEAD $merge_head "$curr_head" &&
-	git read-tree --reset -u HEAD || exit 1
+	git read-tree -m -u HEAD || exit 1
 	exit
 fi

Though I don't know if there are any cases where the --reset would be
beneficial over "-m". I couldn't think of any.

-Peff
