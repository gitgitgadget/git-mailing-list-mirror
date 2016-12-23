Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7EDB01FF76
	for <e@80x24.org>; Fri, 23 Dec 2016 17:11:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761715AbcLWRLs (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Dec 2016 12:11:48 -0500
Received: from mout.gmx.net ([212.227.15.15]:52750 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755198AbcLWRLr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Dec 2016 12:11:47 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Likl3-1cqEIN3vmX-00cw0u; Fri, 23
 Dec 2016 18:11:35 +0100
Date:   Fri, 23 Dec 2016 18:11:33 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH] mingw: add a regression test for pushing to UNC paths
Message-ID: <9fb8a9f405b19db087379ea5bbad80c3fbac8e4e.1482513055.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:EzFHU8cvs0xhOr6asvB397j+OwZSKd7noCdVS0cB1ji/mWVh9ql
 fpRlN7BESPf4ZrularjbdzLvPMipDmysFrYgKh6h2mnudCPjVEjkeSWNXBJgCIIlBpt5EAq
 MR6Q0ca6tCu43xfvE8O/5yZ+lBeo5SEuV4aS2dLpLhypLoEYfgJ30cnKF+W+Vlng5dXOoZY
 FNnQCBb6Lez4UbIBOjQhA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:C1teMtW3gSI=:9giz+eNwa/OqbNUL94rnhq
 mkfM6NukSgz//gjly4etVjZeg3BqsfnMmOZSmMfTFHGPbSv5hIUDiLbT7XGVEy4HHD+qnzBDU
 WQE1VKTf+6kBBSVg092mYgxEvKtnFSrU1ONrfXUZJrfTE1dWrYax5sF7WPn+N8qL98amJ50+F
 OXgqUnw7mjWafVeNo+uA0jbJxDYqlEWsmVadpYkLSn6A7l5x0uyspsIueGASEA5nLEbBE8pVO
 dvq+71TytWJgMM6wc97rxcS5pTKQ5L6qo+LAHMBOJ3InqIL+MdOOX5JlAXl4aTE5zEBfMpEPy
 7Ym6BmUxLkgiCaqunP0DNV2fjQMEgLch1b5W45rdX9fcQxOwIpSN1krsGZnWlqGsXGP8+kwFW
 +UEGFV3Kms1Z3zTpnA2tNb33AAmPpMfP6j0SkP/z+83FRITu2doI9mJaUp4fraU7PKapuqnwE
 OOgySgbRoDKmkCLu31ks3EbLg72gmNNQqE23fPeCh8dX43xsS08zz/kDOZHgpD67HqxFrPCLS
 wV9cj2J1dpqQPCdUCoJU4riMrTNjwJLdczn9PWOgBTytbcCvrQMIapoufvgukmO4d/irEaV7E
 Ecne8CMdsias1zRurjNCZ+joe1AZUPIqHfVbHE2wLpnGTPhHFBLrouvz+vGqxBoP5O3HP7MoO
 ukZSFhwEzqWCVMQE3FnFsd3Yvy2IhGoYHy9BYfEpu6+owKFp76casJ8+hLLFB06NWmUl/NH76
 +HTe3gppE8pIN8AFlFFxnWzZiInICL6pAzRipfg/L4nfC110SUG9JiYh6hQUJh11Y881xae7a
 QCKOgJb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Windows, there are "UNC paths" to access network (AKA shared)
folders, of the form \\server\sharename\directory. This provides a
convenient way for Windows developers to share their Git repositories
without having to have a dedicated server.

Git for Windows v2.11.0 introduced a regression where pushing to said
UNC paths no longer works, although fetching and cloning still does, as
reported here: https://github.com/git-for-windows/git/issues/979

This regression was fixed in 7814fbe3f1 (normalize_path_copy(): fix
pushing to //server/share/dir on Windows, 2016-12-14).

Let's make sure that it does not regress again, by introducing a test
that uses so-called "administrative shares": disk volumes are
automatically shared under certain circumstances, e.g.  the C: drive is
shared as \\localhost\c$. The test needs to be skipped if the current
directory is inaccessible via said administrative share, of course.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
Published-As: https://github.com/dscho/git/releases/tag/unc-paths-test-v1
Fetch-It-Via: git fetch https://github.com/dscho/git unc-paths-test-v1

 t/t5580-clone-push-unc.sh | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100755 t/t5580-clone-push-unc.sh

diff --git a/t/t5580-clone-push-unc.sh b/t/t5580-clone-push-unc.sh
new file mode 100755
index 0000000000..e06d230724
--- /dev/null
+++ b/t/t5580-clone-push-unc.sh
@@ -0,0 +1,46 @@
+#!/bin/sh
+
+test_description='various UNC path tests (Windows-only)'
+. ./test-lib.sh
+
+if ! test_have_prereq MINGW; then
+	skip_all='skipping UNC path tests, requires Windows'
+	test_done
+fi
+
+UNCPATH="$(pwd)"
+case "$UNCPATH" in
+[A-Z]:*)
+	# Use administrative share e.g. \\localhost\C$\git-sdk-64\usr\src\git
+	# (we use forward slashes here because MSYS2 and Git accept them, and
+	# they are easier on the eyes)
+	UNCPATH="//localhost/${UNCPATH%%:*}\$/${UNCPATH#?:}"
+	test -d "$UNCPATH" || {
+		skip_all='could not access administrative share; skipping'
+		test_done
+	}
+	;;
+*)
+	skip_all='skipping UNC path tests, cannot determine current path as UNC'
+	test_done
+	;;
+esac
+
+test_expect_success setup '
+	test_commit initial
+'
+
+test_expect_success clone '
+	git clone "file://$UNCPATH" clone
+'
+
+test_expect_success push '
+	(
+		cd clone &&
+		git checkout -b to-push &&
+		test_commit to-push &&
+		git push origin HEAD
+	)
+'
+
+test_done

base-commit: 1ede815b8d1562f46b7aa5d55af084a3cad2ecf8
-- 
2.11.0.rc3.windows.1
