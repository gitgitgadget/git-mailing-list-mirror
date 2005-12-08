From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Make sure we use compat/subprocess.py with Python 2.3 while running tests.
Date: Wed, 07 Dec 2005 22:07:39 -0800
Message-ID: <7vr78oktp0.fsf_-_@assigned-by-dhcp.cox.net>
References: <20051207181225.67737.qmail@web34304.mail.mud.yahoo.com>
	<7vslt4rb4v.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 08 07:08:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EkEwe-0004bw-Ip
	for gcvg-git@gmane.org; Thu, 08 Dec 2005 07:07:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751123AbVLHGHm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Dec 2005 01:07:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751189AbVLHGHm
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Dec 2005 01:07:42 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:1736 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751123AbVLHGHl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Dec 2005 01:07:41 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051208060559.GZIZ17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 8 Dec 2005 01:05:59 -0500
To: Mark Allen <mrallen1@yahoo.com>
In-Reply-To: <7vslt4rb4v.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 07 Dec 2005 10:54:24 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13359>

Otherwise the test will not succeed without installing.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

  Junio C Hamano <junkio@cox.net> writes:

  > Mark Allen <mrallen1@yahoo.com> writes:
  >
  >> So, basically the problem is that the subprocess.py module is
  >> in the compat directory, and by default (I think)..
  >
  > Ah, you are right.
  >
  > Just like we fix PATH and GIT_EXEC_PATH during the test
  > execution, we need to do something with PYTHONPATH environment
  > variable (this one is _without_ underscore), I think.

  This seems to fix it for me.

 t/test-lib.sh |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

49ccb0877f64308662669a09db7b221419c13d0a
diff --git a/t/test-lib.sh b/t/test-lib.sh
index f2eccd7..0539dac 100755
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -172,7 +172,18 @@ test_done () {
 # t/ subdirectory and are run in trash subdirectory.
 PATH=$(pwd)/..:$PATH
 GIT_EXEC_PATH=$(pwd)/..
-export GIT_EXEC_PATH
+export PATH GIT_EXEC_PATH
+
+# Similarly use ../compat/subprocess.py if our python does not
+# have subprocess.py on its own.
+PYTHON=`sed -e '1{
+	s/^#!//
+	q
+}' ../git-merge-recursive` &&
+"$PYTHON" -c 'import subprocess' 2>/dev/null || {
+	PYTHONPATH=$(pwd)/../compat
+	export PYTHONPATH
+}
 
 # Test repository
 test=trash
-- 
0.99.9.GIT
