From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 5/7] log --grep: use the same helper to set -E/-F options
 as "git grep"
Date: Wed, 10 Oct 2012 00:55:12 -0700
Message-ID: <1349855714-17008-6-git-send-email-gitster@pobox.com>
References: <1349855714-17008-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 10 09:55:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLr92-0000fl-L4
	for gcvg-git-2@plane.gmane.org; Wed, 10 Oct 2012 09:55:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754689Ab2JJHzo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2012 03:55:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44411 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754489Ab2JJHzn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2012 03:55:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1C0AC6FAB
	for <git@vger.kernel.org>; Wed, 10 Oct 2012 03:55:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=Gjna
	PTA9vrnNh1JiYZR9vBZvNPo=; b=VOwpnqJfi5QtwJ770Ud0APKKS2Ec5NnoR9zK
	ylGSIDbvSnyNKlT1itRg5tRrW/NABZcloNPlHTjjhoRDP2H9ujI3yM0wjCi9zYeb
	d7miGgUvZB4av1XOq+4dnu2FA61jqPEOLLGt4x3B+KW4IFzaaD6nEgEpL3nCEi8X
	a5BGSxw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=V+wzaf
	gBV2rDEzSbvS9Ny7uTEKjUCOVeaORpSRBC/CJRpZUfIOWK18CRDu1wKmU0TkEr1N
	RiQkMlXu5nQbk+/tVXScikLbe0tTMM0/mB03BQKGfaopP5PwXeMejjUwIeclNTZM
	HsNYZqg+hl0OCCi1m3Sx4Sty70omjrysFRagk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 095A76FAA
	for <git@vger.kernel.org>; Wed, 10 Oct 2012 03:55:43 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 469406FA8 for
 <git@vger.kernel.org>; Wed, 10 Oct 2012 03:55:42 -0400 (EDT)
X-Mailer: git-send-email 1.8.0.rc1.76.g5a375e6
In-Reply-To: <1349855714-17008-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: E3AE2C14-12AF-11E2-823F-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207377>

The command line option parser for "git log -F -E --grep='<ere>'"
did not flip the "fixed" bit, violating the general "last option
wins" principle among conflicting options.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 revision.c     | 4 ++--
 t/t4202-log.sh | 6 ++++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/revision.c b/revision.c
index a4a9314..68545c8 100644
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
1.8.0.rc1.76.g5a375e6
