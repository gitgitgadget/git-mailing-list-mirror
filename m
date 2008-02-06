From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] fix config reading in tests
Date: Wed, 6 Feb 2008 05:11:53 -0500
Message-ID: <20080206101153.GB1123@coredump.intra.peff.net>
References: <20080206092753.GA32264@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 06 11:12:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMhGV-000816-1M
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 11:12:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761066AbYBFKL5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2008 05:11:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760946AbYBFKL4
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 05:11:56 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2728 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761036AbYBFKLz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2008 05:11:55 -0500
Received: (qmail 27765 invoked by uid 111); 6 Feb 2008 10:11:54 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 06 Feb 2008 05:11:54 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Feb 2008 05:11:53 -0500
Content-Disposition: inline
In-Reply-To: <20080206092753.GA32264@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72789>

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
index da47bd7..83889c4 100644
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
+GIT_CONFIG_NOSYSTEM=1
+GIT_CONFIG_NOGLOBAL=1
+export PATH GIT_EXEC_PATH GIT_TEMPLATE_DIR GIT_CONFIG_NOSYSTEM GIT_CONFIG_NOGLOBAL
 
 GITPERLLIB=$(pwd)/../perl/blib/lib:$(pwd)/../perl/blib/arch/auto/Git
 export GITPERLLIB
-- 
1.5.4.25.g251c56-dirty
