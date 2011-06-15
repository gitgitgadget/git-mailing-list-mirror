From: Jeff King <peff@peff.net>
Subject: [PATCH 7/7] archive: provide builtin .tar.gz filter
Date: Wed, 15 Jun 2011 18:35:01 -0400
Message-ID: <20110615223501.GG16807@sigill.intra.peff.net>
References: <20110615223030.GA16110@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"J.H." <warthog19@eaglescrag.net>, git@vger.kernel.org,
	git-dev@github.com
To: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Thu Jun 16 00:35:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWyg1-0000OR-KD
	for gcvg-git-2@lo.gmane.org; Thu, 16 Jun 2011 00:35:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753534Ab1FOWfF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jun 2011 18:35:05 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:45268
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752101Ab1FOWfE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jun 2011 18:35:04 -0400
Received: (qmail 7649 invoked by uid 107); 15 Jun 2011 22:35:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 15 Jun 2011 18:35:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Jun 2011 18:35:01 -0400
Content-Disposition: inline
In-Reply-To: <20110615223030.GA16110@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175863>

This works exactly as if the user had configured it via:

  [tarfilter "tgz"]
	command = gzip
	extension = tgz
	extension = tar.gz
	compressionlevels = true

but since it is so common, it's convenient to have it
builtin without the user needing to do anything.

Signed-off-by: Jeff King <peff@peff.net>
---
 archive-tar-filter.c |   12 ++++++++++++
 t/t5000-tar-tree.sh  |   48 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+), 0 deletions(-)

diff --git a/archive-tar-filter.c b/archive-tar-filter.c
index e749133..de8719a 100644
--- a/archive-tar-filter.c
+++ b/archive-tar-filter.c
@@ -126,6 +126,17 @@ static void remove_filters_without_command(void)
 	}
 }
 
+static void load_builtin_filters(void)
+{
+	struct tar_filter *tf;
+
+	tf = tar_filter_new("tgz", strlen("tgz"));
+	tf->command = xstrdup("gzip");
+	string_list_append(&tf->extensions, "tgz");
+	string_list_append(&tf->extensions, "tar.gz");
+	tf->use_compression = 1;
+}
+
 /*
  * We don't want to load twice, since some of our
  * values actually append rather than overwrite.
@@ -137,6 +148,7 @@ extern void tar_filter_load_config(void)
 		return;
 	tar_filter_config_loaded = 1;
 
+	load_builtin_filters();
 	git_config(tar_filter_config, NULL);
 	remove_filters_without_command();
 }
diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index fe661f3..ebad295 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -26,6 +26,7 @@ commit id embedding:
 
 . ./test-lib.sh
 UNZIP=${UNZIP:-unzip}
+GUNZIP=${GUNZIP:-gzip -d}
 
 SUBSTFORMAT=%H%n
 
@@ -306,4 +307,51 @@ test_expect_success 'extension matching requires dot' '
 	test_cmp b.tar config-implicittar.foo
 '
 
+test_expect_success 'git archive --format=tgz' '
+	git archive --format=tgz HEAD >j.tgz
+'
+
+test_expect_success 'infer tgz from .tgz filename' '
+	git archive --output=j1.tgz HEAD &&
+	test_cmp j.tgz j1.tgz
+'
+
+test_expect_success 'infer tgz from .tar.gz filename' '
+	git archive --output=j2.tar.gz HEAD &&
+	test_cmp j.tgz j2.tar.gz
+'
+
+if $GUNZIP --version >/dev/null 2>&1; then
+	test_set_prereq GUNZIP
+else
+	say "Skipping some tgz tests because gunzip was not found"
+fi
+
+test_expect_success GUNZIP 'extract tgz file' '
+	$GUNZIP -c <j.tgz >j.tar &&
+	test_cmp b.tar j.tar
+'
+
+test_expect_success GUNZIP 'tgz allows compression levels' '
+	git archive -1 --output=j3.tgz HEAD
+'
+
+test_expect_success 'disable builtin tgz via config' '
+	git config tarfilter.tgz.command ""
+'
+
+test_expect_success 'disabled filter does not appear in --list' '
+	git archive --list >output &&
+	! grep tgz output
+'
+
+test_expect_success 'disabled filter cannot be used' '
+	test_must_fail git archive --format=tgz HEAD >output
+'
+
+test_expect_success 'disabled filter does not match extensions' '
+	git archive -o disabled.tar.gz HEAD &&
+	test_cmp b.tar disabled.tar.gz
+'
+
 test_done
-- 
1.7.6.rc1.4.g49204
