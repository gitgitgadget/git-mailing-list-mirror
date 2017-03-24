Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CF722095E
	for <e@80x24.org>; Fri, 24 Mar 2017 01:01:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965044AbdCXBBK (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 21:01:10 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59652 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S965041AbdCXBBJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 21:01:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 09EC36B71C;
        Thu, 23 Mar 2017 21:01:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/mYjtCJjgg/S3cg45a/QKByeyXA=; b=r+8q9m
        h8M/b5g7nf2dyLVx1tzRRR/fq54/vV/K5doWJJUXBjq0vtcKi7ymvpoURn3aUO/V
        x9/IR4RIP3Ngp6hqz0uVBg/7UYrvn/0SjBmyYY0Xno7O724uaDCrlWjxDRXTF15n
        PsSvorVIckWEHu+8MiI8HX3f3O1lRCQla5FyA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JgpRq5Yx/Q+WCjlM2EUehcruoMc+4z9m
        867eQ/lsIvD3mnfeLXwzovQuE/ikQ46Ksff9KNbaC0isa9Jk2Va760xHPaqbI+X8
        0HOAKGs/GSsHsVd9k5dzzlkDiMWiiUy/rn5NylsxSWIUi5WhNXl6I3X01VhOUzXE
        XrSSHQt9W18=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 033776B71B;
        Thu, 23 Mar 2017 21:01:02 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 54DBD6B718;
        Thu, 23 Mar 2017 21:01:01 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH v2 2/3] sequencer: make commit options more extensible
References: <cover.1490194846.git.johannes.schindelin@gmx.de>
        <cover.1490285210.git.johannes.schindelin@gmx.de>
        <75e2c4fe839602af19811ed3e251eb583ff6c8ad.1490285210.git.johannes.schindelin@gmx.de>
Date:   Thu, 23 Mar 2017 18:01:00 -0700
In-Reply-To: <75e2c4fe839602af19811ed3e251eb583ff6c8ad.1490285210.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Thu, 23 Mar 2017 17:07:11 +0100
        (CET)")
Message-ID: <xmqq7f3fa3oz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 592AC00E-102D-11E7-9719-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> @@ -926,14 +930,14 @@ static void record_in_rewritten(struct object_id *oid,
>  static int do_pick_commit(enum todo_command command, struct commit *commit,
>  		struct replay_opts *opts, int final_fixup)
>  {
> -	int edit = opts->edit, cleanup_commit_message = 0;
> -	const char *msg_file = edit ? NULL : git_path_merge_msg();
> +	unsigned int flags = opts->edit ? EDIT_MSG : 0, allow = 0;
> +	const char *msg_file = opts->edit ? NULL : git_path_merge_msg();
>  	unsigned char head[20];
>  	struct commit *base, *next, *parent;
>  	const char *base_label, *next_label;
>  	struct commit_message msg = { NULL, NULL, NULL, NULL };
>  	struct strbuf msgbuf = STRBUF_INIT;
> -	int res, unborn = 0, amend = 0, allow = 0;
> +	int res, unborn = 0;
> ... 
> @@ -1123,11 +1127,11 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
>  	if (allow < 0) {
>  		res = allow;
>  		goto leave;
> -	}
> +	} else if (allow)
> +		flags |= ALLOW_EMPTY;

Making "flags" unsigned was a correct change, but this is now wrong,
as "allow" is made unsigned by accident.  It still needs to receive
the return value from allow_empty() that can signal an error by
returning a negative value.  It seems you did this deliberately (it
wasn't like "flags" and "allow" were on the same line both "int" and
the change to make "flags" unsigned accidentally made "allow" also
unsigned; "allow" was "int" and didn't have to move when "flags" was
introduced in the first place), but I failed to spot it because I
was only looking at s/int/unsigned/ on the line in the interdiff,
and missed that "allow" was on the same line.  Compilers are better at
finding these bugs.

Perhaps something like this needs to be squashed in?

 sequencer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index bc2fe48e65..6c423566e6 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -932,14 +932,14 @@ static void record_in_rewritten(struct object_id *oid,
 static int do_pick_commit(enum todo_command command, struct commit *commit,
 		struct replay_opts *opts, int final_fixup)
 {
-	unsigned int flags = opts->edit ? EDIT_MSG : 0, allow = 0;
+	unsigned int flags = opts->edit ? EDIT_MSG : 0;
 	const char *msg_file = opts->edit ? NULL : git_path_merge_msg();
 	unsigned char head[20];
 	struct commit *base, *next, *parent;
 	const char *base_label, *next_label;
 	struct commit_message msg = { NULL, NULL, NULL, NULL };
 	struct strbuf msgbuf = STRBUF_INIT;
-	int res, unborn = 0;
+	int allow, res, unborn = 0;
 
 	if (opts->no_commit) {
 		/*
-- 
2.12.1-432-gf364f02724



