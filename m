Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=1.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: (qmail 16123 invoked by uid 111); 2 Nov 2007 15:09:37 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.32) with ESMTP; Fri, 02 Nov 2007 11:09:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754288AbXKBPJ1 (ORCPT <rfc822;peff@peff.net>);
	Fri, 2 Nov 2007 11:09:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754221AbXKBPJ1
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 11:09:27 -0400
Received: from pan.madism.org ([88.191.52.104]:50888 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754207AbXKBPJZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 11:09:25 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 79D5B28145;
	Fri,  2 Nov 2007 16:09:23 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 8BFDC347A56; Fri,  2 Nov 2007 16:09:22 +0100 (CET)
From:	Pierre Habouzit <madcoder@debian.org>
To:	gitster@pobox.com, torvalds@linux-foundation.org
Cc:	git@vger.kernel.org, Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH] Update git-sh-setup(1) to allow transparent use of git-parseopt(1)
Date:	Fri,  2 Nov 2007 16:09:20 +0100
Message-Id: <1194016162-23599-3-git-send-email-madcoder@debian.org>
X-Mailer: git-send-email 1.5.3.5.1458.g2aa13-dirty
In-Reply-To: <1194016162-23599-2-git-send-email-madcoder@debian.org>
References: alpine.LFD.0.999.0711011129460.3342@woody.linux-foundation.org
 <1194016162-23599-1-git-send-email-madcoder@debian.org>
 <1194016162-23599-2-git-send-email-madcoder@debian.org>
To:	Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List:	git@vger.kernel.org

If you set OPTIONS_SPEC, git-sh-setups uses git-parseopt automatically.
It also diverts usage to re-exec $0 with the -h option as parse-options.c
will catch that.

PARSEOPT_OPTS can also be used to pass options git git-parseopt(1) (like
--keep-dashdash).
---
 git-sh-setup.sh |   44 ++++++++++++++++++++++++++------------------
 1 files changed, 26 insertions(+), 18 deletions(-)

diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index 86d7d4c..d7b13e0 100755
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -16,9 +16,32 @@ die() {
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
+	eval `echo "$OPTIONS_SPEC" | git parseopt $PARSEOPT_OPTS -- "$@" || echo exit $?`
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
@@ -91,21 +114,6 @@ get_author_ident_from_commit () {
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
1.5.3.5.1458.g2aa13-dirty

