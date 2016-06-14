From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] blame: dwim "blame --reverse OLD" as "blame --reverse OLD.."
Date: Tue, 14 Jun 2016 11:41:11 -0700
Message-ID: <xmqqziqn8vg8.fsf_-_@gitster.mtv.corp.google.com>
References: <xmqqtwgvadru.fsf@gitster.mtv.corp.google.com>
	<xmqqporjackh.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 14 20:41:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCtHB-0006bX-5l
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jun 2016 20:41:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752984AbcFNSlV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2016 14:41:21 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64777 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752948AbcFNSlU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2016 14:41:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 91AF023490;
	Tue, 14 Jun 2016 14:41:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Whlc/6PyZ0MWKBwEluQou8Q8Rxs=; b=ahtyjA
	ZfoywBpRq8IY6NfHJjIO4RYT9FrCXrG4J5/JLEtN9nffeWgBvQXEnBD68BkJ65g/
	NJhH07Xkh0sE0j1ogJ3NtwjKNNKKksoDpdTc9267w1ErvL+JlTeirP8s6EmBKzJk
	B/+xKNH3SPPJV2B4celuhg28YNalRufDp5VLU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Yxyl+cR/CWJfew2YLyeya6Q1+sZwDMDG
	XZOaThhD1E1avsJuabVR4b4nG5xNXWsz0fOsLD7XsCIok43Do1f6tiEBEfykxBRx
	W2eyrp09LqFWplbOZ28vYikXbeMewWYpLxG23tgYMIahQdyZwTbmVTuaTQoTymYA
	Zl7ALPbxH00=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 89B342348F;
	Tue, 14 Jun 2016 14:41:13 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 120A92348E;
	Tue, 14 Jun 2016 14:41:13 -0400 (EDT)
In-Reply-To: <xmqqporjackh.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Tue, 14 Jun 2016 10:46:06 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 91CDB7CE-325F-11E6-B26F-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297318>

Instead of always requiring both ends of a range, we could DWIM
"OLD", which could be a misspelt "OLD..", to be a range that ends at
the current commit.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * I am not convinced that this is a good change, though.  It is
   true that there is no other sensible interpretation of the user's
   intent when --reverse is given a single positive commit without
   any other revision, but at the same time, this feels a bit too
   much special casing that could hurt casual users when they are
   still forming their mental world model by learning from examples.

 Documentation/blame-options.txt |  5 +++--
 builtin/blame.c                 | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/Documentation/blame-options.txt b/Documentation/blame-options.txt
index 02cb684..6c6c78f 100644
--- a/Documentation/blame-options.txt
+++ b/Documentation/blame-options.txt
@@ -28,12 +28,13 @@ include::line-range-format.txt[]
 -S <revs-file>::
 	Use revisions from revs-file instead of calling linkgit:git-rev-list[1].
 
---reverse::
+--reverse <rev>..<rev>::
 	Walk history forward instead of backward. Instead of showing
 	the revision in which a line appeared, this shows the last
 	revision in which a line has existed. This requires a range of
 	revision like START..END where the path to blame exists in
-	START.
+	START.  `git blame --reverse START` is taken as `git blame
+	--reverse START..HEAD` for convenience.
 
 -p::
 --porcelain::
diff --git a/builtin/blame.c b/builtin/blame.c
index a027b8a..574b47d 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2447,6 +2447,41 @@ static char *prepare_final(struct scoreboard *sb)
 	return xstrdup_or_null(name);
 }
 
+static const char *dwim_reverse_initial(struct scoreboard *sb)
+{
+	/*
+	 * DWIM "git blame --reverse ONE -- PATH" as
+	 * "git blame --reverse ONE..HEAD -- PATH" but only do so
+	 * when it makes sense.
+	 */
+	struct object *obj;
+	struct commit *head_commit;
+	unsigned char head_sha1[20];
+
+	if (sb->revs->pending.nr != 1)
+		return NULL;
+
+	/* Is that sole rev a committish? */
+	obj = sb->revs->pending.objects[0].item;
+	obj = deref_tag(obj, NULL, 0);
+	if (obj->type != OBJ_COMMIT)
+		return NULL;
+
+	/* Do we have HEAD? */
+	if (!resolve_ref_unsafe("HEAD", RESOLVE_REF_READING, head_sha1, NULL))
+		return NULL;
+	head_commit = lookup_commit_reference_gently(head_sha1, 1);
+	if (!head_commit)
+		return NULL;
+
+	/* Turn "ONE" into "ONE..HEAD" then */
+	obj->flags |= UNINTERESTING;
+	add_pending_object(sb->revs, &head_commit->object, "HEAD");
+
+	sb->final = (struct commit *)obj;
+	return sb->revs->pending.objects[0].name;
+}
+
 static char *prepare_initial(struct scoreboard *sb)
 {
 	int i;
@@ -2472,6 +2507,9 @@ static char *prepare_initial(struct scoreboard *sb)
 		sb->final = (struct commit *) obj;
 		final_commit_name = revs->pending.objects[i].name;
 	}
+
+	if (!final_commit_name)
+		final_commit_name = dwim_reverse_initial(sb);
 	if (!final_commit_name)
 		die("No commit to dig up from?");
 	return xstrdup(final_commit_name);
