Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: (qmail 28463 invoked by uid 107); 28 Feb 2010 13:58:37 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.180.67)
    by peff.net (qpsmtpd/0.40) with ESMTP; Sun, 28 Feb 2010 08:58:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935829Ab0B1N6O (ORCPT <rfc822;peff@peff.net>);
	Sun, 28 Feb 2010 08:58:14 -0500
Received: from smtprelay01.ispgateway.de ([80.67.31.39]:41774 "EHLO
	smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754088Ab0B1N6O (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Feb 2010 08:58:14 -0500
Received: from [79.210.50.103] (helo=stokes.schwinge.homeip.net)
	by smtprelay01.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <thomas@dirichlet.schwinge.homeip.net>)
	id 1Nljer-0000RR-2m
	for git@vger.kernel.org; Sun, 28 Feb 2010 14:58:09 +0100
Received: (qmail 1297 invoked from network); 28 Feb 2010 13:57:42 -0000
Received: from dslb-084-057-207-194.pools.arcor-ip.net (84.57.207.194)
  by stokes.schwinge.homeip.net with QMQP; 28 Feb 2010 13:57:42 -0000
Received: (nullmailer pid 29825 invoked by uid 1000);
	Sun, 28 Feb 2010 13:57:41 -0000
From:	Thomas Schwinge <thomas@schwinge.name>
To:	u.kleine-koenig@pengutronix.de
Cc:	Thomas Schwinge <thomas@schwinge.name>, git@vger.kernel.org
Subject: [PATCH] tg-push: Filter out plain SHA1s from being pushed.
Date:	Sun, 28 Feb 2010 14:57:41 +0100
Message-Id: <1267365461-29801-1-git-send-email-thomas@schwinge.name>
X-Mailer: git-send-email 1.6.0.4
In-Reply-To: <20100228101807.GB13987@pengutronix.de>
References: <20100228101807.GB13987@pengutronix.de>
To:	u.kleine-koenig@pengutronix.de
X-Df-Sender: thomas@schwinge.name
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Otherwise, problems arise when branches depend (via .topdeps) on SHA1s:

    $ tg push -r tmp t/____longjmp_chk_cleanup_linux_x86_64
    fatal: 77c84aeb81808c3109665949448dba59965c391e cannot be resolved to branch.
    fatal: The remote end hung up unexpectedly

Signed-off-by: Thomas Schwinge <thomas@schwinge.name>

---

Hello!

I was facing the following problem:

    thomas@dirichlet:~/tmp/source/glibc/git/glibc.hurd $ bash -v -x /usr/bin/tg push -r tmp t/____longjmp_chk_cleanup_linux_x86_64
    [...]
    ++ read _dep
    ++ missing_deps=
    ++ rm /tmp/tg-depsfile.nCfywI
    ++ return 0
    ++ xargs git push tmp
    ++ sort -u /tmp/tg-push-listfile.sZeHIr
    fatal: 77c84aeb81808c3109665949448dba59965c391e cannot be resolved to branch.
    fatal: The remote end hung up unexpectedly
    rm -f "/tmp/tg-push-listfile.sZeHIr"
    + rm -f /tmp/tg-push-listfile.sZeHIr

That's the actual problem:

    thomas@dirichlet:~/tmp/source/glibc/git/glibc.hurd $ git push tmp 77c84aeb81808c3109665949448dba59965c391e
    fatal: 77c84aeb81808c3109665949448dba59965c391e cannot be resolved to branch.
    fatal: The remote end hung up unexpectedly

... which is due to:

    $ git show t/____longjmp_chk_cleanup_linux_x86_64:.topdeps
    77c84aeb81808c3109665949448dba59965c391e

All other parts (at least those I tested / got to use so far) work just
fine when passing SHA1s.

Here is a patch to make this work for tg push, too.

    thomas@dirichlet:~/tmp/source/glibc/git/glibc.hurd $ tg push -r tmp t/____longjmp_chk_cleanup_linux_x86_64
    Counting objects: 196207, done.
    Compressing objects: 100% (32953/32953), done.
    Writing objects: 100% (196207/196207), 66.45 MiB | 4047 KiB/s, done.
    Total 196207 (delta 163379), reused 191592 (delta 159243)
    To /media/Stalin/tmp/glibc
     * [new branch]      t/____longjmp_chk_cleanup_linux_x86_64 -> t/____longjmp_chk_cleanup_linux_x86_64
     * [new branch]      refs/top-bases/t/____longjmp_chk_cleanup_linux_x86_64 -> refs/top-bases/t/____longjmp_chk_cleanup_linux_x86_64

 tg-push.sh |    3 +++
 tg.sh      |    7 +++++++
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/tg-push.sh b/tg-push.sh
index cd208a0..089f885 100644
--- a/tg-push.sh
+++ b/tg-push.sh
@@ -53,6 +53,9 @@ push_branch()
 	# if so desired omit non tgish deps
 	$tgish_deps_only && [ -z "$_dep_is_tgish" ] && return 0
 
+	# filter out plain SHA1s
+	is_sha1 "$_dep" && return 0
+
 	echo "$_dep" >> "$_listfile"
 	[ -z "$_dep_is_tgish" ] ||
 		echo "top-bases/$_dep" >> "$_listfile"
diff --git a/tg.sh b/tg.sh
index 1f6d3da..91c374a 100644
--- a/tg.sh
+++ b/tg.sh
@@ -126,6 +126,13 @@ branch_annihilated()
 	test "$(git rev-parse "$mb^{tree}")" = "$(git rev-parse "$_name^{tree}")";
 }
 
+# is_sha1 REF
+# Whether REF is a SHA1 (compared to a symbolic name).
+is_sha1()
+{
+	[ "$(git rev-parse "$1")" = "$1" ]
+}
+
 # recurse_deps CMD NAME [BRANCHPATH...]
 # Recursively eval CMD on all dependencies of NAME.
 # CMD can refer to $_name for queried branch name,
-- 
tg: (341a371..) t/tg_push_no_SHA1 (depends on: master)
