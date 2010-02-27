From: Thomas Schwinge <thomas@schwinge.name>
Subject: [PATCH] tg-push: Filter out plain SHA1s from being pushed.
Date: Sat, 27 Feb 2010 23:09:08 +0100
Message-ID: <1267308548-10136-1-git-send-email-thomas@schwinge.name>
Cc: git@vger.kernel.org, Thomas Schwinge <thomas@schwinge.name>
To: u.kleine-koenig@pengutronix.de
X-From: git-owner@vger.kernel.org Sat Feb 27 23:17:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NlUyb-0004Jl-1T
	for gcvg-git-2@lo.gmane.org; Sat, 27 Feb 2010 23:17:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936334Ab0B0WR2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Feb 2010 17:17:28 -0500
Received: from smtprelay03.ispgateway.de ([80.67.31.30]:55635 "EHLO
	smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936308Ab0B0WR1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Feb 2010 17:17:27 -0500
X-Greylist: delayed 492 seconds by postgrey-1.27 at vger.kernel.org; Sat, 27 Feb 2010 17:17:27 EST
Received: from [79.210.78.144] (helo=stokes.schwinge.homeip.net)
	by smtprelay03.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <thomas@dirichlet.schwinge.homeip.net>)
	id 1NlUqX-00067U-Oo
	for git@vger.kernel.org; Sat, 27 Feb 2010 23:09:13 +0100
Received: (qmail 23294 invoked from network); 27 Feb 2010 22:09:09 -0000
Received: from dslb-084-057-191-223.pools.arcor-ip.net (84.57.191.223)
  by stokes.schwinge.homeip.net with QMQP; 27 Feb 2010 22:09:09 -0000
Received: (nullmailer pid 10159 invoked by uid 1000);
	Sat, 27 Feb 2010 22:09:08 -0000
X-Mailer: git-send-email 1.6.0.4
X-Df-Sender: thomas@schwinge.name
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141235>

Otherwise, problems arise when branches depend (via .topdeps) on SHA1s:

    $ tg push -r tmp t/____longjmp_chk_cleanup_linux_x86_64
    fatal: 77c84aeb81808c3109665949448dba59965c391e cannot be resolved to branch.
    fatal: The remote end hung up unexpectedly
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


 tg-push.sh |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/tg-push.sh b/tg-push.sh
index cd208a0..28cad81 100644
--- a/tg-push.sh
+++ b/tg-push.sh
@@ -71,6 +71,9 @@ for name in $branches; do
 	$recurse_deps && [ -n "$_dep_is_tgish" ] &&
 		no_remotes=1 recurse_deps push_branch "$name"
 
+	# filter out plain SHA1s
 	# remove multiple occurrences of the same branch
-	sort -u "$_listfile" | xargs git push $dry_run "$remote"
+	grep -vE '^[0-9a-f]{40}$' < "$_listfile" \
+		| sort -u \
+			| xargs git push $dry_run "$remote"
 done
-- 
1.6.0.4
