From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/6] log --grep: accept --basic-regexp and --perl-regexp
Date: Wed,  3 Oct 2012 18:33:37 -0700
Message-ID: <1349314419-8397-5-git-send-email-gitster@pobox.com>
References: <7v626r48cv.fsf@alter.siamese.dyndns.org>
 <1349314419-8397-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 04 23:59:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJtN1-0001DP-Sa
	for gcvg-git-2@plane.gmane.org; Thu, 04 Oct 2012 23:54:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755188Ab2JDBdw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2012 21:33:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52901 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753855Ab2JDBdt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2012 21:33:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 26DA9806D
	for <git@vger.kernel.org>; Wed,  3 Oct 2012 21:33:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=dz3q
	OWQZ6ZMeUFDnW+Ck0q4Vjb4=; b=lwqvT8y3fZwkw5bUmEb0pK7qtwjH8NdYWayJ
	iKg4hvJ+TITaKvlN4eFLgEy0ZsUWmfLH+/SKuyRmxVDcSowhOv4IzxssJol47/co
	+m5YsGjfmYyNKXANI4tmP4AW9A6ce7eatJ3DVg0boXplPmMbH1cObnF68g3BErDe
	d8lX1hM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=eqiU/q
	ERls9ChDoH+hJ0H4bXa8XsOrg8kTU78oPPmsnpVU/PTIWey/6e13MXXiykMrV4kM
	hLdVdZZKPGu4uYHvGTvN/yiijV+/wFPaz22ZM+FVJ31gDecoPYYKa7TThJQlp9bw
	YK7IEIOpYHcQoYaRfe2DALrXYvTYFHlPwoVbQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 14309806C
	for <git@vger.kernel.org>; Wed,  3 Oct 2012 21:33:49 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 926A2806B for
 <git@vger.kernel.org>; Wed,  3 Oct 2012 21:33:48 -0400 (EDT)
X-Mailer: git-send-email 1.8.0.rc0.57.g712528f
In-Reply-To: <1349314419-8397-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 8B942498-0DC3-11E2-BF39-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206946>

When we added the "--perl-regexp" option (or "-P") to "git grep", we
should have done the same for the commands in the "git log" family,
but somehow we forgot to do so.  This corrects it.

Also introduce the "--basic-regexp" option for completeness, so that
the "last one wins" principle can be used to defeat an earlier -E
option, e.g. "git log -E --basic-regexp --grep='<bre>'".  Note that
it cannot have the short "-G" option as the option is to grep in the
patch text in the context of "log" family.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 revision.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/revision.c b/revision.c
index 7f5e53b..0f73512 100644
--- a/revision.c
+++ b/revision.c
@@ -1603,6 +1603,8 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		return argcount;
 	} else if (!strcmp(arg, "--grep-debug")) {
 		revs->grep_filter.debug = 1;
+	} else if (!strcmp(arg, "--basic-regexp")) {
+		grep_set_pattern_type_option(GREP_PATTERN_TYPE_BRE, &revs->grep_filter);
 	} else if (!strcmp(arg, "--extended-regexp") || !strcmp(arg, "-E")) {
 		grep_set_pattern_type_option(GREP_PATTERN_TYPE_ERE, &revs->grep_filter);
 	} else if (!strcmp(arg, "--regexp-ignore-case") || !strcmp(arg, "-i")) {
@@ -1610,6 +1612,8 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		DIFF_OPT_SET(&revs->diffopt, PICKAXE_IGNORE_CASE);
 	} else if (!strcmp(arg, "--fixed-strings") || !strcmp(arg, "-F")) {
 		grep_set_pattern_type_option(GREP_PATTERN_TYPE_FIXED, &revs->grep_filter);
+	} else if (!strcmp(arg, "--perl-regexp") || !strcmp(arg, "-P")) {
+		grep_set_pattern_type_option(GREP_PATTERN_TYPE_PCRE, &revs->grep_filter);
 	} else if (!strcmp(arg, "--all-match")) {
 		revs->grep_filter.all_match = 1;
 	} else if ((argcount = parse_long_opt("encoding", argv, &optarg))) {
-- 
1.8.0.rc0.57.g712528f
