From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] merge: do not contaminate option_commit with --squash
Date: Tue, 26 Apr 2016 14:32:24 -0700
Message-ID: <xmqqk2jkdpjr.fsf_-_@gitster.mtv.corp.google.com>
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
X-From: git-owner@vger.kernel.org Tue Apr 26 23:32:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avAax-0006UQ-4i
	for gcvg-git-2@plane.gmane.org; Tue, 26 Apr 2016 23:32:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752553AbcDZVc3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2016 17:32:29 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54394 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752406AbcDZVc2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2016 17:32:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1FBAF14EE9;
	Tue, 26 Apr 2016 17:32:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gUSk6iGgI0Ft5HP2h6Pt6hRpmXc=; b=NZJyAi
	VicG8mUMGyWtfOem6pj3ZPdSk4ytvhmKmP9u21V1EuEOo1qwRfytP0siopnGKhUl
	gncG2fyg4DUFlmzZVDsI6LM3qW8JgDEliZUpxyOMc0QeJI46whef4UKMp8/LDvpH
	qzR+WyL+ierM8uTsxGqnZzZLUZCLuGFq6LDU8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=afu3L0p96il7KcTz4az6AtUWgg5EY2sE
	zRceqVIZvvIL4wp8/KklkKGDAdXrJiEWBxglkD+N9buGtWw5/5SWd4ShgXjz7BAl
	wEA0dJ24CX/mU3yK7UZ/b82c9zYgfbRAR0uyVoM5osF8T4CqMySHrgP77Bn5hHHb
	lO1RsGxVv3U=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1836214EE8;
	Tue, 26 Apr 2016 17:32:27 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 83F8014EE7;
	Tue, 26 Apr 2016 17:32:26 -0400 (EDT)
In-Reply-To: <xmqqtwiy6end.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Mon, 18 Apr 2016 09:54:46 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5F06CB9E-0BF6-11E6-98D8-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292683>

It is true that we do not make a commit when we are asked to do
"merge --squash", and the code does so by setting option_commit
variable to zero when seeing the squash option.  But this made it
impossible to see from the value of option_commit if --no-commit was
given from the command line, or --squash turned it off.

We check for the value of option_commit at only two places.  Check
for the value of squash at them, too.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Just a preliminary clean-up for the next one which is on topic.

 builtin/merge.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index bf2f261..de9d1b6 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1237,11 +1237,8 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	if (verbosity < 0)
 		show_diffstat = 0;
 
-	if (squash) {
-		if (fast_forward == FF_NO)
-			die(_("You cannot combine --squash with --no-ff."));
-		option_commit = 0;
-	}
+	if (squash && fast_forward == FF_NO)
+		die(_("You cannot combine --squash with --no-ff."));
 
 	if (!argc) {
 		if (default_to_upstream)
@@ -1449,10 +1446,10 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		 * We are not doing octopus and not fast-forward.  Need
 		 * a real merge.
 		 */
-	else if (!remoteheads->next && !common->next && option_commit) {
+	else if (!remoteheads->next && !common->next && option_commit && !squash)
 		/*
 		 * We are not doing octopus, not fast-forward, and have
-		 * only one common.
+		 * only one common.  And we do want to create a new commit.
 		 */
 		refresh_cache(REFRESH_QUIET);
 		if (allow_trivial && fast_forward != FF_ONLY) {
@@ -1535,7 +1532,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		ret = try_merge_strategy(use_strategies[i]->name,
 					 common, remoteheads,
 					 head_commit, head_arg);
-		if (!option_commit && !ret) {
+		if ((!option_commit || squash) && !ret) {
 			merge_was_ok = 1;
 			/*
 			 * This is necessary here just to avoid writing
-- 
2.8.1-491-g88b9e4a
