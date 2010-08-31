From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] tests: make test_must_fail more verbose
Date: Tue, 31 Aug 2010 11:56:36 -0400
Message-ID: <20100831155636.GA11530@sigill.intra.peff.net>
References: <20100831155457.GB11014@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 31 17:56:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqTCC-00086Y-HT
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 17:56:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753157Ab0HaP4T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Aug 2010 11:56:19 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:60090 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752115Ab0HaP4T (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Aug 2010 11:56:19 -0400
Received: (qmail 28374 invoked by uid 111); 31 Aug 2010 15:56:18 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 31 Aug 2010 15:56:18 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 31 Aug 2010 11:56:36 -0400
Content-Disposition: inline
In-Reply-To: <20100831155457.GB11014@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154923>

Because test_must_fail fails when a command succeeds, the
command frequently does not produce any output (since, after
all, it thought it was succeeding). So let's have
test_must_fail itself report that a problem occurred.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/test-lib.sh |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 3a3d4c4..285bfd8 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -591,7 +591,15 @@ test_path_is_missing () {
 
 test_must_fail () {
 	"$@"
-	test $? -gt 0 -a $? -le 129 -o $? -gt 192
+	exit_code=$?
+	if test $exit_code = 0; then
+		echo >&2 "test_must_fail: command succeeded: $*"
+		return 1
+	elif test $exit_code -gt 129 -a $exit_code -le 192; then
+		echo >&2 "test_must_fail: died by signal: $*"
+		return 1
+	fi
+	return 0
 }
 
 # Similar to test_must_fail, but tolerates success, too.  This is
-- 
1.7.2.2.119.gf9c33
