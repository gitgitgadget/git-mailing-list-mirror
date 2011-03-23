From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] diff: remove dead code that flips arguments order
Date: Wed, 23 Mar 2011 14:36:43 -0700
Message-ID: <7voc51cydw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 23 22:37:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2Vji-00082y-EF
	for gcvg-git-2@lo.gmane.org; Wed, 23 Mar 2011 22:37:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756653Ab1CWVgy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2011 17:36:54 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:56138 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753165Ab1CWVgx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2011 17:36:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8C6AC49C7;
	Wed, 23 Mar 2011 17:38:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=y
	1T9dv3GbMn+PQ1ktnNyIf5Gt3A=; b=BPdyTLrydsUdVWMDSbX4f9jvw1EwSDueZ
	I2IBDsmRaS0/UZLvsodZgZ+KRtrR2wwN+lyrR8se9TKS1tNVpNuQk6n9NC8pdKYx
	y3Vne5OPO4P356BaFSXnGj1Hd1TImZOh8urgOkrVUOUcoQ7gUujQnVP3lO1mZP2i
	oVirAFJf3E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=tJsExEItl1xhdFyK9UXx3uKVDKbR/emZKSgxO3OJZg6liQ7C0LVoiBmb
	hO/wxY08D9LYOiuL/llGojZGc9L2qFPByESJTaHKqMpXvnbCWdYWWHbyjOjyLH0W
	fmRcKGlbkzIyD4R9ufoVaaGQL3qb8fs8NJSU5FO1NkrnGV7Kl00=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6875549C4;
	Wed, 23 Mar 2011 17:38:28 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 62B4F49BF; Wed, 23 Mar 2011
 17:38:25 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E3EBF680-5595-11E0-B0B4-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169873>

In the olden days, "git cmd A..B" used to push ^A and then B into the list
of parsed revisions. The output from "git rev-list A..B" still does this,
and shows "B" first and then "^A" for backward compatibility.

The command line parser for "git diff A..B" was written originally to take
this swappage into account; when it internally sees an uninteresting
commit as its second input argument, it swapped the arguments to make it
the origin of the comparison, and the other one the destination.

These days, there is no need for this swappage, as the internal machinery
feeds ^A and then B to builtin_diff_tree().  Remove the dead code.

The funny thing is, I think this was a dead code from day one when it
was first written 6505602 (built-in diff., 2006-04-28); the author of
that patch must have known the implementation of the scripted version
that needed to deal with the swapped output from rev-parse too deeply
and didn't realize that the gotcha the dead code attempts to protect
him from didn't even apply to this codepath.

This change _will_ regress if somebody is insane enough to manually call
"git diff B ^A", but that is simply too insane for me to care.

There is exactly the same tree swapping code in diff-tree; that is not to
be changed not to break "git diff-tree B ^A" issued by Porcelain scripts,
but reword the comment to explain why we swap trees a bit better.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 builtin/diff-tree.c |    4 ++--
 builtin/diff.c      |   13 +------------
 2 files changed, 3 insertions(+), 14 deletions(-)

diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
index 0d2a3e9..c843546 100644
--- a/builtin/diff-tree.c
+++ b/builtin/diff-tree.c
@@ -133,8 +133,8 @@ int cmd_diff_tree(int argc, const char **argv, const char *prefix)
 	}
 
 	/*
-	 * NOTE! We expect "a ^b" to be equal to "a..b", so we
-	 * reverse the order of the objects if the second one
+	 * NOTE! We expect "b ^a" to have come from "rev-parse a..b",
+	 * so we reverse the order of the objects if the second one
 	 * is marked UNINTERESTING.
 	 */
 	nr_sha1 = opt->pending.nr;
diff --git a/builtin/diff.c b/builtin/diff.c
index 4c9deb2..86614d4 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -146,20 +146,9 @@ static int builtin_diff_tree(struct rev_info *revs,
 			     int argc, const char **argv,
 			     struct object_array_entry *ent)
 {
-	const unsigned char *(sha1[2]);
-	int swap = 0;
-
 	if (argc > 1)
 		usage(builtin_diff_usage);
-
-	/* We saw two trees, ent[0] and ent[1].
-	 * if ent[1] is uninteresting, they are swapped
-	 */
-	if (ent[1].item->flags & UNINTERESTING)
-		swap = 1;
-	sha1[swap] = ent[0].item->sha1;
-	sha1[1-swap] = ent[1].item->sha1;
-	diff_tree_sha1(sha1[0], sha1[1], "", &revs->diffopt);
+	diff_tree_sha1(ent[0].item->sha1, ent[1].item->sha1, "", &revs->diffopt);
 	log_tree_diff_flush(revs);
 	return 0;
 }
