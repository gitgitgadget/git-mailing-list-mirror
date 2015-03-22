From: Junio C Hamano <gitster@pobox.com>
Subject: [RFC/PATCH] align D/F handling of "diff --no-index" with that of normal Git
Date: Sat, 21 Mar 2015 22:11:27 -0700
Message-ID: <xmqqiodtd3b4.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 22 06:12:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZYBy-0000sk-F1
	for gcvg-git-2@plane.gmane.org; Sun, 22 Mar 2015 06:12:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751499AbbCVFLb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2015 01:11:31 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50581 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751322AbbCVFLa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2015 01:11:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6B7783E208;
	Sun, 22 Mar 2015 01:11:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=2
	7+gIpU25uPHMh+ROGkGcbsbiy0=; b=bEYfIK+cQQlLiigL3aNTCw+QrPiiEqABM
	jdytyd1hSHKw8d1KvFVRz2IngsjRCn6rRKgH6ch5vgLfFWpRTjAltpdFLRa7HsL+
	lDNi6VJGSKxGaPvcbgCExp3v3QOsQyhsHmMnaJw1PUNYqX0wFZ0hHTOqL/BV+5uy
	JlxiMYQjmA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=ig9
	comVZc4SHC9IV12WAPW+xd7rOv36TBZ66f1TsVY8wZ+Xgt+aa/S0V+cztvMrRvWL
	dlWtDsXEAXS0xYYiuxVRf0rpp5DaGX61C6jZQDk3yyPDlflf/StGpwHSPcaDl6Cr
	spZrArNPvoclPEhl8MzSASxdffazv/p3Vno/WMLM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 656063E207;
	Sun, 22 Mar 2015 01:11:29 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DD8C03E206;
	Sun, 22 Mar 2015 01:11:28 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E57EE670-D051-11E4-BF62-6DD39F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266051>

When a commit changes a path P that used to be a file to a directory
and create a new path P/X in it, "git show" would say that file P
was removed and file P/X was created for such a commit.

However, if we compare two directories, D1 and D2, where D1 has a
file D1/P in it and D2 has a directory D2/P under which there is a
file D2/P/X, and ask "git diff --no-index D1 D2" to show their
differences, we simply get a refusal "file/directory conflict".

The "diff --no-index" implementation has an underlying machinery
that can make it more in line with the normal Git if it wanted to,
but somehow it is not being exercised.  The only thing we need to
do, when we see a file P and a directory P/ (or the other way
around) is to show the removal of a file P and then pretend as if we
are comparing nothing with a whole directory P/, as the code is
fully prepared to express a creation of everything in a directory
(and if the comparison is between a directory P/ and a file P, then
show the creation of the file and then let the existing code remove
everything in P/).

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff-no-index.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/diff-no-index.c b/diff-no-index.c
index 265709b..52e9546 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -97,8 +97,27 @@ static int queue_diff(struct diff_options *o,
 	if (get_mode(name1, &mode1) || get_mode(name2, &mode2))
 		return -1;
 
-	if (mode1 && mode2 && S_ISDIR(mode1) != S_ISDIR(mode2))
-		return error("file/directory conflict: %s, %s", name1, name2);
+	if (mode1 && mode2 && S_ISDIR(mode1) != S_ISDIR(mode2)) {
+		struct diff_filespec *d1, *d2;
+
+		if (S_ISDIR(mode1)) {
+			/* 2 is file that is created */
+			d1 = noindex_filespec(NULL, 0);
+			d2 = noindex_filespec(name2, mode2);
+			name2 = NULL;
+			mode2 = 0;
+		} else {
+			/* 1 is file that is deleted */
+			d1 = noindex_filespec(name1, mode2);
+			d2 = noindex_filespec(NULL, 0);
+			name1 = NULL;
+			mode1 = 0;
+		}
+		/* emit that file */
+		diff_queue(&diff_queued_diff, d1, d2);
+
+		/* and then let the entire directory created or deleted */
+	}
 
 	if (S_ISDIR(mode1) || S_ISDIR(mode2)) {
 		struct strbuf buffer1 = STRBUF_INIT;
