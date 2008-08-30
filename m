From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] git-apply: Loosen "match_beginning" logic
Date: Sat, 30 Aug 2008 12:40:32 -0700
Message-ID: <7vk5dygukv.fsf_-_@gitster.siamese.dyndns.org>
References: <20080830164527.GA25370@localhost>
 <20080830165600.GB25370@localhost>
 <7vhc92ie44.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Clemens Buchacher <drizzd@aon.at>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 30 21:41:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZWKV-0004uZ-Bu
	for gcvg-git-2@gmane.org; Sat, 30 Aug 2008 21:41:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754541AbYH3Tkn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Aug 2008 15:40:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754467AbYH3Tkm
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Aug 2008 15:40:42 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:49008 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754222AbYH3Tkl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2008 15:40:41 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 1B5BB6D377;
	Sat, 30 Aug 2008 15:40:40 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 32B186D376; Sat, 30 Aug 2008 15:40:33 -0400 (EDT)
In-Reply-To: <7vhc92ie44.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sat, 30 Aug 2008 10:53:15 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 86AB1FEC-76CB-11DD-8B8C-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94409>

Even after a handfle attempts, match_beginning logic still has corner
cases:

    1bf1a85 (apply: treat EOF as proper context., 2006-05-23)
    65aadb9 (apply: force matching at the beginning., 2006-05-24)
    4be6096 (apply --unidiff-zero: loosen sanity checks ..., 2006-09-17)
    ee5a317 (Fix "git apply" to correctly enforce "match ..., 2008-04-06)

This is a tricky piece of code.

We still incorrectly enforce "match_beginning" for -U0 matches.
I noticed this while trying out an example sequence from Clemens Buchacher:

    $ echo a >victim
    $ git add victim
    $ echo b >>victim
    $ git diff -U0 >patch
    $ cat patch
    diff --git i/victim w/victim
    index 7898192..422c2b7 100644
    --- i/victim
    +++ w/victim
    @@ -1,0 +2 @@ a
    +b
    $ git apply --cached --unidiff-zero <patch
    $ git show :victim
    b
    a

The change inserts a new line before the second line, but we insist it to
be applied at the beginning.  As the result, the code refuses to apply it
at the original offset, and we end up adding the line at the beginning.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-apply.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git c/builtin-apply.c w/builtin-apply.c
index 2216a0b..47261e1 100644
--- c/builtin-apply.c
+++ w/builtin-apply.c
@@ -1996,6 +1996,8 @@ static int apply_one_fragment(struct image *img, struct fragment *frag,
 	/*
 	 * A hunk to change lines at the beginning would begin with
 	 * @@ -1,L +N,M @@
+	 * but we need to be careful.  -U0 that inserts before the second
+	 * line also has this pattern.
 	 *
 	 * And a hunk to add to an empty file would begin with
 	 * @@ -0,0 +N,M @@
@@ -2003,7 +2005,8 @@ static int apply_one_fragment(struct image *img, struct fragment *frag,
 	 * In other words, a hunk that is (frag->oldpos <= 1) with or
 	 * without leading context must match at the beginning.
 	 */
-	match_beginning = frag->oldpos <= 1;
+	match_beginning = (!frag->oldpos ||
+			   (frag->oldpos == 1 && !unidiff_zero));
 
 	/*
 	 * A hunk without trailing lines must match at the end.
