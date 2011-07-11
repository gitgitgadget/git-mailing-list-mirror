From: Junio C Hamano <gitster@pobox.com>
Subject: Re: reproducible unexpected behavior for 'git reset'
Date: Mon, 11 Jul 2011 15:41:09 -0700
Message-ID: <7voc10a1a2.fsf@alter.siamese.dyndns.org>
References: <75BBC138-2BD7-41F9-9D84-CEFF23CDC235@johnnowak.com>
 <7vwrfoa3fg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Nowak <john@johnnowak.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 12 00:41:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgPAE-0003ru-47
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jul 2011 00:41:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758285Ab1GKWlN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jul 2011 18:41:13 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:41148 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758232Ab1GKWlM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2011 18:41:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 082095322;
	Mon, 11 Jul 2011 18:41:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SolMiKGL+ZBDtFe+jvExpDPnlmk=; b=YE3J98
	eGZB1Iz1ivNBRiaq2H0FsKdEViPgLFpfhCkrovQGUsO6cH1sEtwpUBKgEzUULF1i
	v67A9GIF30SysvbPPf/zI111n4JVijGIA54rsCoDHhEaW2qZnQ0l/QQoQqp/eBbP
	kSpqA9pWSGPamRQxpCxPPtwaZxG540bJtVce4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kY30lAlgRKWX+DN2MmJgOr5M6Ay4k4mN
	gpe53hzso5YOFLOk1XnzRMNW6y5Y8DIOizTNm9u59yg0fiGnKuQyDDgvGy3zQNfu
	SnZILyVN7TI+JOVrX+hc43jOHVTYw96UuPGiXwumeG7kVbXX1IeVxj26CXaCe33R
	aW7ZNWPGVhs=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 021FE5321;
	Mon, 11 Jul 2011 18:41:12 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 2E3CF5320; Mon, 11 Jul 2011
 18:41:11 -0400 (EDT)
In-Reply-To: <7vwrfoa3fg.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 11 Jul 2011 14:54:43 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E03189D6-AC0E-11E0-826D-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176906>

Junio C Hamano <gitster@pobox.com> writes:

>> I am able to reproduce a scenario where, after a 'commit' and a 'stash
>> pop' that results in a merge conflict, I need to 'reset' a file twice in
>> order to get the index back to HEAD.
>
> Thanks, you found a bug in "git reset [<commit>] -- path" codepath, it
> seems, when dealing with an unmerged path.

This patch is probably a wrong way to fix this issue; I have this
suspicion that the original code for "reset [<commit>] -- paths..."
codepath is correctly designed to deal with unmerged index, and it would
probably need a deeper surgery.

-- >8 --
Subject: [PATCH] reset [<commit>] paths...: do not mishandle unmerged paths

By reading the index with unmerged content before running diff-index
with the tree-ish we are reading from, read_from_tree() function ended
up stuffing the object name from a wrong stage to the resulting index.

Noticed by John Nowak.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 builtin/reset.c  |    2 +-
 t/t7102-reset.sh |   15 +++++++++++++++
 2 files changed, 16 insertions(+), 1 deletions(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index 98bca04..09c8d2a 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -202,7 +202,7 @@ static int read_from_tree(const char *prefix, const char **argv,
 
 	index_fd = hold_locked_index(lock, 1);
 	index_was_discarded = 0;
-	read_cache();
+	read_cache_unmerged();
 	if (do_diff_cache(tree_sha1, &opt))
 		return 1;
 	diffcore_std(&opt);
diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
index f1cfc9a..1784412 100755
--- a/t/t7102-reset.sh
+++ b/t/t7102-reset.sh
@@ -429,6 +429,21 @@ test_expect_success '--mixed refreshes the index' '
 	test_i18ncmp expect output
 '
 
+test_expect_success 'resetting specific path that is unmerged' '
+	F1=$(git rev-parse HEAD:file1) &&
+	F2=$(git rev-parse HEAD:file2) &&
+	F3=$(git rev-parse HEAD:secondfile) &&
+	{
+		echo "000000 $_z40 0	file2" &&
+		echo "100644 $F1 1	file2" &&
+		echo "100644 $F2 2	file2" &&
+		echo "100644 $F3 3	file2"
+	} | git update-index --index-info &&
+	git ls-files -u &&
+	test_must_fail git reset HEAD file2 &&
+	git diff-index --exit-code --cached HEAD
+'
+
 test_expect_success 'disambiguation (1)' '
 
 	git reset --hard &&
