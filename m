From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] specifying ranges: we did not mean to make ".." an empty set
Date: Wed, 22 Aug 2012 15:59:43 -0700
Message-ID: <7vd32i5y8w.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 23 00:59:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4Jtz-0002g3-2z
	for gcvg-git-2@plane.gmane.org; Thu, 23 Aug 2012 00:59:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932676Ab2HVW7t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Aug 2012 18:59:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44134 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932426Ab2HVW7q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2012 18:59:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7680183BE;
	Wed, 22 Aug 2012 18:59:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=F
	glGFO8iTxVXCXZAJR9xiSELNmo=; b=A8puUnaGedoG+5u+2exHRrCraAxvJNy6v
	Sk9GTtUbqj/wTiVG76hO9uPB6RzGkHb0lI3oY4Q9dUWurRD0cHFfsnn3LgMiRQAV
	g++kPF/4XF273ZqoiVj0BNDrbjsWFBsdBKLdbPdAQf4TxhRbXAx6VVeA3nQ93v8U
	2yTgj38qzw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=YMD
	hHWdkeHkuh5I2f1dKbJB+eOUmnbgcfoklbMaoweX9Yh+1fT7btpHqwU6pl1F5mVO
	eMZcYM4rNr4upAPLPjRXEwheozQRVbUMhFzuRiHdMfPAXxXCKs2F7ft0cOOSAMue
	sc11SDUoI14rli+cFNziDjp1eANE4UQYxNGLgD6w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6306A83BD;
	Wed, 22 Aug 2012 18:59:45 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 70CEE83BB; Wed, 22 Aug 2012
 18:59:44 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 104B596E-ECAD-11E1-B370-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204104>

Date: Mon, 2 May 2011 13:39:16 -0700

Either end of revision range operator can be omitted to default to HEAD,
as in "origin.." (what did I do since I forked) or "..origin" (what did
they do since I forked).  But the current parser interprets ".."  as an
empty range "HEAD..HEAD", and worse yet, because ".." does exist on the
filesystem, we get this annoying output:

  $ cd Documentation/howto
  $ git log .. ;# give me recent commits that touch Documentation/ area.
  fatal: ambiguous argument '..': both revision and filename
  Use '--' to separate filenames from revisions

Surely we could say "git log ../" or even "git log -- .." to disambiguate,
but we shouldn't have to.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * The other day I was looking into my old pile of leftover bits,
   and found this ($gmane/172619).  This is rebased to more recent
   codebase, but it is still relevant.

   Comments, other than "we may want to reuse 'log ..' as a
   short-hand for 'log @{u}..'", which is an utter nonsense?

 Documentation/revisions.txt    |  7 +++++++
 builtin/rev-parse.c            | 16 ++++++++++++++--
 revision.c                     | 16 ++++++++++++++--
 t/t1506-rev-parse-diagnosis.sh | 14 ++++++++++++++
 t/t4202-log.sh                 |  7 +++++++
 5 files changed, 56 insertions(+), 4 deletions(-)

diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index dc0070b..69d996b 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -213,6 +213,13 @@ of 'r1' and 'r2' and is defined as
 It is the set of commits that are reachable from either one of
 'r1' or 'r2' but not from both.
 
+In these two shorthands, you can omit one end and let it default to HEAD.
+For example, 'origin..' is a shorthand for 'origin..HEAD' and asks "What
+did I do since I forked from the origin branch?"  Similarly, '..origin'
+is a shorthand for 'HEAD..origin' and asks "What did the origin do since
+I forked from them?"  Note that '..' would mean 'HEAD..HEAD' which is an
+empty range that is both reachable and unreachable from HEAD.
+
 Two other shorthands for naming a set that is formed by a commit
 and its parent commits exist.  The 'r1{caret}@' notation means all
 parents of 'r1'.  'r1{caret}!' includes commit 'r1' but excludes
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 13495b8..47b4e7a 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -224,6 +224,7 @@ static int try_difference(const char *arg)
 	const char *next;
 	const char *this;
 	int symmetric;
+	static const char head_by_default[] = "HEAD";
 
 	if (!(dotdot = strstr(arg, "..")))
 		return 0;
@@ -235,9 +236,20 @@ static int try_difference(const char *arg)
 	next += symmetric;
 
 	if (!*next)
-		next = "HEAD";
+		next = head_by_default;
 	if (dotdot == arg)
-		this = "HEAD";
+		this = head_by_default;
+
+	if (this == head_by_default && next == head_by_default &&
+	    !symmetric) {
+		/*
+		 * Just ".."?  That is not a range but the
+		 * pathspec for the parent directory.
+		 */
+		*dotdot = '.';
+		return 0;
+	}
+
 	if (!get_sha1(this, sha1) && !get_sha1(next, end)) {
 		show_rev(NORMAL, end, next);
 		show_rev(symmetric ? NORMAL : REVERSED, sha1, this);
diff --git a/revision.c b/revision.c
index 5b81a92..457868d 100644
--- a/revision.c
+++ b/revision.c
@@ -1132,15 +1132,27 @@ int handle_revision_arg(const char *arg_, struct rev_info *revs,
 		const char *this = arg;
 		int symmetric = *next == '.';
 		unsigned int flags_exclude = flags ^ UNINTERESTING;
+		static const char head_by_default[] = "HEAD";
 		unsigned int a_flags;
 
 		*dotdot = 0;
 		next += symmetric;
 
 		if (!*next)
-			next = "HEAD";
+			next = head_by_default;
 		if (dotdot == arg)
-			this = "HEAD";
+			this = head_by_default;
+		if (this == head_by_default && next == head_by_default &&
+		    !symmetric) {
+			/*
+			 * Just ".."?  That is not a range but the
+			 * pathspec for the parent directory.
+			 */
+			if (!cant_be_filename) {
+				*dotdot = '.';
+				return -1;
+			}
+		}
 		if (!get_sha1(this, from_sha1) &&
 		    !get_sha1(next, sha1)) {
 			struct commit *a, *b;
diff --git a/t/t1506-rev-parse-diagnosis.sh b/t/t1506-rev-parse-diagnosis.sh
index c5cb77a..0cd2a2a 100755
--- a/t/t1506-rev-parse-diagnosis.sh
+++ b/t/t1506-rev-parse-diagnosis.sh
@@ -182,4 +182,18 @@ test_expect_success '<commit>:file correctly diagnosed after a pathname' '
 	test_cmp expect actual
 '
 
+test_expect_success 'dotdot is not an empty set' '
+	( H=$(git rev-parse HEAD) && echo $H ; echo ^$H ) >expect &&
+
+	git rev-parse HEAD.. >actual &&
+	test_cmp expect actual &&
+
+	git rev-parse ..HEAD >actual &&
+	test_cmp expect actual &&
+
+	echo .. >expect &&
+	git rev-parse .. >actual &&
+	test_cmp expect actual
+'
+
 test_done
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 71be59d..45058cc 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -806,4 +806,11 @@ test_expect_success 'log --graph with diff and stats' '
 	test_cmp expect actual.sanitized
 '
 
+test_expect_success 'dotdot is a parent directory' '
+	mkdir -p a/b &&
+	( echo sixth && echo fifth ) >expect &&
+	( cd a/b && git log --format=%s .. ) >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
1.7.12.149.g7ae593c
