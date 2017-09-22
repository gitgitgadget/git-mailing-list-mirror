Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CE81202A5
	for <e@80x24.org>; Fri, 22 Sep 2017 04:57:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751791AbdIVE5t (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Sep 2017 00:57:49 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59700 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751358AbdIVE5t (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2017 00:57:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A0478A8444;
        Fri, 22 Sep 2017 00:57:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fKAAhjAdvAUsiuKn+yLJkriyVVw=; b=DApNb7
        9HUHQ7r8R7WZ+klwRqU58HVTmARx+d9G8/4v7enxWnGemunzays/Cb3MaeNi1GPd
        GRhNFyITSI8Jve2lOynJyue9oUYFGzUgO9goD7vHtVnSqLjhVMOTwZ0gJZ1zLhSV
        yQo824Lb7ZKhJ5aJ4HmCHQAFYk6U5qi7bvKqE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=X6xdfA9+GDyB8urHdb45H5OV5dKzl4V1
        uhOY+M7Knptuz1U/ZroexAVyiKv0M4kruPssFUZGvA6nRZJLguTOJB7KA9dKsqcX
        DEaWZ8ln7Lg9pdMN/JF6+c9cQGnH4UgWSxobXaE/tL0uBl1YfDykRojl0u8A2ClY
        AlsDTFd7Gl4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 97328A8443;
        Fri, 22 Sep 2017 00:57:48 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EA87AA8441;
        Fri, 22 Sep 2017 00:57:47 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sahil Dua <sahildua2305@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 4/3] branch: fix "copy" to never touch HEAD
References: <xmqqeftuh5q7.fsf@gitster.mtv.corp.google.com>
        <20170705231454.15666-1-avarab@gmail.com>
        <xmqq60f6h03t.fsf@gitster.mtv.corp.google.com>
Date:   Fri, 22 Sep 2017 13:57:46 +0900
In-Reply-To: <xmqq60f6h03t.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Wed, 05 Jul 2017 17:37:10 -0700")
Message-ID: <xmqqvakbjpo5.fsf_-_@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9426B50A-9F52-11E7-95E3-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When creating a new branch B by copying the branch A that happens to
be the current branch, it also updates HEAD to point at the new
branch.  It probably was made this way because "git branch -c A B"
piggybacked its implementation on "git branch -m A B",

This does not match the usual expectation.  If I were sitting on a
blue chair, and somebody comes and repaints it to red, I would
accept ending up sitting on a chair that is now red (I am also OK to
stand, instead, as there no longer is my favourite blue chair).  But
if somebody creates a new red chair, modelling it after the blue
chair I am sitting on, I do not expect to be booted off of the blue
chair and ending up on sitting on the new red one.

Let's fix this before it hits 'next'.  Those who want to create a
new branch and switch to it can do "git checkout B" after doing a
"git branch -c B", and if that operation is so useful and deserves a
short-hand way to do so, perhaps extend "git checkout -b B" to copy
configurations while creating the new branch B.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Let's send an updated one as a follow-up to the discussion thread
   that it is a follow-up to.  The patch in this message is the same
   as the one I previously sent; the proposed log message has been
   updated somewhat.

 builtin/branch.c  |  9 +++------
 t/t3200-branch.sh | 10 +++++-----
 2 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 89f64f4123..e2e3692838 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -506,12 +506,9 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 				oldref.buf + 11);
 	}
 
-	if (replace_each_worktree_head_symref(oldref.buf, newref.buf, logmsg.buf)) {
-		if (copy)
-			die(_("Branch copied to %s, but HEAD is not updated!"), newname);
-		else
-			die(_("Branch renamed to %s, but HEAD is not updated!"), newname);
-	}
+	if (!copy &&
+	    replace_each_worktree_head_symref(oldref.buf, newref.buf, logmsg.buf))
+		die(_("Branch renamed to %s, but HEAD is not updated!"), newname);
 
 	strbuf_release(&logmsg);
 
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 5d03ad16f6..be9b3784c6 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -422,7 +422,7 @@ test_expect_success 'git branch --copy is a synonym for -c' '
 	test_cmp expect actual
 '
 
-test_expect_success 'git branch -c ee ef should copy and checkout branch ef' '
+test_expect_success 'git branch -c ee ef should copy to create branch ef' '
 	git checkout -b ee &&
 	git reflog exists refs/heads/ee &&
 	git config branch.ee.dummy Hello &&
@@ -431,7 +431,7 @@ test_expect_success 'git branch -c ee ef should copy and checkout branch ef' '
 	git reflog exists refs/heads/ef &&
 	test $(git config branch.ee.dummy) = Hello &&
 	test $(git config branch.ef.dummy) = Hello &&
-	test $(git rev-parse --abbrev-ref HEAD) = ef
+	test $(git rev-parse --abbrev-ref HEAD) = ee
 '
 
 test_expect_success 'git branch -c f/f g/g should work' '
@@ -494,12 +494,12 @@ test_expect_success 'git branch -C c1 c2 should succeed when c1 is checked out'
 	git checkout -b c1 &&
 	git branch c2 &&
 	git branch -C c1 c2 &&
-	test $(git rev-parse --abbrev-ref HEAD) = c2
+	test $(git rev-parse --abbrev-ref HEAD) = c1
 '
 
-test_expect_success 'git branch -C c1 c2 should add entries to .git/logs/HEAD' '
+test_expect_success 'git branch -C c1 c2 should never touch HEAD' '
 	msg="Branch: copied refs/heads/c1 to refs/heads/c2" &&
-	grep "$msg$" .git/logs/HEAD
+	! grep "$msg$" .git/logs/HEAD
 '
 
 test_expect_success 'git branch -C master should work when master is checked out' '
-- 
2.14.1-929-g25eae544e9

