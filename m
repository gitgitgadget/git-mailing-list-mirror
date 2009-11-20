From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/3] setup_revisions(): do not call get_pathspec() too early
Date: Fri, 20 Nov 2009 03:25:14 -0800
Message-ID: <1258716315-2213-3-git-send-email-gitster@pobox.com>
References: <1258716315-2213-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 20 12:25:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBRcN-0004Rj-Vi
	for gcvg-git-2@lo.gmane.org; Fri, 20 Nov 2009 12:25:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752743AbZKTLZU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Nov 2009 06:25:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751869AbZKTLZS
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Nov 2009 06:25:18 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36753 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752393AbZKTLZP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Nov 2009 06:25:15 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5694D811D2
	for <git@vger.kernel.org>; Fri, 20 Nov 2009 06:25:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=QIO2
	x4SJYJpgYIxsRkJmS53z3j0=; b=C3p9F5XaiZp+t9wLbaN8YsoqLwCsXXOjJNGg
	nKG4jO+BU+VnyxNkRuAcLWQRm6ZMIoh6Mz5kTLiBh7uvqYSw8/iKKvQeU34fTENZ
	jwTid2soJs3PXN1RYHOK33oLHrUb9mi6kj811qIbkK3zANKJ9UFR41QcpjFNjlaF
	TZLG8mk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=Nxi7Gu
	7VN8PlmKDaOHXj1E90AFiOoagI8paqwWXhwJGYc94zEJ1UgCjHNDTWx5xFE1Koh6
	M8SVRHvWIkouxYHgjG+bSAP6MoF5GSa5iruq9TmgHaPI1VXo5z/NcJPwvLgtevZF
	c6nA4rnaTYR/NlFkEELcFhkI0Hhpa0LQ0alN8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3F411811D1
	for <git@vger.kernel.org>; Fri, 20 Nov 2009 06:25:21 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AA2A4811D0 for
 <git@vger.kernel.org>; Fri, 20 Nov 2009 06:25:20 -0500 (EST)
X-Mailer: git-send-email 1.6.5.3.342.g14bb9
In-Reply-To: <1258716315-2213-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 63810426-D5C7-11DE-92D4-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133334>

This is necessary because in the next patch I'll allow pathspecs to be fed
from the standard input, and pathspecs taken from the command line (and
converted via get_pathspec() already) in revs->prune_data too early gets
in the way when we want to append from the standard input.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 revision.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/revision.c b/revision.c
index f5b735f..4410a45 100644
--- a/revision.c
+++ b/revision.c
@@ -1230,6 +1230,7 @@ void parse_revision_opt(struct rev_info *revs, struct parse_opt_ctx_t *ctx,
 int setup_revisions(int argc, const char **argv, struct rev_info *revs, const char *def)
 {
 	int i, flags, left, seen_dashdash, read_from_stdin;
+	const char **prune_data = NULL;
 
 	/* First, search for "--" */
 	seen_dashdash = 0;
@@ -1240,7 +1241,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 		argv[i] = NULL;
 		argc = i;
 		if (argv[i + 1])
-			revs->prune_data = get_pathspec(revs->prefix, argv + i + 1);
+			prune_data = argv + i + 1;
 		seen_dashdash = 1;
 		break;
 	}
@@ -1321,12 +1322,14 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 			for (j = i; j < argc; j++)
 				verify_filename(revs->prefix, argv[j]);
 
-			revs->prune_data = get_pathspec(revs->prefix,
-							argv + i);
+			prune_data = argv + i;
 			break;
 		}
 	}
 
+	if (prune_data)
+		revs->prune_data = get_pathspec(revs->prefix, prune_data);
+
 	if (revs->def == NULL)
 		revs->def = def;
 	if (revs->show_merge)
-- 
1.6.5.3.342.g14bb9
