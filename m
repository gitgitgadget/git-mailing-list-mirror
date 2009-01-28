From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bad objects error since upgrading GitHub servers to 1.6.1
Date: Tue, 27 Jan 2009 23:41:22 -0800
Message-ID: <7vvdrzvpwd.fsf@gitster.siamese.dyndns.org>
References: <7v1vuo1f6d.fsf@gitster.siamese.dyndns.org>
 <bab6a2ab0901271634x7201130bx4a565bd8bea6967b@mail.gmail.com>
 <7vvds0z1c1.fsf@gitster.siamese.dyndns.org>
 <7vk58gz04l.fsf@gitster.siamese.dyndns.org>
 <7vfxj4yzjj.fsf@gitster.siamese.dyndns.org>
 <bab6a2ab0901271757i4602774ahef1d881b7ed58097@mail.gmail.com>
 <20090128020220.GE1321@spearce.org>
 <7v3af4yvmu.fsf@gitster.siamese.dyndns.org>
 <20090128033020.GF1321@spearce.org>
 <7v1vuoxcxk.fsf@gitster.siamese.dyndns.org>
 <20090128044150.GI1321@spearce.org>
 <7vd4e7x5ov.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	PJ Hyett <pjhyett@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Jan 28 08:43:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LS54z-0000fH-QC
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 08:43:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753857AbZA1Hlg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 02:41:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752279AbZA1Hlg
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 02:41:36 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47207 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752132AbZA1Hlf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 02:41:35 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 618B894EE4;
	Wed, 28 Jan 2009 02:41:32 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 1D0CD94EE3; Wed,
 28 Jan 2009 02:41:23 -0500 (EST)
In-Reply-To: <7vd4e7x5ov.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 27 Jan 2009 23:14:56 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1503E3A0-ED0F-11DD-84EC-CC4CC92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107496>

Junio C Hamano <gitster@pobox.com> writes:

> Here is my work in progress.  It introduces "ignore-missing-negative"
> option to the revision traversal machinery, and squelches the places we
> currently complain loudly and die when we expect an object to be
> available, when the color we are going to paint the object with is
> UNINTERESTING.
>
> I have a mild suspicion that it may even be the right thing to ignore them
> unconditionally, and it might even match the intention of Linus's original
> code.  That would make many hunks in this patch much simpler.
>
> The evidences behind this suspicion are found in a handful of places in
> revision.c.  mark_blob_uninteresting() does not complain if the caller
> fails to find the blob.  mark_tree_uninteresting() does not, either.
> mark_parents_uninteresting() does not, either, and it even has a comment
> that strongly suggests the original intention was not to care about
> missing UNINTERESTING objects.

Here is what I ended up with doing.  It lost "ignore-missing-negative"
so missing UNINTERESTING objects are non-error events more uniformly,
but on the other hand get_reference() which is about the command line
arguments always wants the named objects to exist, even if they are
marked as UNINTERESTING.

I'll send [PATCH 1/2] which is an update to my previous fix as a follow-up
to this message.

-- >8 --
Subject: [PATCH 2/2] revision traversal: allow UNINTERESTING objects to be missing

Most of the existing codepaths were meant to treat missing uninteresting
objects to be a silently ignored non-error, but there were a few places
in handle_commit() and add_parents_to_list(), which are two key functions
in the revision traversal machinery, that cared:

 - When a tag refers to an object that we do not have, we barfed.  We
   ignore such a tag if it is painted as UNINTERESTING with this change.

 - When digging deeper into the ancestry chain of a commit that is already
   painted as UNINTERESTING, in order to paint its parents UNINTERESTING,
   we barfed if parse_parent() for a parent commit object failed.  We can
   ignore such a parent commit object.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 revision.c                 |    7 +++++--
 t/t5519-push-alternates.sh |   37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/revision.c b/revision.c
index db60f06..ea8ba0f 100644
--- a/revision.c
+++ b/revision.c
@@ -183,8 +183,11 @@ static struct commit *handle_commit(struct rev_info *revs, struct object *object
 		if (!tag->tagged)
 			die("bad tag");
 		object = parse_object(tag->tagged->sha1);
-		if (!object)
+		if (!object) {
+			if (flags & UNINTERESTING)
+				return NULL;
 			die("bad object %s", sha1_to_hex(tag->tagged->sha1));
+		}
 	}
 
 	/*
@@ -480,7 +483,7 @@ static int add_parents_to_list(struct rev_info *revs, struct commit *commit,
 			struct commit *p = parent->item;
 			parent = parent->next;
 			if (parse_commit(p) < 0)
-				return -1;
+				continue;
 			p->object.flags |= UNINTERESTING;
 			if (p->parents)
 				mark_parents_uninteresting(p);
diff --git a/t/t5519-push-alternates.sh b/t/t5519-push-alternates.sh
index 6dfc55a..96be523 100755
--- a/t/t5519-push-alternates.sh
+++ b/t/t5519-push-alternates.sh
@@ -103,4 +103,41 @@ test_expect_success 'bob works and pushes' '
 	)
 '
 
+test_expect_success 'alice works and pushes yet again' '
+	(
+		# Alice does not care what Bob does.  She does not
+		# even have to be aware of his existence.  She just
+		# keeps working and pushing
+		cd alice-work &&
+		echo more and more alice >file &&
+		git commit -a -m sixth.1 &&
+		echo more and more alice >>file &&
+		git commit -a -m sixth.2 &&
+		echo more and more alice >>file &&
+		git commit -a -m sixth.3 &&
+		git push ../alice-pub
+	)
+'
+
+test_expect_success 'bob works and pushes again' '
+	(
+		cd alice-pub &&
+		git cat-file commit master >../bob-work/commit
+	)
+	(
+		# This time Bob does not pull from Alice, and
+		# the master branch at her public repository points
+		# at a commit Bob does not fully know about, but
+		# he happens to have the commit object (but not the
+		# necessary tree) in his repository from Alice.
+		# This should not prevent the push by Bob from
+		# succeeding.
+		cd bob-work &&
+		git hash-object -t commit -w commit &&
+		echo even more bob >file &&
+		git commit -a -m seventh &&
+		git push ../bob-pub
+	)
+'
+
 test_done
-- 
1.6.1.1.273.g0e555
