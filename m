Return-Path: <SRS0=4z2X=6U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E82AC28CBC
	for <git@archiver.kernel.org>; Wed,  6 May 2020 17:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E19CA206B8
	for <git@archiver.kernel.org>; Wed,  6 May 2020 17:31:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="oQ22rCAh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728566AbgEFRbj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 May 2020 13:31:39 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57444 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728049AbgEFRbj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 May 2020 13:31:39 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1B785CF056;
        Wed,  6 May 2020 13:31:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=7LjbSUIcbTd4
        QpawhMh6rVl1cyI=; b=oQ22rCAhl5E5xmmP4qbYg7JyPEVbZwBjb7vSt0Uvcas4
        qurAtJlDOuwR55Xv11cl4CZTCHGgaL72hKgMDfTe+wx4ErT28kKctlIHYNpejSeo
        beKN6GR+wMWM5wPB+o3HN8uc2sjiD4b5cx+0bb5qPofDrrrG6+pJWP9MNslMlaw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=vnGK6F
        ybULjZxpTxXLvtWUUNhNTBxApYZI7iuRCgr29JlRks36T1atOIw8acW1V+C0vjg4
        TS9Ey6QGqdOnolbJuqlert00/SrOkK/2lTqELKDIgjt+dyQytJY631Duf2QS+NIM
        663kH4HXPCG1EHwZyp8NvGf7lFzRgrpRayhIM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 12E9BCF055;
        Wed,  6 May 2020 13:31:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 530B2CF052;
        Wed,  6 May 2020 13:31:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Pierrick Gaudry <pierrick.gaudry@loria.fr>
Cc:     git@vger.kernel.org
Subject: Re: option -q not passed from "git commit" to "git gc --auto"
References: <20200506094327.GC31637@rillettes>
Date:   Wed, 06 May 2020 10:31:31 -0700
In-Reply-To: <20200506094327.GC31637@rillettes> (Pierrick Gaudry's message of
        "Wed, 6 May 2020 11:43:27 +0200")
Message-ID: <xmqqd07h6kcs.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6DE608C2-8FBF-11EA-A7BA-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pierrick Gaudry <pierrick.gaudry@loria.fr> writes:

> Hello,
>
> It seems that when "git commit" is run with the "-q" option, there are
> still, from time to time, messages that get printed. With the French
> locale the message is:
>   Compression automatique du d=C3=A9p=C3=B4t en t=C3=A2che de fond pour=
 optimiser les performances.
>   Voir "git help gc" pour toute information sur le nettoyage manuel.
>
> From what I could guess, this is due to the fact that "git commit" call=
s
> "git gc --auto", but does not propagate the "-q" option if present.
>
> A similar problem was present some time ago with "git fetch" and was
> solved in the 2-line patch 6fceed3b . I guess that the same should be
> done for "git commit".

Hmph, once our minds are on this, we probably should see how
widespread the issues would be before just "fixing" commit.

$ git grep -e 'gc.*,.*--auto' \*.c
builtin/am.c:	const char *argv_gc_auto[] =3D {"gc", "--auto", NULL};
builtin/commit.c:	const char *argv_gc_auto[] =3D {"gc", "--auto", NULL};
builtin/fetch.c:		argv_array_pushl(&argv_gc_auto, "gc", "--auto", NULL);
builtin/merge.c:			const char *argv_gc_auto[] =3D { "gc", "--auto", NULL =
};
builtin/rebase.c:	const char *argv_gc_auto[] =3D { "gc", "--auto", NULL }=
;
builtin/receive-pack.c:				"gc", "--auto", "--quiet", NULL,

It is quite clear that "git am --quiet" will ignore "--quiet" (there
is no room to pass an extra argument to "gc --auto").  "merge" and
"rebase" are in the same boat.

I'd rather not see a fix that mimicks 6fceed3b (fetch: silence
git-gc if --quiet is given, 2014-08-16).  Instead why not introduce
a helper "int run_auto_gc(int quiet)" and use it consistently when
we run the auto-gc?

An illustration to cover these (not even compile tested) to show
what I mean and help anybody get started.

 builtin/am.c     | 3 +--
 builtin/commit.c | 3 +--
 builtin/merge.c  | 3 +--
 builtin/rebase.c | 3 +--
 4 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index e3dfd93c25..955f91f076 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1691,7 +1691,6 @@ static int do_interactive(struct am_state *state)
  */
 static void am_run(struct am_state *state, int resume)
 {
-	const char *argv_gc_auto[] =3D {"gc", "--auto", NULL};
 	struct strbuf sb =3D STRBUF_INIT;
=20
 	unlink(am_path(state, "dirtyindex"));
@@ -1796,7 +1795,7 @@ static void am_run(struct am_state *state, int resu=
me)
 	if (!state->rebasing) {
 		am_destroy(state);
 		close_object_store(the_repository->objects);
-		run_command_v_opt(argv_gc_auto, RUN_GIT_CMD);
+		run_gc_auto(state->quiet);
 	}
 }
=20
diff --git a/builtin/commit.c b/builtin/commit.c
index a73de0a4c5..15755a52e1 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1494,7 +1494,6 @@ static int git_commit_config(const char *k, const c=
har *v, void *cb)
=20
 int cmd_commit(int argc, const char **argv, const char *prefix)
 {
-	const char *argv_gc_auto[] =3D {"gc", "--auto", NULL};
 	static struct wt_status s;
 	static struct option builtin_commit_options[] =3D {
 		OPT__QUIET(&quiet, N_("suppress summary after successful commit")),
@@ -1703,7 +1702,7 @@ int cmd_commit(int argc, const char **argv, const c=
har *prefix)
 	git_test_write_commit_graph_or_die();
=20
 	repo_rerere(the_repository, 0);
-	run_command_v_opt(argv_gc_auto, RUN_GIT_CMD);
+	run_gc_auto(quiet);
 	run_commit_hook(use_editor, get_index_file(), "post-commit", NULL);
 	if (amend && !no_post_rewrite) {
 		commit_post_rewrite(the_repository, current_head, &oid);
diff --git a/builtin/merge.c b/builtin/merge.c
index 923e32acf1..2361e3604a 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -450,7 +450,6 @@ static void finish(struct commit *head_commit,
 		if (verbosity >=3D 0 && !merge_msg.len)
 			printf(_("No merge message -- not updating HEAD\n"));
 		else {
-			const char *argv_gc_auto[] =3D { "gc", "--auto", NULL };
 			update_ref(reflog_message.buf, "HEAD", new_head, head,
 				   0, UPDATE_REFS_DIE_ON_ERR);
 			/*
@@ -458,7 +457,7 @@ static void finish(struct commit *head_commit,
 			 * user should see them.
 			 */
 			close_object_store(the_repository->objects);
-			run_command_v_opt(argv_gc_auto, RUN_GIT_CMD);
+			run_gc_auto(verbosity < 0);
 		}
 	}
 	if (new_head && show_diffstat) {
diff --git a/builtin/rebase.c b/builtin/rebase.c
index fb1227de45..2edd2ea596 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -737,7 +737,6 @@ static int rebase_write_basic_state(struct rebase_opt=
ions *opts)
 static int finish_rebase(struct rebase_options *opts)
 {
 	struct strbuf dir =3D STRBUF_INIT;
-	const char *argv_gc_auto[] =3D { "gc", "--auto", NULL };
 	int ret =3D 0;
=20
 	delete_ref(NULL, "REBASE_HEAD", NULL, REF_NO_DEREF);
@@ -747,7 +746,7 @@ static int finish_rebase(struct rebase_options *opts)
 	 * We ignore errors in 'gc --auto', since the
 	 * user should see them.
 	 */
-	run_command_v_opt(argv_gc_auto, RUN_GIT_CMD);
+	run_auto_gc(!(opts->flags & (REBASE_NO_QUIET|REBASE_VERBOSE)));
 	if (opts->type =3D=3D REBASE_MERGE) {
 		struct replay_opts replay =3D REPLAY_OPTS_INIT;
=20
