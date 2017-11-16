Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3550D201C8
	for <e@80x24.org>; Thu, 16 Nov 2017 06:04:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932243AbdKPGEU (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Nov 2017 01:04:20 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53909 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932144AbdKPGET (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Nov 2017 01:04:19 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5E995A6810;
        Thu, 16 Nov 2017 01:04:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Bu4ECFIk8FHQo5FQhtMNNDLDjLE=; b=SKQdq2
        oSG4rFWk61jS9dltyOl1ihtz6bCewt9mwUsqZ8tw8Kgz3m9YFDMeJUQoZXrGD9zO
        KG2JTOqmmbMAhoqFRYu0BZ492hC2iWX7vSdQ6jrrpaQ8bemYReDyW5+Q8GLVLmdv
        DcLuw3raA4rX8qjTRF0CX1RJKuObabLoCT7jY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XvGi82iOv/LcTgZn9BS307XjOsSBPuCN
        oA086PJxYa6I+S6tFBY8+kD+YsQNSkG3oNjwjLf0mg7PNEAoGeMzpVawlK3k+VLY
        h1jZvegE16C3bwT9LqWI0x5hbd/d/IAEHHamwEM5Ib5Hd6VJ0GoFNrLzD7W78i1K
        CzeofcrJ2xo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 55EFCA680F;
        Thu, 16 Nov 2017 01:04:18 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BE063A680E;
        Thu, 16 Nov 2017 01:04:17 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     git <git@vger.kernel.org>
Subject: [PATCH] launch_editor(): indicate that Git waits for user input
References: <274B4850-2EB7-4BFA-A42C-25A573254969@gmail.com>
Date:   Thu, 16 Nov 2017 15:04:16 +0900
In-Reply-To: <274B4850-2EB7-4BFA-A42C-25A573254969@gmail.com> (Lars
        Schneider's message of "Wed, 15 Nov 2017 16:08:23 +0100")
Message-ID: <xmqqr2syvjxb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FAFC1FE2-CA93-11E7-8077-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a graphical GIT_EDITOR is spawned by a Git command that opens
and waits for it for the user input (e.g. "git rebase -i") pops its
window elsewhere that is obscure, the user may be left staring the
original terminal window s/he invoked the Git command from, without
even realizing that now s/he needs to interact with another window
the editor is waiting in, before Git can proceed.

Show a message to the original terminal, and get rid of it when the
editor returns.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * I tried this with "emacsclient" but it turns out that Emacs folks
   have already thought about this issue, and the program says
   "Waiting for Emacs..." while it does its thing, so from that
   point of view, perhaps as Stefan said originally, the editor Lars
   had trouble with is what is at fault and needs fixing?  I dunno.

   Also, emacsclient seems to conclude its message, once the editing
   is done, by emitting LF _before_ we have a chance to do the "go
   back to the beginning and clear" dance, so it probably is not a
   very good example to emulate the situation Lars had trouble with.
   You cannot observe the nuking of the "launched, waiting..." with
   it.

 editor.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/editor.c b/editor.c
index 7519edecdc..1321944716 100644
--- a/editor.c
+++ b/editor.c
@@ -40,6 +40,28 @@ int launch_editor(const char *path, struct strbuf *buffer, const char *const *en
 		const char *args[] = { editor, real_path(path), NULL };
 		struct child_process p = CHILD_PROCESS_INIT;
 		int ret, sig;
+		static const char *close_notice = NULL;
+
+		if (isatty(2) && !close_notice) {
+			char *term = getenv("TERM");
+
+			if (term && strcmp(term, "dumb"))
+				/*
+				 * go back to the beginning and erase the
+				 * entire line if the terminal is capable
+				 * to do so, to avoid wasting the vertical
+				 * space.
+				 */
+				close_notice = "\r\033[K";
+			else
+				/* otherwise, complete and waste the line */
+				close_notice = "done.\n";
+		}
+
+		if (close_notice) {
+			fprintf(stderr, "Launched your editor, waiting...");
+			fflush(stderr);
+		}
 
 		p.argv = args;
 		p.env = env;
@@ -53,11 +75,14 @@ int launch_editor(const char *path, struct strbuf *buffer, const char *const *en
 		sig = ret - 128;
 		sigchain_pop(SIGINT);
 		sigchain_pop(SIGQUIT);
+
 		if (sig == SIGINT || sig == SIGQUIT)
 			raise(sig);
 		if (ret)
 			return error("There was a problem with the editor '%s'.",
 					editor);
+		if (close_notice)
+			fputs(close_notice, stderr);
 	}
 
 	if (!buffer)
-- 
2.15.0-360-gf2497ca0e5

