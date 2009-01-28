From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bad objects error since upgrading GitHub servers to 1.6.1
Date: Tue, 27 Jan 2009 23:14:56 -0800
Message-ID: <7vd4e7x5ov.fsf@gitster.siamese.dyndns.org>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	PJ Hyett <pjhyett@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Jan 28 08:16:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LS4f5-0003Kb-9S
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 08:16:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752077AbZA1HPK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Jan 2009 02:15:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751705AbZA1HPJ
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 02:15:09 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:46788 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751155AbZA1HPH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Jan 2009 02:15:07 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id A74401D70C;
	Wed, 28 Jan 2009 02:15:05 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 2BCE51D70A; Wed,
 28 Jan 2009 02:14:58 -0500 (EST)
In-Reply-To: <20090128044150.GI1321@spearce.org> (Shawn O. Pearce's message
 of "Tue, 27 Jan 2009 20:41:50 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6342A2A8-ED0B-11DD-8BCD-0372113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107486>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Junio C Hamano <gitster@pobox.com> wrote:
>> "Shawn O. Pearce" <spearce@spearce.org> writes:
>> >
>> > Oh, right, its not.  I was pointing out that the last time the
>> > protocol changed in a way the server can infer something about the
>> > client, which IIRC was 41fa7d2, we still don't have a way to tell
>> > what the client is.
>>=20
>> But you are still talking as if there is one protocol you can call "=
the
>> protocol", but it is not.  The send-pack receive-pack protocol is on=
 topic
>> in this thread; the quoted commit was about a separate and independe=
nt
>> fetch-pack upload-pack protocol.  It does not matter when that unrel=
ated
>> protocol was enhanced.
>
> Blargh.  Of course you are right.  Its been a long 2 months for me
> at work.  I'm too #@*#@!@! tired to keep the basics straight anymore.
>
> I'm going to shut up now.

Please don't.

I've been toying with an idea for an alternative solution, and need
somebody competent to bounce it around with.

pack-objects ends up doing eventually

    rev-list --objects $send1 $send2 $send3 ... --not $have1 $have2 ...

which lists commits and associated objects reachable from $sendN,
excluding the ones that are reachable from $haveN.

The tentative solution Bj=C3=B6rn Steinbrink and I came up with exclude=
s
missing commit from $haveN to avoid rev-list machinery to barf, but it
violates the ref-object contract as I explained to Bj=C3=B6rn in my oth=
er
message.

	Side note.  We often cite "interrupted commit walkers" as the
	reason why has_sha1_file() is not a good enough check, but you can
	discard a deep commit chain by deleting a branch, and have gc
	expire older commit in the commit chain while retaining newer ones
	near the tip of that branch.  If (1) you earlier gave that branch
	to somebody else, (2) that somebody else has the tip of the branch
	you discarded in his repository, and (3) the repository you are
	pushing into borrows from that somebody else's repository, then
	you have the same situation that your has_sha1_file() succeeds but
	it will fail when you start digging deeper.

Checking if each commit is reachable from any of the refs is quite
expensive, and it would especially be so if it is done once per ".have"
and real ref we receive from the other end.

An alternative is to realize that rev-list traversal already does
something quite similar to what is needed to prove if these ".have"s ar=
e
reachable from refs when listing the reachable objects.  This computati=
on
is what it needs to do anyway, so if we teach rev-list to ignore missin=
g
or broken chain while traversing negative refs, we do not have to incur
any overhead over existing code.

Here is my work in progress.  It introduces "ignore-missing-negative"
option to the revision traversal machinery, and squelches the places we
currently complain loudly and die when we expect an object to be
available, when the color we are going to paint the object with is
UNINTERESTING.

I have a mild suspicion that it may even be the right thing to ignore t=
hem
unconditionally, and it might even match the intention of Linus's origi=
nal
code.  That would make many hunks in this patch much simpler.

The evidences behind this suspicion are found in a handful of places in
revision.c.  mark_blob_uninteresting() does not complain if the caller
fails to find the blob.  mark_tree_uninteresting() does not, either.
mark_parents_uninteresting() does not, either, and it even has a commen=
t
that strongly suggests the original intention was not to care about
missing UNINTERESTING objects.

 builtin-pack-objects.c |    1 +
 revision.c             |   24 ++++++++++++++++++++----
 revision.h             |    1 +
 3 files changed, 22 insertions(+), 4 deletions(-)

diff --git i/builtin-pack-objects.c w/builtin-pack-objects.c
index cedef52..c615a2f 100644
--- i/builtin-pack-objects.c
+++ w/builtin-pack-objects.c
@@ -2026,6 +2026,7 @@ static void get_object_list(int ac, const char **=
av)
 	int flags =3D 0;
=20
 	init_revisions(&revs, NULL);
+	revs.ignore_missing_negative =3D 1;
 	save_commit_buffer =3D 0;
 	setup_revisions(ac, av, &revs, NULL);
=20
diff --git i/revision.c w/revision.c
index db60f06..314341b 100644
--- i/revision.c
+++ w/revision.c
@@ -132,6 +132,8 @@ void mark_parents_uninteresting(struct commit *comm=
it)
=20
 static void add_pending_object_with_mode(struct rev_info *revs, struct=
 object *obj, const char *name, unsigned mode)
 {
+	if (!obj)
+		return;
 	if (revs->no_walk && (obj->flags & UNINTERESTING))
 		die("object ranges do not make sense when not walking revisions");
 	if (revs->reflog_info && obj->type =3D=3D OBJ_COMMIT &&
@@ -163,8 +165,11 @@ static struct object *get_reference(struct rev_inf=
o *revs, const char *name, con
 	struct object *object;
=20
 	object =3D parse_object(sha1);
-	if (!object)
+	if (!object) {
+		if (revs->ignore_missing_negative && (flags & UNINTERESTING))
+			return NULL;
 		die("bad object %s", name);
+	}
 	object->flags |=3D flags;
 	return object;
 }
@@ -183,8 +188,11 @@ static struct commit *handle_commit(struct rev_inf=
o *revs, struct object *object
 		if (!tag->tagged)
 			die("bad tag");
 		object =3D parse_object(tag->tagged->sha1);
-		if (!object)
+		if (!object) {
+			if (revs->ignore_missing_negative && (flags & UNINTERESTING))
+				return NULL;
 			die("bad object %s", sha1_to_hex(tag->tagged->sha1));
+		}
 	}
=20
 	/*
@@ -193,8 +201,11 @@ static struct commit *handle_commit(struct rev_inf=
o *revs, struct object *object
 	 */
 	if (object->type =3D=3D OBJ_COMMIT) {
 		struct commit *commit =3D (struct commit *)object;
-		if (parse_commit(commit) < 0)
+		if (parse_commit(commit) < 0) {
+			if (revs->ignore_missing_negative && (flags & UNINTERESTING))
+				return NULL;
 			die("unable to parse commit %s", name);
+		}
 		if (flags & UNINTERESTING) {
 			commit->object.flags |=3D UNINTERESTING;
 			mark_parents_uninteresting(commit);
@@ -479,8 +490,11 @@ static int add_parents_to_list(struct rev_info *re=
vs, struct commit *commit,
 		while (parent) {
 			struct commit *p =3D parent->item;
 			parent =3D parent->next;
-			if (parse_commit(p) < 0)
+			if (parse_commit(p) < 0) {
+				if (revs->ignore_missing_negative)
+					return 0;
 				return -1;
+			}
 			p->object.flags |=3D UNINTERESTING;
 			if (p->parents)
 				mark_parents_uninteresting(p);
@@ -1110,6 +1124,8 @@ static int handle_revision_opt(struct rev_info *r=
evs, int argc, const char **arg
 		revs->tree_objects =3D 1;
 		revs->blob_objects =3D 1;
 		revs->edge_hint =3D 1;
+	} else if (!strcmp(arg, "--ignore-missing-negative")) {
+		revs->ignore_missing_negative =3D 1;
 	} else if (!strcmp(arg, "--unpacked")) {
 		revs->unpacked =3D 1;
 		free(revs->ignore_packed);
diff --git i/revision.h w/revision.h
index 7cf8487..bb90399 100644
--- i/revision.h
+++ w/revision.h
@@ -48,6 +48,7 @@ struct rev_info {
 			tree_objects:1,
 			blob_objects:1,
 			edge_hint:1,
+			ignore_missing_negative:1,
 			limited:1,
 			unpacked:1, /* see also ignore_packed below */
 			boundary:2,
