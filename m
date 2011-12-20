From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] commit: do not lose mergetag header when not amending
Date: Tue, 20 Dec 2011 13:24:54 -0800
Message-ID: <7v4nwvj5qx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 20 22:25:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rd7BF-00078C-IC
	for gcvg-git-2@lo.gmane.org; Tue, 20 Dec 2011 22:25:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752903Ab1LTVY6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Dec 2011 16:24:58 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46929 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751688Ab1LTVY4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Dec 2011 16:24:56 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7FBCE6C7E;
	Tue, 20 Dec 2011 16:24:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=X
	N2X7hYuEVN2av117Ho62rTVenk=; b=LSK6tHfbbJZOMHQE7MaAo41X6eXlo4J+u
	xJn3lR30bq3a+igxnUOHLcwHOlgrOfOCXxmCZ+l3fuTiaXN3PKywtWt1+2vnR0/p
	vs4KQPafn48kI/pfS/pfsYWCe+rbpyJtL4WsYzj55PN3arq2Mlh6zg1OwsFGHFXr
	AJFPkQMVU0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=pld
	aYnXA4JnVVV6DVbvlkQFdCdRVVvMwVNAwD0bLQZHz+X8MQKkRJZ96QaJXWQIQCU4
	NX108CuCOmtS+Eyur5XSDlwWODHndpUzzRz8IgYGSRaOMyyhkm+zjYT7y72WMyxz
	Lb6dMw8q5DRhgKEJCXQ63xfH2xiAprMKMGnkd+U0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 773EB6C7D;
	Tue, 20 Dec 2011 16:24:56 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 01D776C7A; Tue, 20 Dec 2011
 16:24:55 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1017FF10-2B51-11E1-AE74-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187529>

The earlier ed7a42a (commit: teach --amend to carry forward extra headers,
2011-11-08) broke "git merge/pull; edit to fix conflict; git commit"
workflow by forgetting that commit_tree_extended() takes the whole extra
header list.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * Will directly queue to 'master'.

 builtin/commit.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index fca7ea0..0c64c88 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1484,8 +1484,12 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		exit(1);
 	}
 
-	if (amend)
+	if (amend) {
 		extra = read_commit_extra_headers(current_head);
+	} else {
+		struct commit_extra_header **tail = &extra;
+		append_merge_tag_headers(parents, &tail);
+	}
 
 	if (commit_tree_extended(sb.buf, active_cache_tree->sha1, parents, sha1,
 				 author_ident.buf, extra)) {
-- 
1.7.8.376.g7c0c1
