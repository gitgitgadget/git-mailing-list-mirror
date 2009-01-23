From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/3] builtin-commit: shorten eye-sore overlong lines
Date: Thu, 22 Jan 2009 22:19:04 -0800
Message-ID: <7v63k64k9z.fsf_-_@gitster.siamese.dyndns.org>
References: <4978202C.3090703@viscovery.net>
 <alpine.DEB.2.00.0901211549070.15860@vellum.laroia.net>
 <49779521.9040208@drmicha.warpmail.net>
 <c1a864630901211346j4b702fb3tcc5a098ed7e1541d@mail.gmail.com>
 <20090123094509.6117@nanako3.lavabit.com>
 <7viqo64kfo.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Nathan Yergler <nathan@creativecommons.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Asheesh Laroia <asheesh@asheesh.org>, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Fri Jan 23 07:21:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQFPn-0001oJ-4W
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 07:21:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762101AbZAWGTS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2009 01:19:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761183AbZAWGTR
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jan 2009 01:19:17 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:61130 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761494AbZAWGTQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2009 01:19:16 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 6C72A1D1E5;
	Fri, 23 Jan 2009 01:19:14 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id B1CF21D1E4; Fri,
 23 Jan 2009 01:19:06 -0500 (EST)
In-Reply-To: <7viqo64kfo.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 22 Jan 2009 22:15:39 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C1B34AEE-E915-11DD-9135-BE78113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106840>

This does not change anything other than the way the variable to hold
an informative message thrown in the commit log buffer is assigned.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * This does not really belong to the series in the sense that it is
   needed to implement the new semantics, but these long lines have always
   bothered me.

 builtin-commit.c |   27 +++++++++++++++++++++++++--
 1 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 7aaa530..d861263 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -71,6 +71,29 @@ static int use_editor = 1, initial_commit, in_merge;
 static const char *only_include_assumed;
 static struct strbuf message;
 
+enum {
+	MSG_AMEND_CLEVER,
+	MSG_ASSUME_PARTIAL,
+};
+
+static void set_partial_commit_message(int msgnum)
+{
+	const char *msg;
+
+	switch (msgnum) {
+	case MSG_AMEND_CLEVER:
+		msg = "Clever... amending the last one with dirty index.";
+		break;
+	case MSG_ASSUME_PARTIAL:
+		msg = "Explicit paths specified without -i nor -o; assuming --only paths...";
+		break;
+	default:
+		die("Oops (%d) is not a valid message number", msgnum);
+		break;
+	}
+	only_include_assumed = msg;
+}
+
 static int opt_parse_m(const struct option *opt, const char *arg, int unset)
 {
 	struct strbuf *buf = opt->value;
@@ -788,9 +811,9 @@ static int parse_and_validate_options(int argc, const char *argv[],
 	if (argc == 0 && (also || (only && !amend)))
 		die("No paths with --include/--only does not make sense.");
 	if (argc == 0 && only && amend)
-		only_include_assumed = "Clever... amending the last one with dirty index.";
+		set_partial_commit_message(MSG_AMEND_CLEVER);
 	if (argc > 0 && !also && !only)
-		only_include_assumed = "Explicit paths specified without -i nor -o; assuming --only paths...";
+		set_partial_commit_message(MSG_ASSUME_PARTIAL);
 	if (!cleanup_arg || !strcmp(cleanup_arg, "default"))
 		cleanup_mode = use_editor ? CLEANUP_ALL : CLEANUP_SPACE;
 	else if (!strcmp(cleanup_arg, "verbatim"))
-- 
1.6.1.265.g9a013
