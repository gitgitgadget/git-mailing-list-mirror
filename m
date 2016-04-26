From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] merge: warn --no-commit merge when no new commit is created
Date: Tue, 26 Apr 2016 14:37:31 -0700
Message-ID: <xmqqd1pcdpb8.fsf_-_@gitster.mtv.corp.google.com>
References: <874mb0kkkk.fsf@gmail.com>
	<alpine.DEB.2.20.1604180825170.2967@virtualbox>
	<CAH5451kW3t1Y7oW=uHv85jzHwsnQcDK2jdLisauNF-x1LRwqLA@mail.gmail.com>
	<87a8krpehl.fsf@gmail.com>
	<CAH5451mDYhavx_OLfXe6cC2WguCsFWEBBBBOCPyX3E6ZJw27+w@mail.gmail.com>
	<xmqqy48a6fht.fsf@gitster.mtv.corp.google.com>
	<xmqqtwiy6end.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Christoph Paulik <cpaulik@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Andrew Ardill <andrew.ardill@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 26 23:37:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avAfr-0008Qy-3a
	for gcvg-git-2@plane.gmane.org; Tue, 26 Apr 2016 23:37:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752690AbcDZVhf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2016 17:37:35 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59266 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752415AbcDZVhe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2016 17:37:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 493B316C83;
	Tue, 26 Apr 2016 17:37:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UxiaIFmYxgrZ6mV7BRCdmSUty0s=; b=rF9YYa
	i4Sm0nRBMM0izmik6HtskQ5U8b1+aXz5QqssZdezNWdX3vKr3XhNLlvr6bLv9PXI
	dbi84PhHEB93BpwONkNajCKHzPiKIjRU3bOw937hxtq0czIbu0ooN4mcjumDfznB
	4yirA/Gjo21lVXFreZ092DMfPL9GJ6WqrCOs0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DO8UGTjxtV20w4OOCyC0JVx7aTTHSsvd
	J/XTxBfpmWhp46/u/t9c7tYz+jgwZkQypT/Lw+N4PVLryHasrXxn7mqEL8/X8YtI
	qP9kFAe6nSkgBvvrtC10hBGLud73qnphB7NaEpnQLU/9VjAKkUSEKe/pIime/3m6
	UKcZIrlI6vU=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3FB7C16C82;
	Tue, 26 Apr 2016 17:37:33 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9DE6A16C81;
	Tue, 26 Apr 2016 17:37:32 -0400 (EDT)
In-Reply-To: <xmqqtwiy6end.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Mon, 18 Apr 2016 09:54:46 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 157B280C-0BF7-11E6-8899-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292684>

A user who uses "--no-commit" does so with the intention to record a
resulting merge after amending the merge result in the working tree.
But there is nothing to amend and record, if the same "git merge"
without "--no-commit" wouldn't have created a merge commit (there
are two cases: (1) the other branch is a descendant of the current
branch, (2) the other branch is an ancestor of the current branch).

The user would want to know that before doing further damange to his
history.  When "merge --no-commit" fast-forwarded or succeeded with
"already up-to-date" or "fast-forward", give a warning message.

We may want to turn this into a die() after a transition period.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * The necessary update to avoid end-user mistake would look like
   this.  I am not queuing this or further working on it myself,
   as I am not sure if it is all that useful.

 builtin/merge.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/builtin/merge.c b/builtin/merge.c
index f641751..66c536d 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1157,6 +1157,15 @@ static struct commit_list *collect_parents(struct commit *head_commit,
 	return remoteheads;
 }
 
+static void no_commit_impossible(const char *message)
+{
+	if (!option_commit) {
+		warning("%s\n%s", _(message),
+			_("--no-commit is impossible"));
+		warning(_("In future versions of Git, this will become an error."));
+	}
+}
+
 int cmd_merge(int argc, const char **argv, const char *prefix)
 {
 	unsigned char result_tree[20];
@@ -1403,6 +1412,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		 * If head can reach all the merge then we are up to date.
 		 * but first the most common case of merging one remote.
 		 */
+		no_commit_impossible(_("Already up-to-date"));
 		finish_up_to_date("Already up-to-date.");
 		goto done;
 	} else if (fast_forward != FF_NO && !remoteheads->next &&
@@ -1412,6 +1422,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		struct strbuf msg = STRBUF_INIT;
 		struct commit *commit;
 
+		no_commit_impossible(_("Fast-forward"));
 		if (verbosity >= 0) {
 			char from[GIT_SHA1_HEXSZ + 1], to[GIT_SHA1_HEXSZ + 1];
 			find_unique_abbrev_r(from, head_commit->object.oid.hash,
@@ -1488,6 +1499,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 			}
 		}
 		if (up_to_date) {
+			no_commit_impossible(_("Already up-to-date"));
 			finish_up_to_date("Already up-to-date. Yeeah!");
 			goto done;
 		}
-- 
2.8.1-491-g88b9e4a
