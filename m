From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] reflog-walk: don't segfault on non-commit sha1's in the reflog
Date: Wed, 30 Dec 2015 13:20:44 -0800
Message-ID: <xmqqege3eiqb.fsf@gitster.mtv.corp.google.com>
References: <20151230131914.GA27241@lanh> <20151230152245.GA30549@spirit>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, pclouds@gmail.com
To: Dennis Kaarsemaker <dennis@kaarsemaker.net>
X-From: git-owner@vger.kernel.org Wed Dec 30 22:21:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aEOBc-0005oW-4X
	for gcvg-git-2@plane.gmane.org; Wed, 30 Dec 2015 22:21:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753476AbbL3VVA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Dec 2015 16:21:00 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:58924 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752118AbbL3VU6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Dec 2015 16:20:58 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D9385355FA;
	Wed, 30 Dec 2015 16:20:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=a8U7XqdWkNwlwFBXL3up8+IHs88=; b=KVn2rM
	g3tOITF+91Kb5cyvGyhy5le7S8jc2SIlHqMHQf8w3hIvqhLHGtNeemJsLxGoPgib
	dyE7bso9qHkFZ7jSd6oh6NWPV/h7Yuj7tA3E5cdWavglO1MwrOpxjcDb+Px1/8nh
	Ihx1i+inQZL9QgUNBg2mjYQp8cY50wKGVGMLg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ib1CiQ7djxZhkjf0FuMo4hlzCN4bJdOp
	3/a8XNOXpBGj21WlD0wHAG+JT9/cSHdnHVoef2gMQtF7Z5l901vviYczsybyBepy
	Sc/LBqwRuCsm+MrAYrbcJhqr+gAhb8bRpn/JyQ0N1QXHevKg6lOkfZNmXcoQDNtS
	q/MWX2eKVec=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D079C355F9;
	Wed, 30 Dec 2015 16:20:56 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 557C6355F8;
	Wed, 30 Dec 2015 16:20:56 -0500 (EST)
In-Reply-To: <20151230152245.GA30549@spirit> (Dennis Kaarsemaker's message of
	"Wed, 30 Dec 2015 16:22:49 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 36E650CA-AF3B-11E5-82A3-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283198>

Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:

> diff --git a/reflog-walk.c b/reflog-walk.c
> index 85b8a54..b85c8e8 100644
> --- a/reflog-walk.c
> +++ b/reflog-walk.c
> @@ -236,8 +236,8 @@ void fake_reflog_parent(struct reflog_walk_info *info, struct commit *commit)
>  	reflog = &commit_reflog->reflogs->items[commit_reflog->recno];
>  	info->last_commit_reflog = commit_reflog;
>  	commit_reflog->recno--;
> -	commit_info->commit = (struct commit *)parse_object(reflog->osha1);
> -	if (!commit_info->commit) {
> +	commit_info->commit = lookup_commit(reflog->osha1);
> +	if (!commit_info->commit || parse_commit(commit_info->commit)) {
>  		commit->parents = NULL;
>  		return;

This looks somewhat roundabout and illogical.  The original was bad
because it blindly assumed reflgo->osha1 refers to a commit without
making sure that assumption holds.  Calling lookup_commit() blindly
is not much better, even though you are helped that the function
happens not to barf if the given object is not a commit.

Also this changes semantics, no?  Trace the original flow and think
what happens, when we see a commit object that cannot be parsed in
parse_commit_buffer().  parse_object() calls parse_object_buffer()
which in turn calls parse_commit_buffer() and the entire callchain
returns NULL.  commit_info->commit will become NULL in such a case.

With your code, lookup_commit() will store a non NULL in
commit_info->commit, and parse_commit() calls parse_commit_buffer()
and that would fail, so you clear commit->parents to NULL but fail
to set commit_info->commit to NULL.

Why not keep the parse_object() as-is and make sure we error out
unless the result is a commit with a more explicit check, perhaps
like this, instead?

 reflog-walk.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/reflog-walk.c b/reflog-walk.c
index 85b8a54..861d7c4 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -221,6 +221,7 @@ void fake_reflog_parent(struct reflog_walk_info *info, struct commit *commit)
 	struct commit_info *commit_info =
 		get_commit_info(commit, &info->reflogs, 0);
 	struct commit_reflog *commit_reflog;
+	struct object *logobj;
 	struct reflog_info *reflog;
 
 	info->last_commit_reflog = NULL;
@@ -236,11 +237,13 @@ void fake_reflog_parent(struct reflog_walk_info *info, struct commit *commit)
 	reflog = &commit_reflog->reflogs->items[commit_reflog->recno];
 	info->last_commit_reflog = commit_reflog;
 	commit_reflog->recno--;
-	commit_info->commit = (struct commit *)parse_object(reflog->osha1);
-	if (!commit_info->commit) {
+	logobj = parse_object(reflog->osha1);
+	if (!logobj || logobj->type != OBJ_COMMIT) {
+		commit_info->commit = NULL;
 		commit->parents = NULL;
 		return;
 	}
+	commit_info->commit = (struct commit *)logobj;
 
 	commit->parents = xcalloc(1, sizeof(struct commit_list));
 	commit->parents->item = commit_info->commit;


> +test_expect_success 'reflog containing non-commit sha1s' '
> +	git checkout -b broken-reflog &&
> +	echo "$(git rev-parse HEAD^{tree}) $(git rev-parse HEAD) abc <xyz> 0000000001 +0000" >> .git/logs/refs/heads/broken-reflog &&
> +	git reflog broken-reflog
> +'
> +

This will negatively affect the ongoing effort to abstract out the
on-disk implementation of the reflog.  In some future installation
of Git, the reflog may not even be in .git/logs/refs/whatever file.

Use a non-branch ref, so that you can store any valid object not
just commits, and use a Git command (e.g. "git update-ref" or "git
tag") instead of the raw filesystem access to update it, perhaps
like this?

	git tag --create-reflog test-logs HEAD^ &&
	git tag -f test-logs HEAD^{tree} &&
	git tag -f test-logs HEAD &&
	git reflog test-logs
