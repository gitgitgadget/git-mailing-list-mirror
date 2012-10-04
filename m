From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/6] log --grep: use the same helper to set -E/-F options as
 "git grep"
Date: Wed,  3 Oct 2012 18:33:36 -0700
Message-ID: <1349314419-8397-4-git-send-email-gitster@pobox.com>
References: <7v626r48cv.fsf@alter.siamese.dyndns.org>
 <1349314419-8397-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 05 00:03:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJtN1-0001DP-B5
	for gcvg-git-2@plane.gmane.org; Thu, 04 Oct 2012 23:54:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754976Ab2JDBds (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2012 21:33:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52883 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753855Ab2JDBdr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2012 21:33:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 518F88065
	for <git@vger.kernel.org>; Wed,  3 Oct 2012 21:33:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=fLzp
	2Nb/06VnnUi+LDPFXOxNapQ=; b=QJRCMrGFM7SrQPdGrWK8ulTQX+F6pW8W6GbX
	phJGwtEFQiwm4zMhAF9kyV7S04ccqhKo0SD+z621UWqoAjaI1UFCTHt3p+v3TJfO
	gfCl9pPDnbA/eSki0JtSesSZyPBmnJ53rwR0I2hflk5RyGrTgxwV/3NcwSpZyu4X
	pEUO7PM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=v7Iy4O
	V4vCtUMTLVWX5yolfWRcRENhqvA3A15O6wQmdEfemb94vIGCtIRsoi3JQ4suS85c
	DoB1T7ILtAdLJVIDcmuVurY3XSfcFtRf/CIO30q38woXbZYgZMjOzoDBW6aFEhy2
	C81fdz3/Jmw/t5mTrRp5PZfZg39jLBMvkCdGk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3F6B58064
	for <git@vger.kernel.org>; Wed,  3 Oct 2012 21:33:47 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B9D028061 for
 <git@vger.kernel.org>; Wed,  3 Oct 2012 21:33:46 -0400 (EDT)
X-Mailer: git-send-email 1.8.0.rc0.57.g712528f
In-Reply-To: <1349314419-8397-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 8A7B9ECE-0DC3-11E2-8826-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206955>

The command line option parser for "git log -F -E --grep='<ere>'"
did not flip the "fixed" bit, violating the general "last option
wins" principle among conflicting options.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 revision.c     | 4 ++--
 t/t4202-log.sh | 6 ++++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/revision.c b/revision.c
index a09e60b..7f5e53b 100644
--- a/revision.c
+++ b/revision.c
@@ -1604,12 +1604,12 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	} else if (!strcmp(arg, "--grep-debug")) {
 		revs->grep_filter.debug = 1;
 	} else if (!strcmp(arg, "--extended-regexp") || !strcmp(arg, "-E")) {
-		revs->grep_filter.regflags |= REG_EXTENDED;
+		grep_set_pattern_type_option(GREP_PATTERN_TYPE_ERE, &revs->grep_filter);
 	} else if (!strcmp(arg, "--regexp-ignore-case") || !strcmp(arg, "-i")) {
 		revs->grep_filter.regflags |= REG_ICASE;
 		DIFF_OPT_SET(&revs->diffopt, PICKAXE_IGNORE_CASE);
 	} else if (!strcmp(arg, "--fixed-strings") || !strcmp(arg, "-F")) {
-		revs->grep_filter.fixed = 1;
+		grep_set_pattern_type_option(GREP_PATTERN_TYPE_FIXED, &revs->grep_filter);
 	} else if (!strcmp(arg, "--all-match")) {
 		revs->grep_filter.all_match = 1;
 	} else if ((argcount = parse_long_opt("encoding", argv, &optarg))) {
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 924ba53..e6537ab 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -230,6 +230,12 @@ test_expect_success 'log --grep -i' '
 	test_cmp expect actual
 '
 
+test_expect_success 'log -F -E --grep=<ere> uses ere' '
+	echo second >expect &&
+	git log -1 --pretty="tformat:%s" -F -E --grep=s.c.nd >actual &&
+	test_cmp expect actual
+'
+
 cat > expect <<EOF
 * Second
 * sixth
-- 
1.8.0.rc0.57.g712528f
