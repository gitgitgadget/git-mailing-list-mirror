From: Junio C Hamano <gitster@pobox.com>
Subject: Re: breakage in revision traversal with pathspec
Date: Thu, 19 Sep 2013 14:35:40 -0700
Message-ID: <xmqq38p0sdeb.fsf@gitster.dls.corp.google.com>
References: <xmqqy574y4pz.fsf@gitster.dls.corp.google.com>
	<522F8ED2.9000408@bracey.fi>
	<xmqq38pcwc21.fsf@gitster.dls.corp.google.com>
	<5230AD23.2050009@bracey.fi> <20130911182444.GD4326@google.com>
	<5230C6E3.3080406@bracey.fi>
	<xmqqa9jjrrfb.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Kevin Bracey <kevin@bracey.fi>
X-From: git-owner@vger.kernel.org Thu Sep 19 23:35:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VMlt6-00040m-Rv
	for gcvg-git-2@plane.gmane.org; Thu, 19 Sep 2013 23:35:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753434Ab3ISVfp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Sep 2013 17:35:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41096 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753298Ab3ISVfo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Sep 2013 17:35:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 45AAE43604;
	Thu, 19 Sep 2013 21:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RlU71TvK0iwKwZ/U0EFRFT1oVYQ=; b=MrP4r2
	9u4P1VfGmD/iqz2NCFVB3aKB4lIb+ya3I0c4JrAcVsAFDA4O6FpyCwrFzUBXDc/+
	3TZtsNrZV24dnQxngedImJcKrmMtSdmMr7TJDRnzaixDvbhPUL4n681eFjauxfAn
	moAbh4EdvkDkw0rNTsvOPKgSy9o+tJtF7hjLk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EF1dYrb3wuD6P44BZKQrpgdVicOQ6JSq
	XDg7J/dfSTxKTJ02MiOR3zNgkY/o4UQtY70I84Cbf7a4e/8IasM6Kb+N5kkB8PCk
	JqpAJ//ST1FB7J20GBzzbK1dYYVD5rRD3NhWfnWVEacqiJG4P5yjP6pl28IHoW+T
	HR0JtB1nKCs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3A16143603;
	Thu, 19 Sep 2013 21:35:43 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 81519435FB;
	Thu, 19 Sep 2013 21:35:42 +0000 (UTC)
In-Reply-To: <xmqqa9jjrrfb.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 11 Sep 2013 14:15:20 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 6F6990D6-2173-11E3-B21C-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235032>

Junio C Hamano <gitster@pobox.com> writes:

> Kevin Bracey <kevin@bracey.fi> writes:
>
>> To see the effect at the command line: "git log v1.8.3..v.1.8.4" hides
>> the merge, but "git log ^v1.8.3 v1.8.4" shows it. Whoops. A new
>> example of a dotty shorthand not being exactly equivalent.
>>
>> In the ".." case the v1.8.3 tag gets peeled before being sent to
>> add_rev_cmdline , and the "mark bottom commits" logic works. But in
>> the "^" case, the v1.8.3 doesn't get peeled.
>
> That sounds like a bug.  ^v1.8.3 should mark v1.8.3^0 as
> uninteresting.

OK, so "git rev-list ^v1.8.3 v1.8.4" throws two objects into
revs->pending.objects[] array.  Two tags, v1.8.3 marked as
UNINTERESTING and v1.8.4.  The revision walking machinery will peel
the tag by calling handle_commit() (which by the way arguably is
misnamed because it has to be called for any type of object) when it
starts to walk in prepare_revision_walk().

But "git rev-list v1.8.3..v1.8.4" throws two commits (v1.8.3^0 with
UNINTERESTING bit and v1.8.4^0) to revs->pending.objects[] after
peeling.  I _think_ it is wrong.  Because the range is only defined
over commit DAG, and because the same codepath handles the symmetric
difference v1.8.3...v1.8.4 as well, both ends of dots operator do
need to be peeled to commits, but I think it is wrong to throw these
peeled results into revs->pending.objects[].

Where it makes a difference is when rev-list is used with --objects.

    $ git rev-list --objects v1.8.4^1..v1.8.4 | grep $(git rev-parse v1.8.4)
    $ git rev-list --objects v1.8.4 ^v1.8.4^1 | grep $(git rev-parse v1.8.4)
    04f013dc38d7512eadb915eba22efc414f18b869 v1.8.4

-- >8 --
Subject: revision: do not peel tags used in range notation

A range notation "A..B" means exactly the same thing as what "^A B"
means, i.e. the set of commits that are reachable from B but not
from A.  But the internal representation after the revision parser
parsed these two notations are subtly different.

 - "rev-list ^A B" leaves A and B in the revs->pending.objects[]
   array, with the former marked as UNINTERESTING and the revision
   traversal machinery propagates the mark to underlying commit
   objects A^0 and B^0.

 - "rev-list A..B" peels tags and leaves A^0 (marked as
   UNINTERESTING) and B^0 in revs->pending.objects[] array before
   the traversal machinery kicks in.

This difference usually does not matter, but starts to matter when
the --objects option is used.  For example, we see this:

    $ git rev-list --objects v1.8.4^1..v1.8.4 | grep $(git rev-parse v1.8.4)
    $ git rev-list --objects v1.8.4 ^v1.8.4^1 | grep $(git rev-parse v1.8.4)
    04f013dc38d7512eadb915eba22efc414f18b869 v1.8.4

With the former invocation, the revision traversal machinery never
hears about the tag v1.8.4 (it only sees the result of peeling it,
i.e. the commit v1.8.4^0), and the tag itself does not appear in the
output.  The latter does send the tag object itself to the output.

Make the range notation keep the unpeeled objects and feed them to
the traversal machinery to fix this inconsistency.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Made against maint-1.8.0 just in case we may want to fix older
   maintenance series.

 revision.c               | 19 +++++++++++++------
 t/t6000-rev-list-misc.sh |  8 ++++++++
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/revision.c b/revision.c
index 68545c8..a6d2150 100644
--- a/revision.c
+++ b/revision.c
@@ -1159,6 +1159,7 @@ int handle_revision_arg(const char *arg_, struct rev_info *revs, int flags, unsi
 		    !get_sha1_committish(next, sha1)) {
 			struct commit *a, *b;
 			struct commit_list *exclude;
+			struct object *a_obj, *b_obj;
 
 			a = lookup_commit_reference(from_sha1);
 			b = lookup_commit_reference(sha1);
@@ -1184,14 +1185,20 @@ int handle_revision_arg(const char *arg_, struct rev_info *revs, int flags, unsi
 				a_flags = flags | SYMMETRIC_LEFT;
 			} else
 				a_flags = flags_exclude;
-			a->object.flags |= a_flags;
-			b->object.flags |= flags;
-			add_rev_cmdline(revs, &a->object, this,
+			a_obj = (!hashcmp(a->object.sha1, from_sha1)
+				 ? &a->object
+				 : lookup_object(from_sha1));
+			b_obj = (!hashcmp(b->object.sha1, sha1)
+				 ? &b->object
+				 : lookup_object(sha1));
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
