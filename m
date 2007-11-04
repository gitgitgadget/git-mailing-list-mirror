Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=0.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: (qmail 16512 invoked by uid 111); 4 Nov 2007 10:31:15 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.32) with ESMTP; Sun, 04 Nov 2007 05:31:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755821AbXKDKbI (ORCPT <rfc822;peff@peff.net>);
	Sun, 4 Nov 2007 05:31:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755788AbXKDKbH
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 05:31:07 -0500
Received: from pan.madism.org ([88.191.52.104]:42909 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755136AbXKDKbE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 05:31:04 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 7A6632860D;
	Sun,  4 Nov 2007 11:31:03 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 68C241FED4; Sun,  4 Nov 2007 11:31:02 +0100 (CET)
From:	Pierre Habouzit <madcoder@debian.org>
To:	gitster@pobox.com
Cc:	git@vger.kernel.org, Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH 02/10] Update git-sh-setup(1) to allow transparent use of git-rev-parse --parseopt
Date:	Sun,  4 Nov 2007 11:30:54 +0100
Message-Id: <1194172262-1563-3-git-send-email-madcoder@debian.org>
X-Mailer: git-send-email 1.5.3.5.1498.g0c64
In-Reply-To: <1194172262-1563-2-git-send-email-madcoder@debian.org>
References: <1194172262-1563-1-git-send-email-madcoder@debian.org>
 <1194172262-1563-2-git-send-email-madcoder@debian.org>
To:	Junio C Hamano <gitster@pobox.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List:	git@vger.kernel.org

If you set OPTIONS_SPEC, git-sh-setups uses git-rev-parse --parseopt
automatically.

It also diverts usage to re-exec $0 with the -h option as parse-options.c
will catch that.

If you need git-rev-parse --parseopt to keep the `--` the user may have
passed to your command, just set OPTIONS_KEEPDASHDASH to a non empty value.

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 git-sh-setup.sh |   48 ++++++++++++++++++++++++++++++------------------
 1 files changed, 30 insertions(+), 18 deletions(-)

diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index 86d7d4c..e1cf885 100755
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -16,9 +16,36 @@ die() {
 	exit 1
 }
 
-usage() {
-	die "Usage: $0 $USAGE"
-}
+if test -n "$OPTIONS_SPEC"; then
+	usage() {
+		exec "$0" -h
+	}
+
+	parseopt_extra=
+	[ -n "$OPTIONS_KEEPDASHDASH" ] &&
+		parseopt_extra="$parseopt_extra --keep-dashdash"
+
+	eval `echo "$OPTIONS_SPEC" | git rev-parse --parseopt $parseopt_extra -- "$@" || echo exit $?`
+else
+	usage() {
+		die "Usage: $0 $USAGE"
+	}
+
+	if [ -z "$LONG_USAGE" ]
+	then
+		LONG_USAGE="Usage: $0 $USAGE"
+	else
+		LONG_USAGE="Usage: $0 $USAGE
+
+$LONG_USAGE"
+	fi
+
+	case "$1" in
+		-h|--h|--he|--hel|--help)
+		echo "$LONG_USAGE"
+		exit
+	esac
+fi
 
 set_reflog_action() {
 	if [ -z "${GIT_REFLOG_ACTION:+set}" ]
@@ -91,21 +118,6 @@ get_author_ident_from_commit () {
 	LANG=C LC_ALL=C sed -ne "$pick_author_script"
 }
 
-if [ -z "$LONG_USAGE" ]
-then
-	LONG_USAGE="Usage: $0 $USAGE"
-else
-	LONG_USAGE="Usage: $0 $USAGE
-
-$LONG_USAGE"
-fi
-
-case "$1" in
-	-h|--h|--he|--hel|--help)
-	echo "$LONG_USAGE"
-	exit
-esac
-
 # Make sure we are in a valid repository of a vintage we understand.
 if [ -z "$SUBDIRECTORY_OK" ]
 then
-- 
1.5.3.5.1509.g66d41

