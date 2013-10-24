From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] merge-base: use OPT_CMDMODE and clarify the command line parsing
Date: Thu, 24 Oct 2013 12:11:23 -0700
Message-ID: <1382641884-14756-2-git-send-email-gitster@pobox.com>
References: <xmqqhac6o5hj.fsf@gitster.dls.corp.google.com>
 <1382641884-14756-1-git-send-email-gitster@pobox.com>
Cc: Martin von Zweigbergk <martinvonz@gmail.com>,
	John Keeping <john@keeping.me.uk>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 24 21:11:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZQJk-0003Hr-Pz
	for gcvg-git-2@plane.gmane.org; Thu, 24 Oct 2013 21:11:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756095Ab3JXTLb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Oct 2013 15:11:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35557 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756021Ab3JXTLa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Oct 2013 15:11:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 37AFB4D05A;
	Thu, 24 Oct 2013 19:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=r0NE
	QXFMh8KbBMsWEJfJP1bQdxI=; b=Za1MVObZVecaoJ0EoslkgM0s28Lav3N48imE
	Xri4CrIJ8BQoNetHazJrthQ69ackfUomUGkhSPIa3UV2nVsn/9hM2sexseHk4LkF
	9kSaktZNSqkUNpZCGfeD0QW9nzzVI201WL+azCJFdDokTWSCICl4mSZkOlOII75U
	ktCNwWw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	o/T+CPIJun4PM4ugS4i9rLfs0kwjJkhYL183Z1cbWAP5ahrZrQEt8k7PbxZ2BPoa
	zdwhpI1soHBTWW54c2rO/ot+GGi7O3+wt10ZiBD9i9olfPs6VYLAz88TUw1FYC4d
	g9MbexTp+VrwUpu7A76C+jdHZOO/YLwCcbU3uO1b1ic=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2A8754D059;
	Thu, 24 Oct 2013 19:11:30 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 794244D051;
	Thu, 24 Oct 2013 19:11:29 +0000 (UTC)
X-Mailer: git-send-email 1.8.4.1-799-g1c32b8d
In-Reply-To: <1382641884-14756-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 16429E8E-3CE0-11E3-8FC3-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236610>

The --octopus, --independent and --is-ancestor are mutually
exclusive command modes (in addition to not giving any of these
options), so represent them as such using the recent OPT_CMDMODE
facility available since 11588263 (parse-options: add OPT_CMDMODE(),
2013-07-30), which is in v1.8.4-82-g366b80b.  --all is compatible
only with plain vanilla mode and --octopus mode, and the minimum
number of arguments the command takes depends on the command modes,
so these are now separately checked in each command mode.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/merge-base.c | 38 ++++++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/builtin/merge-base.c b/builtin/merge-base.c
index e88eb93..d39c910 100644
--- a/builtin/merge-base.c
+++ b/builtin/merge-base.c
@@ -90,32 +90,38 @@ int cmd_merge_base(int argc, const char **argv, const char *prefix)
 	struct commit **rev;
 	int rev_nr = 0;
 	int show_all = 0;
-	int octopus = 0;
-	int reduce = 0;
-	int is_ancestor = 0;
+	int cmdmode = 0;
 
 	struct option options[] = {
 		OPT_BOOL('a', "all", &show_all, N_("output all common ancestors")),
-		OPT_BOOL(0, "octopus", &octopus, N_("find ancestors for a single n-way merge")),
-		OPT_BOOL(0, "independent", &reduce, N_("list revs not reachable from others")),
-		OPT_BOOL(0, "is-ancestor", &is_ancestor,
-			 N_("is the first one ancestor of the other?")),
+		OPT_CMDMODE(0, "octopus", &cmdmode,
+			    N_("find ancestors for a single n-way merge"), 'o'),
+		OPT_CMDMODE(0, "independent", &cmdmode,
+			    N_("list revs not reachable from others"), 'r'),
+		OPT_CMDMODE(0, "is-ancestor", &cmdmode,
+			    N_("is the first one ancestor of the other?"), 'a'),
 		OPT_END()
 	};
 
 	git_config(git_default_config, NULL);
 	argc = parse_options(argc, argv, prefix, options, merge_base_usage, 0);
-	if (!octopus && !reduce && argc < 2)
-		usage_with_options(merge_base_usage, options);
-	if (is_ancestor && (show_all || octopus || reduce))
-		die("--is-ancestor cannot be used with other options");
-	if (is_ancestor)
+
+	if (cmdmode == 'a') {
+		if (argc < 2)
+			usage_with_options(merge_base_usage, options);
+		if (show_all)
+			die("--is-ancestor cannot be used with --all");
 		return handle_is_ancestor(argc, argv);
-	if (reduce && (show_all || octopus))
-		die("--independent cannot be used with other options");
+	}
 
-	if (octopus || reduce)
-		return handle_octopus(argc, argv, reduce, show_all);
+	if (cmdmode == 'r' && show_all)
+		die("--independent cannot be used with --all");
+
+	if (cmdmode == 'r' || cmdmode == 'o')
+		return handle_octopus(argc, argv, cmdmode == 'r', show_all);
+
+	if (argc < 2)
+		usage_with_options(merge_base_usage, options);
 
 	rev = xmalloc(argc * sizeof(*rev));
 	while (argc-- > 0)
-- 
1.8.4.1-799-g1c32b8d
