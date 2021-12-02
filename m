Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B5BCC433EF
	for <git@archiver.kernel.org>; Thu,  2 Dec 2021 00:39:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354678AbhLBAmu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Dec 2021 19:42:50 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62978 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354662AbhLBAmc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Dec 2021 19:42:32 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D21C315903B;
        Wed,  1 Dec 2021 19:39:05 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bdXyICMJyDvMulCC27urMO1gTWHW4arG/W/2Kd
        kvGAc=; b=CBJdxbFa2XKgxn6GeWLyyNv4tfxjJhTcssbLDIC6hj359fM41euv1K
        802bT78OFcEjNKY9mj5q3GVY8rIXxUoAU0VFJiE24/5wn1BE8+RpW/mOxnsYGgkt
        LEu/7MXe5aZkp9m17bsoCmKz05hYiat/4GbxXB1v4n7TNJSU1E/4w=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CA9AB15903A;
        Wed,  1 Dec 2021 19:39:05 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8347D159038;
        Wed,  1 Dec 2021 19:39:01 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Chris Torek <chris.torek@gmail.com>,
        Carlo Arenas <carenas@gmail.com>
Cc:     phillip.wood@dunelm.org.uk, Git List <git@vger.kernel.org>,
        thomas.wolf@paranor.ch, Alexander Veit <alexander.veit@gmx.net>
Subject: Re: [PATCH] editor: only save (and restore) the terminal if using a
 tty
References: <04ab7301-ea34-476c-eae4-4044fef74b91@gmail.com>
        <20211122222850.674-1-carenas@gmail.com>
        <b1f2257a-044c-17bb-2737-42b8026421eb@gmail.com>
        <CAPUEsphP2GRaHJa0Qnvf22WUnNB+GnnfG8TgHqwJvSGdYfUQGA@mail.gmail.com>
        <7138fa14-02b2-b123-4d8d-df73763f8431@gmail.com>
        <CAPx1GvcML9TvmP1BSLN0vKWD++8LBj-68Xwmz-KrZM32Q=0_Ug@mail.gmail.com>
        <xmqq35nc15nr.fsf@gitster.g>
Date:   Wed, 01 Dec 2021 16:38:59 -0800
In-Reply-To: <xmqq35nc15nr.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        01 Dec 2021 11:33:44 -0800")
Message-ID: <xmqq7dcnyh5o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3E878B06-5308-11EC-85BB-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>  - Add a multi-valued configuration variable whose value is the name
>    of an editor program that needs this save/restore; optionally, we
>    may want a way to say "don't do save/restore on this editor",
>    e.g. "!emacs" may countermand an earlier value that would include
>    the editor in the list.
>
>  - Around the program invocation in launch_specified_editor(), check
>    the name of the editor against this list and do the save/restore
>    as necessary;
>
>  - When the variable is not defined in the configuration, pretend
>    that "vi" is on that list (coming up with the list of editors is
>    left as an exercise to readers).
>
> That would give us your flexibility to apply the save/restore on an
> arbitrary editor that is not "vi", Dscho's convenience to special
> case "vi" out of the box when unconfigured, and an escape hatch for
> "vi" users for whom it hurts to do the save/restore on their "vi".
>
> Hmm?

That's an overkill.

A single configuration variable as an escape hatch, that enables the
save/restore around editor invocation, whose default value is
determined by the name of the editor, is probably the right degree
of flexibility.

Something along this line, perhaps?

 editor.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git c/editor.c w/editor.c
index fdd3eeafa9..70d3f80966 100644
--- c/editor.c
+++ w/editor.c
@@ -3,6 +3,7 @@
 #include "strbuf.h"
 #include "run-command.h"
 #include "sigchain.h"
+#include "compat/terminal.h"
 
 #ifndef DEFAULT_EDITOR
 #define DEFAULT_EDITOR "vi"
@@ -47,6 +48,16 @@ const char *git_sequence_editor(void)
 	return editor;
 }
 
+static int prepare_term(const char *editor)
+{
+	int need_saverestore = !strcmp(editor, "vi");
+
+	git_config_get_bool("editor.stty", &need_saverestore);
+	if (need_saverestore)
+		return save_term(1);
+	return 0;
+}
+
 static int launch_specified_editor(const char *editor, const char *path,
 				   struct strbuf *buffer, const char *const *env)
 {
@@ -57,7 +68,7 @@ static int launch_specified_editor(const char *editor, const char *path,
 		struct strbuf realpath = STRBUF_INIT;
 		const char *args[] = { editor, NULL, NULL };
 		struct child_process p = CHILD_PROCESS_INIT;
-		int ret, sig;
+		int ret, sig, need_restore = 0;
 		int print_waiting_for_editor = advice_enabled(ADVICE_WAITING_FOR_EDITOR) && isatty(2);
 
 		if (print_waiting_for_editor) {
@@ -83,7 +94,10 @@ static int launch_specified_editor(const char *editor, const char *path,
 		p.env = env;
 		p.use_shell = 1;
 		p.trace2_child_class = "editor";
+		need_restore = prepare_term(editor);
 		if (start_command(&p) < 0) {
+			if (need_restore)
+				restore_term();
 			strbuf_release(&realpath);
 			return error("unable to start editor '%s'", editor);
 		}
@@ -91,6 +105,8 @@ static int launch_specified_editor(const char *editor, const char *path,
 		sigchain_push(SIGINT, SIG_IGN);
 		sigchain_push(SIGQUIT, SIG_IGN);
 		ret = finish_command(&p);
+		if (need_restore)
+			restore_term();
 		strbuf_release(&realpath);
 		sig = ret - 128;
 		sigchain_pop(SIGINT);
