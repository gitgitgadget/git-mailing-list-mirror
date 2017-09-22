Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29D17202A5
	for <e@80x24.org>; Fri, 22 Sep 2017 03:39:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751801AbdIVDjw (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Sep 2017 23:39:52 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56944 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751791AbdIVDjv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Sep 2017 23:39:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C8FA993FFE;
        Thu, 21 Sep 2017 23:39:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9rfaD8kWINR/n/EAOLwF6crpIic=; b=EQIF0u
        SIgxS6N/FK5fBXLNIoQF0YEH9gXotcksgtYP/KpHa9LrSoqWxlqyk1GgunuprEHa
        V9BeCd0fhhTfpehZv34YbP4ffzgZt2YQjKVXFN/bAhRPGBhJdQ9oS3ToRO70Aw5R
        kIp4GlW0kF8d5NrUiSn7l4H3TAc6i3hpRuDjU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GCCjNSp+lp3WZZ+9cDul/ni86/2ocgdm
        mZVPWfvAGqxG1aPdNWSYz6D3R8vSEJHt7Zp+8Ei/sSp2SaZQ7Euxri95+cm/CudC
        mY7bGxZbTiR7fp/5FDC5tLuZAFbyXNU/AfzKvd7ZkiJJafe465WrD5ZdvQeittw+
        RKnzCQ9HLqc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C1EB293FFD;
        Thu, 21 Sep 2017 23:39:48 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2A3A493FFC;
        Thu, 21 Sep 2017 23:39:48 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sahil Dua <sahildua2305@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Sep 2017, #03; Fri, 15)
References: <xmqq8thgy03t.fsf@gitster.mtv.corp.google.com>
        <CALiud+m1PAD8r0ygoUj3g4LzQjdoPu0CmjiejyG8pHOhr3Fk=Q@mail.gmail.com>
        <xmqqpoajmtu4.fsf@gitster.mtv.corp.google.com>
Date:   Fri, 22 Sep 2017 12:39:46 +0900
In-Reply-To: <xmqqpoajmtu4.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Fri, 22 Sep 2017 09:59:31 +0900")
Message-ID: <xmqqlgl7l7ul.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AEC6EAA2-9F47-11E7-8D5E-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> My understanding of the next step was for those who are interested
> in moving this topic forward to update these patches in that
> direction.

Well, I am one of those who are interested in moving this topic
forward, not because I'm likely to use it, but because the fewer
number of topics I have to keep in flight, the easier my work gets.

So here is such an update.  As the topic is not in 'next' yet, it
could also be implemented by replacing patch(es) in the series, but
doing it as a follow-up fix made it easier to see what got changed
(both in the code and in the tests), so that is how I decided to do
this patch.

-- >8 --
Subject: [PATCH] branch: fix "copy" to never touch HEAD

Probably because "git branch -c A B" piggybacked its implementation
on "git branch -m A B", when creating a new branch B by copying the
branch A that happens to be the current branch, it also updated HEAD
to point at the new branch.

This does not match the usual expectation.  If I were sitting on a
blue chair, and somebody comes and repaints it to red, I would
accept ending up sitting on a red chair, but if somebody creates a
new red chair, modelling it after the blue chair I am sitting on, I
do not expect to be booted off of the blue chair and ending up on
sitting on the red one.

Let's fix this strange behaviour before it hits 'next'.  Those who
want to create a new branch and switch to it can do "git checkout B"
after creating it by copying the current branch, or if that is so
useful to deserve a short-hand way to do so, perhaps extend "git
checkout -b B" to copy configurations while creating the new branch
B.  A "copy" should remain to be "copy", not "copy and sometimes
checkout".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
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
2.14.1-907-g5aa63875cf



