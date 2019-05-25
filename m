Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EACD1F462
	for <e@80x24.org>; Sat, 25 May 2019 02:18:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbfEYCS2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 May 2019 22:18:28 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:39421 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbfEYCS2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 May 2019 22:18:28 -0400
Received: by mail-ua1-f65.google.com with SMTP id 79so4454264uav.6
        for <git@vger.kernel.org>; Fri, 24 May 2019 19:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nanocritical.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5e/462A+OGv46XOBrWit9WcQ9ta4alETsP773LHtids=;
        b=OzI/BrQSMIY+An3VVuSiINh4LR+xi47MU4x1RRNM34e9ZesUXjAbU/MczW9WCqY2sX
         ZXJkoXP7qSEN9r3Wq3RfQUHHJoT5elDPDL0wo1Qw8vS9HH5J6BSf92+XF9Pxv0H/hss3
         GqbUfwoHI8ZVBWV3yNnTgrT+E6keDYqlZrbic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5e/462A+OGv46XOBrWit9WcQ9ta4alETsP773LHtids=;
        b=keVmPprfkDt62P1rOzLO8x2hu4RPhwk78AjzzxkSVIInsoSmLZssSbpjDiBPNcLWfH
         9NWvIlRA/h2Gb7HJ+4bN4ijjRDNWHei5S8LuCPEZCn/bDKZIkt/t32Lrz8G8hsaOknvv
         mYOiEMAMqKWzzZaOvGpERwxDkTHxUZbfDvsdpdRQlfKzhbtwRzXhtvkYLRuPosjpF5gX
         we3Jf/M62n3KotGo11Ft4qDXjnaP4LWsjDayP9SXNy/RkNquDLyJZDMPNNiGXDmWjPUy
         5T6Bn0VBHpnC7rHcw6DXApdsw38OoARCAlrSrPjZqHEoVdCashq6G0HvjL/off9xRbTs
         pEyA==
X-Gm-Message-State: APjAAAX5IbiTjYpA9i3T6PuQFYM1SKWBNzVubTiMHP6NLzZcqjAmBu6Q
        TLudVwzuNws5PiUfcadGJcO9ze0mINqiOJnM6GY9PUB/
X-Google-Smtp-Source: APXvYqxi498p/yXXH6CYeYjDHy9Wnk7oV7YKsh5CeJHb3vZz0CzA9taeVr5MlxQyomHxxnfO4zGSfCayXhhHbX19o3g=
X-Received: by 2002:ab0:e08:: with SMTP id g8mr27413155uak.32.1558750706759;
 Fri, 24 May 2019 19:18:26 -0700 (PDT)
MIME-Version: 1.0
References: <407a267d549bb83543e7046dc7cdf882a583b006.1558738737.git.e@nanocritical.com>
In-Reply-To: <407a267d549bb83543e7046dc7cdf882a583b006.1558738737.git.e@nanocritical.com>
From:   Eric Rannaud <e@nanocritical.com>
Date:   Fri, 24 May 2019 19:18:15 -0700
Message-ID: <CAH_=xoYQEvXKnhyZsUeZ=VTEMOpOdgbd-57f7-6M+2KQLSAAUQ@mail.gmail.com>
Subject: Re: [PATCH v4] fast-import: checkpoint: only write out refs and tags
 if we changed them
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jeremy Serror <jeremy.serror@gmail.com>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(The patch is identical to v3 but I've tried to clarify the commit
message and added the missing sign-off.)

On Fri, May 24, 2019 at 4:10 PM Eric Rannaud <e@nanocritical.com> wrote:
>
> At a checkpoint, fast-import resets all branches and tags on disk to the
> OID that we have in memory. If --force is not given, only branch resets
> that result in fast forwards with respect to the state on disk are
> allowed. fast-import never updates its internal view of branches in
> response to external changes.
>
> Also, even for refs that fast-import has not been commanded to change
> for a long time (or ever), at each checkpoint, we will systematically
> reset them to the last state this process knows about, a state which may
> have been set before the previous checkpoint. Any changes made to these
> refs by a different process since the last checkpoint will be
> overwritten.
>
> 1> is one process, 2> is another:
>
>         1> $ git fast-import --force
>         1> reset refs/heads/master
>         1> from $A
>         1> checkpoint
>         2> $ git branch -f refs/heads/master $B
>         1> reset refs/heads/tip  # not changing master!
>         1> from $C
>         1> checkpoint
>
> At this point master points again to $A. (With this patch applied,
> master points to $B.)
>
> This problem is mitigated somewhat for branches when --force is not
> specified (the default), as requiring a fast forward means in practice
> that concurrent external changes are likely to be preserved. But it's
> not foolproof either:
>
>         1> $ git fast-import
>         1> reset refs/heads/master
>         1> from $A
>         1> checkpoint
>         2> $ git branch -f refs/heads/master refs/heads/master~1
>         1> reset refs/heads/tip  # not changing master!
>         1> from $C
>         1> checkpoint
>
> At this point, master points again to $A, not $A~1 as requested by the
> second process. (With this patch applied, master points to $A~1.)
>
> With this patch, we keep track of whether a particular branch or tag has
> been changed by this fast-import process since our last checkpoint (or
> startup). At the next checkpoint, only refs and tags that new commands
> have changed are written to disk. To be clear, fast-import still does
> not update its internal view of branches in response to external
> changes, but now it avoids interfering with external changes unless
> there was an explicit command to do so since the last checkpoint.
>
> Note, therefore, that fast-import will still overwrite external changes
> to some refs and tags. For example, with this patch applied, the change
> made by process 2 will be overwritten:
>
>         1> $ git fast-import --force
>         1> reset refs/heads/master
>         1> from $A
>         1> checkpoint
>         2> $ git branch -f refs/heads/master $B
>         1> reset refs/heads/master
>         1> from $C
>         1> checkpoint
>
> and master will point to $C.
>
> Signed-off-by: Eric Rannaud <e@nanocritical.com>
> ---
>  fast-import.c          |  14 ++++++
>  t/t9300-fast-import.sh | 106 ++++++++++++++++++++++++++++++++++-------
>  2 files changed, 104 insertions(+), 16 deletions(-)
>
> diff --git a/fast-import.c b/fast-import.c
> index f38d04fa5851..e9c3ea23ae42 100644
> --- a/fast-import.c
> +++ b/fast-import.c
> @@ -103,6 +103,7 @@ struct branch {
>         uintmax_t num_notes;
>         unsigned active : 1;
>         unsigned delete : 1;
> +       unsigned changed : 1;
>         unsigned pack_id : PACK_ID_BITS;
>         struct object_id oid;
>  };
> @@ -110,6 +111,7 @@ struct branch {
>  struct tag {
>         struct tag *next_tag;
>         const char *name;
> +       unsigned changed : 1;
>         unsigned int pack_id;
>         struct object_id oid;
>  };
> @@ -581,6 +583,7 @@ static struct branch *new_branch(const char *name)
>         b->branch_tree.versions[1].mode = S_IFDIR;
>         b->num_notes = 0;
>         b->active = 0;
> +       b->changed = 0;
>         b->pack_id = MAX_PACK_ID;
>         branch_table[hc] = b;
>         branch_count++;
> @@ -1571,6 +1574,10 @@ static int update_branch(struct branch *b)
>         struct object_id old_oid;
>         struct strbuf err = STRBUF_INIT;
>
> +       if (!b->changed)
> +               return 0;
> +       b->changed = 0;
> +
>         if (is_null_oid(&b->oid)) {
>                 if (b->delete)
>                         delete_ref(NULL, b->name, NULL, 0);
> @@ -1636,6 +1643,10 @@ static void dump_tags(void)
>                 goto cleanup;
>         }
>         for (t = first_tag; t; t = t->next_tag) {
> +               if (!t->changed)
> +                       continue;
> +               t->changed = 0;
> +
>                 strbuf_reset(&ref_name);
>                 strbuf_addf(&ref_name, "refs/tags/%s", t->name);
>
> @@ -2679,6 +2690,7 @@ static void parse_new_commit(const char *arg)
>
>         if (!store_object(OBJ_COMMIT, &new_data, NULL, &b->oid, next_mark))
>                 b->pack_id = pack_id;
> +       b->changed = 1;
>         b->last_commit = object_count_by_type[OBJ_COMMIT];
>  }
>
> @@ -2763,6 +2775,7 @@ static void parse_new_tag(const char *arg)
>                 t->pack_id = MAX_PACK_ID;
>         else
>                 t->pack_id = pack_id;
> +       t->changed = 1;
>  }
>
>  static void parse_reset_branch(const char *arg)
> @@ -2783,6 +2796,7 @@ static void parse_reset_branch(const char *arg)
>                 b = new_branch(arg);
>         read_next_command();
>         parse_from(b);
> +       b->changed = 1;
>         if (command_buf.len > 0)
>                 unread_command_buf = 1;
>  }
> diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
> index 3668263c4046..12abaebb22b6 100755
> --- a/t/t9300-fast-import.sh
> +++ b/t/t9300-fast-import.sh
> @@ -3121,14 +3121,23 @@ test_expect_success 'U: validate root delete result' '
>  ### series V (checkpoint)
>  ###
>
> -# The commands in input_file should not produce any output on the file
> -# descriptor set with --cat-blob-fd (or stdout if unspecified).
> +# Instructions can be sent from $input_file to background_import() loop via the
> +# fast-import progress command.
> +#
> +#      progress do: shell
> +# Parse the next progress line and invoke it as a shell command.
> +#
> +#      progress do: checkpoint and stop
> +# Send checkpoint and wait for its completion.
> +#
> +#      progress do: stop
> +# Internal instruction.
>  #
>  # To make sure you're observing the side effects of checkpoint *before*
>  # fast-import terminates (and thus writes out its state), check that the
>  # fast-import process is still running using background_import_still_running
>  # *after* evaluating the test conditions.
> -background_import_then_checkpoint () {
> +background_import () {
>         options=$1
>         input_file=$2
>
> @@ -3153,22 +3162,30 @@ background_import_then_checkpoint () {
>         # pipes writing sequence. We want to assume that the write below could
>         # block, e.g. if fast-import blocks writing its own output to &9
>         # because there is no reader on &9 yet.
> -       (
> -               cat "$input_file"
> -               echo "checkpoint"
> -               echo "progress checkpoint"
> -       ) >&8 &
> +       cat "$input_file" >&8 &
>
>         error=1 ;# assume the worst
>         while read output <&9
>         do
> -               if test "$output" = "progress checkpoint"
> +               if test "$output" = "progress do: shell"
> +               then
> +                       read output <&9
> +                       shell_cmd="$(echo $output |sed -e 's/^progress //')"
> +                       $shell_cmd
> +               elif test "$output" = "progress do: checkpoint and stop"
> +               then
> +                       (
> +                               echo "checkpoint"
> +                               echo "progress do: stop"
> +                       ) >&8 &
> +               elif test "$output" = "progress do: stop"
>                 then
>                         error=0
>                         break
> +               else
> +                       # otherwise ignore cruft
> +                       echo >&2 "cruft: $output"
>                 fi
> -               # otherwise ignore cruft
> -               echo >&2 "cruft: $output"
>         done
>
>         if test $error -eq 1
> @@ -3189,10 +3206,11 @@ test_expect_success PIPE 'V: checkpoint helper does not get stuck with extra out
>         cat >input <<-INPUT_END &&
>         progress foo
>         progress bar
> +       progress do: checkpoint and stop
>
>         INPUT_END
>
> -       background_import_then_checkpoint "" input &&
> +       background_import "" input &&
>         background_import_still_running
>  '
>
> @@ -3201,9 +3219,11 @@ test_expect_success PIPE 'V: checkpoint updates refs after reset' '
>         reset refs/heads/V
>         from refs/heads/U
>
> +       progress do: checkpoint and stop
> +
>         INPUT_END
>
> -       background_import_then_checkpoint "" input &&
> +       background_import "" input &&
>         test "$(git rev-parse --verify V)" = "$(git rev-parse --verify U)" &&
>         background_import_still_running
>  '
> @@ -3216,9 +3236,11 @@ test_expect_success PIPE 'V: checkpoint updates refs and marks after commit' '
>         data 0
>         from refs/heads/U
>
> +       progress do: checkpoint and stop
> +
>         INPUT_END
>
> -       background_import_then_checkpoint "--export-marks=marks.actual" input &&
> +       background_import "--export-marks=marks.actual" input &&
>
>         echo ":1 $(git rev-parse --verify V)" >marks.expected &&
>
> @@ -3237,9 +3259,11 @@ test_expect_success PIPE 'V: checkpoint updates refs and marks after commit (no
>         data 0
>         from refs/heads/U
>
> +       progress do: checkpoint and stop
> +
>         INPUT_END
>
> -       background_import_then_checkpoint "--export-marks=marks.actual" input &&
> +       background_import "--export-marks=marks.actual" input &&
>
>         echo ":2 $(git rev-parse --verify V2)" >marks.expected &&
>
> @@ -3255,13 +3279,63 @@ test_expect_success PIPE 'V: checkpoint updates tags after tag' '
>         tagger $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
>         data 0
>
> +       progress do: checkpoint and stop
> +
>         INPUT_END
>
> -       background_import_then_checkpoint "" input &&
> +       background_import "" input &&
>         git show-ref -d Vtag &&
>         background_import_still_running
>  '
>
> +test_expect_success PIPE 'V: checkpoint only resets changed branches' '
> +       cat >input <<-INPUT_END &&
> +       reset refs/heads/V3
> +       from refs/heads/U
> +
> +       checkpoint
> +
> +       progress do: shell
> +       progress git branch -f V3 V
> +
> +       reset refs/heads/V4
> +       from refs/heads/U
> +
> +       progress do: checkpoint and stop
> +
> +       INPUT_END
> +
> +       background_import "--force" input &&
> +       test "$(git rev-parse --verify V3)" = "$(git rev-parse --verify V)" &&
> +       background_import_still_running
> +'
> +
> +test_expect_success PIPE 'V: checkpoint only updates changed tags' '
> +       cat >input <<-INPUT_END &&
> +       tag Vtag2
> +       from refs/heads/U
> +       tagger $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
> +       data 0
> +
> +       checkpoint
> +
> +       progress do: shell
> +       progress git tag -f Vtag2 V
> +
> +       tag Vtag3
> +       from refs/heads/U
> +       tagger $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
> +       data 0
> +
> +       progress do: checkpoint and stop
> +
> +       INPUT_END
> +
> +       background_import "" input &&
> +       test "$(git show-ref -d Vtag2 |tail -1 |awk \{print\ \$1\})" = "$(git rev-parse --verify V)" &&
> +       background_import_still_running
> +'
> +
>  ###
>  ### series W (get-mark and empty orphan commits)
>  ###
> --
> 2.21.0
>


-- 
Eric Rannaud <e@nanocritical.com>
Nanocritical, CEO
