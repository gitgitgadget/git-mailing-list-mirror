From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Funnies with "git fetch"
Date: Thu, 01 Sep 2011 20:28:50 -0700
Message-ID: <7vd3fjmxl9.fsf@alter.siamese.dyndns.org>
References: <7vpqjkw3nb.fsf@alter.siamese.dyndns.org>
 <7vpqjjnau1.fsf@alter.siamese.dyndns.org>
 <20110901233108.GA9339@sigill.intra.peff.net>
 <7vippbmygy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 02 05:30:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QzKS8-00073A-Co
	for gcvg-git-2@lo.gmane.org; Fri, 02 Sep 2011 05:30:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933138Ab1IBD2y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Sep 2011 23:28:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59289 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933111Ab1IBD2x (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Sep 2011 23:28:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E109E566D;
	Thu,  1 Sep 2011 23:28:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=N7otONJfE+lzWr4U8XYQOVH42VY=; b=fiUGWT
	g211N1IIE8qd8SqjYOGKSMeR/8nBQLNKqnysOG6doOe9NTD9HkXefqeIRVKD7T/9
	MfTKEDF/iqt5XAhav91KVsr+NuA4RSZaZoGdXvJVCROaj52L6sdlANtcaCvAm0+x
	Pub+ekeOVH2MYBotEopGOofwOutUcyKy4O7Cc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JBVNg6iHpR+aGHsostBTKMjRfxSJ0WCR
	5zSjOiqXgRDrAWO0T5bE8PEwzQH9CLZYGCPNYcier5x3ab2eKZDa2al0BWecW6hi
	TjnCk4CD2wkId9+IlD8Z2pIun4dUWhPSHOZTyfaEzDge00TLC2KVNbTFBFbBQubu
	mocKmBkET/U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D8989566C;
	Thu,  1 Sep 2011 23:28:52 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 37149566B; Thu,  1 Sep 2011
 23:28:52 -0400 (EDT)
In-Reply-To: <7vippbmygy.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 01 Sep 2011 20:09:49 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AE0DFFCE-D513-11E0-A229-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180593>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> If I understand correctly, your series is just about checking that we
>> have newly-referenced blobs. We were already checking commits and trees,
>> and we should already be hashing individual objects when we index the
>> pack. Right?
>
> You may be slightly misunderstanding the series.
>
> We let unpack-objects or index-pack consume the pack stream, either by
> exploding them into loose objects, or computing the object name for each
> object to create the mapping from object name to the offset. During this
> process, we deflate to read the contents and resolve the delta to come up
> with the object name for individual objects, so we would notice corruption
> at the individual object level. As pack stream does not say what name each
> object is (the recipient is expected to compute it), there is no "stream
> says it is object X but the data is actually for object Y" problem. The
> recipient does not even see "X"---all it sees is Y.

One thing I forgot to mention.

If you have receive.fsckobjects set, unpack-objects and index-pack are
called with the --strict option and causes fsck_objects() to run, so we
will also catch malformed commits and trees that way. But even then,
calling fsck_object() on a blob object always succeeds, so it is not a
real check.

We probably would want to flip the default for receive_fsck_objects to
true one of these days.

> The current code does not try to make sure we really have the objects
> necessary to connect the updated tips to our original refs at all.  Not
> just blobs but neither commits nor trees are traversed. The new check in
> store_updated_refs() is about that. So in that sense, the series is not
> about "just blobs".
>
> The "rev-list --verify-objects" patch is about "blob vs everything else".
> It is used in the existing quickfetch() check, and also the additional
> check in store_updated_refs(). The existing check we run with "--objects"
> is capable of detecting corruptions of commits and trees (as we had to be
> able to read them to discover objects they refer to), but that is not a
> sufficient check if we worry about missing blobs.

I am debating myself if we want to also add calls to fsck_object() to the
new codepath. An additional patch on top of [2/3] would look like this
(totally untested).

It would make "rev-list --verify-objects" useful independently from its
use in the context of "git fetch", and more importantly, what it checks in
the context of "git fetch", while it is related, is more or less
orthogonal to what receive.fsckobjects checks. The check done during the
transfer is to check the set of objects the other side threw at us. The
check done in the check_everything_connected() by calling "rev-list
--verify-objects" is to check the set of objects we are actually going to
use. The former _should_ be superset of the latter, but [3/3] is about
making sure that the former indeed is the superset of the latter.

 builtin/rev-list.c |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index ab3be7c..bd49615 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -7,6 +7,7 @@
 #include "log-tree.h"
 #include "graph.h"
 #include "bisect.h"
+#include "fsck.h"
 
 static const char rev_list_usage[] =
 "git rev-list [OPTION] <commit-id>... [ -- paths... ]\n"
@@ -53,6 +54,11 @@ static void show_commit(struct commit *commit, void *data)
 	struct rev_info *revs = info->revs;
 
 	graph_show_commit(revs->graph);
+	if (revs->verify_objects) {
+		if (!commit->object.parsed)
+			parse_object(commit->object.sha1);
+		fsck_object(&commit->object, 1, fsck_error_function);
+	}
 
 	if (revs->count) {
 		if (commit->object.flags & PATCHSAME)
@@ -183,8 +189,11 @@ static void show_object(struct object *obj,
 	struct rev_info *info = cb_data;
 
 	finish_object(obj, path, component, cb_data);
-	if (info->verify_objects && !obj->parsed && obj->type != OBJ_COMMIT)
-		parse_object(obj->sha1);
+	if (info->verify_objects && obj->type != OBJ_COMMIT) {
+		if (!obj->parsed)
+			parse_object(obj->sha1);
+		fsck_object(obj, 1, fsck_error_function);
+	}
 	show_object_with_name(stdout, obj, path, component);
 }
 
