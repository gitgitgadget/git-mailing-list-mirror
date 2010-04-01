From: "Scott R. Godin" <scottg.wp-hackers@mhg2.com>
Subject: Re: [BUG] [RESOLVED] merge-recursive call in git-am -3 chokes, autocrlf
 issue?
Date: Thu, 01 Apr 2010 13:03:15 -0400
Organization: MAD House Graphics
Message-ID: <hp2jkj$mu0$1@dough.gmane.org>
References: <201003190149.03025.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 01 19:03:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxNo8-0008DG-OI
	for gcvg-git-2@lo.gmane.org; Thu, 01 Apr 2010 19:03:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756881Ab0DARDc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Apr 2010 13:03:32 -0400
Received: from lo.gmane.org ([80.91.229.12]:38774 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751285Ab0DARDa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Apr 2010 13:03:30 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1NxNnj-0007xx-2r
	for git@vger.kernel.org; Thu, 01 Apr 2010 19:03:27 +0200
Received: from c-71-58-29-3.hsd1.de.comcast.net ([71.58.29.3])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 01 Apr 2010 19:03:27 +0200
Received: from scottg.wp-hackers by c-71-58-29-3.hsd1.de.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 01 Apr 2010 19:03:27 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: c-71-58-29-3.hsd1.de.comcast.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.9) Gecko/20100330 Fedora/3.0.4-1.fc12 Lightning/1.0b2pre Thunderbird/3.0.4
In-Reply-To: <201003190149.03025.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143735>

On 03/18/2010 08:49 PM, Thomas Rast wrote:
> Hi everyone,
>
> I helped Scott R. "WebDragon" Godin on IRC[1] with a bug internal to
> git-rebase.  It manifests like this:

It turns out it's not actually a bug in git-am/git-rebase.

while changing merge-recursive to merge-resolve in git-am solved the 
plain git rebase branch1 branch2 issue, I still ran into trouble when 
trying to do a rebase -i so I could squash a commit or two together.

Ilari stepped up to the plate [1] and it was quickly determined that the 
working copy cache is somehow left dirty after checkout.

doener stepped back in, and while pulling the hooks out that used 
setgitperms.perl, temporarily, it became obvious that one of them was 
the culprit, and further testing at this point would allow the rebase to 
continue, albiet without permissions being set. using git update-index 
--refresh allowed things to go on normally, when added to the 
post-checkout hook calling setgitperms.perl [2].

So my recommendation at this point is to patch the instructions within 
setgitperms.perl to add 'git update-index --refresh' to the end of the 
post-checkout hook.

I've since reset git-am to use recursive again (instead of resolve) and 
done several rebases (both with and without -i) and all seems well and 
normal, and this has made my day.

patch follows:

--8<--

Subject: [PATCH] revise setgitperms.perl hook script description to fix 
rebase issue

add index-refresh command to post-checkout post-merge script hooks to 
keep working tree from being marked dirty during a rebase action
---
  contrib/hooks/setgitperms.perl |    1 +
  1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/contrib/hooks/setgitperms.perl b/contrib/hooks/setgitperms.perl
index a577ad0..286835d 100644
--- a/contrib/hooks/setgitperms.perl
+++ b/contrib/hooks/setgitperms.perl
@@ -17,6 +17,7 @@
  #      #!/bin/sh
  #     SUBDIRECTORY_OK=1 . git-sh-setup
  #     $GIT_DIR/hooks/setgitperms.perl -w
+#     git update-index --refresh
  #
  use strict;
  use Getopt::Long;

--8<--

[1] http://colabti.org/irclogger/irclogger_log/git?date=2010-03-31#l1556
[2] http://colabti.org/irclogger/irclogger_log/git?date=2010-03-31#l1743

-- 
(please respond to the list as opposed to my email box directly,
unless you are supplying private information you don't want public
on the list)
