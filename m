From: Junio C Hamano <gitster@pobox.com>
Subject: [Annoyance] "git log .." thinks ".." is ambiguous
Date: Mon, 02 May 2011 12:15:23 -0700
Message-ID: <7vr58glxro.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 02 21:15:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QGyal-0006Zr-Id
	for gcvg-git-2@lo.gmane.org; Mon, 02 May 2011 21:15:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753157Ab1EBTPb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2011 15:15:31 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:38269 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751198Ab1EBTPa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2011 15:15:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5D69342C7;
	Mon,  2 May 2011 15:17:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=9
	6JuwAPvBEWraJ1bYnbpBMsqjeA=; b=suoK0qN3yq293Lo7ZDHwaynW8jq5kmwdL
	xr7060Vzfi2j3R3FJZW68HqKlMeG+RZnUoA2MJxNdu74FhBHO9zv2C0UY/GRO0r1
	C7Fp3gIauwlUVpL/Y5ALWUzZM80k8lGitbS32H7yzSkyybF5Qe5cGN1yDJnh1ePX
	1hVWVVck/4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=nmJ
	KvaiFgCuVHDH9lZPZgqnbqNOpaLNqkjy5mlo+icYrxRkT5uizHb+MxqV0i0TlJY3
	IYZ0cjoxO/CSXcEqMv38R6UEAvLz8oRu+b2Oiqgi/EJIFGDT2LVOqStQFTfr48mj
	VKEP4VsT20vTK3lqVL4ME6rG+04WBVswxio8KzjI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 462BF42C5;
	Mon,  2 May 2011 15:17:31 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0322642C0; Mon,  2 May 2011
 15:17:28 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D39853A8-74F0-11E0-810B-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172619>

Either end of revision range operator can be omitted to default to
HEAD, as in "origin.." (what did I do since I forked) or "..origin" (what
did they do since I forked).  But this resulted in ".." to be interpreted
as an empty range "HEAD..HEAD", and worse yet, because ".." does exist on
the filesystem, we get this annoying output:

  $ cd Documentation/howto
  $ git log .. ;# give me recent commits that touch Documentation/ area.
  fatal: ambiguous argument '..': both revision and filename
  Use '--' to separate filenames from revisions

Surely we could say "git log .. --", but we shouldn't have to.

---
 * I don't have very strong feeling about this, but just got annoyed
   enough to write this patch.  Should apply cleanly all the way down to
   at least 1.6.0 if not earlier.

 revision.c |   16 ++++++++++++++--
 1 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/revision.c b/revision.c
index f4b8b38..26271d1 100644
--- a/revision.c
+++ b/revision.c
@@ -905,14 +905,26 @@ int handle_revision_arg(const char *arg, struct rev_info *revs,
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
