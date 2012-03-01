From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/4] diff -p: squelch "diff --git" header for stat-dirty
 paths
Date: Wed, 29 Feb 2012 18:14:16 -0800
Message-ID: <1330568057-27304-4-git-send-email-gitster@pobox.com>
References: <1330568057-27304-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 01 03:14:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2vXO-0003tv-DY
	for gcvg-git-2@plane.gmane.org; Thu, 01 Mar 2012 03:14:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757508Ab2CACO2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Feb 2012 21:14:28 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63776 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756530Ab2CACOZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Feb 2012 21:14:25 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 59A187D5F
	for <git@vger.kernel.org>; Wed, 29 Feb 2012 21:14:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=0wOv
	XY3Qo1fZVGSxtrzJYrAuK90=; b=P5iE68v0poY+av2YX64hmeTiR73g9eU3OU3L
	FUB36js2+ARLGtWJTTez8iIbzlIKEkHn4Z0n3jKHD5Riw8g2bbtZU+j5mrkNsuV8
	K4lPLxtX4Z+aqCGPS/76Alfu8wi9XFfvzNQG41jV5WgmV+G/wYoniiddZ+Cbl5dk
	Kc6E6q0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=Ej+YOZ
	J4nsEATaY5+oY2pWVUwV2bLobYlyexY5scPmcYlYhKXFKijROPpxjAtG7/7n8+0S
	aCXnfXtLFNerAIyRIvRMa/bu4AJwFk5B+8PZLV/8FJoBWi1GX87hU/MOfd2Qg5ON
	Gwc/YXiV2GNXeuitz0B7TqcvwO+cYWFGI8DOs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4E6ED7D5E
	for <git@vger.kernel.org>; Wed, 29 Feb 2012 21:14:25 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C6AFC7D5D for
 <git@vger.kernel.org>; Wed, 29 Feb 2012 21:14:24 -0500 (EST)
X-Mailer: git-send-email 1.7.9.2.350.g74d65
In-Reply-To: <1330568057-27304-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 4409DBF6-6344-11E1-8705-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191887>

The plumbing "diff" commands look at the working tree files without
refreshing the index themselves for performance reasons (the calling
script is expected to do that upfront just once, before calling one or
more of them).  In the early days of git, they showed the "diff --git"
header before they actually ask the xdiff machinery to produce patches,
and ended up showing only these headers if the real contents are the same
and the difference they noticed was only because the stat info cached in
the index did not match that of the working tree. It was too late for the
implementation to take the header that it already emitted back.

But 3e97c7c (No diff -b/-w output for all-whitespace changes, 2009-11-19)
introduced necessary logic to keep the meta-information headers in a
strbuf and delay their output until the xdiff machinery noticed actual
changes. This was primarily in order to generate patches that ignore
whitespaces. When operating under "-w" mode, we wouldn't know if the
header is needed until we actually look at the resulting patch, so it was
a sensible thing to do, but we did not realize that the same reasoning
applies to stat-dirty paths.

Later, 296c6bb2 generalized this machinery and introduced must_show_header
toggle.  This is turned on when the header must be shown even when there
is no patch to be produced, e.g. only the mode was changed, or the path
was renamed, without changing the contents.  However, when it did so, it
still kept the special case for the "-w" mode, which meant that the
plumbing would keep showing these phantom changes.

This corrects this historical inconsistency by allowing the plumbing to
omit paths that are only stat-dirty from its output in the same way as it
handles whitespace only changes under "-w" option.

The change in the behaviour can be seen in the updated test.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c                  |    2 +-
 t/t4011-diff-symlink.sh |    5 +----
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/diff.c b/diff.c
index c8e4366..0ecbf32 100644
--- a/diff.c
+++ b/diff.c
@@ -1972,7 +1972,7 @@ static void builtin_diff(const char *name_a,
 		struct emit_callback ecbdata;
 		const struct userdiff_funcname *pe;
 
-		if (!DIFF_XDL_TST(o, WHITESPACE_FLAGS) || must_show_header) {
+		if (must_show_header) {
 			fprintf(o->file, "%s", header.buf);
 			strbuf_reset(&header);
 		}
diff --git a/t/t4011-diff-symlink.sh b/t/t4011-diff-symlink.sh
index 6097e19..7547c6d 100755
--- a/t/t4011-diff-symlink.sh
+++ b/t/t4011-diff-symlink.sh
@@ -67,10 +67,7 @@ test_expect_success SYMLINKS 'diff removed symlink and file' '
 '
 
 test_expect_success SYMLINKS 'diff identical, but newly created symlink and file' '
-	cat >expected <<-\EOF &&
-	diff --git a/frotz b/frotz
-	diff --git a/nitfol b/nitfol
-	EOF
+	>expected &&
 	sleep 3 &&
 	rm -f frotz &&
 	echo xyzzy >nitfol3 &&
-- 
1.7.9.2.350.g74d65
