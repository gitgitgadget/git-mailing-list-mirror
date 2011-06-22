From: Jeff King <peff@peff.net>
Subject: [PATCHv2 8/9] archive: provide builtin .tar.gz filter
Date: Tue, 21 Jun 2011 21:27:35 -0400
Message-ID: <20110622012735.GH30604@sigill.intra.peff.net>
References: <20110622011923.GA30370@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	"J.H." <warthog19@eaglescrag.net>, git@vger.kernel.org,
	git-dev@github.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 22 03:27:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZCEJ-0006Aw-Nu
	for gcvg-git-2@lo.gmane.org; Wed, 22 Jun 2011 03:27:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757798Ab1FVB1i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jun 2011 21:27:38 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51571
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757729Ab1FVB1h (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2011 21:27:37 -0400
Received: (qmail 7603 invoked by uid 107); 22 Jun 2011 01:27:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 21 Jun 2011 21:27:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Jun 2011 21:27:35 -0400
Content-Disposition: inline
In-Reply-To: <20110622011923.GA30370@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176211>

This works exactly as if the user had configured it via:

  [tar "tgz"]
	command = gzip -cn
  [tar "tar.gz"]
	command = gzip -cn

but since it is so common, it's convenient to have it
builtin without the user needing to do anything.

Signed-off-by: Jeff King <peff@peff.net>
---
Similar to v1, but rebased. And with docs.

 Documentation/git-archive.txt |   11 +++++++++++
 archive-tar.c                 |    2 ++
 t/t5000-tar-tree.sh           |   38 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 51 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.txt
index 726bf63..8b0080a 100644
--- a/Documentation/git-archive.txt
+++ b/Documentation/git-archive.txt
@@ -110,6 +110,9 @@ tar.<format>.command::
 	to the command (e.g., "-9"). An output file with the same
 	extension as `<format>` will be use this format if no other
 	format is given.
++
+The "tar.gz" and "tgz" formats are defined automatically and default to
+`gzip -cn`. You may override them with custom commands.
 
 ATTRIBUTES
 ----------
@@ -143,6 +146,14 @@ git archive --format=tar --prefix=git-1.4.0/ v1.4.0 | gzip >git-1.4.0.tar.gz::
 
 	Create a compressed tarball for v1.4.0 release.
 
+git archive --format=tar.gz --prefix=git-1.4.0/ v1.4.0 >git-1.4.0.tar.gz::
+
+	Same as above, but using the builtin tar.gz handling.
+
+git archive --prefix=git-1.4.0/ -o git-1.4.0.tar.gz v1.4.0::
+
+	Same as above, but the format is inferred from the output file.
+
 git archive --format=tar --prefix=git-1.4.0/ v1.4.0{caret}\{tree\} | gzip >git-1.4.0.tar.gz::
 
 	Create a compressed tarball for v1.4.0 release, but without a
diff --git a/archive-tar.c b/archive-tar.c
index 5c30747..f470ebe 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -357,6 +357,8 @@ void init_tar_archiver(void)
 	int i;
 	register_archiver(&tar_archiver);
 
+	tar_filter_config("tar.tgz.command", "gzip -cn", NULL);
+	tar_filter_config("tar.tar.gz.command", "gzip -cn", NULL);
 	git_config(git_tar_config, NULL);
 	for (i = 0; i < nr_tar_filters; i++) {
 		/* omit any filters that never had a command configured */
diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index 1f90692..070250e 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -26,6 +26,8 @@ commit id embedding:
 
 . ./test-lib.sh
 UNZIP=${UNZIP:-unzip}
+GZIP=${GZIP:-gzip}
+GUNZIP=${GUNZIP:-gzip -d}
 
 SUBSTFORMAT=%H%n
 
@@ -295,4 +297,40 @@ test_expect_success 'extension matching requires dot' '
 	test_cmp b.tar config-implicittar.foo
 '
 
+if $GZIP --version >/dev/null 2>&1; then
+	test_set_prereq GZIP
+else
+	say "Skipping some tar.gz tests because gzip not found"
+fi
+
+test_expect_success GZIP 'git archive --format=tgz' '
+	git archive --format=tgz HEAD >j.tgz
+'
+
+test_expect_success GZIP 'git archive --format=tar.gz' '
+	git archive --format=tar.gz HEAD >j1.tar.gz &&
+	test_cmp j.tgz j1.tar.gz
+'
+
+test_expect_success GZIP 'infer tgz from .tgz filename' '
+	git archive --output=j2.tgz HEAD &&
+	test_cmp j.tgz j2.tgz
+'
+
+test_expect_success GZIP 'infer tgz from .tar.gz filename' '
+	git archive --output=j3.tar.gz HEAD &&
+	test_cmp j.tgz j3.tar.gz
+'
+
+if $GUNZIP --version >/dev/null 2>&1; then
+	test_set_prereq GUNZIP
+else
+	say "Skipping some tar.gz tests because gunzip was not found"
+fi
+
+test_expect_success GZIP,GUNZIP 'extract tgz file' '
+	$GUNZIP -c <j.tgz >j.tar &&
+	test_cmp b.tar j.tar
+'
+
 test_done
-- 
1.7.5.4.44.g4b107
