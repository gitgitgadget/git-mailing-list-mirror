From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/4] merge-base: "--is-ancestor A B"
Date: Thu, 30 Aug 2012 16:13:06 -0700
Message-ID: <1346368388-23576-3-git-send-email-gitster@pobox.com>
References: <1346368388-23576-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 31 01:13:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T7Dve-0007Wq-31
	for gcvg-git-2@plane.gmane.org; Fri, 31 Aug 2012 01:13:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752906Ab2H3XNU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Aug 2012 19:13:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40819 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752541Ab2H3XNO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2012 19:13:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 31AC78CFB
	for <git@vger.kernel.org>; Thu, 30 Aug 2012 19:13:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=hxyD
	SxbmozLsOH8oyxmUV4Z4O1U=; b=PlrgnE+KxYEUpBYxsFzKdTcV/0rxF/M7ln4H
	6c/DFZkWydmjMe7PhYPNlbGcXhhTHCctZGHF+ZOYFztVjicgDWNjfHrcfjIUYMqs
	npKBBT1IX/ssPEJd2maulXEtiP0exbeQWGtQcJHT+z04E4s0oqRZ0naGcz9Btakj
	RYbdq1s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=M9Umnq
	EkL3mAsKnaZhm0mTB+B2Rxk/OMt4ck+M1PmhFloFtFmKRZj/yUJ/0kJzac/wQK/i
	ZiKd2AM9XTj0Sc/W+dohlRkFLJ3jPAvn3hqQVfcfvTjeqUowvxl7eXEsuYAp/Hi5
	mNfegQhRAdnRahVao6w2iQHG8vjQ4Cau605Mg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1FAC18CFA
	for <git@vger.kernel.org>; Thu, 30 Aug 2012 19:13:14 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6982F8CED for
 <git@vger.kernel.org>; Thu, 30 Aug 2012 19:13:13 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.293.g6aeebca
In-Reply-To: <1346368388-23576-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 45C83B60-F2F8-11E1-A49C-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204577>

In many scripted Porcelain commands, we find this idiom:

    if test "$(git rev-parse --verify A)" = "$(git merge-base A B)"
    then
    	... A is an ancestor of B ...
    fi

But you do not have to compute exact merge-base only to see if A is
an ancestor of B.  Give them a more direct way to use the underlying
machinery.
---
 builtin/merge-base.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/builtin/merge-base.c b/builtin/merge-base.c
index 4f30f1b..615aa04 100644
--- a/builtin/merge-base.c
+++ b/builtin/merge-base.c
@@ -70,6 +70,20 @@ static int handle_octopus(int count, const char **args, int reduce, int show_all
 	return 0;
 }
 
+static int show_is_ancestor(int argc, const char **argv)
+{
+	struct commit *one, *two;
+
+	if (argc != 2)
+		die("--is-ancestor takes exactly two commits");
+	one = get_commit_reference(argv[0]);
+	two = get_commit_reference(argv[1]);
+	if (in_merge_bases(one, two))
+		return 0;
+	else
+		return 1;
+}
+
 int cmd_merge_base(int argc, const char **argv, const char *prefix)
 {
 	struct commit **rev;
@@ -77,11 +91,14 @@ int cmd_merge_base(int argc, const char **argv, const char *prefix)
 	int show_all = 0;
 	int octopus = 0;
 	int reduce = 0;
+	int is_ancestor = 0;
 
 	struct option options[] = {
 		OPT_BOOLEAN('a', "all", &show_all, "output all common ancestors"),
 		OPT_BOOLEAN(0, "octopus", &octopus, "find ancestors for a single n-way merge"),
 		OPT_BOOLEAN(0, "independent", &reduce, "list revs not reachable from others"),
+		OPT_BOOLEAN(0, "is-ancestor", &is_ancestor,
+			    "is the first one ancestor of the other?"),
 		OPT_END()
 	};
 
@@ -89,6 +106,10 @@ int cmd_merge_base(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, options, merge_base_usage, 0);
 	if (!octopus && !reduce && argc < 2)
 		usage_with_options(merge_base_usage, options);
+	if (is_ancestor && (show_all | octopus | reduce))
+		die("--is-reachable cannot be used with other options");
+	if (is_ancestor)
+		return show_is_ancestor(argc, argv);
 	if (reduce && (show_all || octopus))
 		die("--independent cannot be used with other options");
 
-- 
1.7.12.293.g6aeebca
