Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=1.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: (qmail 15241 invoked by uid 111); 19 Sep 2008 09:16:56 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.32) with ESMTP; Fri, 19 Sep 2008 05:16:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751017AbYISJQl (ORCPT <rfc822;peff@peff.net>);
	Fri, 19 Sep 2008 05:16:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750914AbYISJQk
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Sep 2008 05:16:40 -0400
Received: from vs281.server4u.cz ([81.91.85.31]:52937 "EHLO vs281.server4u.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750709AbYISJQj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Sep 2008 05:16:39 -0400
Received: from localhost ([127.0.0.1] helo=roro3)
	by vs281.server4u.cz with esmtp (Exim 4.69)
	(envelope-from <kirr@landau.phys.spbu.ru>)
	id 1KgcD3-0000hj-LE; Fri, 19 Sep 2008 11:23:29 +0200
Received: from kirr by roro3 with local (Exim 4.69)
	(envelope-from <kirr@roro3>)
	id 1KgbyP-0006XM-Rv; Fri, 19 Sep 2008 13:08:21 +0400
From:	Kirill Smelkov <kirr@landau.phys.spbu.ru>
To:	Petr Baudis <pasky@suse.cz>
Cc:	Kirill Smelkov <kirr@landau.phys.spbu.ru>,
	Git Mailing List <git@vger.kernel.org>
Subject: [TopGit RFC PATCH] tg mail: new command for mailing patches
Date:	Fri, 19 Sep 2008 13:08:21 +0400
Message-Id: <1221815301-25090-1-git-send-email-kirr@landau.phys.spbu.ru>
X-Mailer: git-send-email 1.6.0.2.250.g965aa
To:	Petr Baudis <pasky@suse.cz>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Petr, since you've asked for help on this, here you are:

    $ tg mail [NAME]

a simple script to send one patch over email.


All it does is

    - call `tg patch` for actual patch preparation
    - extract email addresses from whom and where to send a mail
    - boils down to `git send-email`


It is self-hosted -- this mail was send by me with

    $ tg mail t/tg-mail


P.S. I'm not a bash guy, please do not beat me too much...

Signed-off-by: Kirill Smelkov <kirr@landau.phys.spbu.ru>

---
 .gitignore |    2 ++
 README     |   18 ++++++++++++++++++
 tg-mail.sh |   53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 73 insertions(+), 0 deletions(-)

diff --git a/.gitignore b/.gitignore
index aa39db4..df4a662 100644
--- a/.gitignore
+++ b/.gitignore
@@ -5,6 +5,8 @@ tg-delete
 tg-delete.txt
 tg-info
 tg-info.txt
+tg-mail
+tg-mail.txt
 tg-patch
 tg-patch.txt
 tg-summary
diff --git a/README b/README
index b99b036..1a001a6 100644
--- a/README
+++ b/README
@@ -272,6 +272,24 @@ tg patch
 	TODO: tg patch -i to base at index instead of branch,
 		-w for working tree
 
+tg mail
+~~~~~~~
+	Send a patch from the current or specified topic branch as
+	email.
+
+	Takes the patch given on the command line and emails it out.
+	Destination addresses such as To, Cc and Bcc are taken from the
+	patch header.
+
+	Since it actually boils down to `git send-email` please refer to
+	it's documentation for details on how to setup email for git.
+
+
+	TODO: tg mail patchfile  to mail an already exported patch
+	TODO: mailing patch series
+	TODO: specifying additional options and addresses on command
+	      line
+
 tg remote
 ~~~~~~~~~
 	Register given remote as TopGit-controlled. This will create
diff --git a/tg-mail.sh b/tg-mail.sh
new file mode 100644
index 0000000..f3abd2c
--- /dev/null
+++ b/tg-mail.sh
@@ -0,0 +1,53 @@
+#!/bin/sh
+# TopGit - A different patch queue manager
+# GPLv2
+
+name=
+
+
+## Parse options
+
+while [ -n "$1" ]; do
+	arg="$1"; shift
+	case "$arg" in
+	-*)
+		echo "Usage: tg [...] mail [NAME]" >&2
+		exit 1;;
+	*)
+		[ -z "$name" ] || die "name already specified ($name)"
+		name="$arg";;
+	esac
+done
+
+# TODO refactor me into something common?
+[ -n "$name" ] || name="$(git symbolic-ref HEAD | sed 's#^refs/heads/##')"
+base_rev="$(git rev-parse --short --verify "refs/top-bases/$name" 2>/dev/null)" ||
+	die "not a TopGit-controlled branch"
+
+
+patchfile="$(mktemp -t tg-mail.XXXXXX)"
+
+$tg patch $name >"$patchfile"
+
+hlines=$(grep -n -m 1 '^---' "$patchfile" | sed 's/:---//')
+header=$(head -$(($hlines - 1)) "$patchfile")
+
+
+
+from="$(echo "$header" | grep '^From:' | sed 's/From:\s*//')"
+to="$(echo "$header" | grep '^To:' | sed 's/To:\s*//')"
+
+
+# XXX I can't get quoting right without arrays
+[ -n "$from" ] && from=(--from "$from")
+[ -n "$to"   ] && to=(--to "$to") # FIXME there could be multimple To
+
+people=()
+[ -n "$from" ] && people=("${people[@]}" "${from[@]}")
+[ -n "$to" ]   && people=("${people[@]}" "${to[@]}")
+
+
+# NOTE git-send-email handles cc itself
+git send-email "${people[@]}" "$patchfile"
+
+rm "$patchfile"
-- 
tg: (6b5d0b8..) t/tg-mail (depends on: kirr)
