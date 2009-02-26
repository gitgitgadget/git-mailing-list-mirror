From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH] clone: ignore --depth when cloning locally (implicitly
 --local)
Date: Thu, 26 Feb 2009 19:20:19 +0100 (CET)
Message-ID: <1f63785d96d243ff19a063f684abbbe46cafc075.1235672273u.git.johannes.schindelin@gmx.de>
References: <cover.1235672273u.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Feb 26 19:22:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lckro-0001tz-KV
	for gcvg-git-2@gmane.org; Thu, 26 Feb 2009 19:21:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751819AbZBZSUZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2009 13:20:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751451AbZBZSUZ
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Feb 2009 13:20:25 -0500
Received: from mail.gmx.net ([213.165.64.20]:40041 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751408AbZBZSUY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2009 13:20:24 -0500
Received: (qmail invoked by alias); 26 Feb 2009 18:20:20 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp034) with SMTP; 26 Feb 2009 19:20:20 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19oDo8tkx9oXoz//y9zqDp3zJZIAP4JD/Efn0valC
	AnIqSRKh/VWOmC
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <cover.1235672273u.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.52
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111585>

When cloning locally, we default to --local, as it makes the whole
operation fast and efficient.

As the most common intent of cloning with a --depth parameter is to
save space, and --local saves space more than --depth ever can,
warn the user and ignore the --depth parameter when cloning locally.

Should --depth be desired, the user can always force proper cloning
by using a file:// URL.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	Before making git-clone a builtin, we had code to force a clone 
	when a --depth parameter was passed.  However, it is dubitable 
	that a user wants --depth rather than --local, and as in the 
	--local case, we should cater for the common case.

 Documentation/git-clone.txt |    4 ++++
 builtin-clone.c             |    5 ++++-
 t/t5701-clone-local.sh      |    7 +++++++
 3 files changed, 15 insertions(+), 1 deletions(-)

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
index c338910..5831034 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -511,8 +511,11 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	refspec.src = src_ref_prefix;
 	refspec.dst = branch_top.buf;
 
-	if (path && !is_bundle)
+	if (path && !is_bundle) {
+		if (option_depth)
+			warning("Ignoring --depth for local clone");
 		refs = clone_local(path, git_dir);
+	}
 	else {
 		struct remote *remote = remote_get(argv[0]);
 		transport = transport_get(remote, remote->url[0]);
diff --git a/t/t5701-clone-local.sh b/t/t5701-clone-local.sh
index 3559d17..2938c02 100755
--- a/t/t5701-clone-local.sh
+++ b/t/t5701-clone-local.sh
@@ -132,4 +132,11 @@ test_expect_success 'clone empty repository' '
 	 test $actual = $expected)
 '
 
+test_expect_success 'clone --depth locally ignores --depth' '
+	test_commit meredith chivers &&
+	git clone --depth 1 . depth 2> out.err &&
+	grep "warning: Ignoring --depth for local clone" out.err &&
+	test 1 -lt $(cd depth && git rev-list master | wc -l)
+'
+
 test_done
-- 
1.6.2.rc1.350.g6caf6
