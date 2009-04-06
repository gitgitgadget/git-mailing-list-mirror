From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/3] git remote update: Check args and fallback to
	remotes
Date: Mon, 6 Apr 2009 16:18:23 -0400
Message-ID: <20090406201823.GD28120@coredump.intra.peff.net>
References: <1239025262-16960-1-git-send-email-finnag@pvv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Finn Arne Gangstad <finnag@pvv.org>
X-From: git-owner@vger.kernel.org Mon Apr 06 22:20:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqvIo-0005IL-Mh
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 22:20:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753059AbZDFUSq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2009 16:18:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752378AbZDFUSp
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 16:18:45 -0400
Received: from peff.net ([208.65.91.99]:43481 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750784AbZDFUSp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2009 16:18:45 -0400
Received: (qmail 26490 invoked by uid 107); 6 Apr 2009 20:19:02 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 06 Apr 2009 16:19:02 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 06 Apr 2009 16:18:23 -0400
Content-Disposition: inline
In-Reply-To: <1239025262-16960-1-git-send-email-finnag@pvv.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115876>

On Mon, Apr 06, 2009 at 03:40:59PM +0200, Finn Arne Gangstad wrote:

> This series is on top of next.
> 
> git remote update <non-existing> would previously silently do nothing.
> With this patch series, it will (with 1/3) error out when non-existing groups
> are given, and with 2/3 & 3/3 it will use a remote if a group cannot be found.

Great, this was on my todo list so I am happy that procrastination saved
me some work. :)

The patches look fine to me, except that there are no tests. The patch
below adds a "remote groups" test script. There is a slight bit of
overlap with the update tests from t5505, but I don't think it is a
problem.

It is intended to be applied before your series. Your 1/3 would switch
t5506.3 from expect_failure to expect_success, and 3/3 would switch
t5506.6 from failure to success.

-- >8 --
Subject: [PATCH] add tests for remote groups

This tries to systematically cover existing behavior, and
also mark some expect_failure cases for desired behavior.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5506-remote-groups.sh |   81 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 81 insertions(+), 0 deletions(-)
 create mode 100755 t/t5506-remote-groups.sh

diff --git a/t/t5506-remote-groups.sh b/t/t5506-remote-groups.sh
new file mode 100755
index 0000000..6653a9c
--- /dev/null
+++ b/t/t5506-remote-groups.sh
@@ -0,0 +1,81 @@
+#!/bin/sh
+
+test_description='git remote group handling'
+. ./test-lib.sh
+
+mark() {
+	echo "$1" >mark
+}
+
+update_repo() {
+	(cd $1 &&
+	echo content >>file &&
+	git add file &&
+	git commit -F ../mark)
+}
+
+update_repos() {
+	update_repo one $1 &&
+	update_repo two $1
+}
+
+repo_fetched() {
+	if test "`git log -1 --pretty=format:%s $1 --`" = "`cat mark`"; then
+		echo >&2 "repo was fetched: $1"
+		return 0
+	fi
+	echo >&2 "repo was not fetched: $1"
+	return 1
+}
+
+test_expect_success 'setup' '
+	mkdir one && (cd one && git init) &&
+	mkdir two && (cd two && git init) &&
+	git remote add -m master one one &&
+	git remote add -m master two two
+'
+
+test_expect_success 'no group updates all' '
+	mark update-all &&
+	update_repos &&
+	git remote update &&
+	repo_fetched one &&
+	repo_fetched two
+'
+
+test_expect_failure 'nonexistant group produces error' '
+	mark nonexistant &&
+	update_repos &&
+	test_must_fail git remote update nonexistant &&
+	! repo_fetched one &&
+	! repo_fetched two
+'
+
+test_expect_success 'updating group updates all members' '
+	mark group-all &&
+	update_repos &&
+	git config --add remotes.all one &&
+	git config --add remotes.all two &&
+	git remote update all &&
+	repo_fetched one &&
+	repo_fetched two
+'
+
+test_expect_success 'updating group does not update non-members' '
+	mark group-some &&
+	update_repos &&
+	git config --add remotes.some one &&
+	git remote update some &&
+	repo_fetched one &&
+	! repo_fetched two
+'
+
+test_expect_failure 'updating remote name updates that remote' '
+	mark remote-name &&
+	update_repos &&
+	git remote update one &&
+	repo_fetched one &&
+	! repo_fetched two
+'
+
+test_done
-- 
1.6.2.2.585.g1e067
