From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 3/5] test-lib-functions: support "test_config -C <dir> ..."
Date: Sat,  5 Sep 2015 14:12:47 +0100
Message-ID: <1f82fa1a0f185ab4944ecbf6dd65adb21e77e04f.1441458341.git.john@keeping.me.uk>
References: <20150905085429.GB25039@sigill.intra.peff.net>
 <cover.1441458341.git.john@keeping.me.uk>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 05 15:13:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZYDHs-0008Pk-C8
	for gcvg-git-2@plane.gmane.org; Sat, 05 Sep 2015 15:13:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751798AbbIENNl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Sep 2015 09:13:41 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:56049 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751039AbbIENNk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Sep 2015 09:13:40 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 1B474CDA5D8;
	Sat,  5 Sep 2015 14:13:40 +0100 (BST)
X-Quarantine-ID: <o78HRbrOdu0h>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -0.199
X-Spam-Level: 
X-Spam-Status: No, score=-0.199 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_50=0.8, URIBL_BLOCKED=0.001] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id o78HRbrOdu0h; Sat,  5 Sep 2015 14:13:39 +0100 (BST)
Received: from river.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id C054CCDA46B;
	Sat,  5 Sep 2015 14:13:23 +0100 (BST)
X-Mailer: git-send-email 2.5.0.466.g9af26fa
In-Reply-To: <cover.1441458341.git.john@keeping.me.uk>
In-Reply-To: <cover.1441458341.git.john@keeping.me.uk>
References: <cover.1441458341.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277372>

If used in a subshell, test_config cannot unset variables at the end of
a test.  This is a problem when testing submodules because we do not
want to "cd" at to top level of a test script in order to run the
command inside the submodule.

Add a "-C" option to test_config (and test_unconfig) so that test_config
can be kept outside subshells and still affect subrepositories.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 t/test-lib-functions.sh | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index e8d3c0f..0e80f37 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -201,7 +201,14 @@ test_chmod () {
 
 # Unset a configuration variable, but don't fail if it doesn't exist.
 test_unconfig () {
-	git config --unset-all "$@"
+	config_dir=
+	if test "$1" = -C
+	then
+		shift
+		config_dir=$1
+		shift
+	fi
+	git ${config_dir:+-C "$config_dir"} config --unset-all "$@"
 	config_status=$?
 	case "$config_status" in
 	5) # ok, nothing to unset
@@ -213,8 +220,15 @@ test_unconfig () {
 
 # Set git config, automatically unsetting it after the test is over.
 test_config () {
-	test_when_finished "test_unconfig '$1'" &&
-	git config "$@"
+	config_dir=
+	if test "$1" = -C
+	then
+		shift
+		config_dir=$1
+		shift
+	fi
+	test_when_finished "test_unconfig ${config_dir:+-C '$config_dir'} '$1'" &&
+	git ${config_dir:+-C "$config_dir"} config "$@"
 }
 
 test_config_global () {
-- 
2.5.0.466.g9af26fa
