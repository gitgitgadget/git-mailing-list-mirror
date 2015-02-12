From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 07/12] commit: avoid race when creating orphan commits
Date: Thu, 12 Feb 2015 12:12:18 +0100
Message-ID: <1423739543-1025-8-git-send-email-mhagger@alum.mit.edu>
References: <1423739543-1025-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 12 12:19:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YLroF-0007QT-4q
	for gcvg-git-2@plane.gmane.org; Thu, 12 Feb 2015 12:19:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755352AbbBLLTq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2015 06:19:46 -0500
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:54870 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755204AbbBLLTp (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Feb 2015 06:19:45 -0500
X-Greylist: delayed 423 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Feb 2015 06:19:45 EST
X-AuditID: 12074413-f79f26d0000030e7-45-54dc8aaabe1e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 3E.A9.12519.AAA8CD45; Thu, 12 Feb 2015 06:12:42 -0500 (EST)
Received: from michael.fritz.box (p4FC96396.dip0.t-ipconnect.de [79.201.99.150])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t1CBCT7a003107
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Thu, 12 Feb 2015 06:12:40 -0500
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1423739543-1025-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGIsWRmVeSWpSXmKPExsUixO6iqLuq606Iwdbd/BZdV7qZLBp6rzBb
	vL25hNHi9or5zBbdU94yWvT2fWK12Ly5ncWB3ePv+w9MHjtn3WX3WLCp1OPiJWWPz5vkAlij
	uG2SEkvKgjPT8/TtErgzGh9dYSy4zlOxZ98SxgbGRVxdjJwcEgImEovX32OBsMUkLtxbz9bF
	yMUhJHCZUWLzjX1Qzgkmick7H7ODVLEJ6Eos6mlmArFFBNQkJrYdAutmFljNJLH1LhuILSzg
	KXG5+QcziM0ioCqxbP0GsBpeAWeJ3w3zoLbJSZw//hOshlPAReLdpQZGEFsIqGZX2xbWCYy8
	CxgZVjHKJeaU5urmJmbmFKcm6xYnJ+blpRbpmuvlZpbopaaUbmKEhJnwDsZdJ+UOMQpwMCrx
	8AYY3wkRYk0sK67MPcQoycGkJMrL1QoU4kvKT6nMSCzOiC8qzUktPsQowcGsJMLr2wSU401J
	rKxKLcqHSUlzsCiJ86otUfcTEkhPLEnNTk0tSC2CycpwcChJ8JZ3AjUKFqWmp1akZeaUIKSZ
	ODhBhnNJiRSn5qWkFiWWlmTEg2IjvhgYHSApHqC9YiDtvMUFiblAUYjWU4yKUuK8mSAJAZBE
	Rmke3FhY8njFKA70pTDvPJAqHmDiget+BTSYCWjwxBm3QQaXJCKkpBoYpZdckdDeutZh1oFr
	VYJvT920q1Be+dqWz8TwxN/Kym9NZ7p/MAaHvzV2a/o6sWE9S8jyMjdTETc2KaMlsawOPTtt
	gr/6vW3c8+X0hPvf/zn9/fO2vFP5eIPTWqOO//9bXxbaOFxf3xETFnLuZdG8o1sF 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263725>

If HEAD doesn't point at anything during the initial check, then we
should make sure that it *still* doesn't point at anything when we are
ready to update the reference. Otherwise, another process might commit
while we are working (e.g., while we are waiting for the user to edit
the commit message) and we will silently overwrite it.

This fixes a failing test in t7516.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Reviewed-by: Stefan Beller <sbeller@google.com>
---
 builtin/commit.c        | 2 +-
 t/t7516-commit-races.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 8afb0ff..682f922 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1766,7 +1766,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	if (!transaction ||
 	    ref_transaction_update(transaction, "HEAD", sha1,
 				   current_head
-				   ? current_head->object.sha1 : NULL,
+				   ? current_head->object.sha1 : null_sha1,
 				   0, sb.buf, &err) ||
 	    ref_transaction_commit(transaction, &err)) {
 		rollback_index_files();
diff --git a/t/t7516-commit-races.sh b/t/t7516-commit-races.sh
index 08e6a6c..dd44ef2 100755
--- a/t/t7516-commit-races.sh
+++ b/t/t7516-commit-races.sh
@@ -12,7 +12,7 @@ test_expect_success 'set up editor' '
 	EOF
 '
 
-test_expect_failure 'race to create orphan commit' '
+test_expect_success 'race to create orphan commit' '
 	test_must_fail env EDITOR=./editor git commit --allow-empty &&
 	git show -s --pretty=format:%s >subject &&
 	grep -q hare subject &&
-- 
2.1.4
