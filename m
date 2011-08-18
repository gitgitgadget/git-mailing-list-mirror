From: Jeff King <peff@peff.net>
Subject: [PATCH 02/10] test-lib: add helper functions for config
Date: Wed, 17 Aug 2011 22:01:15 -0700
Message-ID: <20110818050114.GB2889@sigill.intra.peff.net>
References: <20110818045821.GA17377@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Steffen Daode Nurpmeso <sdaoden@googlemail.com>,
	Ingo =?utf-8?Q?Br=C3=BCckl?= <ib@wupperonline.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 18 07:01:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QtujN-0006fN-VF
	for gcvg-git-2@lo.gmane.org; Thu, 18 Aug 2011 07:01:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751774Ab1HRFBV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Aug 2011 01:01:21 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:35425
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751138Ab1HRFBV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2011 01:01:21 -0400
Received: (qmail 18231 invoked by uid 107); 18 Aug 2011 05:02:01 -0000
Received: from me42036d0.tmodns.net (HELO sigill.intra.peff.net) (208.54.32.228)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 18 Aug 2011 01:02:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 17 Aug 2011 22:01:15 -0700
Content-Disposition: inline
In-Reply-To: <20110818045821.GA17377@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179559>

There are a few common tasks when working with configuration
variables in tests; this patch aims to make them a little
easier to write and less error-prone.

When setting a variable, you should typically make sure to
clean it up after the test is finished, so as not to pollute
other tests. Like:

   test_when_finished 'git config --unset foo.bar' &&
   git config foo.bar baz

This patch lets you just write:

  test_config foo.bar baz

When clearing a variable that does not exist, git-config
will report a specific non-zero error code. Meaning that
tests which call "git config --unset" often either rely on
the prior tests having actually set it, or must use
test_might_fail. With this patch, the previous:

  test_might_fail git config --unset foo.bar

becomes:

  test_unconfig foo.bar

Not only is this easier to type, but it is more robust; it
will correctly detect errors from git-config besides "key
was not set".

Signed-off-by: Jeff King <peff@peff.net>
---
 t/test-lib.sh |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index df25f17..926667a 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -357,6 +357,24 @@ test_chmod () {
 	git update-index --add "--chmod=$@"
 }
 
+# Unset a configuration variable, but don't fail if it doesn't exist.
+test_unconfig () {
+	git config --unset-all "$@"
+	config_status=$?
+	case "$config_status" in
+	5) # ok, nothing to usnet
+		config_status=0
+		;;
+	esac
+	return $config_status
+}
+
+# Set git config, automatically unsetting it after the test is over.
+test_config () {
+	test_when_finished "test_unconfig '$1'" &&
+	git config "$@"
+}
+
 # Use test_set_prereq to tell that a particular prerequisite is available.
 # The prerequisite can later be checked for in two ways:
 #
-- 
1.7.6.10.g62f04
