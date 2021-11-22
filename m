Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47354C433F5
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 17:53:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239430AbhKVR4I (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 12:56:08 -0500
Received: from cloud.peff.net ([104.130.231.41]:36458 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239606AbhKVR4E (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 12:56:04 -0500
Received: (qmail 21844 invoked by uid 109); 22 Nov 2021 17:52:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 22 Nov 2021 17:52:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22714 invoked by uid 111); 22 Nov 2021 17:52:57 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 22 Nov 2021 12:52:57 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 22 Nov 2021 12:52:56 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Enzo Matsumiya <ematsumiya@suse.de>
Subject: Re: [PATCH 0/5] run-command API: get rid of "argv"
Message-ID: <YZvY+BJhxaFIOdnJ@coredump.intra.peff.net>
References: <YZseJ4jOVIK3+bUD@coredump.intra.peff.net>
 <cover-0.5-00000000000-20211122T153605Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover-0.5-00000000000-20211122T153605Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 22, 2021 at 05:04:02PM +0100, Ævar Arnfjörð Bjarmason wrote:

> This series is an alternate but more thorough way to solve the pager
> segfault reported by Enzo Matsumiya[1], and more generally avoids
> similar issues in the future.
> 
> That the run-command API exposed two subtly different ways of doing
> the same thing wouldn't only lead to the sort of bug reported in [1],
> but also made memory management around it rather painful. As noted by
> Jeff King in[2]:
> 
>     I'd like to eventually get rid of the argv interface entirely
>     because it has memory-ownership semantics that are easy to get
>     wrong.

Yeah, unsurprisingly I'm in favor of this direction (and in fact started
looking at myself before seeing your responses). It's big and complex
enough that I do worry about prepending it in front of the segfault bug
fix being discussed.

> As noted in 5/5 we've still got a similar issue with "env" and
> "env_array". I've got a follow-up series that similarly removes "env"
> which we can do at some point (it's much smaller than this one), but
> for now let's focus on "argv".

I think we should probably do both, though I am OK with doing it
separately. There are fewer callers for "env", but I found more
ancillary cleanup necessary (e.g., "const char **" versus "const char
*const *" headaches).

> Ævar Arnfjörð Bjarmason (5):
>   archive-tar: use our own cmd.buf in error message
>   upload-archive: use regular "struct child_process" pattern
>   run-command API users: use strvec_pushv(), not argv assignment
>   run-command API users: use strvec_pushl(), not argv construction
>   run-command API: remove "argv" member, always use "args"

I left a few comments on individual patches. I had done a rough cut at
this, too. One big difference is that I used the opportunity to clean up
some ugly and error-prone uses of argv that are now unnecessary. For
instance:

diff --git a/builtin/notes.c b/builtin/notes.c
index 2b2bac43f3..85d1abad88 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -134,14 +134,13 @@ static void copy_obj_to_fd(int fd, const struct object_id *oid)
 
 static void write_commented_object(int fd, const struct object_id *object)
 {
-	const char *show_args[5] =
-		{"show", "--stat", "--no-notes", oid_to_hex(object), NULL};
 	struct child_process show = CHILD_PROCESS_INIT;
 	struct strbuf buf = STRBUF_INIT;
 	struct strbuf cbuf = STRBUF_INIT;
 
 	/* Invoke "git show --stat --no-notes $object" */
-	strvec_pushv(&show.args, show_args);
+	strvec_pushl(&show.args, "show", "--stat", "--no-notes",
+		     oid_to_hex(object), NULL);
 	show.no_stdin = 1;
 	show.out = -1;
 	show.err = 0;

The show_args variable is error-prone in two ways:

  - the magic number "5" must be in sync with the rest of the array. In
    this case it's superfluous and could just be removed, but I'll give
    a related example below.

  - we have to remember to include the trailing NULL. We have to for
    pushl(), too, but in that case the compiler will warn us when we
    omit it.

Here's another one:

@@ -943,23 +941,22 @@ static int run_receive_hook(struct command *commands,
 
 static int run_update_hook(struct command *cmd)
 {
-	const char *argv[5];
+	const char *hook_cmd;
 	struct child_process proc = CHILD_PROCESS_INIT;
 	int code;
 
-	argv[0] = find_hook("update");
-	if (!argv[0])
+	hook_cmd = find_hook("update");
+	if (!hook_cmd)
 		return 0;
 
-	argv[1] = cmd->ref_name;
-	argv[2] = oid_to_hex(&cmd->old_oid);
-	argv[3] = oid_to_hex(&cmd->new_oid);
-	argv[4] = NULL;
+	strvec_push(&proc.args, hook_cmd);
+	strvec_push(&proc.args, cmd->ref_name);
+	strvec_push(&proc.args, oid_to_hex(&cmd->old_oid));
+	strvec_push(&proc.args, oid_to_hex(&cmd->new_oid));
 
 	proc.no_stdin = 1;
 	proc.stdout_to_stderr = 1;
 	proc.err = use_sideband ? -1 : 0;
-	strvec_pushv(&proc.args, argv);
 	proc.trace2_hook_name = "update";

In this case the magic "5" really is important, and we get rid of it
(and again don't need to worry about the terminating NULL).

I'm on the fence on how important it is to do these cleanups. IMHO they
are half of what really sells the change in the first place (since the
other bug can pretty easily be fixed without it).

But maybe it is piling too much onto what is already a pretty big
change. The cleanups could be done individually later.

diff --git a/daemon.c b/daemon.c
index cc278077d2..4a000ee4af 100644
--- a/daemon.c
+++ b/daemon.c
@@ -329,10 +329,15 @@ static int run_access_hook(struct daemon_service *service, const char *dir,
 	char *eol;
 	int seen_errors = 0;
 
+	strvec_push(&child.args, access_hook);
+	strvec_push(&child.args, service->name);
+	strvec_push(&child.args, path);
+	strvec_push(&child.args, hi->hostname.buf);
+	strvec_push(&child.args, get_canon_hostname(hi));
+	strvec_push(&child.args, get_ip_address(hi));
+	strvec_push(&child.args, hi->tcp_port.buf);
+
 	child.use_shell = 1;
-	strvec_pushl(&child.args, access_hook, service->name, path,
-		     hi->hostname.buf, get_canon_hostname(hi),
-		     get_ip_address(hi), hi->tcp_port.buf, NULL);
 	child.no_stdin = 1;
 	child.no_stderr = 1;
 	child.out = -1;

I had other changes from yours like this. This is purely cosmetic, and I
could see arguments either way. I find the one-per-line version a bit
easier to read. Even though it repeats child.args over and over, it's
easy to look past since it's all aligned.

I'm OK calling that bike-shedding, but I offer it mostly in case you
didn't try it the other way and actually like my color. ;)

-Peff
