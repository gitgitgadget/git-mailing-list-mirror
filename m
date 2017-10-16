Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72C6520446
	for <e@80x24.org>; Mon, 16 Oct 2017 05:38:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751563AbdJPFip (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Oct 2017 01:38:45 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60543 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751136AbdJPFio (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Oct 2017 01:38:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 938EFA4022;
        Mon, 16 Oct 2017 01:38:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FdbjDcioo8f4QDEDkvQK//v9c0U=; b=JRxjOw
        3Yc4c+QdmoB3DyNUz+rAuoyYDo6zC71DW2AeLaUKMHdJRgHKIgWWuM8NTViv6mUp
        CuKSIfuLr98eusVUAFM/OScxdSrLIvIqYK+P4SqsAR+B3fMxfljVG5bJK0XkE8qX
        pWCpIBw5CGuQFzweFekemSW898WlrgUAzvHZM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Y09j0mBoTLe9TnesF/mTRQtbOrm1HS+t
        EgS2wyW+na03Jj74DAaxn0i7/jerl96/zKf6Dp1En7PqWDVaTgKVnAyagogKyIp/
        hTXE0wGJBA3Ez/qVX6NH/0bmtNhsOyBSZb5Ke1NaaoNaEWO0TAPGf0+IqZ4sOHh2
        KIGNUR4CqSU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8CB7BA4020;
        Mon, 16 Oct 2017 01:38:38 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EB424A401F;
        Mon, 16 Oct 2017 01:38:37 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "git\@vger.kernel.org" <git@vger.kernel.org>
Cc:     Yaroslav Halchenko <yoh@onerussian.com>
Subject: [PATCH] merge: teach -Xours/-Xtheirs to symbolic link merge
References: <20170925000213.rilmsczdbi3jqkta@hopa.kiewit.dartmouth.edu>
        <xmqqwp4nfuv1.fsf@gitster.mtv.corp.google.com>
        <20170925031751.lg7zk6krt65dxwas@hopa.kiewit.dartmouth.edu>
        <xmqqmv5je412.fsf_-_@gitster.mtv.corp.google.com>
        <20170925143040.4qgofxcdahal46r7@hopa.kiewit.dartmouth.edu>
        <xmqqing6cje7.fsf@gitster.mtv.corp.google.com>
        <xmqqefqucigh.fsf@gitster.mtv.corp.google.com>
        <xmqqa81ichdu.fsf@gitster.mtv.corp.google.com>
        <20170926133703.7gtk5ztkhqvfxszh@hopa.kiewit.dartmouth.edu>
Date:   Mon, 16 Oct 2017 14:38:36 +0900
In-Reply-To: <20170926133703.7gtk5ztkhqvfxszh@hopa.kiewit.dartmouth.edu>
        (Yaroslav Halchenko's message of "Tue, 26 Sep 2017 09:37:03 -0400")
Message-ID: <xmqqtvyzslcz.fsf_-_@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 42610E24-B234-11E7-B14D-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The -Xours/-Xtheirs merge options were originally defined as a way
to "force" the resolution of 3way textual merge conflicts to take
one side without using your editor, hence did not even trigger in
situations where you would normally not get the <<< === >>> conflict
markers.

This was improved for binary files back in 2012 with a944af1d
("merge: teach -Xours/-Xtheirs to binary ll-merge driver",
2012-09-08).

Teach a similar trick to the codepath that deals with merging two
conflicting changes to symbolic links.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Looks like I queued this on 'pu' but never sent it out to the
   list for extra eyeballs.  On the tests are new, relative to what
   was sent out earlier and archived at:

   https://public-inbox.org/git/xmqqa81ichdu.fsf@gitster.mtv.corp.google.com

 merge-recursive.c            | 17 +++++++++++++----
 t/t6037-merge-ours-theirs.sh | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+), 4 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 1494ffdb82..ed529f2ceb 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1002,10 +1002,19 @@ static int merge_file_1(struct merge_options *o,
 						       &b->oid,
 						       !o->call_depth);
 		} else if (S_ISLNK(a->mode)) {
-			oidcpy(&result->oid, &a->oid);
-
-			if (!oid_eq(&a->oid, &b->oid))
-				result->clean = 0;
+			switch (o->recursive_variant) {
+			case MERGE_RECURSIVE_NORMAL:
+				oidcpy(&result->oid, &a->oid);
+				if (!oid_eq(&a->oid, &b->oid))
+					result->clean = 0;
+				break;
+			case MERGE_RECURSIVE_OURS:
+				oidcpy(&result->oid, &a->oid);
+				break;
+			case MERGE_RECURSIVE_THEIRS:
+				oidcpy(&result->oid, &b->oid);
+				break;
+			}
 		} else
 			die("BUG: unsupported object type in the tree");
 	}
diff --git a/t/t6037-merge-ours-theirs.sh b/t/t6037-merge-ours-theirs.sh
index 3889eca4ae..0aebc6c028 100755
--- a/t/t6037-merge-ours-theirs.sh
+++ b/t/t6037-merge-ours-theirs.sh
@@ -73,4 +73,36 @@ test_expect_success 'pull passes -X to underlying merge' '
 	git reset --hard master && test_must_fail git pull -s recursive -X bork . side
 '
 
+test_expect_success SYMLINKS 'symlink with -Xours/-Xtheirs' '
+	git reset --hard master &&
+	git checkout -b two master &&
+	ln -s target-zero link &&
+	git add link &&
+	git commit -m "add link pointing to zero" &&
+
+	ln -f -s target-two link &&
+	git commit -m "add link pointing to two" link &&
+
+	git checkout -b one HEAD^ &&
+	ln -f -s target-one link &&
+	git commit -m "add link pointing to one" link &&
+
+	# we expect symbolic links not to resolve automatically, of course
+	git checkout one^0 &&
+	test_must_fail git merge -s recursive two &&
+
+	# favor theirs to resolve to target-two?
+	git reset --hard &&
+	git checkout one^0 &&
+	git merge -s recursive -X theirs two &&
+	git diff --exit-code two HEAD link &&
+
+	# favor ours to resolve to target-one?
+	git reset --hard &&
+	git checkout one^0 &&
+	git merge -s recursive -X ours two &&
+	git diff --exit-code one HEAD link
+
+'
+
 test_done
-- 
2.15.0-rc1-172-gbfe4246c99

