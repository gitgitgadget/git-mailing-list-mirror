From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [RFC/PATCH] t9159-*.sh: Don't use the svn '@<rev>' syntax
Date: Sat, 10 Sep 2011 18:40:10 +0100
Message-ID: <4E6BA0FA.9070103@ramsay1.demon.co.uk>
References: <4E21D295.7020600@ramsay1.demon.co.uk> <7vvcuy82kn.fsf@alter.siamese.dyndns.org> <4E269AB6.8070207@drmicha.warpmail.net> <4E27098B.906@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Wong <normalperson@yhbt.net>,
	GIT Mailing-list <git@vger.kernel.org>, mhagger@alum.mit.edu
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Sat Sep 10 19:44:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R2RbF-0007AT-2Q
	for gcvg-git-2@lo.gmane.org; Sat, 10 Sep 2011 19:44:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933725Ab1IJRoI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Sep 2011 13:44:08 -0400
Received: from anchor-post-3.mail.demon.net ([195.173.77.134]:44213 "EHLO
	anchor-post-3.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933486Ab1IJRoH (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Sep 2011 13:44:07 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-3.mail.demon.net with esmtp (Exim 4.69)
	id 1R2Rb3-0003rY-ml; Sat, 10 Sep 2011 17:44:06 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <4E27098B.906@vilain.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181158>

Sam Vilain wrote:
> On 20/07/11 10:07, Michael J Gruber wrote:
>> path@REV are so-called peg revisions, introduced in svn 1.1, and denote
>> "I mean the file named path in REV" (as opposed to "the file named path
>> now and maybe differently back then"). It (now) defaults to BASE (for
>> worktree) resp. HEAD (for URLs). A bit like our rename detection.
>>
>> -r REV specifies the operative revision. After resolving the
>> name/location using the pegrev, the version at the resolved path at the
>> oprative version is operated on.
>>
>> svn 1.5.0 (June 2008) introduced peg revisions to "svn copy", so I
>> assume our people were following svn trunk and adjusting in 2007 already
>> (to r22964). There were some fixes to "svn copy" with peg later on.
>>
>> I do not understand the above commit message at all; and I did not find
>> anything about how "svn copy -r REV" acted in svn 1.4. I would assume
>> "operative revision", and the above commit message seems to imply that
>> peg defaulted to REV here (not HEAD) and that that changed in 1.5.0, but
>> that is a wild guess (svnbook 1.4 does not so anything).
> 
> What happened is that I noticed that the code stopped working after svn
> 1.5 was released.  Previously I wrote it to detect the merge properties
> as left by SVK and the experimental/contrib python script for merging. 
> I was testing at times using trunk SVN versions.  You could probably
> figure it out by running ffab6268^ with svn 1.4.x vs svn 1.5.x if you
> cared.  My comment tries to explain what you describe above, but without
> the correct terms.  I could see via experimentation what the difference
> was between "-r N" and '/path@N', and that the behaviour changed in svn
> 1.5.  Apologies for not explaining this thoroughly enough in the
> submitted description!

Hmm, I was hoping that someone would say something like:

   "This test does not depend on the difference between the peg revision
and the operative revision, because the history represented in the test
repo is so simple that there *is* no difference, so Acked By: ... "

But, since that didn't happen, maybe the patch given below would be more
acceptable? (I personally prefer the original patch ...)

Given that I didn't quite follow Sam's explanation, I still don't know
if t9104-git-svn-follow-parent.sh needs to be changed (again, this test
*passes* for me), so ... :-P

ATB,
Ramsay Jones

-- >8 --
Subject: [PATCH] t9159-*.sh: Add an svn version check


Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 t/t9159-git-svn-no-parent-mergeinfo.sh |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/t/t9159-git-svn-no-parent-mergeinfo.sh b/t/t9159-git-svn-no-parent-mergeinfo.sh
index 85120b7..69e4815 100755
--- a/t/t9159-git-svn-no-parent-mergeinfo.sh
+++ b/t/t9159-git-svn-no-parent-mergeinfo.sh
@@ -2,6 +2,14 @@
 test_description='git svn handling of root commits in merge ranges'
 . ./lib-git-svn.sh
 
+svn_ver="$(svn --version --quiet)"
+case $svn_ver in
+0.* | 1.[0-4].*)
+	skip_all="skipping git-svn test - SVN too old ($svn_ver)"
+	test_done
+	;;
+esac
+
 test_expect_success 'test handling of root commits in merge ranges' '
 	mkdir -p init/trunk init/branches init/tags &&
 	echo "r1" > init/trunk/file.txt &&
-- 
1.7.6
