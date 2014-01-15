From: Junio C Hamano <gitster@pobox.com>
Subject: revision: propagate flag bits from tags to pointees
Date: Wed, 15 Jan 2014 12:26:13 -0800
Message-ID: <xmqqwqi10z6i.fsf_-_@gitster.dls.corp.google.com>
References: <52CFF27C.1090108@gmail.com>
	<20140115094945.GD14335@sigill.intra.peff.net>
	<xmqq1u092f2k.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Francis Moreau <francis.moro@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 15 21:26:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3X2c-0004ey-EY
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jan 2014 21:26:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751482AbaAOU0T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jan 2014 15:26:19 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42487 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751046AbaAOU0R (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jan 2014 15:26:17 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 114A863DE8;
	Wed, 15 Jan 2014 15:26:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7o92bZFKRcYNOcMxZU3Bpm1b9gs=; b=X4rmvp
	CyJ2hXb1bOhWmGXmKO1Id3tQFXREy1rode74i5QAu8qiLuLItd6HRpV3wGAJfKYY
	TCgwZttVQDPOITYsqE5kU8aBslmc0p4QOkl93aSyAks9p68rWvAcRIj+wrr3/y/I
	7wp2HK1nRa/1oWc+B16TtpI6MPQFwULEBwZfI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HirMLaBqInm4YoUvqx4KrSDyGqpTFiU3
	7ovZlJSOJsYJUkweQJNwHLMmQqUr32WZ5lTDkLAB690ns+eO/JKqYd3y/SeQIvWL
	BQzVKR4J0Uov7Z6rqRz3O/DE5Z2klniw2i6+7PwoDYIGaNSG1YLA6Z7VBIqkzKIz
	2KctbokPJJU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0047E63DE7;
	Wed, 15 Jan 2014 15:26:17 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 30F9863DE5;
	Wed, 15 Jan 2014 15:26:16 -0500 (EST)
In-Reply-To: <xmqq1u092f2k.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 15 Jan 2014 11:57:39 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 48D4A02A-7E23-11E3-9956-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240476>

With the previous fix 895c5ba3 (revision: do not peel tags used in
range notation, 2013-09-19), handle_revision_arg() that processes
command line arguments for the "git log" family of commands no
longer directly places the object pointed by the tag in the pending
object array when it sees a tag object.  We used to place pointee
there after copying the flag bits like UNINTERESTING and
SYMMETRIC_LEFT.

This change meant that any flag that is relevant to later history
traversal must now be propagated to the pointed objects (most often
these are commits) while starting the traversal, which is partly
done by handle_commit() that is called from prepare_revision_walk().
We did propagate UNINTERESTING, but did not do so for others, most
notably SYMMETRIC_LEFT.  This caused "git log --left-right v1.0..."
(where "v1.0" is a tag) to start losing the "leftness" from the
commit the tag points at.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Comes directly on top of the faulty commit, so that we could
   backport it to 1.8.4.x series.

 revision.c               |  2 +-
 t/t6000-rev-list-misc.sh | 11 +++++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/revision.c b/revision.c
index 7010aff..6d1c8f9 100644
--- a/revision.c
+++ b/revision.c
@@ -265,6 +265,7 @@ static struct commit *handle_commit(struct rev_info *revs, struct object *object
 				return NULL;
 			die("bad object %s", sha1_to_hex(tag->tagged->sha1));
 		}
+		object->flags |= flags;
 	}
 
 	/*
@@ -276,7 +277,6 @@ static struct commit *handle_commit(struct rev_info *revs, struct object *object
 		if (parse_commit(commit) < 0)
 			die("unable to parse commit %s", name);
 		if (flags & UNINTERESTING) {
-			commit->object.flags |= UNINTERESTING;
 			mark_parents_uninteresting(commit);
 			revs->limited = 1;
 		}
diff --git a/t/t6000-rev-list-misc.sh b/t/t6000-rev-list-misc.sh
index 15e3d64..b84d6b0 100755
--- a/t/t6000-rev-list-misc.sh
+++ b/t/t6000-rev-list-misc.sh
@@ -56,4 +56,15 @@ test_expect_success 'rev-list A..B and rev-list ^A B are the same' '
 	test_cmp expect actual
 '
 
+test_expect_success 'symleft flag bit is propagated down from tag' '
+	git log --format="%m %s" --left-right v1.0...master >actual &&
+	cat >expect <<-\EOF &&
+	> two
+	> one
+	< another
+	< that
+	EOF
+	test_cmp expect actual
+'
+
 test_done
