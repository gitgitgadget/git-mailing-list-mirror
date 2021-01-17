Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 011E8C433E0
	for <git@archiver.kernel.org>; Sun, 17 Jan 2021 22:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB8D0224B0
	for <git@archiver.kernel.org>; Sun, 17 Jan 2021 22:57:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730204AbhAQW5A (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 Jan 2021 17:57:00 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59384 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730186AbhAQW46 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Jan 2021 17:56:58 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CE2E7B73A8;
        Sun, 17 Jan 2021 17:56:16 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=WR7hI2Ky8yJsj2QPT+FZ2JYJVs4=; b=huGHPdAipncwlcfgXB4C
        oF1wBxlmwRShlDls7eenamnr7n9U/yuP08QFNmeeDmA3P+k4r0cArLmI4u1CJ557
        ZrIdO/UXQHP8LfyzE/MCKNMZnUyqJyKksrjI1JXcbG1NpVynG+QuUuykqeivS8xi
        9JCpqIO/hysbVSP4Bc/VG4U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=grOv/CvrjcuA15cMcIneE4BY7YPLKt7eiWo2HqZViMG1on
        +tUoRJdyWchu+UNLGqNc5tGmLSABv/VQUBuoHUVPc4+XvT8HPnD8SPnNp/ydl6MD
        +LuNuVLUJOoz1bAdHIoz5u3hnlnb2Q//DUY7tLjUsNqfT/S/ZDNnna4lnq9UA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C613DB73A7;
        Sun, 17 Jan 2021 17:56:16 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4708EB73A6;
        Sun, 17 Jan 2021 17:56:16 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kyle Marek <kmarek@pdinc.us>
Cc:     Jason Pyeron <jpyeron@pdinc.us>, git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH 2/2] revision: implement --show-linear-break for --graph
References: <196101d6eab6$20714550$6153cff0$@pdinc.us>
        <20210117110337.429994-1-kmarek@pdinc.us>
        <20210117110337.429994-3-kmarek@pdinc.us>
Date:   Sun, 17 Jan 2021 14:56:15 -0800
Message-ID: <xmqqsg6zkwa8.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 34658236-5917-11EB-A199-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kyle Marek <kmarek@pdinc.us> writes:

> where <barrier> sets rev_info.break_revision_mark, the revision mark
> used for root commits.

Please make sure that the body of the proposed log message begins
with a full sentence, not as a continuation of a sentence that the
title started (as a consequence, the title must be understandable
without the help of the beginning part of the body, too).

> Signed-off-by: Kyle Marek <kmarek@pdinc.us>
> ---

> diff --git a/revision.c b/revision.c
> index 8556923de8..51deab2326 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -2402,10 +2402,12 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
>  		revs->show_signature = 0;
>  	} else if (!strcmp(arg, "--show-linear-break")) {
>  		revs->break_bar = "                    ..........";
> +		revs->break_revision_mark = "#";
>  		revs->track_linear = 1;
>  		revs->track_first_time = 1;
>  	} else if (skip_prefix(arg, "--show-linear-break=", &optarg)) {
>  		revs->break_bar = xstrdup(optarg);
> +		revs->break_revision_mark = xstrdup(optarg);
>  		revs->track_linear = 1;
>  		revs->track_first_time = 1;
>  	} else if (skip_prefix(arg, "--show-notes=", &optarg) ||

In other words, revs->break_revision_mark is left NULL unless
--show-linear-break is given.

> @@ -4192,8 +4192,8 @@ const char *get_revision_mark(const struct rev_info *revs, const struct commit *
>  		else
>  			return ">";
>  	} else if (revs->graph) {
> -		if (!commit->parents)
> -			return "#";
> +		if (revs->break_revision_mark && !commit->parents)
> +			return revs->break_revision_mark;

And that causes this to break.  Now "--graph" alone won't show '#'
for the root commits, despite that is what [1/2] wanted to do.

Here is a fix-up, plus some minimum tests.  

The part to teach left-right codepath to show L/R is a fix-up to
[1/2], not to this step.  You might want to change them to some
left/right punctuation letters, like () or [].

The other hunks in revision.c are fixes to step [2/2].

I didn't test a custom --show-linear-break='My break line' in the
attachedtest, so that it can be squashed into your [1/2] to test the
feature that step adds.  You should be able to add tests for that
feature in this step [2/2] on top.

I still am skeptical that spending 3 more letters to denote roots is
worth it, though.

 revision.c                   |  11 ++--
 t/t6020-rev-list-boundary.sh | 132 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 138 insertions(+), 5 deletions(-)

diff --git c/revision.c w/revision.c
index 33fbef5c08..55521c53af 100644
--- c/revision.c
+++ w/revision.c
@@ -2402,7 +2402,6 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->show_signature = 0;
 	} else if (!strcmp(arg, "--show-linear-break")) {
 		revs->break_bar = "                    ..........";
-		revs->break_revision_mark = "#";
 		revs->track_linear = 1;
 		revs->track_first_time = 1;
 	} else if (skip_prefix(arg, "--show-linear-break=", &optarg)) {
@@ -4219,12 +4218,14 @@ const char *get_revision_mark(const struct rev_info *revs, const struct commit *
 		return "=";
 	else if (!revs || revs->left_right) {
 		if (commit->object.flags & SYMMETRIC_LEFT)
-			return "<";
+			return commit->parents ? "<" : "L";
 		else
-			return ">";
+			return commit->parents ? ">" : "R";
 	} else if (revs->graph) {
-		if (revs->break_revision_mark && !commit->parents)
-			return revs->break_revision_mark;
+		if (!commit->parents)
+			return (revs->break_revision_mark 
+				? revs->break_revision_mark
+				: "#");
 		return "*";
 	} else if (revs->cherry_mark)
 		return "+";
diff --git c/t/t6020-rev-list-boundary.sh w/t/t6020-rev-list-boundary.sh
new file mode 100755
index 0000000000..35614e9baf
--- /dev/null
+++ w/t/t6020-rev-list-boundary.sh
@@ -0,0 +1,132 @@
+#!/bin/sh
+
+test_description='rev-list/log boundary and root'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	test_commit A &&
+	test_commit B &&
+	git reset --hard A &&
+	test_commit C &&
+
+	git checkout --orphan side &&
+	git rm -fr . &&
+	test_commit X &&
+	test_commit Y &&
+
+	test_tick && git merge --allow-unrelated-histories -m "M" B &&
+	test_tick && git merge -m "N" C &&
+	test_commit Z
+'
+
+test_expect_success 'log with boundary' '
+	git log --graph --boundary --format='%s' ^A ^X Z >actual &&
+	sed -e "s/Q$//" >expect <<-\EOF &&
+	* Z
+	*   N
+	|\  Q
+	| * C
+	* |   M
+	|\ \  Q
+	| * | B
+	| |/  Q
+	* | Y
+	o | X
+	 /  Q
+	o A
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'log --left-right with symmetric boundary' '
+	git log --graph --left-right --boundary --format='%s' B...C >actual &&
+	sed -e "s/Q$//" >expect <<-\EOF &&
+	> C
+	| < B
+	|/  Q
+	o A
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'log --left-right with asymmetric boundary' '
+	git log --graph --left-right --boundary --format='%s' ^A ^X Z >actual &&
+	sed -e "s/Q$//" >expect <<-\EOF &&
+	> Z
+	>   N
+	|\  Q
+	| > C
+	> |   M
+	|\ \  Q
+	| > | B
+	| |/  Q
+	> | Y
+	o | X
+	 /  Q
+	o A
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'log down to root' '
+	git log --graph --format='%s' Z >actual &&
+	sed -e "s/Q$//" >expect <<-\EOF &&
+	* Z
+	*   N
+	|\  Q
+	| * C
+	* |   M
+	|\ \  Q
+	| * | B
+	| |/  Q
+	| # A
+	* Y
+	# X
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'log down to root' '
+	git log --graph --format='%s' B Y >actual &&
+	sed -e "s/Q$//" >expect <<-\EOF &&
+	* Y
+	# X
+	* B
+	# A
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'log that happens to show root' '
+	git log --graph -3 --format='%s' B Y >actual &&
+	sed -e "s/Q$//" >expect <<-\EOF &&
+	* Y
+	# X
+	* B
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'log --left-right down to root' '
+	git log --graph --left-right --format='%s' B...Y >actual &&
+	sed -e "s/Q$//" >expect <<-\EOF &&
+	> Y
+	R X
+	< B
+	L A
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'log --left-right that happens to show root' '
+	git log --graph -3 --left-right --format='%s' B...Y >actual &&
+	sed -e "s/Q$//" >expect <<-\EOF &&
+	> Y
+	R X
+	< B
+	EOF
+	test_cmp expect actual
+'
+
+test_done
