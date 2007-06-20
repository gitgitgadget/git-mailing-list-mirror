From: Paul Mackerras <paulus@samba.org>
Subject: filenames with " b" in them create confusing git diff-tree output
Date: Wed, 20 Jun 2007 21:15:39 +1000
Message-ID: <18041.3163.329391.298926@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 20 13:15:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0yAB-0003yy-6e
	for gcvg-git@gmane.org; Wed, 20 Jun 2007 13:15:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752897AbXFTLPt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Jun 2007 07:15:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752689AbXFTLPt
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jun 2007 07:15:49 -0400
Received: from ozlabs.org ([203.10.76.45]:51993 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751777AbXFTLPs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2007 07:15:48 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id A7DC5DDEB6; Wed, 20 Jun 2007 21:15:47 +1000 (EST)
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50558>

While trying to improve gitk's handling of filenames with spaces, I
realised that the header line in git diff-tree's output can be
inherently ambiguous, since it doesn't put quotes around filenames
with spaces (although it does for filenames with other special
characters in them).

For example:

paulus@quango:~/gitk/testrepo$ mkdir "test b"
paulus@quango:~/gitk/testrepo$ cat >"test b/foo"
stuff
paulus@quango:~/gitk/testrepo$ git add "test b/foo"
paulus@quango:~/gitk/testrepo$ git commit -a
Created commit 71a3074: Add a "test b" directory
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 test b/foo
paulus@quango:~/gitk/testrepo$ git diff-tree -r -p -C HEAD
71a3074e723c3e5eb599e6b3c47e3267a3cac3bc
diff --git a/test b/foo b/test b/foo
new file mode 100644
index 0000000..f2e4113
--- /dev/null
+++ b/test b/foo
@@ -0,0 +1 @@
+stuff

Note how there appear to be 4 filenames on the "diff --git" line.  At
present gitk will interpret that as a diff between "test" and
"foo b/test b/foo", since it looks for " a/" and " b/" to delimit the
filenames.  Of course if the file got renamed it could get even more
confusing. :)

Would there be any ill effects from quoting filenames with spaces, do
you think?  It seems the simplest fix to me (and I will make gitk
handle quoted filenames, which it doesn't at present :).

Paul.
