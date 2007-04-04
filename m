From: Martin Langhoff <martin@catalyst.net.nz>
Subject: Re: git-cvsimport does not like detached HEAD
Date: Thu, 05 Apr 2007 09:40:18 +1200
Message-ID: <46141B42.4080102@catalyst.net.nz>
References: <7vmz1pzx12.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Apr 05 00:05:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZDba-0007p1-Lc
	for gcvg-git@gmane.org; Thu, 05 Apr 2007 00:05:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752326AbXDDWFX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Apr 2007 18:05:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752357AbXDDWFW
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Apr 2007 18:05:22 -0400
Received: from godel.catalyst.net.nz ([202.78.240.40]:36025 "EHLO
	mail1.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752326AbXDDWFV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2007 18:05:21 -0400
X-Greylist: delayed 1488 seconds by postgrey-1.27 at vger.kernel.org; Wed, 04 Apr 2007 18:05:20 EDT
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=[192.168.2.69])
	by mail1.catalyst.net.nz with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1HZDDS-0005PL-Js; Thu, 05 Apr 2007 09:40:30 +1200
User-Agent: Thunderbird 1.5.0.10 (X11/20070307)
In-Reply-To: <7vmz1pzx12.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43782>

Junio C Hamano wrote:
> In my day-job project, I use git-cvsimport with -i option to
> treat the central CVS repository as if it is just a branch in a
> remote git repository.  Since I hoard many changes in my git
> repository and trickle only a few changes at a time to the
> central CVS back, I keep shuffling and rebasing my commits on
> top of what I obtain from CVS, and many times, my HEAD is
> detached and not on a particular branch.

I don't quite understand detached HEAD very well so my reply may be
bogus... (I'm familiar with cg-seek, which seems to be a similar concept
of checking out an arbitrary commit in a mode where you are not allowed
to commit because you are not really at the tip of any branch).

> However, it seems git-cvsimport does not like to work when your
> HEAD is detached.

Yep - I can see how...

> Here is a minimum patch that seems to let me going, but I am not
> quite sure what the implication is for letting orig_branch (and
> last_branch) to default to "master" (I do not use "master"
> branch for that project so maybe I am getting lucky).

cvsimport should never write to 'master'*, so setting $last_branch to
master will mean that it will always switch to the branch it's importing
(and the switch will do the initialisation of temp index files, etc).
You could set it to '' and get the same effect, perhaps even safer.

* unless the cvs repo has a branch called 'master', and in that case
we're fsck'd.

Which leads me to think -- how magic is master anyway. Should we protect
it? The CVS repo could have a branchname collision with us on any
refname -- always make sure that repos where I do cvsimport are never
development repositories, which means that my dev branches are protected
from collisions. I think it's the only sane thing to do.

OTOH, it's trivial to say something like (warning, MUA-broken patch)

diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index 1a1ba7b..73e0544 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -685,6 +685,9 @@ my (@old,@new,@skipped,%ignorebranch);
 # commits that cvsps cannot place anywhere...
 $ignorebranch{'#CVSPS_NO_BRANCH'} = 1;

+# protect 'master';
+$ignorebranch{'master'} = 1;
+
 sub commit {
        if ($branch eq $opt_o && !$index{branch} &&
!get_headref($branch, $git_dir)) {
            # looks like an initial commit


cheers,


m
-- 
-----------------------------------------------------------------------
Martin @ Catalyst .Net .NZ  Ltd, PO Box 11-053, Manners St,  Wellington
WEB: http://catalyst.net.nz/           PHYS: Level 2, 150-154 Willis St
OFFICE: +64(4)916-7224  UK: 0845 868 5733 ext 7224  MOB: +64(21)364-017
      Make things as simple as possible, but no simpler - Einstein
-----------------------------------------------------------------------
