From: "Scott R. Godin" <scottg.wp-hackers@mhg2.com>
Subject: Re: [BUG] [RESOLVED] merge-recursive call in git-am -3 chokes, autocrlf
 issue?
Date: Tue, 04 May 2010 17:47:05 -0400
Organization: MAD House Graphics
Message-ID: <4BE095D9.6090403@mhg2.com>
References: <201003190149.03025.trast@student.ethz.ch> <hp2jkj$mu0$1@dough.gmane.org> <7vbpe3qe09.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 04 23:47:41 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9Pxr-0006u2-Q7
	for gcvg-git-2@lo.gmane.org; Tue, 04 May 2010 23:47:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934192Ab0EDVrW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 May 2010 17:47:22 -0400
Received: from lo.gmane.org ([80.91.229.12]:50657 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934098Ab0EDVrV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 May 2010 17:47:21 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1O9PxV-0006kY-3N
	for git@vger.kernel.org; Tue, 04 May 2010 23:47:17 +0200
Received: from c-71-58-29-3.hsd1.de.comcast.net ([71.58.29.3])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 04 May 2010 23:47:17 +0200
Received: from scottg.wp-hackers by c-71-58-29-3.hsd1.de.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 04 May 2010 23:47:17 +0200
X-Injected-Via-Gmane: http://gmane.org/
connect(): No such file or directory
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: c-71-58-29-3.hsd1.de.comcast.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.9) Gecko/20100330 Fedora/3.0.4-1.fc12 Lightning/1.0b2pre Thunderbird/3.0.4
In-Reply-To: <7vbpe3qe09.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146350>

On 04/01/2010 01:27 PM, Junio C Hamano wrote:
> I however think the patch probably "fixes" the issue at the worst point.
> Wouldn't either of these alternatives be better?
>
>   (1) Perhaps the caller of "pre-commit/post-merge/post-checkout" hook
>       should instead refresh the index when the hook returns, _iff_ we
>       expect that majority of these hooks are used to munge the work tree
>       or the index; or
>
>   (2) Because you already established that setgitperms script is the
>       culprit that leaves the index unrefreshed, instead of forcing all the
>       callers of the script, it should do the refresh for its callers
>       before it exits.

Good call.

I talked it over with Todd Zullinger and he came up with the following 
patch, which I tested on my end to my complete satisfaction, rebases and 
merges go smoothly.

it's still necessary however, to --no-commit on merges so that you can 
fix the permissions before your umask blots them out and they wind up in 
the commit and saved in the gitmeta file

As a result, my usual modus operandi currently is:
	git checkout master
	git merge --no-ff --no-commit develop
	find . -perm 0600 -or -perm 0700 |grep -v .git/
	...fix perms back to where they should be
	git add -A
	git commit

which is somewhat less than optimal, but otherwise setgitperms.perl is 
doing what it should.

Revised patch follows:
--8<--
Subject: [PATCH] Revise setgitperms.perl to fix dirty tree problem when 
rebasing/merging

reference:
http://comments.gmane.org/gmane.comp.version-control.git/142548

Note that it will be necessary to not only copy the changed
setgitperms.perl from /usr/share/git-core/contrib/hooks/ to
/usr/share/git-core/templates/hooks/ but additionally every git
repository you currently use this script with, will also need to be
updated with the new version. This process is regrettably not automatic 
simply
because git was updated on your system.
---
  contrib/hooks/setgitperms.perl |    4 ++++
  1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/contrib/hooks/setgitperms.perl b/contrib/hooks/setgitperms.perl
index a577ad0..e571560 100644
--- a/contrib/hooks/setgitperms.perl
+++ b/contrib/hooks/setgitperms.perl
@@ -91,6 +91,10 @@ if ($write_mode) {
         }
      }
      close IN;
+
+    # Make sure the index isn't left dirty
+    # http://comments.gmane.org/gmane.comp.version-control.git/142548
+    system("git update-index --refresh");
  }
  elsif ($read_mode) {
      # Handle merge conflicts in the .gitperms file
-- 
1.7.1

--8<--

-- 
(please respond to the list as opposed to my email box directly,
unless you are supplying private information you don't want public
on the list)
