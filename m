From: Junio C Hamano <gitster@pobox.com>
Subject: Re: breakage in revision traversal with pathspec
Date: Fri, 20 Sep 2013 10:51:55 -0700
Message-ID: <xmqqeh8jqt38.fsf@gitster.dls.corp.google.com>
References: <xmqqy574y4pz.fsf@gitster.dls.corp.google.com>
	<522F8ED2.9000408@bracey.fi>
	<xmqq38pcwc21.fsf@gitster.dls.corp.google.com>
	<5230AD23.2050009@bracey.fi> <20130911182444.GD4326@google.com>
	<5230C6E3.3080406@bracey.fi>
	<xmqqa9jjrrfb.fsf@gitster.dls.corp.google.com>
	<xmqq38p0sdeb.fsf@gitster.dls.corp.google.com>
	<20130920033541.GC15101@sigill.intra.peff.net>
	<xmqqioxwqec0.fsf@gitster.dls.corp.google.com>
	<20130920051107.GA17609@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kevin Bracey <kevin@bracey.fi>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 20 19:52:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VN4sA-0000yJ-KE
	for gcvg-git-2@plane.gmane.org; Fri, 20 Sep 2013 19:52:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753283Ab3ITRwB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Sep 2013 13:52:01 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61136 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753198Ab3ITRv7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Sep 2013 13:51:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0040743522;
	Fri, 20 Sep 2013 17:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jleN3W+i0iLdraUO8fE6/G/+u1U=; b=yOS+OE
	GJXTpyQc+udx95AdOYAV3yNVR33AFtHU+DFwK3hSo9bMj674TE3HSvmNYSUmM5x4
	YgboZOxiQE3+Q3i3UNS3M95POH6z7zB8Ge57Lzf6DAaFwPjZIwCIcoYvnwcPOUfl
	jO0ZRtBUmghSTQhKZd/iZqa5Kv4S8WaiQVU0c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LhBwGt357Zkv7FbCQMDBUawm4wbMP4YJ
	hJ2nGQvE1qQGynxf7gzjPYZxJtreXJnduKnePiSXTW6ZMAn2Ul670GWe7awuVf5X
	pYhdWZMRVjHYQAOOzCVO2ArGfKTfEH/I7cF9D5HuaNocrH9DSvMlyB1Pb4TKdDYA
	iI+JzYcXVCo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E4DA543521;
	Fri, 20 Sep 2013 17:51:58 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 358034351E;
	Fri, 20 Sep 2013 17:51:58 +0000 (UTC)
In-Reply-To: <20130920051107.GA17609@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 20 Sep 2013 01:11:07 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 58500038-221D-11E3-9FA1-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235071>

Jeff King <peff@peff.net> writes:

> My original question was going to be: why bother peeling at all if we
> are just going to push the outer objects, anyway?
>
> And after staring at it, I somehow convinced myself that the answer was
> that you were pushing both. But that is not the case. Sorry for the
> noise.

But that is still a valid point, and the patch to avoid peeling for
non symmetric diff does not look too bad, either.

 revision.c               | 59 ++++++++++++++++++++++++++++++------------------
 t/t6000-rev-list-misc.sh |  8 +++++++
 2 files changed, 45 insertions(+), 22 deletions(-)

diff --git a/revision.c b/revision.c
index 68545c8..7010aff 100644
--- a/revision.c
+++ b/revision.c
@@ -1157,41 +1157,56 @@ int handle_revision_arg(const char *arg_, struct rev_info *revs, int flags, unsi
 		}
 		if (!get_sha1_committish(this, from_sha1) &&
 		    !get_sha1_committish(next, sha1)) {
-			struct commit *a, *b;
-			struct commit_list *exclude;
-
-			a = lookup_commit_reference(from_sha1);
-			b = lookup_commit_reference(sha1);
-			if (!a || !b) {
-				if (revs->ignore_missing)
-					return 0;
-				die(symmetric ?
-				    "Invalid symmetric difference expression %s...%s" :
-				    "Invalid revision range %s..%s",
-				    arg, next);
-			}
+			struct object *a_obj, *b_obj;
 
 			if (!cant_be_filename) {
 				*dotdot = '.';
 				verify_non_filename(revs->prefix, arg);
 			}
 
-			if (symmetric) {
+			a_obj = parse_object(from_sha1);
+			b_obj = parse_object(sha1);
+			if (!a_obj || !b_obj) {
+			missing:
+				if (revs->ignore_missing)
+					return 0;
+				die(symmetric
+				    ? "Invalid symmetric difference expression %s"
+				    : "Invalid revision range %s", arg);
+			}
+
+			if (!symmetric) {
+				/* just A..B */
+				a_flags = flags_exclude;
+			} else {
+				/* A...B -- find merge bases between the two */
+				struct commit *a, *b;
+				struct commit_list *exclude;
+
+				a = (a_obj->type == OBJ_COMMIT
+				     ? (struct commit *)a_obj
+				     : lookup_commit_reference(a_obj->sha1));
+				b = (b_obj->type == OBJ_COMMIT
+				     ? (struct commit *)b_obj
+				     : lookup_commit_reference(b_obj->sha1));
+				if (!a || !b)
+					goto missing;
 				exclude = get_merge_bases(a, b, 1);
 				add_pending_commit_list(revs, exclude,
 							flags_exclude);
 				free_commit_list(exclude);
+
 				a_flags = flags | SYMMETRIC_LEFT;
-			} else
-				a_flags = flags_exclude;
-			a->object.flags |= a_flags;
-			b->object.flags |= flags;
-			add_rev_cmdline(revs, &a->object, this,
+			}
+
+			a_obj->flags |= a_flags;
+			b_obj->flags |= flags;
+			add_rev_cmdline(revs, a_obj, this,
 					REV_CMD_LEFT, a_flags);
-			add_rev_cmdline(revs, &b->object, next,
+			add_rev_cmdline(revs, b_obj, next,
 					REV_CMD_RIGHT, flags);
-			add_pending_object(revs, &a->object, this);
-			add_pending_object(revs, &b->object, next);
+			add_pending_object(revs, a_obj, this);
+			add_pending_object(revs, b_obj, next);
 			return 0;
 		}
 		*dotdot = '.';
diff --git a/t/t6000-rev-list-misc.sh b/t/t6000-rev-list-misc.sh
index b10685a..15e3d64 100755
--- a/t/t6000-rev-list-misc.sh
+++ b/t/t6000-rev-list-misc.sh
@@ -48,4 +48,12 @@ test_expect_success 'rev-list --objects with pathspecs and copied files' '
 	! grep one output
 '
 
+test_expect_success 'rev-list A..B and rev-list ^A B are the same' '
+	git commit --allow-empty -m another &&
+	git tag -a -m "annotated" v1.0 &&
+	git rev-list --objects ^v1.0^ v1.0 >expect &&
+	git rev-list --objects v1.0^..v1.0 >actual &&
+	test_cmp expect actual
+'
+
 test_done
