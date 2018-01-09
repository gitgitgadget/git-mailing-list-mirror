Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,PI_IMPORTANCE_HIGH,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC2DD1FAE2
	for <e@80x24.org>; Tue,  9 Jan 2018 18:19:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752112AbeAIST2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jan 2018 13:19:28 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50189 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751667AbeAIST1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jan 2018 13:19:27 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9D9F3BDB03;
        Tue,  9 Jan 2018 13:19:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=F+y9jEnZ/FTx02BBEpvvkKQ2MOA=; b=Bbkdff
        3wkFDIm6+NGU9kJtbkDM+X4BnmcvFQzCB8U9JlPO4rMJ66ajjrAZMSl+PB18CPaW
        /5MTPAZ65+UJ5F5iCqCSl2GqYtUN95ufH8R2McpIDE1EPhShEl2rkDW/5QMxDdAj
        LHPjvnbAdXuZkmTDEb9I/+NYZwk1tk6JCwgh8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nY5mnCf6yqPOPLog33mKT6nVsN2Q1G2/
        i04TistFFmTVCurbVYQgFmN6ooC3HSIk+zcdJ+Alkg4CRcjC2aS7Ff2eVURXa9AO
        4WO5MsDpdGWVimLoVUAPqzoHJtCARm1A3gLohAC7JCkD5uvNfY4NsYzdEUwTbA/b
        f2oKnHZZA5s=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 946F6BDB02;
        Tue,  9 Jan 2018 13:19:26 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0F5FBBDB01;
        Tue,  9 Jan 2018 13:19:25 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, a.krey@gmx.de
Subject: [PATCH] merge-recursive: do not look at the index during recursive merge
References: <CABPp-BGy3_RyVQfCm+9O_AAfKA0_CZ5ajJE7NuLbToERWyWmqQ@mail.gmail.com>
        <20171221191907.4251-1-newren@gmail.com>
        <20171221191907.4251-3-newren@gmail.com>
        <xmqqbmi484tw.fsf@gitster.mtv.corp.google.com>
Importance: high
Date:   Tue, 09 Jan 2018 10:19:24 -0800
In-Reply-To: <xmqqbmi484tw.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Mon, 08 Jan 2018 12:37:31 -0800")
Message-ID: <xmqq7esq7v4j.fsf_-_@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9FE15504-F569-11E7-B783-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When merging another branch into ours, if their tree is the same as
the common ancestor's, we can declare that our tree represents the
result of three-way merge.  In such a case, the recursive merge
backend incorrectly used to create a commit out of our index, even
when the index has changes.

A recent fix attempted to prevent this by adding a comparison
between "our" tree and the index, but forgot that this check must be
restricted only to the outermost merge.  Inner merges performed by
the recursive backend across merge bases are by definition made from
scratch without having any local changes added to the index.  The
call to index_has_changes() during an inner merge is working on the
index that has no relation to the merge being performed, preventing
legitimate merges from getting carried out.

Fix it by limiting the check to the outermost merge.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

    Junio C Hamano <gitster@pobox.com> writes:

    > Elijah Newren <newren@gmail.com> writes:
    >
    >> diff --git a/merge-recursive.c b/merge-recursive.c
    >> index 2ecf495cc2..780f81a8bd 100644
    >> --- a/merge-recursive.c
    >> +++ b/merge-recursive.c
    >> @@ -1952,6 +1952,13 @@ int merge_trees(struct merge_options *o,
    >>  	}
    >>  
    >>  	if (oid_eq(&common->object.oid, &merge->object.oid)) {
    >> +		struct strbuf sb = STRBUF_INIT;
    >> +
    >> +		if (index_has_changes(&sb)) {
    >> +			err(o, _("Dirty index: cannot merge (dirty: %s)"),
    >> +			    sb.buf);
    >> +			return 0;
    >> +		}
    >>  		output(o, 0, _("Already up to date!"));
    >>  		*result = head;
    >>  		return 1;
    >
    > I haven't come up with an addition to the test suite, but I suspect
    > this change is conceptually wrong.  What if a call to this function
    > is made during a recursive, inner merge?

    Now I have.

 merge-recursive.c          |  2 +-
 t/t3030-merge-recursive.sh | 50 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 780f81a8bd..0fc580d8ca 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1954,7 +1954,7 @@ int merge_trees(struct merge_options *o,
 	if (oid_eq(&common->object.oid, &merge->object.oid)) {
 		struct strbuf sb = STRBUF_INIT;
 
-		if (index_has_changes(&sb)) {
+		if (!o->call_depth && index_has_changes(&sb)) {
 			err(o, _("Dirty index: cannot merge (dirty: %s)"),
 			    sb.buf);
 			return 0;
diff --git a/t/t3030-merge-recursive.sh b/t/t3030-merge-recursive.sh
index 9a893b5fe7..12e3b1392d 100755
--- a/t/t3030-merge-recursive.sh
+++ b/t/t3030-merge-recursive.sh
@@ -678,4 +678,54 @@ test_expect_success 'merge-recursive remembers the names of all base trees' '
 	test_cmp expect actual
 '
 
+test_expect_success 'merge-recursive internal merge resolves to the sameness' '
+	git reset --hard HEAD &&
+
+	# We are going to create a history leading to two criss-cross
+	# branches A and B.  The common ancestor at the bottom, O0,
+	# has two childs O1 and O2, both of which will be merge base
+	# between A and B, like so:
+	#
+	#       O1---A
+	#      /  \ /
+	#    O0    .
+	#      \  / \
+	#       O2---B
+	#
+	# The recently added "check to see if the index is different from
+	# the tree into which something else is getting merged into and
+	# reject" check must NOT kick in when an inner merge between O1
+	# and O2 is made.  Both O1 and O2 happen to have the same tree
+	# as O0 in this test to trigger the bug---whether the inner merge
+	# is made by merging O2 into O1 or O1 into O2, their common ancestor
+	# O0 and the branch being merged have the same tree, and the code
+	# before fix will incorrectly try to look at the index.
+
+	echo "zero" >file &&
+	git add file &&
+	test_tick &&
+	git commit -m "O0" &&
+	O0=$(git rev-parse HEAD) &&
+
+	test_tick &&
+	git commit --allow-empty -m "O2" &&
+	O1=$(git rev-parse HEAD) &&
+
+	git reset --hard $O0 &&
+	test_tick &&
+	git commit --allow-empty -m "O2" &&
+	O2=$(git rev-parse HEAD) &&
+
+	test_tick &&
+	git merge -s ours $O1 &&
+	B=$(git rev-parse HEAD) &&
+
+	git reset --hard $O1 &&
+	test_tick &&
+	git merge -s ours $O2 &&
+	A=$(git rev-parse HEAD) &&
+
+	git merge $B
+'
+
 test_done
-- 
2.16.0-rc1-164-gb9fca19b00

