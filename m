From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2] specifying ranges: we did not mean to make ".." an empty
 set
Date: Mon, 02 May 2011 13:56:51 -0700
Message-ID: <7v62pslt2k.fsf_-_@alter.siamese.dyndns.org>
References: <7vr58glxro.fsf@alter.siamese.dyndns.org>
 <20110502193321.GB10487@sigill.intra.peff.net>
 <7vhb9clu0n.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 02 22:57:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QH0B2-0001hc-Qh
	for gcvg-git-2@lo.gmane.org; Mon, 02 May 2011 22:57:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754163Ab1EBU5B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2011 16:57:01 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:57035 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753274Ab1EBU5A (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2011 16:57:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5A0EC5078;
	Mon,  2 May 2011 16:59:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lconywVkDptEs1hNH1T9NmDCh6Q=; b=mrCxuE
	APCnLrA2DbXlywXTnO1ARs7CSwLKyzXRiDNIsrWhcdixG7lf5u/m1WToFNtIdPUl
	VewBXq7/amTkf1DSbVykO5Z7N7sxFoK4VGi3or0QcsO6MbvNqHu7YQud6ya8eGZ5
	We7p0qeJ8i1+dN5aqzv2E451U/fyxtRuwSS5U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TUcocSLCFBhaDVlvAwx7HK/KcUyaMbBo
	sOe+Z+PiL+FTWVANv10iT+QvITHFYpZ5XhX8AbyayazgZYMrsmQ85pKl8DJzgNsD
	qiBnI6LG55wO/aUpkvWVhVg0NyLj2Vsjyjver2Y/glsRp1nFqfVqf7lZMPfSg44s
	ULrqHFdK3so=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3213F5077;
	Mon,  2 May 2011 16:59:00 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id CF2A6506C; Mon,  2 May 2011
 16:58:56 -0400 (EDT)
In-Reply-To: <7vhb9clu0n.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 02 May 2011 13:36:24 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 00DE7D66-74FF-11E0-80A6-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172631>

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

 * With docs and tests.  In an early version, I forgot to restore the
   revision string that is temporarily NUL terminated with *dotdot = '.', 
   which resulted in "git log .." from Doc/howto to show not just the log
   of Doc but show everything.  The new test in t4202 tries to catch that
   rather common mistake as well.

 Documentation/revisions.txt    |    7 +++++++
 builtin/rev-parse.c            |   16 ++++++++++++++--
 revision.c                     |   16 ++++++++++++++--
 t/t1506-rev-parse-diagnosis.sh |   14 ++++++++++++++
 t/t4202-log.sh                 |    7 +++++++
 5 files changed, 56 insertions(+), 4 deletions(-)

diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index 3d4b79c..fd043f7 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -184,6 +184,13 @@ of `r1` and `r2` and is defined as
 It is the set of commits that are reachable from either one of
 `r1` or `r2` but not from both.
 
+In these two shorthands, you can omit one end and let it default to HEAD.
+For example, 'origin..' is a shorthand for 'origin..HEAD' and asks "What
+did I do since I forked from the origin branch?"  Similarly, '..origin'
+is a shorthand for 'HEAD..origin' and asks "What did the origin do since
+I forked from them?"  Note that you cannot omit both ends.  '..' is not
+an empty range that is both reachable and unreachable from HEAD.
+
 Two other shorthands for naming a set that is formed by a commit
 and its parent commits exist.  The `r1{caret}@` notation means all
 parents of `r1`.  `r1{caret}!` includes commit `r1` but excludes
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index a5a1c86..54ce44b 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -219,6 +219,7 @@ static int try_difference(const char *arg)
 	const char *next;
 	const char *this;
 	int symmetric;
+	static const char head_by_default[] = "HEAD";
 
 	if (!(dotdot = strstr(arg, "..")))
 		return 0;
@@ -230,9 +231,20 @@ static int try_difference(const char *arg)
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
index ded8812..4572aaf 100644
--- a/revision.c
+++ b/revision.c
@@ -1004,14 +1004,26 @@ int handle_revision_arg(const char *arg, struct rev_info *revs,
 		const char *this = arg;
 		int symmetric = *next == '.';
 		unsigned int flags_exclude = flags ^ UNINTERESTING;
+		static const char head_by_default[] = "HEAD";
 
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
index 0eeeb0e..4485d0a 100755
--- a/t/t1506-rev-parse-diagnosis.sh
+++ b/t/t1506-rev-parse-diagnosis.sh
@@ -75,4 +75,18 @@ test_expect_success 'invalid @{n} reference' '
 	grep "fatal: Log for [^ ]* only has [0-9][0-9]* entries." error
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
index 2043bb8..b89f9af 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -463,4 +463,11 @@ test_expect_success 'show added path under "--follow -M"' '
 	)
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
1.7.5.253.g2243e
