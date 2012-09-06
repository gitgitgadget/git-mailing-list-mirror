From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 7/8] real_path(): properly handle nonexistent top-level paths
Date: Fri,  7 Sep 2012 00:41:03 +0200
Message-ID: <1346971264-23744-8-git-send-email-mhagger@alum.mit.edu>
References: <1346971264-23744-1-git-send-email-mhagger@alum.mit.edu>
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	Orgad and Raizel Shaneh <orgads@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 07 00:42:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9klv-0007lO-Gc
	for gcvg-git-2@plane.gmane.org; Fri, 07 Sep 2012 00:42:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755016Ab2IFWlt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Sep 2012 18:41:49 -0400
Received: from ALUM-MAILSEC-SCANNER-4.MIT.EDU ([18.7.68.15]:56635 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754890Ab2IFWlp (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Sep 2012 18:41:45 -0400
X-AuditID: 1207440f-b7fde6d00000095c-81-504926a85c00
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 31.4B.02396.8A629405; Thu,  6 Sep 2012 18:41:44 -0400 (EDT)
Received: from michael.berlin.jpk.com (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q86MfGJZ025515
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 6 Sep 2012 18:41:43 -0400
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1346971264-23744-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFIsWRmVeSWpSXmKPExsUixO6iqLtCzTPA4Ge/kEXXlW4mi4beK8wW
	T+beZba4vWI+s8X6RQ2sFt1T3jI6sHn8ff+ByWPnrLvsHg9fdbF7XLyk7PF5k1wAaxS3TVJi
	SVlwZnqevl0Cd8bNmY0sBS+4K86dDmlg3MjZxcjJISFgIrFtwhomCFtM4sK99WxdjFwcQgKX
	GSVmnX/IDuGcZpI4+nkSG0gVm4CuxKKeZrAOEQE1iYlth1hAbGaB84wSf26yg9jCAgES9zqP
	g9ksAqoSq65sYwaxeQVcJO6cPQm1TVHix/c1QHEODk4BV4lpC+RAwkJAJfPe32abwMi7gJFh
	FaNcYk5prm5uYmZOcWqybnFyYl5eapGuiV5uZoleakrpJkZIaPHvYOxaL3OIUYCDUYmH1+is
	R4AQa2JZcWXuIUZJDiYlUd5/Sp4BQnxJ+SmVGYnFGfFFpTmpxYcYJTiYlUR4J/4CKudNSays
	Si3Kh0lJc7AoifOqL1H3ExJITyxJzU5NLUgtgsnKcHAoSfDOVAUaKliUmp5akZaZU4KQZuLg
	BBFcIBt4gDYEgBTyFhck5hZnpkMUnWJUlBLnLQJJCIAkMkrz4AbAksArRnGgf4R5u0CqeIAJ
	BK77FdBgJqDBIs9ATi8uSURISTUwbn5xPmdPqtPBG8EVP5kYvUzZPijtrrs90zDr6IuZc7es
	Ut3K8cRM1OvpYVmtt9vWni+7vjDo5/r22JDM5+YZKxzzpr47atrIcuxJkNlZcQVZLT3/nLJj
	FXNP/c8smcy6LTmmzy+4/tmOmQGvlBKuTlvqN2Ef32fxzjUyf6OuROuoKnruaL4Y 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204937>

The change has two points:

1. Do not strip off a leading slash, because that erroneously turns an
   absolute path into a relative path.

2. Do not remove slashes from groups of multiple slashes; instead let
   chdir() handle them.  It could be, for example, that it wants to
   leave leading double-slashes alone.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 abspath.c             | 2 +-
 t/t0060-path-utils.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/abspath.c b/abspath.c
index 3e8325c..05f2d79 100644
--- a/abspath.c
+++ b/abspath.c
@@ -45,8 +45,8 @@ const char *real_path(const char *path)
 		if (!is_directory(buf)) {
 			char *last_slash = find_last_dir_sep(buf);
 			if (last_slash) {
-				*last_slash = '\0';
 				last_elem = xstrdup(last_slash + 1);
+				last_slash[1] = '\0';
 			} else {
 				last_elem = xstrdup(buf);
 				*buf = '\0';
diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index 3121691..30361f9 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -148,7 +148,7 @@ test_expect_success 'real path rejects the empty string' '
 	test_must_fail test-path-utils real_path ""
 '
 
-test_expect_failure POSIX 'real path works on absolute paths' '
+test_expect_success POSIX 'real path works on absolute paths' '
 	nopath="hopefully-absent-path" &&
 	test "/" = "$(test-path-utils real_path "/")" &&
 	test "/$nopath" = "$(test-path-utils real_path "/$nopath")" &&
-- 
1.7.11.3
