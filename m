From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 4/7] revisions: initialize revs->grep_filter using
 grep_init()
Date: Wed, 10 Oct 2012 00:55:11 -0700
Message-ID: <1349855714-17008-5-git-send-email-gitster@pobox.com>
References: <1349855714-17008-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 10 09:55:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLr92-0000fl-5v
	for gcvg-git-2@plane.gmane.org; Wed, 10 Oct 2012 09:55:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754682Ab2JJHzl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2012 03:55:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44381 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754489Ab2JJHzk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2012 03:55:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 204056FA2
	for <git@vger.kernel.org>; Wed, 10 Oct 2012 03:55:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=bLHM
	8LwnxN8CsZka/UmNAlAz6Zw=; b=XZvjCqPYu+YYh+0fH2/g4QP1ICX5CGyCo9n3
	rmxd9PM97DVAil3FiiGPwZa6csktd78ARMXB3tRDeFhKVfNhAdkYfsPJm/mLplOh
	P3OcIwJrXa07BtdoXWrrm8gnuhzGCh4LkoCAVUzEN+EohbhyG/jZUPHH5vQEj/dg
	EhJPtUk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=jeSGqv
	pjrSj0IuLpCdEP/NIMz5VQ5m/spwMu07u4Zhpc+PXxuHHIsiRlOj90cFNu24HV66
	X4O8MqRzuBvqvcjjtxnt7nDULgrGJZnGBBS1eQoUMAa6wyXu7CZikHJ9/3dN+Yin
	I5DX0R1a2guTOiGhz/qdeGMQ9eW0Ct24tnLMg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0E5146FA1
	for <git@vger.kernel.org>; Wed, 10 Oct 2012 03:55:40 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7464F6FA0 for
 <git@vger.kernel.org>; Wed, 10 Oct 2012 03:55:38 -0400 (EDT)
X-Mailer: git-send-email 1.8.0.rc1.76.g5a375e6
In-Reply-To: <1349855714-17008-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: E1687EB4-12AF-11E2-B214-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207376>

Instead of using the hand-rolled initialization sequence,
use grep_init() to populate the necessary bits.  This opens
the door to allow the calling commands to optionally read
grep.* configuration variables via git_config() if they
want to.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 grep.c     | 5 +++++
 revision.c | 6 ++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/grep.c b/grep.c
index 279a559..a947a68 100644
--- a/grep.c
+++ b/grep.c
@@ -16,6 +16,11 @@ static struct grep_opt grep_defaults;
 void init_grep_defaults(void)
 {
 	struct grep_opt *opt = &grep_defaults;
+	static int run_once;
+
+	if (run_once)
+		return;
+	run_once++;
 
 	memset(opt, 0, sizeof(*opt));
 	opt->relative = 1;
diff --git a/revision.c b/revision.c
index a09e60b..a4a9314 100644
--- a/revision.c
+++ b/revision.c
@@ -1048,9 +1048,9 @@ void init_revisions(struct rev_info *revs, const char *prefix)
 
 	revs->commit_format = CMIT_FMT_DEFAULT;
 
+	init_grep_defaults();
+	grep_init(&revs->grep_filter, prefix);
 	revs->grep_filter.status_only = 1;
-	revs->grep_filter.pattern_tail = &(revs->grep_filter.pattern_list);
-	revs->grep_filter.header_tail = &(revs->grep_filter.header_list);
 	revs->grep_filter.regflags = REG_NEWLINE;
 
 	diff_setup(&revs->diffopt);
@@ -1893,6 +1893,8 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 	revs->diffopt.abbrev = revs->abbrev;
 	diff_setup_done(&revs->diffopt);
 
+	grep_commit_pattern_type(GREP_PATTERN_TYPE_UNSPECIFIED,
+				 &revs->grep_filter);
 	compile_grep_patterns(&revs->grep_filter);
 
 	if (revs->reverse && revs->reflog_info)
-- 
1.8.0.rc1.76.g5a375e6
