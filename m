From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 2/2] clone: ignore --depth when cloning locally (implicitly
 --local)
Date: Fri, 27 Feb 2009 00:31:25 +0100 (CET)
Message-ID: <5adb270495925f887a1101c6f63828883e1b9b2c.1235690903u.git.johannes.schindelin@gmx.de>
References: <alpine.DEB.1.00.0902262352380.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Feb 27 00:31:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lcphj-0000Ri-Rp
	for gcvg-git-2@gmane.org; Fri, 27 Feb 2009 00:31:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755489AbZBZXaN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2009 18:30:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751734AbZBZXaM
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Feb 2009 18:30:12 -0500
Received: from mail.gmx.net ([213.165.64.20]:52467 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755416AbZBZXaK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2009 18:30:10 -0500
Received: (qmail invoked by alias); 26 Feb 2009 23:30:07 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp068) with SMTP; 27 Feb 2009 00:30:07 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+ck54/Kkmch8C09qG6yK1QOoNLofIi3pW/HF9545
	6cedUd8tpzqbv6
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.DEB.1.00.0902262352380.10279@pacific.mpi-cbg.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111611>

When cloning locally, we default to --local, as it makes the whole
operation fast and efficient.

As the most common intent of cloning with a --depth parameter is to
save space, and --local saves more space than --depth ever can,
warn the user and ignore the --depth parameter when cloning locally.

Should --depth be desired, the user can always force proper cloning
by passing the --no-hardlinks parameter, or by using a file:// URL.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/git-clone.txt |    4 ++++
 builtin-clone.c             |    5 ++++-
 t/t5701-clone-local.sh      |   14 ++++++++++++++
 3 files changed, 22 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 95f08b9..9b8b389 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -138,6 +138,10 @@ then the cloned repository will become corrupt.
 	are only interested in the recent history of a large project
 	with a long history, and would want to send in fixes
 	as patches.
++
+This option is ignored when cloning locally; to force a shallow
+clone even locally, use the `--no-hardlinks` option, or a
+'file://' location.
 
 <repository>::
 	The (possibly remote) repository to clone from.  See the
diff --git a/builtin-clone.c b/builtin-clone.c
index 5540372..73d5a76 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -511,8 +511,11 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	refspec.src = src_ref_prefix;
 	refspec.dst = branch_top.buf;
 
-	if (path && !is_bundle && use_local_hardlinks)
+	if (path && !is_bundle && use_local_hardlinks) {
+		if (option_depth)
+			warning("Ignoring --depth for local clone");
 		refs = clone_local(path, git_dir);
+	}
 	else {
 		struct remote *remote = remote_get(argv[0]);
 		transport = transport_get(remote, remote->url[0]);
diff --git a/t/t5701-clone-local.sh b/t/t5701-clone-local.sh
index 3559d17..8600539 100755
--- a/t/t5701-clone-local.sh
+++ b/t/t5701-clone-local.sh
@@ -132,4 +132,18 @@ test_expect_success 'clone empty repository' '
 	 test $actual = $expected)
 '
 
+test_expect_success 'clone --depth locally ignores --depth' '
+	test_commit meredith chivers && git tag -d meredith &&
+	test_commit lisa diamond && git tag -d lisa &&
+	git clone --depth 1 . depth 2> out.err &&
+	grep "warning: Ignoring --depth for local clone" out.err &&
+	test 2 -lt $(cd depth && git rev-list master | wc -l)
+'
+
+test_expect_success '--depth is not ignored with --no-hardlinks' '
+	git clone --depth 1 --no-hardlinks . depth2 2> out.err &&
+	! grep "warning: Ignoring --depth for local clone" out.err &&
+	test 2 = $(cd depth2 && git rev-list master | wc -l)
+'
+
 test_done
-- 
1.6.2.rc2.404.g8394e
