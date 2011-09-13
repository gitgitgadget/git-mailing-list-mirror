From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git checkout --orphan skips reflogging
Date: Tue, 13 Sep 2011 16:04:07 -0700
Message-ID: <7vaaa8vyc8.fsf@alter.siamese.dyndns.org>
References: <CA+gfSn-tVgj=FYiVGK7kmH4gpnXF3HUbs+f=DfRey6GrpadVYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Dmitry Ivankov <divanorama@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 14 01:05:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3c2Z-0000Fs-4w
	for gcvg-git-2@lo.gmane.org; Wed, 14 Sep 2011 01:05:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933011Ab1IMXEL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Sep 2011 19:04:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58673 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932984Ab1IMXEK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Sep 2011 19:04:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A78C24AB6;
	Tue, 13 Sep 2011 19:04:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=JKLwT6nqSsZfOjSl0hrX6SCjJog=; b=hGJDNYP68wc5DflDagBn
	t7wEgvu+GEcuVIRAQw3sEfSIEiwcn2bF1nqKibghBee5WpKLRpydi2a7pg0yBNKV
	V9iFLyqDgq+CRL61l/senh8G/EA8lUE/h/IFhNBfUGtrbiH73r/ISDIBk4+Nzvgi
	i+UTaW+FO8QUSPVRlk6EQHQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=o5tlOOVofBedOs8c82kuM7i7SJyHkeuw/tPQ2d1WX6eNpT
	1ZniieA4+wxzi6DHTQXtFUe/otkrau2w1T3yxqSnDwB8g9v/vsmYlRjrjQLtJvik
	k/ZJci5bPuoLQJhtpf0t4JsqOB9lrwiJ+xeQHnqBnbEA/Q+k3xfFW+LtJh40U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9E6934AB4;
	Tue, 13 Sep 2011 19:04:09 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1982B4AB2; Tue, 13 Sep 2011
 19:04:09 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AFEF2FBE-DE5C-11E0-AEDF-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181320>

Dmitry Ivankov <divanorama@gmail.com> writes:

> In short, git checkout --orphan doesn't write
> HEAD_sha1 -> 00000
> entry to logs/HEAD, while git-comit will write
> 00000 -> new_orphan_HEAD_sha1
> entry. And then reflog backward walk will stop on 000 -> entry and
> won't see earlier history.

Funny. From the point of view of the _current_ branch, it sort of makes
sense to stop the traversal at that point, but I agree for HEAD reflog
that records branch switching, the traversal should not stop.

I am not sure if recording 0{40} after --orphan is the right thing to do
either (for that matter, I do not necessarily think running --orphan is a
sane thing to do, but that is a separate issue).

> Isn't  it also a bug in reflog walking that we rely on each old_sha1
> being new_sha1 of a previous entry?

I am not all that familiar with the reflog walking (which is admittedly a
bolted-on hack that injects commits with fake ancestry) code, but I think
it assumes the old sha1 field on the current entry matches the new sha1
field on the previous entry, and we could change it to be a bit more
robust.

The attached patch _may_ (I didn't even compile test it) remove the
dependency on osha1[] and make the code consistently use nsha1[], but I
think stopping at the 0{40} is pretty much fundamental in the revision
walking machinery the reflog walking code is piggy-backing on, and I do
not think this patch would change that.

 reflog-walk.c |   17 ++++++++++++-----
 1 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/reflog-walk.c b/reflog-walk.c
index 5d81d39..261d300 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -211,6 +211,13 @@ int add_reflog_for_walk(struct reflog_walk_info *info,
 	return 0;
 }
 
+static struct reflog_info *peek_reflog_ent(struct commit_reflog *clog)
+{
+	if (clog->recno < 0)
+		return NULL;
+	return &clog->reflogs->items[clog->recno];
+}
+
 void fake_reflog_parent(struct reflog_walk_info *info, struct commit *commit)
 {
 	struct commit_info *commit_info =
@@ -223,20 +230,20 @@ void fake_reflog_parent(struct reflog_walk_info *info, struct commit *commit)
 		return;
 
 	commit_reflog = commit_info->util;
-	if (commit_reflog->recno < 0) {
+	reflog = peek_reflog_ent(commit_reflog);
+	if (!reflog) {
 		commit->parents = NULL;
 		return;
 	}
-
-	reflog = &commit_reflog->reflogs->items[commit_reflog->recno];
 	info->last_commit_reflog = commit_reflog;
 	commit_reflog->recno--;
-	commit_info->commit = (struct commit *)parse_object(reflog->osha1);
-	if (!commit_info->commit) {
+	reflog = peek_reflog_ent(commit_reflog);
+	if (!reflog) {
 		commit->parents = NULL;
 		return;
 	}
 
+	commit_info->commit = (struct commit *)parse_object(reflog->nsha1);
 	commit->parents = xcalloc(sizeof(struct commit_list), 1);
 	commit->parents->item = commit_info->commit;
 }
