From: mhagger@alum.mit.edu
Subject: [PATCH 6/7] real_path(): properly handle nonexistent top-level paths
Date: Tue,  4 Sep 2012 10:14:29 +0200
Message-ID: <1346746470-23127-7-git-send-email-mhagger@alum.mit.edu>
References: <1346746470-23127-1-git-send-email-mhagger@alum.mit.edu>
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 04 10:22:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T8oPE-0003cr-5N
	for gcvg-git-2@plane.gmane.org; Tue, 04 Sep 2012 10:22:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754232Ab2IDIWi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Sep 2012 04:22:38 -0400
Received: from ALUM-MAILSEC-SCANNER-4.MIT.EDU ([18.7.68.15]:47348 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752540Ab2IDIWg (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Sep 2012 04:22:36 -0400
X-AuditID: 1207440f-b7fde6d00000095c-8b-5045b89e301e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id B3.C5.02396.E98B5405; Tue,  4 Sep 2012 04:15:26 -0400 (EDT)
Received: from michael.berlin.jpk.com (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q848EtSa025047
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 4 Sep 2012 04:15:25 -0400
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1346746470-23127-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDIsWRmVeSWpSXmKPExsUixO6iqDtvh2uAQet9LYuuK91MFg29V5gt
	nsy9y2xxe8V8ZgcWj7/vPzB5PHzVxe5x8ZKyx+dNcgEsUdw2SYklZcGZ6Xn6dgncGe/vn2Ur
	+MpZcfvTc8YGxrfsXYycHBICJhJve/4wQthiEhfurWfrYuTiEBK4zCix7fN9FgjnNJNE67rV
	rCBVbAJSEi8be8C6RQTUJCa2HWIBsZkF0iVOLGgHs4UFfCX+f1gHVsMioCpx5OoEsF5eAReJ
	I0t3sEJsU5T48X0NM4jNKeAq8erDa6DNHEDLXCQ+PnCewMi7gJFhFaNcYk5prm5uYmZOcWqy
	bnFyYl5eapGuiV5uZoleakrpJkZI+PDvYOxaL3OIUYCDUYmHt+qTS4AQa2JZcWXuIUZJDiYl
	UV67za4BQnxJ+SmVGYnFGfFFpTmpxYcYJTiYlUR4b68GyvGmJFZWpRblw6SkOViUxHnVl6j7
	CQmkJ5akZqemFqQWwWRlODiUJHj3bQdqFCxKTU+tSMvMKUFIM3FwgggukA08QBsegRTyFhck
	5hZnpkMUnWJUlBLnvQGSEABJZJTmwQ2ARforRnGgf4R5X4NU8QCTBFz3K6DBTECDXd+7gAwu
	SURISTUwFn4wCrk5c9Un47bbBRZTZmly6lYW5R5R+r3nUHlm5P3mxvzvNyMf3xM8/Of1RLsZ
	zzZPrLhxtKrT5sbNjb5mbiJhdmfuXFq8ZOujtV5fOasyPvyeIvbU4/V6VdOLvcpc346Z/A8r
	ePLqYtr0Vxe+rlYvNu152fqBSWiRguERi88rZvYeOBAXuFSJpTgj0VCLuag4EQCr 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204727>

From: Michael Haggerty <mhagger@alum.mit.edu>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 abspath.c        | 5 ++++-
 t/t0000-basic.sh | 2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/abspath.c b/abspath.c
index 3e8325c..0e1cd7f 100644
--- a/abspath.c
+++ b/abspath.c
@@ -45,8 +45,11 @@ const char *real_path(const char *path)
 		if (!is_directory(buf)) {
 			char *last_slash = find_last_dir_sep(buf);
 			if (last_slash) {
-				*last_slash = '\0';
 				last_elem = xstrdup(last_slash + 1);
+				if (last_slash == buf)
+					last_slash[1] = '\0';
+				else
+					last_slash[0] = '\0';
 			} else {
 				last_elem = xstrdup(buf);
 				*buf = '\0';
diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index ad002ee..d929578 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -458,7 +458,7 @@ test_expect_success 'real path rejects the empty string' '
 	test_must_fail test-path-utils real_path ""
 '
 
-test_expect_failure 'real path works on absolute paths' '
+test_expect_success 'real path works on absolute paths' '
 	nopath="hopefully-absent-path" &&
 	test "/" = "$(test-path-utils real_path "/")" &&
 	test "/$nopath" = "$(test-path-utils real_path "/$nopath")" &&
-- 
1.7.11.3
