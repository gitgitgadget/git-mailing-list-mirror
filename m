From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/5] rev-list --exclude: tests
Date: Fri,  1 Nov 2013 12:34:13 -0700
Message-ID: <1383334455-18623-2-git-send-email-gitster@pobox.com>
References: <52264070.3080909@kdbg.org>
 <1383334455-18623-1-git-send-email-gitster@pobox.com>
Cc: Johannes Sixt <j.sixt@viscovery.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 01 20:34:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VcKUM-0004QG-Do
	for gcvg-git-2@plane.gmane.org; Fri, 01 Nov 2013 20:34:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752915Ab3KATeX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Nov 2013 15:34:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56478 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751872Ab3KATeW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Nov 2013 15:34:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F03084ECDD;
	Fri,  1 Nov 2013 15:34:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=embZ
	27ncJ2Z8+2b3gfYGwPsvHZQ=; b=w9jAv3mS6n1kokcedrRsqmbqXU6WoB+elTn/
	l5rkN3Yr3BudviATDFuXNV72BzC1lFdzNFhUjq+pm1L/RvLlAy6MigXIEisisReN
	VbPNFYSpT7sT7fteWK1gt7cwZTK6EL0WhwEZvo2COZWKs+4jZP/K9poDpaw2fANr
	ws7Ncm8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	Kd36CsbaFrOfrR3SBfG5WyYPVF+7Qc5qn4Gd+TBlQjMY48/CML5d1DWzreBQilub
	qXp2pO07Zwn0oV4l3gaL3yq+oPd2RsVAhnQi5bhNxNCCZcZlWWNRcTNmE+Yl0WES
	X1GXOLN+oJ8ntcRlBnktOBzyRe1lk8lYk4Cgv5WOb3s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DC3334ECDC;
	Fri,  1 Nov 2013 15:34:21 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3EE5E4ECDB;
	Fri,  1 Nov 2013 15:34:21 -0400 (EDT)
X-Mailer: git-send-email 1.8.5-rc0-281-g8951339
In-Reply-To: <1383334455-18623-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 9B3284D6-432C-11E3-8ADB-1FFB7F2839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237220>

Add tests for the --exclude=<glob> feature.

A few tests are added for cases where use of globbing and
"--exclude" results in no positive revisions:

 * "--exclude=<glob>" before "--all" etc. resulted in no results;

 * "--stdin" is used but no input was given;

 * "--all" etc. is used but no matching refs are found.

Currently, we fail such a request with the same error message we
would give to a command line that does not specify any positive
revision (e.g. "git rev-list<ENTER>").

We may want to treat these cases differently and not error out, but
the logic to detect that would be common to all of them, so I'd
leave it outside this topic for now, and stop at adding these tests
as food-for-thought.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t6018-rev-list-glob.sh | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/t/t6018-rev-list-glob.sh b/t/t6018-rev-list-glob.sh
index f00cebf..77ef323 100755
--- a/t/t6018-rev-list-glob.sh
+++ b/t/t6018-rev-list-glob.sh
@@ -231,6 +231,48 @@ test_expect_success 'rev-list --remotes=foo' '
 
 '
 
+test_expect_success 'rev-list --exclude with --branches' '
+	compare rev-list "--exclude=*/* --branches" "master someref subspace-x"
+'
+
+test_expect_success 'rev-list --exclude with --all' '
+	compare rev-list "--exclude=refs/remotes/* --all" "--branches --tags"
+'
+
+test_expect_success 'rev-list accumulates multiple --exclude' '
+	compare rev-list "--exclude=refs/remotes/* --exclude=refs/tags/* --all" --branches
+'
+
+
+# "git rev-list<ENTER>" is likely to be a bug in the calling script and may
+# deserve an error message, but do cases where set of refs programatically
+# given using globbing and/or --stdin need to fail with the same error, or
+# are we better off reporting a success with no output?  The following few
+# tests document the current behaviour to remind us that we might want to
+# think about this issue.
+
+test_expect_failure 'rev-list may want to succeed with empty output on no input (1)' '
+	>expect &&
+	git rev-list --stdin <expect >actual &&
+	test_cmp expect actual
+'
+
+test_expect_failure 'rev-list may want to succeed with empty output on no input (2)' '
+	>expect &&
+	git rev-list --exclude=* --all >actual &&
+	test_cmp expect actual
+'
+
+test_expect_failure 'rev-list may want to succeed with empty output on no input (3)' '
+	(
+		test_create_repo empty &&
+		cd empty &&
+		>expect &&
+		git rev-list --all >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_expect_success 'shortlog accepts --glob/--tags/--remotes' '
 
 	compare shortlog "subspace/one subspace/two" --branches=subspace &&
-- 
1.8.5-rc0-281-g8951339
