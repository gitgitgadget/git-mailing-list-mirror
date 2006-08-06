From: Matthias Lederhofer <matled@gmx.net>
Subject: [RFC] gitweb test script
Date: Sun, 6 Aug 2006 18:51:51 +0200
Message-ID: <20060806165151.GB9548@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Aug 06 18:52:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G9lrF-0005K9-G1
	for gcvg-git@gmane.org; Sun, 06 Aug 2006 18:52:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750818AbWHFQv5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 Aug 2006 12:51:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750822AbWHFQv4
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Aug 2006 12:51:56 -0400
Received: from moooo.ath.cx ([85.116.203.178]:65002 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S1750818AbWHFQv4 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Aug 2006 12:51:56 -0400
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24984>

Perhaps this script has a place in the git repository.  Creating some automated
tests at least checking for warnings should be easy too.  This should work from
the git repository and makes gitweb use .git as repository.  At the moment it
still needs the git binary to be in the path already to find the top repository
directory.

This could also be extended for automated tests.  Here is an example how this
could look like (currently this does not test much of gitweb):

#!/bin/sh
die() {
	echo "$0: $*" >&2
	exit 1
}

cleanup() {
	[ -e "$TMP" ] && rm "$TMP"
}

test() {
	echo "test: $@"
	"$gitweb" "$@" > /dev/null 2> "$TMP"
	if [ ! -s "$TMP" ]; then
		return
	fi
	echo "========== ERRORS =========="
	cat "$TMP"
	echo "============================"
}

gitweb="./`git rev-parse --show-cdup`/t/gitweb.sh"
TMP=""
trap cleanup EXIT
TMP="`mktemp`" || die mktemp failed

# repository overview
test
# summary
test p=.git

# commitdiff

# initial commit
test p=.git a=commitdiff \
	h=e83c5163316f89bfbde7d9ab23ca2e25604af290
# some other commit
test p=.git a=commitdiff \
	h=5a716826a6f7f209777f344143cdd9e4f2903097
# merge commit withouth specified parent
test p=.git a=commitdiff \
	h=e190bc55431d906b8c70dc07f8b6d823721f12c9
# merge commit with specified parent
test p=.git a=commitdiff \
	h=e190bc55431d906b8c70dc07f8b6d823721f12c9 \
	hp=360204c324ca9178e2bcb4d75f3986201f8ac7e1
---
 t/gitweb.sh          |   29 +++++++++++++++++++++++++++++
 t/gitweb_config.perl |    4 ++++
 2 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/t/gitweb.sh b/t/gitweb.sh
new file mode 100755
index 0000000..b0dff26
--- /dev/null
+++ b/t/gitweb.sh
@@ -0,0 +1,29 @@
+#!/bin/sh
+# this script runs gitweb.perl from the shell having .git as repository
+# command line parameters are used as query string
+
+TOPDIR="`pwd``git rev-parse --show-cdup`"
+if [ ! -e "$TOPDIR/git" ]; then
+	echo "$0: You haven't built things yet, have you?" >&2
+	exit 1
+fi
+
+export PATH="$TOPDIR:$PATH"
+export GIT_EXEC_PATH="$TOPDIR"
+
+# cgi environment
+export GATEWAY_INTERFACE=CGI/1.1
+export REQUEST_METHOD=GET
+QUERY_STRING=""
+if [ $# -gt 0 ]; then
+	QUERY_STRING="$1"
+	shift
+fi
+while [ $# -gt 0 ]; do
+	QUERY_STRING="$QUERY_STRING;$1"
+	shift
+done
+export QUERY_STRING
+
+export GITWEB_CONFIG="$TOPDIR/t/gitweb_config.perl"
+exec "$TOPDIR/gitweb/gitweb.perl"
diff --git a/t/gitweb_config.perl b/t/gitweb_config.perl
new file mode 100644
index 0000000..5c245ff
--- /dev/null
+++ b/t/gitweb_config.perl
@@ -0,0 +1,4 @@
+$projectroot = "./".qx(git rev-parse --show-cdup);
+chomp($projectroot);
+$projects_list = $projectroot;
+$GIT = $projectroot.'/git';
-- 
1.4.1.gfd699
