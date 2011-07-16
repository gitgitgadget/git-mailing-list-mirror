From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [RFC/PATCH] t9159-*.sh: Don't use the svn '@<rev>' syntax
Date: Sat, 16 Jul 2011 19:04:05 +0100
Message-ID: <4E21D295.7020600@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>, sam@vilian.net,
	mhagger@alum.mit.edu
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 16 20:16:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qi9Ph-0005o0-QW
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jul 2011 20:16:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751869Ab1GPSMF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Jul 2011 14:12:05 -0400
Received: from lon1-post-3.mail.demon.net ([195.173.77.150]:38385 "EHLO
	lon1-post-3.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751605Ab1GPSMD (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Jul 2011 14:12:03 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-3.mail.demon.net with esmtp (Exim 4.69)
	id 1Qi9L3-0006n2-eJ; Sat, 16 Jul 2011 18:12:00 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177281>


Avoiding the use of the '@<rev>' syntax, in favour of an '-r <rev>'
parameter, allows older versions of svn to execute the test.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Hi Junio,

This test is failing for me on Linux and MinGW (I don't have svn
installed on cygwin), again (i suspect) due to the older versions
of svn I have. [v1.4.3 on Linux and v1.4.6 on MinGW]

This patch fixes the test for me. However, I noticed that there are
two other uses of the syntax in t9104-git-svn-follow-parent.sh which
look like this:

        (svn_cmd cp -m "resurrecting trunk as junk" \
               "$svnrepo"/trunk@2 "$svnrepo"/junk ||
         svn cp -m "resurrecting trunk as junk" \
               -r2 "$svnrepo"/trunk "$svnrepo"/junk) &&

which, unless I'm confused (possible), has been coded specifically
to cater to just this problem!

However, I think the above is a little too "belt & braces" for my
liking. What do you think?

Hmm, I've just found commit ffab62681 (git-svn: handle changed svn
command-line syntax, 21-09-2007), which seems to imply that the
above is necessary due to a change in behaviour. I'm afraid I don't
know svn much at all; the only reason it is installed on Linux is
to improve test coverage of git! :-P

So, maybe this patch should do the same as above (which is the reason
for the RFC); dunno ...

Hopefully, someone who knows svn can pick this up and make a proper patch.

ATB,
Ramsay Jones

 t/t9159-git-svn-no-parent-mergeinfo.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t9159-git-svn-no-parent-mergeinfo.sh b/t/t9159-git-svn-no-parent-mergeinfo.sh
index 85120b7..4cf26e9 100755
--- a/t/t9159-git-svn-no-parent-mergeinfo.sh
+++ b/t/t9159-git-svn-no-parent-mergeinfo.sh
@@ -11,7 +11,7 @@ test_expect_success 'test handling of root commits in merge ranges' '
 		cd tmp &&
 		echo "r2" > trunk/file.txt &&
 		svn_cmd commit -m "Modify file.txt on trunk" &&
-		svn_cmd cp trunk@1 branches/a &&
+		svn_cmd cp -r1 trunk branches/a &&
 		svn_cmd commit -m "Create branch a from trunk r1" &&
 		svn_cmd propset svn:mergeinfo /trunk:1-2 branches/a &&
 		svn_cmd commit -m "Fake merge of trunk r2 into branch a" &&
@@ -21,7 +21,7 @@ test_expect_success 'test handling of root commits in merge ranges' '
 		svn_cmd commit -m "Create branch b from thin air" &&
 		echo "r6" > branches/b/file2.txt &&
 		svn_cmd commit -m "Modify file2.txt on branch b" &&
-		svn_cmd cp branches/b@5 branches/c &&
+		svn_cmd cp -r5 branches/b branches/c &&
 		svn_cmd commit -m "Create branch c from branch b r5" &&
 		svn_cmd propset svn:mergeinfo /branches/b:5-6 branches/c &&
 		svn_cmd commit -m "Fake merge of branch b r6 into branch c"
-- 
1.7.6
