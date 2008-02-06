From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] fix config reading in tests
Date: Wed, 6 Feb 2008 04:07:55 -0500
Message-ID: <20080206090755.GB3258@coredump.intra.peff.net>
References: <20080206090453.GA6762@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 06 10:08:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMgGe-0004ZO-Ok
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 10:08:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759861AbYBFJIA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2008 04:08:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759814AbYBFJH7
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 04:07:59 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2939 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759745AbYBFJH5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2008 04:07:57 -0500
Received: (qmail 27293 invoked by uid 111); 6 Feb 2008 09:07:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 06 Feb 2008 04:07:56 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Feb 2008 04:07:55 -0500
Content-Disposition: inline
In-Reply-To: <20080206090453.GA6762@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72776>

Previously, we set the GIT_CONFIG environment variable in
our tests so that only that file was read. However, setting
it to a static value is not correct, since we are not
necessarily always in the same directory; instead, we want
the usual git config file lookup to happen.

To do this, we stop setting GIT_CONFIG, which means that we
must now suppress the reading of the system-wide and user
configs.

This exposes an incorrect test in t1500, which is also
fixed (the incorrect test worked because we were failing to
read the core.bare value from the config file, since the
GIT_CONFIG variable was pointing us to the wrong file).

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t1500-rev-parse.sh |    4 ++--
 t/test-lib.sh        |    7 +++++--
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
index e474b3f..38a2bf0 100755
--- a/t/t1500-rev-parse.sh
+++ b/t/t1500-rev-parse.sh
@@ -33,9 +33,9 @@ test_rev_parse() {
 test_rev_parse toplevel false false true ''
 
 cd .git || exit 1
-test_rev_parse .git/ true true false ''
+test_rev_parse .git/ false true false ''
 cd objects || exit 1
-test_rev_parse .git/objects/ true true false ''
+test_rev_parse .git/objects/ false true false ''
 cd ../.. || exit 1
 
 mkdir -p sub/dir || exit 1
diff --git a/t/test-lib.sh b/t/test-lib.sh
index da47bd7..40db00c 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -324,8 +324,11 @@ test_done () {
 PATH=$(pwd)/..:$PATH
 GIT_EXEC_PATH=$(pwd)/..
 GIT_TEMPLATE_DIR=$(pwd)/../templates/blt
-GIT_CONFIG=.git/config
-export PATH GIT_EXEC_PATH GIT_TEMPLATE_DIR GIT_CONFIG
+unset GIT_CONFIG
+unset GIT_CONFIG_LOCAL
+HOME=$(pwd)
+GIT_CONFIG_ETC=$GIT_CONFIG_LOCAL
+export PATH GIT_EXEC_PATH GIT_TEMPLATE_DIR HOME GIT_CONFIG_ETC
 
 GITPERLLIB=$(pwd)/../perl/blib/lib:$(pwd)/../perl/blib/arch/auto/Git
 export GITPERLLIB
-- 
1.5.4.26.g9be9
