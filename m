From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 6/7] log --grep: accept --basic-regexp and --perl-regexp
Date: Wed, 10 Oct 2012 00:55:13 -0700
Message-ID: <1349855714-17008-7-git-send-email-gitster@pobox.com>
References: <1349855714-17008-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 10 09:55:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLr93-0000fl-Gp
	for gcvg-git-2@plane.gmane.org; Wed, 10 Oct 2012 09:55:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754702Ab2JJHzs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2012 03:55:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44445 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754489Ab2JJHzr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2012 03:55:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3EABA6FB1
	for <git@vger.kernel.org>; Wed, 10 Oct 2012 03:55:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=AmnX
	shzmkNx+EIcNUPMqtf9sDTE=; b=ot4nU5bBXIKjtaGlMBl1iL8S2OofTAd1jlgr
	0erCSqWCpxvYtccEtAWWNezpCq0XZsEBXZoXBO8SndoE1XdIxKzIIxy7QdSWSOWJ
	VHTpsWvntchLeK/2uxW+7yuzDup173hfNAGs76RVFSo0iUTE/ukjFEqqcsN9UNi3
	nXa5Qvw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=n5vw3R
	zkHu463dpo54H4OZOmh8w13ynoCWlEd1GdPF25WGaUlkjuyKEYCTYlkBcHofftX0
	QwoVxGT7aommCcS33XdC8ZlSxIY8nHaeYImTZxfDWheoj7n16G5Sn3JNJlvLHud3
	aBM/nmy+RyltX+WNiQWnZXuQwBCDf96/PTsPw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D0E36FB0
	for <git@vger.kernel.org>; Wed, 10 Oct 2012 03:55:47 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 228D36FAF for
 <git@vger.kernel.org>; Wed, 10 Oct 2012 03:55:46 -0400 (EDT)
X-Mailer: git-send-email 1.8.0.rc1.76.g5a375e6
In-Reply-To: <1349855714-17008-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: E5F9FC82-12AF-11E2-BA4A-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207378>

When we added the "--perl-regexp" option (or "-P") to "git grep", we
should have done the same for the commands in the "git log" family,
but somehow we forgot to do so.  This corrects it, but we will
reserve the short-and-sweet "-P" option for something else for now.

Also introduce the "--basic-regexp" option for completeness, so that
the "last one wins" principle can be used to defeat an earlier -E
option, e.g. "git log -E --basic-regexp --grep='<bre>'".  Note that
it cannot have the short "-G" option as the option is to grep in the
patch text in the context of "log" family.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/rev-list-options.txt | 10 ++++++++++
 revision.c                         |  4 ++++
 2 files changed, 14 insertions(+)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index ee49743..1ec14a0 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -79,6 +79,11 @@ if it is part of the log message.
 
 	Match the regexp limiting patterns without regard to letters case.
 
+--basic-regexp::
+
+	Consider the limiting patterns to be basic regular expressions;
+	this is the default.
+
 -E::
 --extended-regexp::
 
@@ -91,6 +96,11 @@ if it is part of the log message.
 	Consider the limiting patterns to be fixed strings (don't interpret
 	pattern as a regular expression).
 
+--perl-regexp::
+
+	Consider the limiting patterns to be Perl-compatible regexp.
+	Requires libpcre to be compiled in.
+
 --remove-empty::
 
 	Stop when a given path disappears from the tree.
diff --git a/revision.c b/revision.c
index 68545c8..d7d621c 100644
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
+	} else if (!strcmp(arg, "--perl-regexp")) {
+		grep_set_pattern_type_option(GREP_PATTERN_TYPE_PCRE, &revs->grep_filter);
 	} else if (!strcmp(arg, "--all-match")) {
 		revs->grep_filter.all_match = 1;
 	} else if ((argcount = parse_long_opt("encoding", argv, &optarg))) {
-- 
1.8.0.rc1.76.g5a375e6
