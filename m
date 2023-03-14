Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADCC3C6FD1D
	for <git@archiver.kernel.org>; Tue, 14 Mar 2023 23:51:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjCNXvq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Mar 2023 19:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjCNXvp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Mar 2023 19:51:45 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050:0:465::101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1299B2887F
        for <git@vger.kernel.org>; Tue, 14 Mar 2023 16:51:40 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4Pbr090SpKz9sV5;
        Wed, 15 Mar 2023 00:51:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hsal.es; s=MBO0001;
        t=1678837897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ySqjPOd+p3Ie3IH9UQDY6fp/+oPrwdTsN3rC7ajto5s=;
        b=x+kjscM1OVVb8xqRTwyTGz4r77NMKLfxOGJlcIiuMPB46J5riKkHsDgrtbtPGm10GGRpsj
        ipbVXb0ofWVTvz0BEGPDSEmMzUin7yCYK0Hwoq+CgFCOczOiEk7kXG9U3lpw0lxthXazDd
        Tz6hWmyMUo01BaTmAqyOJsBr5SL86tq8a6gm59fYljJNi4VuycpCkTlDjFbtgEIhJAG2DD
        0jRcz2mnp9iMRgZb0rxwZhBDBiPpKM/nV5/sETJHpQ4RrPYmVhBm0Eamw5dE9mvb4Vg8Kv
        m7tonAOvLweYKsDaAJ6N59lGA581tDKyMAZi09wNxCooVHYcigA66koMZh1qSg==
Content-Type: multipart/mixed; boundary="------------gvNbCHhIbLkAoyIAog1MW5h0"
Message-ID: <00a07e7d-7605-48df-0192-775c2fee39a3@hsal.es>
Date:   Tue, 14 Mar 2023 23:51:02 +0000
MIME-Version: 1.0
Subject: Re: [PATCH] Add `restore.defaultLocation` option
To:     Junio C Hamano <gitster@pobox.com>,
        Hugo Sales via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
References: <pull.1467.git.git.1678578153640.gitgitgadget@gmail.com>
 <xmqq1qlss0un.fsf@gitster.g>
Content-Language: en-US, en-US-large
From:   Hugo Sales <hugo@hsal.es>
In-Reply-To: <xmqq1qlss0un.fsf@gitster.g>
X-Rspamd-Queue-Id: 4Pbr090SpKz9sV5
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------gvNbCHhIbLkAoyIAog1MW5h0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I think I addressed your comments in the patch below.

> I think a better solution would be to teach
> these users to use "git reset -- <path>" when they want to reset the
> index entries, and not run the "git restore" command.

I read _somewhere_ that `git restore` was the Modern Replacement for `git
checkout` and `git reset`, along with `git switch`. I do find it more intuitive,
too. Friends I talked with liked this change, as they've also read similar
things and lost work due to a missing `--staged`, so they stopped using it. I
find `git reset` somewhat confusing, as I use it for `git reset --soft HEAD~`
and `git reset --hard <commit-ish>`, so I don't really associate it with the
same usage as `git restore`.

> +static const char *checkout_default_index_worktree;
> +static int git_restore_config(const char *var, const char *value, void *cb)
> +{
> +    struct checkout_opts *opts = cb;
> +
> +    if (!strcmp(var, "restore.defaultdestination")) {
> +        git_config_string(&checkout_default_index_worktree, var, value);

I'm not sure if this use of `git_config_string` is required, as `value` seems to
contain the desired value, but this seems to be how it's done elsewhere.

> > +    git restore one &&
> > +    test -z $(git status --porcelain --untracked-files=no) &&
>
> This (together with many other uses of "git status" in the new
> tests) will not catch a segfaulting "git status".

I replaced this with `test_must_be_empty`, I'm not sure if that's what you
meant. I wasn't able to find a version that doesn't need to write to a file.

I'm aware I'm not supposed to send patches as an attachment, but I spent at least 3 hours
today and 3-4 more the day I sent the first patch, and it just doesn't work, so I hope this works



From ec878a84db4dc7aabbc5cddf0897b717ac772494 Mon Sep 17 00:00:00 2001
From: Hugo Sales <hugo@hsal.es>
Date: Sat, 11 Mar 2023 12:43:34 +0000
Subject: [PATCH v2] restore: add `restore.defaultDestination` to configure what
 gets updated

`git restore` takes `--worktree` and/or `--staged` options to specify
which one of the working tree files and/or the index entries are
updated. With neither option, the command, by default, updates the
working tree files.

If a user attempts to reset the index entries from HEAD, they may, by
mistake, run `git restore` without the `--staged` option. When such a
mistake happens, the work made in the working tree files that are not
yet added to the index will be forever lost. This patch is intended to
mitigate this. This is a trade-off between lost worktree changes,
which may not be present anywhere else, and lost index modifications,
which can be recreated.

Introduce the `restore.defaultDestination` configuration variable,
which can be set to one of "both", "index", or "worktree", useful for
users who want to set it to "index" to avoid touching the working tree
files by mistake. They now force themselves to use the `--worktree`
option explicitly when they want to restore the working tree files.

Signed-off-by: Hugo Sales <hugo@hsal.es>
---
I think I addressed your comments in the patch below.

> I think a better solution would be to teach
> these users to use "git reset -- <path>" when they want to reset the
> index entries, and not run the "git restore" command.

I read _somewhere_ that `git restore` was the Modern Replacement for `git
checkout` and `git reset`, along with `git switch`. I do find it more intuite,
too. Friends I talked with liked this change, as they've also read similar
things and lost work due to a missing `--staged`, so they stopped using it. I
find `git reset` somewhat confusing, as I use it for `git reset --soft HEAD~`
and `git reset --hard <commit-ish>`, so I don't really associate it with the
same usage as `git restore`.

> +static const char *checkout_default_index_worktree;
> +static int git_restore_config(const char *var, const char *value, void *cb)
> +{
> +    struct checkout_opts *opts = cb;
> +
> +    if (!strcmp(var, "restore.defaultdestination")) {
> +        git_config_string(&checkout_default_index_worktree, var, value);

I'm not sure if this use of `git_config_string` is required, as `value` seems to
contain the desired value, but this seems to be how it's done elsewhere.

> > +    git restore one &&
> > +    test -z $(git status --porcelain --untracked-files=no) &&
>
> This (together with many other uses of "git status" in the new
> tests) will not catch a segfaulting "git status".

I replaced this with `test_must_be_empty`, I'm not sure if that's what you
meant. I wasn't able to find a version that doesn't need to write to a file.

P.S. I hope the following reaches you correctly, as I'm still struggling to
connect to mailbox.org with send-email.

 Documentation/config.txt         |   2 +
 Documentation/config/restore.txt |  16 ++++
 Documentation/git-restore.txt    |  17 ++--
 builtin/checkout.c               |  25 ++++++
 t/t2070-restore.sh               | 143 +++++++++++++++++++++++++++++++
 5 files changed, 198 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/config/restore.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 0e93aef862..4359c63794 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -501,6 +501,8 @@ include::config/repack.txt[]
 
 include::config/rerere.txt[]
 
+include::config/restore.txt[]
+
 include::config/revert.txt[]
 
 include::config/safe.txt[]
diff --git a/Documentation/config/restore.txt b/Documentation/config/restore.txt
new file mode 100644
index 0000000000..6a06310b4a
--- /dev/null
+++ b/Documentation/config/restore.txt
@@ -0,0 +1,16 @@
+restore.defaultDestination::
+    Valid values: "worktree", "staged" or "both". Controls the default
+    behavior of `git restore` without `--worktree` or `--staged`. If
+    "worktree", `git restore` without `--worktree` or `--staged` is
+    equivalent to `git restore --worktree`. If "staged", `git restore`
+    without `--worktree` or `--staged` is equivalent to `git restore
+    --staged`. If "both", `git restore` without `--worktree` or `--staged`
+    is equivalent to `git restore --worktree --staged`. Adding an option
+    overrides the default, such that if the configuration variable is set to
+    "staged", specifying `--worktree` will only affect the worktree, not
+    both. This variable can be set to "staged" to help prevent accidentally
+    losing modifications to the worktree, caused by running `git restore .`
+    when `git restore --staged .` was intended. In this case, modifications
+    to the index would be lost, which could also be a significant amount of
+    work, so care is highly recommended.
+    See linkgit:git-restore[1]
diff --git a/Documentation/git-restore.txt b/Documentation/git-restore.txt
index 5964810caa..391c367d32 100644
--- a/Documentation/git-restore.txt
+++ b/Documentation/git-restore.txt
@@ -14,14 +14,18 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-Restore specified paths in the working tree with some contents from a
+Restore specified paths in the working tree and/or index with some contents from a
 restore source. If a path is tracked but does not exist in the restore
 source, it will be removed to match the source.
 
-The command can also be used to restore the content in the index with
+The command can be used to restore the content in the index with
 `--staged`, or restore both the working tree and the index with
 `--staged --worktree`.
 
+The configuration vairable `restore.defaultDestination`, which accepts values
+"worktree", "staged" or "both", can be used to control the default behavior for
+which flag(s) apply if neither `--staged` nor `--worktree` is supplied.
+
 By default, if `--staged` is given, the contents are restored from `HEAD`,
 otherwise from the index. Use `--source` to restore from a different commit.
 
@@ -59,9 +63,12 @@ all modified paths.
 --worktree::
 -S::
 --staged::
-    Specify the restore location. If neither option is specified,
-    by default the working tree is restored. Specifying `--staged`
-    will only restore the index. Specifying both restores both.
+    Specify the restore destination. If neither option is specified, the default
+    depends on the `'restore.defaultDestination` configuration variable,
+    which can be "worktree" (the default), "staged" or "both", to control
+    which of the two flags is assumed if none are given. Specifying
+    `--worktree` will only restore the worktree. Specifying `--staged` will
+    only restore the index. Specifying both restores both.
 
 -q::
 --quiet::
diff --git a/builtin/checkout.c b/builtin/checkout.c
index a5155cf55c..4a9131ec29 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1922,6 +1922,29 @@ int cmd_switch(int argc, const char **argv, const char *prefix)
     return ret;
 }
 
+static const char *checkout_default_index_worktree;
+static int git_restore_config(const char *var, const char *value, void *cb)
+{
+    struct checkout_opts *opts = cb;
+
+    if (!strcmp(var, "restore.defaultdestination")) {
+        git_config_string(&checkout_default_index_worktree, var, value);
+        if (!strcmp(checkout_default_index_worktree, "both")) {
+            opts->checkout_index = -2;    /* default on */
+            opts->checkout_worktree = -2; /* default on */
+        } else if (!strcmp(checkout_default_index_worktree, "staged")) {
+            opts->checkout_index = -2;    /* default on */
+            opts->checkout_worktree = -1; /* default off */
+        } else {
+            opts->checkout_index = -1;    /* default off */
+            opts->checkout_worktree = -2; /* default on */
+        }
+        return 0;
+    }
+    return git_xmerge_config(var, value, NULL);
+}
+
+
 int cmd_restore(int argc, const char **argv, const char *prefix)
 {
     struct checkout_opts opts;
@@ -1950,6 +1973,8 @@ int cmd_restore(int argc, const char **argv, const char *prefix)
     opts.checkout_worktree = -2; /* default on */
     opts.ignore_unmerged_opt = "--ignore-unmerged";
 
+    git_config(git_restore_config, &opts);
+
     options = parse_options_dup(restore_options);
     options = add_common_options(&opts, options);
     options = add_checkout_path_options(&opts, options);
diff --git a/t/t2070-restore.sh b/t/t2070-restore.sh
index 7c43ddf1d9..c3a35dd878 100755
--- a/t/t2070-restore.sh
+++ b/t/t2070-restore.sh
@@ -137,4 +137,147 @@ test_expect_success 'restore --staged invalidates cache tree for deletions' '
     test_must_fail git rev-parse HEAD:new1
 '
 
+test_expect_success 'restore with restore.defaultDestination unset works as if --worktree given' '
+    test_when_finished git reset --hard HEAD^ &&
+    test_commit root-unset-restore.defaultDestination &&
+    test_commit unset-restore.defaultDestination one one &&
+    >one &&
+
+    git restore one &&
+    git status --porcelain --untracked-files=no >status &&
+    test_must_be_empty status &&
+    rm status &&
+
+    >one &&
+    git add one &&
+    git restore one &&
+    git status --porcelain --untracked-files=no | grep "^M " &&
+
+    >one &&
+    git add one &&
+    git restore --worktree one &&
+    git status --porcelain --untracked-files=no | grep "^M " &&
+
+    git restore --staged one &&
+    git status --porcelain --untracked-files=no | grep "^ M" &&
+
+    >one &&
+    git add one &&
+    git restore --worktree --staged one &&
+    git status --porcelain --untracked-files=no >status &&
+    test_must_be_empty status &&
+    rm status
+'
+
+test_expect_success 'restore with restore.defaultDestination set to worktree works as if --worktree given' '
+    test_when_finished git reset --hard HEAD^ &&
+    test_when_finished git config --unset restore.defaultDestination &&
+    test_commit root-worktree-restore.defaultDestination &&
+    test_commit worktree-restore.defaultDestination one one &&
+    git config restore.defaultDestination worktree &&
+    >one &&
+
+    git restore one &&
+    git status --porcelain --untracked-files=no >status &&
+    test_must_be_empty status &&
+    rm status &&
+
+    >one &&
+    git add one &&
+    git restore one &&
+    git status --porcelain --untracked-files=no | grep "^M " &&
+
+    >one &&
+    git add one &&
+    git restore --worktree one &&
+    git status --porcelain --untracked-files=no | grep "^M " &&
+
+    git restore --staged one &&
+    git status --porcelain --untracked-files=no | grep "^ M" &&
+
+    >one &&
+    git add one &&
+    git restore --worktree --staged one &&
+    git status --porcelain --untracked-files=no >status &&
+    test_must_be_empty status &&
+    rm status
+'
+
+test_expect_success 'restore with restore.defaultDestination set to staged works as if --staged given' '
+    test_when_finished git reset --hard HEAD^ &&
+    test_when_finished git config --unset restore.defaultDestination &&
+    test_commit root-staged-restore.defaultDestination &&
+    test_commit staged-restore.defaultDestination one one &&
+    git config restore.defaultDestination staged &&
+    >one &&
+
+    git restore one &&
+    git status --porcelain --untracked-files=no | grep "^ M" &&
+
+    git restore --staged one &&
+    git status --porcelain --untracked-files=no | grep "^ M" &&
+
+    git add one &&
+    git restore one &&
+    git status --porcelain --untracked-files=no | grep "^ M" &&
+
+    git add one &&
+    git restore --staged one &&
+    git status --porcelain --untracked-files=no | grep "^ M" &&
+
+    git restore --worktree one &&
+    git status --porcelain --untracked-files=no >status &&
+    test_must_be_empty status &&
+    rm status &&
+
+    >one &&
+    git add one &&
+    git restore --worktree --staged one &&
+    git status --porcelain --untracked-files=no >status &&
+    test_must_be_empty status &&
+    rm status
+'
+
+test_expect_success 'restore with restore.defaultDestination set to both works as if --worktree --staged given' '
+    test_when_finished git reset --hard HEAD^ &&
+    test_when_finished git config --unset restore.defaultDestination &&
+    test_commit root-both-restore.defaultDestination &&
+    test_commit both-restore.defaultDestination one one &&
+    git config restore.defaultDestination both &&
+    >one &&
+
+    git restore one &&
+    git status --porcelain --untracked-files=no >status &&
+    test_must_be_empty status &&
+    rm status &&
+
+    >one &&
+    git add one &&
+    git restore --staged one &&
+    git status --porcelain --untracked-files=no | grep "^ M"  &&
+
+    git add one &&
+    git restore one &&
+    git status --porcelain --untracked-files=no >status &&
+    test_must_be_empty status &&
+    rm status &&
+
+    >one &&
+    git add one &&
+    git restore --staged one &&
+    git status --porcelain --untracked-files=no | grep "^ M" &&
+
+    git restore --worktree one &&
+    git status --porcelain --untracked-files=no >status &&
+    test_must_be_empty status &&
+    rm status &&
+
+    >one &&
+    git add one &&
+    git restore --worktree --staged one &&
+    git status --porcelain --untracked-files=no >status &&
+    test_must_be_empty status &&
+    rm status
+'
+
 test_done
-- 
2.39.2



On 3/13/23 23:11, Junio C Hamano wrote:
> "Hugo Sales via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> Subject: Re: [PATCH] Add `restore.defaultLocation` option
> As to the form, perhaps
>
> 	Subject: [PATCH] restore: make it configurable what gets updated
>
> cf. Documentation/SubmittingPatches[[describe-changes]]
>
> Also on substance,
>
>  * "option" usually refers to the --option given on the command
>    line; when you mean "configuration variable", it is a misleading
>    word to use.
>
>  * "restore" command deals with two quite conceptually different
>    locations.  Where it gets the contents from (i.e. the source
>    location), and where the contents are used to update (i.e. the
>    destination location).  The ".defaultLocation" is a poor name for
>    a configuration variable because it does not convey which one is
>    meant.
>
>> From: Hugo Sales <hugo@hsal.es>
>>
>> This options allows control over which of `--worktree` or `--staged` is
>> applied when `git restore` is invoked with neither
>>
>> This patch is intended to reduce lost work to accidental `git restore .`
>> when `git restore --staged .` was intended.
> We usually describe the status quo (what the current system does),
> what bad things can happen with the current system, and then what
> change is proposed to improve the situation, in this order.  So the
> above is backwards.  Perhaps like
>
>     "git restore" takes "--worktree" and/or "--staged" options to
>     specify which one of the working tree files and/or the index
>     entries are updated.  With neither options, the command by
>     default updates the working tree files.
>
>     A user who wanted to reset the index entries from HEAD may by
>     mistake run "git restore" without the "--staged" option.  When
>     such a mistake happens, the work made in the working tree files
>     that are not yet added to the index will be forever lost.
>
>     Introduce the restore.defaultDestination configuration variable,
>     which can be set to one of "both", "index", or "worktree", to
>     help those users who want to set it to "index" to avoid touching
>     the working tree files by mistake.  They now force themselves to
>     use the "--worktree" option explicitly when they want to restore
>     the working tree files.
>
> or something along that line would make it more like our log messages.
>
> Note that even though I wrote the above by guessing what your
> motivation behind this change is, I do not very much agree with the
> third paragraph myself.  I think a better solution would be to teach
> these users to use "git reset -- <path>" when they want to reset the
> index entries, and not run the "git restore" command.
>
>
>> +	This
>> +	option can be used to prevent accidentally losing work by running `git
>> +	restore .` when `git restore --staged .` was intended.
> This is better left out, as it cuts both ways.  With it set to
> 'index', this option will clobber the index entries the user
> carefully prepared so far with "git add -p" and friends, when the
> user wanted to update the working tree files (either from the index
> or from an existing commit) by running "git restore", which will
> lose work.
>
> If we wanted to advertise it as a feature, then the sentence should
> say something like
>
> 	This variable can be set to 'index' to prevent accidentally
> 	losing work ...
>
> "can be used" is too vague when you are talking about setting it to
> a particular value.  IOW, setting it to any other value would *NOT*
> prevent "git restore" from behaving differently from "git resetore --staged".
>
> Again, I do not think it is a good idea to sell it as a feature in
> the first place, as it cuts both ways.
>
>> diff --git a/Documentation/git-restore.txt b/Documentation/git-restore.txt
>> index 5964810caa4..28165861f55 100644
>> --- a/Documentation/git-restore.txt
>> +++ b/Documentation/git-restore.txt
>> @@ -14,14 +14,18 @@ SYNOPSIS
>>  
>>  DESCRIPTION
>>  -----------
>> -Restore specified paths in the working tree with some contents from a
>> +Restore specified paths in the working tree or index with some contents from a
> Shouldn't it be "and/or"?
>
>> diff --git a/builtin/checkout.c b/builtin/checkout.c
>> index a5155cf55c1..5067753030b 100644
>> --- a/builtin/checkout.c
>> +++ b/builtin/checkout.c
>> @@ -1942,6 +1966,7 @@ int cmd_restore(int argc, const char **argv, const char *prefix)
>>  	struct branch_info new_branch_info = { 0 };
>>  
>>  	memset(&opts, 0, sizeof(opts));
>> +
>>  	opts.accept_ref = 0;
>>  	opts.accept_pathspec = 1;
>>  	opts.empty_pathspec_ok = 0;
> Why?
>
>
>> diff --git a/t/t2070-restore.sh b/t/t2070-restore.sh
>> index 7c43ddf1d99..6e9b06e0bf4 100755
>> --- a/t/t2070-restore.sh
>> +++ b/t/t2070-restore.sh
>> @@ -137,4 +137,128 @@ test_expect_success 'restore --staged invalidates cache tree for deletions' '
>>  	test_must_fail git rev-parse HEAD:new1
>>  '
>>  
>> +test_expect_success 'restore with restore.defaultLocation unset works as if --worktree given' '
>> +	test_when_finished git reset --hard HEAD^ &&
>> +	test_commit root-unset-restore.defaultLocation &&
>> +	test_commit unset-restore.defaultLocation one one &&
>> +	> one &&
> Lose SP between ">" and "one", its redirection target.
>
> cf. Documentation/CodingGuidelines, look for "Redirection operators
> should be written with space before, but no space after them." and
> study the entire paragraph.
>
>> +	git restore one &&
>> +	test -z $(git status --porcelain --untracked-files=no) &&
> This (together with many other uses of "git status" in the new
> tests) will not catch a segfaulting "git status".
>
> Thanks.

--------------gvNbCHhIbLkAoyIAog1MW5h0
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-restore-add-restore.defaultDestination-to-configure-.patch"
Content-Disposition: attachment;
 filename*0="0001-restore-add-restore.defaultDestination-to-configure-.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSBlYzg3OGE4NGRiNGRjN2FhYmJjNWNkZGYwODk3YjcxN2FjNzcyNDk0IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBIdWdvIFNhbGVzIDxodWdvQGhzYWwuZXM+CkRhdGU6
IFNhdCwgMTEgTWFyIDIwMjMgMTI6NDM6MzQgKzAwMDAKU3ViamVjdDogW1BBVENIIHYyXSBy
ZXN0b3JlOiBhZGQgYHJlc3RvcmUuZGVmYXVsdERlc3RpbmF0aW9uYCB0byBjb25maWd1cmUg
d2hhdAogZ2V0cyB1cGRhdGVkCgpgZ2l0IHJlc3RvcmVgIHRha2VzIGAtLXdvcmt0cmVlYCBh
bmQvb3IgYC0tc3RhZ2VkYCBvcHRpb25zIHRvIHNwZWNpZnkKd2hpY2ggb25lIG9mIHRoZSB3
b3JraW5nIHRyZWUgZmlsZXMgYW5kL29yIHRoZSBpbmRleCBlbnRyaWVzIGFyZQp1cGRhdGVk
LiBXaXRoIG5laXRoZXIgb3B0aW9uLCB0aGUgY29tbWFuZCwgYnkgZGVmYXVsdCwgdXBkYXRl
cyB0aGUKd29ya2luZyB0cmVlIGZpbGVzLgoKSWYgYSB1c2VyIGF0dGVtcHRzIHRvIHJlc2V0
IHRoZSBpbmRleCBlbnRyaWVzIGZyb20gSEVBRCwgdGhleSBtYXksIGJ5Cm1pc3Rha2UsIHJ1
biBgZ2l0IHJlc3RvcmVgIHdpdGhvdXQgdGhlIGAtLXN0YWdlZGAgb3B0aW9uLiBXaGVuIHN1
Y2ggYQptaXN0YWtlIGhhcHBlbnMsIHRoZSB3b3JrIG1hZGUgaW4gdGhlIHdvcmtpbmcgdHJl
ZSBmaWxlcyB0aGF0IGFyZSBub3QKeWV0IGFkZGVkIHRvIHRoZSBpbmRleCB3aWxsIGJlIGZv
cmV2ZXIgbG9zdC4gVGhpcyBwYXRjaCBpcyBpbnRlbmRlZCB0bwptaXRpZ2F0ZSB0aGlzLiBU
aGlzIGlzIGEgdHJhZGUtb2ZmIGJldHdlZW4gbG9zdCB3b3JrdHJlZSBjaGFuZ2VzLAp3aGlj
aCBtYXkgbm90IGJlIHByZXNlbnQgYW55d2hlcmUgZWxzZSwgYW5kIGxvc3QgaW5kZXggbW9k
aWZpY2F0aW9ucywKd2hpY2ggY2FuIGJlIHJlY3JlYXRlZC4KCkludHJvZHVjZSB0aGUgYHJl
c3RvcmUuZGVmYXVsdERlc3RpbmF0aW9uYCBjb25maWd1cmF0aW9uIHZhcmlhYmxlLAp3aGlj
aCBjYW4gYmUgc2V0IHRvIG9uZSBvZiAiYm90aCIsICJpbmRleCIsIG9yICJ3b3JrdHJlZSIs
IHVzZWZ1bCBmb3IKdXNlcnMgd2hvIHdhbnQgdG8gc2V0IGl0IHRvICJpbmRleCIgdG8gYXZv
aWQgdG91Y2hpbmcgdGhlIHdvcmtpbmcgdHJlZQpmaWxlcyBieSBtaXN0YWtlLiBUaGV5IG5v
dyBmb3JjZSB0aGVtc2VsdmVzIHRvIHVzZSB0aGUgYC0td29ya3RyZWVgCm9wdGlvbiBleHBs
aWNpdGx5IHdoZW4gdGhleSB3YW50IHRvIHJlc3RvcmUgdGhlIHdvcmtpbmcgdHJlZSBmaWxl
cy4KClNpZ25lZC1vZmYtYnk6IEh1Z28gU2FsZXMgPGh1Z29AaHNhbC5lcz4KLS0tCkkgdGhp
bmsgSSBhZGRyZXNzZWQgeW91ciBjb21tZW50cyBpbiB0aGUgcGF0Y2ggYmVsb3cuCgo+IEkg
dGhpbmsgYSBiZXR0ZXIgc29sdXRpb24gd291bGQgYmUgdG8gdGVhY2gKPiB0aGVzZSB1c2Vy
cyB0byB1c2UgImdpdCByZXNldCAtLSA8cGF0aD4iIHdoZW4gdGhleSB3YW50IHRvIHJlc2V0
IHRoZQo+IGluZGV4IGVudHJpZXMsIGFuZCBub3QgcnVuIHRoZSAiZ2l0IHJlc3RvcmUiIGNv
bW1hbmQuCgpJIHJlYWQgX3NvbWV3aGVyZV8gdGhhdCBgZ2l0IHJlc3RvcmVgIHdhcyB0aGUg
TW9kZXJuIFJlcGxhY2VtZW50IGZvciBgZ2l0CmNoZWNrb3V0YCBhbmQgYGdpdCByZXNldGAs
IGFsb25nIHdpdGggYGdpdCBzd2l0Y2hgLiBJIGRvIGZpbmQgaXQgbW9yZSBpbnR1aXRlLAp0
b28uIEZyaWVuZHMgSSB0YWxrZWQgd2l0aCBsaWtlZCB0aGlzIGNoYW5nZSwgYXMgdGhleSd2
ZSBhbHNvIHJlYWQgc2ltaWxhcgp0aGluZ3MgYW5kIGxvc3Qgd29yayBkdWUgdG8gYSBtaXNz
aW5nIGAtLXN0YWdlZGAsIHNvIHRoZXkgc3RvcHBlZCB1c2luZyBpdC4gSQpmaW5kIGBnaXQg
cmVzZXRgIHNvbWV3aGF0IGNvbmZ1c2luZywgYXMgSSB1c2UgaXQgZm9yIGBnaXQgcmVzZXQg
LS1zb2Z0IEhFQUR+YAphbmQgYGdpdCByZXNldCAtLWhhcmQgPGNvbW1pdC1pc2g+YCwgc28g
SSBkb24ndCByZWFsbHkgYXNzb2NpYXRlIGl0IHdpdGggdGhlCnNhbWUgdXNhZ2UgYXMgYGdp
dCByZXN0b3JlYC4KCj4gK3N0YXRpYyBjb25zdCBjaGFyICpjaGVja291dF9kZWZhdWx0X2lu
ZGV4X3dvcmt0cmVlOwo+ICtzdGF0aWMgaW50IGdpdF9yZXN0b3JlX2NvbmZpZyhjb25zdCBj
aGFyICp2YXIsIGNvbnN0IGNoYXIgKnZhbHVlLCB2b2lkICpjYikKPiArewo+ICsJc3RydWN0
IGNoZWNrb3V0X29wdHMgKm9wdHMgPSBjYjsKPiArCj4gKwlpZiAoIXN0cmNtcCh2YXIsICJy
ZXN0b3JlLmRlZmF1bHRkZXN0aW5hdGlvbiIpKSB7Cj4gKwkJZ2l0X2NvbmZpZ19zdHJpbmco
JmNoZWNrb3V0X2RlZmF1bHRfaW5kZXhfd29ya3RyZWUsIHZhciwgdmFsdWUpOwoKSSdtIG5v
dCBzdXJlIGlmIHRoaXMgdXNlIG9mIGBnaXRfY29uZmlnX3N0cmluZ2AgaXMgcmVxdWlyZWQs
IGFzIGB2YWx1ZWAgc2VlbXMgdG8KY29udGFpbiB0aGUgZGVzaXJlZCB2YWx1ZSwgYnV0IHRo
aXMgc2VlbXMgdG8gYmUgaG93IGl0J3MgZG9uZSBlbHNld2hlcmUuCgo+ID4gKwlnaXQgcmVz
dG9yZSBvbmUgJiYKPiA+ICsJdGVzdCAteiAkKGdpdCBzdGF0dXMgLS1wb3JjZWxhaW4gLS11
bnRyYWNrZWQtZmlsZXM9bm8pICYmCj4gCj4gVGhpcyAodG9nZXRoZXIgd2l0aCBtYW55IG90
aGVyIHVzZXMgb2YgImdpdCBzdGF0dXMiIGluIHRoZSBuZXcKPiB0ZXN0cykgd2lsbCBub3Qg
Y2F0Y2ggYSBzZWdmYXVsdGluZyAiZ2l0IHN0YXR1cyIuCgpJIHJlcGxhY2VkIHRoaXMgd2l0
aCBgdGVzdF9tdXN0X2JlX2VtcHR5YCwgSSdtIG5vdCBzdXJlIGlmIHRoYXQncyB3aGF0IHlv
dQptZWFudC4gSSB3YXNuJ3QgYWJsZSB0byBmaW5kIGEgdmVyc2lvbiB0aGF0IGRvZXNuJ3Qg
bmVlZCB0byB3cml0ZSB0byBhIGZpbGUuCgpQLlMuIEkgaG9wZSB0aGUgZm9sbG93aW5nIHJl
YWNoZXMgeW91IGNvcnJlY3RseSwgYXMgSSdtIHN0aWxsIHN0cnVnZ2xpbmcgdG8KY29ubmVj
dCB0byBtYWlsYm94Lm9yZyB3aXRoIHNlbmQtZW1haWwuCgogRG9jdW1lbnRhdGlvbi9jb25m
aWcudHh0ICAgICAgICAgfCAgIDIgKwogRG9jdW1lbnRhdGlvbi9jb25maWcvcmVzdG9yZS50
eHQgfCAgMTYgKysrKwogRG9jdW1lbnRhdGlvbi9naXQtcmVzdG9yZS50eHQgICAgfCAgMTcg
KystLQogYnVpbHRpbi9jaGVja291dC5jICAgICAgICAgICAgICAgfCAgMjUgKysrKysrCiB0
L3QyMDcwLXJlc3RvcmUuc2ggICAgICAgICAgICAgICB8IDE0MyArKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrCiA1IGZpbGVzIGNoYW5nZWQsIDE5OCBpbnNlcnRpb25zKCspLCA1
IGRlbGV0aW9ucygtKQogY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vY29uZmln
L3Jlc3RvcmUudHh0CgpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9jb25maWcudHh0IGIv
RG9jdW1lbnRhdGlvbi9jb25maWcudHh0CmluZGV4IDBlOTNhZWY4NjIuLjQzNTljNjM3OTQg
MTAwNjQ0Ci0tLSBhL0RvY3VtZW50YXRpb24vY29uZmlnLnR4dAorKysgYi9Eb2N1bWVudGF0
aW9uL2NvbmZpZy50eHQKQEAgLTUwMSw2ICs1MDEsOCBAQCBpbmNsdWRlOjpjb25maWcvcmVw
YWNrLnR4dFtdCiAKIGluY2x1ZGU6OmNvbmZpZy9yZXJlcmUudHh0W10KIAoraW5jbHVkZTo6
Y29uZmlnL3Jlc3RvcmUudHh0W10KKwogaW5jbHVkZTo6Y29uZmlnL3JldmVydC50eHRbXQog
CiBpbmNsdWRlOjpjb25maWcvc2FmZS50eHRbXQpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlv
bi9jb25maWcvcmVzdG9yZS50eHQgYi9Eb2N1bWVudGF0aW9uL2NvbmZpZy9yZXN0b3JlLnR4
dApuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAwMDAwLi42YTA2MzEwYjRhCi0t
LSAvZGV2L251bGwKKysrIGIvRG9jdW1lbnRhdGlvbi9jb25maWcvcmVzdG9yZS50eHQKQEAg
LTAsMCArMSwxNiBAQAorcmVzdG9yZS5kZWZhdWx0RGVzdGluYXRpb246OgorCVZhbGlkIHZh
bHVlczogIndvcmt0cmVlIiwgInN0YWdlZCIgb3IgImJvdGgiLiBDb250cm9scyB0aGUgZGVm
YXVsdAorCWJlaGF2aW9yIG9mIGBnaXQgcmVzdG9yZWAgd2l0aG91dCBgLS13b3JrdHJlZWAg
b3IgYC0tc3RhZ2VkYC4gSWYKKwkid29ya3RyZWUiLCBgZ2l0IHJlc3RvcmVgIHdpdGhvdXQg
YC0td29ya3RyZWVgIG9yIGAtLXN0YWdlZGAgaXMKKwllcXVpdmFsZW50IHRvIGBnaXQgcmVz
dG9yZSAtLXdvcmt0cmVlYC4gSWYgInN0YWdlZCIsIGBnaXQgcmVzdG9yZWAKKwl3aXRob3V0
IGAtLXdvcmt0cmVlYCBvciBgLS1zdGFnZWRgIGlzIGVxdWl2YWxlbnQgdG8gYGdpdCByZXN0
b3JlCisJLS1zdGFnZWRgLiBJZiAiYm90aCIsIGBnaXQgcmVzdG9yZWAgd2l0aG91dCBgLS13
b3JrdHJlZWAgb3IgYC0tc3RhZ2VkYAorCWlzIGVxdWl2YWxlbnQgdG8gYGdpdCByZXN0b3Jl
IC0td29ya3RyZWUgLS1zdGFnZWRgLiBBZGRpbmcgYW4gb3B0aW9uCisJb3ZlcnJpZGVzIHRo
ZSBkZWZhdWx0LCBzdWNoIHRoYXQgaWYgdGhlIGNvbmZpZ3VyYXRpb24gdmFyaWFibGUgaXMg
c2V0IHRvCisJInN0YWdlZCIsIHNwZWNpZnlpbmcgYC0td29ya3RyZWVgIHdpbGwgb25seSBh
ZmZlY3QgdGhlIHdvcmt0cmVlLCBub3QKKwlib3RoLiBUaGlzIHZhcmlhYmxlIGNhbiBiZSBz
ZXQgdG8gInN0YWdlZCIgdG8gaGVscCBwcmV2ZW50IGFjY2lkZW50YWxseQorCWxvc2luZyBt
b2RpZmljYXRpb25zIHRvIHRoZSB3b3JrdHJlZSwgY2F1c2VkIGJ5IHJ1bm5pbmcgYGdpdCBy
ZXN0b3JlIC5gCisJd2hlbiBgZ2l0IHJlc3RvcmUgLS1zdGFnZWQgLmAgd2FzIGludGVuZGVk
LiBJbiB0aGlzIGNhc2UsIG1vZGlmaWNhdGlvbnMKKwl0byB0aGUgaW5kZXggd291bGQgYmUg
bG9zdCwgd2hpY2ggY291bGQgYWxzbyBiZSBhIHNpZ25pZmljYW50IGFtb3VudCBvZgorCXdv
cmssIHNvIGNhcmUgaXMgaGlnaGx5IHJlY29tbWVuZGVkLgorCVNlZSBsaW5rZ2l0OmdpdC1y
ZXN0b3JlWzFdCmRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2dpdC1yZXN0b3JlLnR4dCBi
L0RvY3VtZW50YXRpb24vZ2l0LXJlc3RvcmUudHh0CmluZGV4IDU5NjQ4MTBjYWEuLjM5MWMz
NjdkMzIgMTAwNjQ0Ci0tLSBhL0RvY3VtZW50YXRpb24vZ2l0LXJlc3RvcmUudHh0CisrKyBi
L0RvY3VtZW50YXRpb24vZ2l0LXJlc3RvcmUudHh0CkBAIC0xNCwxNCArMTQsMTggQEAgU1lO
T1BTSVMKIAogREVTQ1JJUFRJT04KIC0tLS0tLS0tLS0tCi1SZXN0b3JlIHNwZWNpZmllZCBw
YXRocyBpbiB0aGUgd29ya2luZyB0cmVlIHdpdGggc29tZSBjb250ZW50cyBmcm9tIGEKK1Jl
c3RvcmUgc3BlY2lmaWVkIHBhdGhzIGluIHRoZSB3b3JraW5nIHRyZWUgYW5kL29yIGluZGV4
IHdpdGggc29tZSBjb250ZW50cyBmcm9tIGEKIHJlc3RvcmUgc291cmNlLiBJZiBhIHBhdGgg
aXMgdHJhY2tlZCBidXQgZG9lcyBub3QgZXhpc3QgaW4gdGhlIHJlc3RvcmUKIHNvdXJjZSwg
aXQgd2lsbCBiZSByZW1vdmVkIHRvIG1hdGNoIHRoZSBzb3VyY2UuCiAKLVRoZSBjb21tYW5k
IGNhbiBhbHNvIGJlIHVzZWQgdG8gcmVzdG9yZSB0aGUgY29udGVudCBpbiB0aGUgaW5kZXgg
d2l0aAorVGhlIGNvbW1hbmQgY2FuIGJlIHVzZWQgdG8gcmVzdG9yZSB0aGUgY29udGVudCBp
biB0aGUgaW5kZXggd2l0aAogYC0tc3RhZ2VkYCwgb3IgcmVzdG9yZSBib3RoIHRoZSB3b3Jr
aW5nIHRyZWUgYW5kIHRoZSBpbmRleCB3aXRoCiBgLS1zdGFnZWQgLS13b3JrdHJlZWAuCiAK
K1RoZSBjb25maWd1cmF0aW9uIHZhaXJhYmxlIGByZXN0b3JlLmRlZmF1bHREZXN0aW5hdGlv
bmAsIHdoaWNoIGFjY2VwdHMgdmFsdWVzCisid29ya3RyZWUiLCAic3RhZ2VkIiBvciAiYm90
aCIsIGNhbiBiZSB1c2VkIHRvIGNvbnRyb2wgdGhlIGRlZmF1bHQgYmVoYXZpb3IgZm9yCit3
aGljaCBmbGFnKHMpIGFwcGx5IGlmIG5laXRoZXIgYC0tc3RhZ2VkYCBub3IgYC0td29ya3Ry
ZWVgIGlzIHN1cHBsaWVkLgorCiBCeSBkZWZhdWx0LCBpZiBgLS1zdGFnZWRgIGlzIGdpdmVu
LCB0aGUgY29udGVudHMgYXJlIHJlc3RvcmVkIGZyb20gYEhFQURgLAogb3RoZXJ3aXNlIGZy
b20gdGhlIGluZGV4LiBVc2UgYC0tc291cmNlYCB0byByZXN0b3JlIGZyb20gYSBkaWZmZXJl
bnQgY29tbWl0LgogCkBAIC01OSw5ICs2MywxMiBAQCBhbGwgbW9kaWZpZWQgcGF0aHMuCiAt
LXdvcmt0cmVlOjoKIC1TOjoKIC0tc3RhZ2VkOjoKLQlTcGVjaWZ5IHRoZSByZXN0b3JlIGxv
Y2F0aW9uLiBJZiBuZWl0aGVyIG9wdGlvbiBpcyBzcGVjaWZpZWQsCi0JYnkgZGVmYXVsdCB0
aGUgd29ya2luZyB0cmVlIGlzIHJlc3RvcmVkLiBTcGVjaWZ5aW5nIGAtLXN0YWdlZGAKLQl3
aWxsIG9ubHkgcmVzdG9yZSB0aGUgaW5kZXguIFNwZWNpZnlpbmcgYm90aCByZXN0b3JlcyBi
b3RoLgorCVNwZWNpZnkgdGhlIHJlc3RvcmUgZGVzdGluYXRpb24uIElmIG5laXRoZXIgb3B0
aW9uIGlzIHNwZWNpZmllZCwgdGhlIGRlZmF1bHQKKwlkZXBlbmRzIG9uIHRoZSBgJ3Jlc3Rv
cmUuZGVmYXVsdERlc3RpbmF0aW9uYCBjb25maWd1cmF0aW9uIHZhcmlhYmxlLAorCXdoaWNo
IGNhbiBiZSAid29ya3RyZWUiICh0aGUgZGVmYXVsdCksICJzdGFnZWQiIG9yICJib3RoIiwg
dG8gY29udHJvbAorCXdoaWNoIG9mIHRoZSB0d28gZmxhZ3MgaXMgYXNzdW1lZCBpZiBub25l
IGFyZSBnaXZlbi4gU3BlY2lmeWluZworCWAtLXdvcmt0cmVlYCB3aWxsIG9ubHkgcmVzdG9y
ZSB0aGUgd29ya3RyZWUuIFNwZWNpZnlpbmcgYC0tc3RhZ2VkYCB3aWxsCisJb25seSByZXN0
b3JlIHRoZSBpbmRleC4gU3BlY2lmeWluZyBib3RoIHJlc3RvcmVzIGJvdGguCiAKIC1xOjoK
IC0tcXVpZXQ6OgpkaWZmIC0tZ2l0IGEvYnVpbHRpbi9jaGVja291dC5jIGIvYnVpbHRpbi9j
aGVja291dC5jCmluZGV4IGE1MTU1Y2Y1NWMuLjRhOTEzMWVjMjkgMTAwNjQ0Ci0tLSBhL2J1
aWx0aW4vY2hlY2tvdXQuYworKysgYi9idWlsdGluL2NoZWNrb3V0LmMKQEAgLTE5MjIsNiAr
MTkyMiwyOSBAQCBpbnQgY21kX3N3aXRjaChpbnQgYXJnYywgY29uc3QgY2hhciAqKmFyZ3Ys
IGNvbnN0IGNoYXIgKnByZWZpeCkKIAlyZXR1cm4gcmV0OwogfQogCitzdGF0aWMgY29uc3Qg
Y2hhciAqY2hlY2tvdXRfZGVmYXVsdF9pbmRleF93b3JrdHJlZTsKK3N0YXRpYyBpbnQgZ2l0
X3Jlc3RvcmVfY29uZmlnKGNvbnN0IGNoYXIgKnZhciwgY29uc3QgY2hhciAqdmFsdWUsIHZv
aWQgKmNiKQoreworCXN0cnVjdCBjaGVja291dF9vcHRzICpvcHRzID0gY2I7CisKKwlpZiAo
IXN0cmNtcCh2YXIsICJyZXN0b3JlLmRlZmF1bHRkZXN0aW5hdGlvbiIpKSB7CisJCWdpdF9j
b25maWdfc3RyaW5nKCZjaGVja291dF9kZWZhdWx0X2luZGV4X3dvcmt0cmVlLCB2YXIsIHZh
bHVlKTsKKwkJaWYgKCFzdHJjbXAoY2hlY2tvdXRfZGVmYXVsdF9pbmRleF93b3JrdHJlZSwg
ImJvdGgiKSkgeworCQkJb3B0cy0+Y2hlY2tvdXRfaW5kZXggPSAtMjsgICAgLyogZGVmYXVs
dCBvbiAqLworCQkJb3B0cy0+Y2hlY2tvdXRfd29ya3RyZWUgPSAtMjsgLyogZGVmYXVsdCBv
biAqLworCQl9IGVsc2UgaWYgKCFzdHJjbXAoY2hlY2tvdXRfZGVmYXVsdF9pbmRleF93b3Jr
dHJlZSwgInN0YWdlZCIpKSB7CisJCQlvcHRzLT5jaGVja291dF9pbmRleCA9IC0yOyAgICAv
KiBkZWZhdWx0IG9uICovCisJCQlvcHRzLT5jaGVja291dF93b3JrdHJlZSA9IC0xOyAvKiBk
ZWZhdWx0IG9mZiAqLworCQl9IGVsc2UgeworCQkJb3B0cy0+Y2hlY2tvdXRfaW5kZXggPSAt
MTsgICAgLyogZGVmYXVsdCBvZmYgKi8KKwkJCW9wdHMtPmNoZWNrb3V0X3dvcmt0cmVlID0g
LTI7IC8qIGRlZmF1bHQgb24gKi8KKwkJfQorCQlyZXR1cm4gMDsKKwl9CisJcmV0dXJuIGdp
dF94bWVyZ2VfY29uZmlnKHZhciwgdmFsdWUsIE5VTEwpOworfQorCisKIGludCBjbWRfcmVz
dG9yZShpbnQgYXJnYywgY29uc3QgY2hhciAqKmFyZ3YsIGNvbnN0IGNoYXIgKnByZWZpeCkK
IHsKIAlzdHJ1Y3QgY2hlY2tvdXRfb3B0cyBvcHRzOwpAQCAtMTk1MCw2ICsxOTczLDggQEAg
aW50IGNtZF9yZXN0b3JlKGludCBhcmdjLCBjb25zdCBjaGFyICoqYXJndiwgY29uc3QgY2hh
ciAqcHJlZml4KQogCW9wdHMuY2hlY2tvdXRfd29ya3RyZWUgPSAtMjsgLyogZGVmYXVsdCBv
biAqLwogCW9wdHMuaWdub3JlX3VubWVyZ2VkX29wdCA9ICItLWlnbm9yZS11bm1lcmdlZCI7
CiAKKwlnaXRfY29uZmlnKGdpdF9yZXN0b3JlX2NvbmZpZywgJm9wdHMpOworCiAJb3B0aW9u
cyA9IHBhcnNlX29wdGlvbnNfZHVwKHJlc3RvcmVfb3B0aW9ucyk7CiAJb3B0aW9ucyA9IGFk
ZF9jb21tb25fb3B0aW9ucygmb3B0cywgb3B0aW9ucyk7CiAJb3B0aW9ucyA9IGFkZF9jaGVj
a291dF9wYXRoX29wdGlvbnMoJm9wdHMsIG9wdGlvbnMpOwpkaWZmIC0tZ2l0IGEvdC90MjA3
MC1yZXN0b3JlLnNoIGIvdC90MjA3MC1yZXN0b3JlLnNoCmluZGV4IDdjNDNkZGYxZDkuLmMz
YTM1ZGQ4NzggMTAwNzU1Ci0tLSBhL3QvdDIwNzAtcmVzdG9yZS5zaAorKysgYi90L3QyMDcw
LXJlc3RvcmUuc2gKQEAgLTEzNyw0ICsxMzcsMTQ3IEBAIHRlc3RfZXhwZWN0X3N1Y2Nlc3Mg
J3Jlc3RvcmUgLS1zdGFnZWQgaW52YWxpZGF0ZXMgY2FjaGUgdHJlZSBmb3IgZGVsZXRpb25z
JyAnCiAJdGVzdF9tdXN0X2ZhaWwgZ2l0IHJldi1wYXJzZSBIRUFEOm5ldzEKICcKIAordGVz
dF9leHBlY3Rfc3VjY2VzcyAncmVzdG9yZSB3aXRoIHJlc3RvcmUuZGVmYXVsdERlc3RpbmF0
aW9uIHVuc2V0IHdvcmtzIGFzIGlmIC0td29ya3RyZWUgZ2l2ZW4nICcKKwl0ZXN0X3doZW5f
ZmluaXNoZWQgZ2l0IHJlc2V0IC0taGFyZCBIRUFEXiAmJgorCXRlc3RfY29tbWl0IHJvb3Qt
dW5zZXQtcmVzdG9yZS5kZWZhdWx0RGVzdGluYXRpb24gJiYKKwl0ZXN0X2NvbW1pdCB1bnNl
dC1yZXN0b3JlLmRlZmF1bHREZXN0aW5hdGlvbiBvbmUgb25lICYmCisJPm9uZSAmJgorCisJ
Z2l0IHJlc3RvcmUgb25lICYmCisJZ2l0IHN0YXR1cyAtLXBvcmNlbGFpbiAtLXVudHJhY2tl
ZC1maWxlcz1ubyA+c3RhdHVzICYmCisJdGVzdF9tdXN0X2JlX2VtcHR5IHN0YXR1cyAmJgor
CXJtIHN0YXR1cyAmJgorCisJPm9uZSAmJgorCWdpdCBhZGQgb25lICYmCisJZ2l0IHJlc3Rv
cmUgb25lICYmCisJZ2l0IHN0YXR1cyAtLXBvcmNlbGFpbiAtLXVudHJhY2tlZC1maWxlcz1u
byB8IGdyZXAgIl5NICIgJiYKKworCT5vbmUgJiYKKwlnaXQgYWRkIG9uZSAmJgorCWdpdCBy
ZXN0b3JlIC0td29ya3RyZWUgb25lICYmCisJZ2l0IHN0YXR1cyAtLXBvcmNlbGFpbiAtLXVu
dHJhY2tlZC1maWxlcz1ubyB8IGdyZXAgIl5NICIgJiYKKworCWdpdCByZXN0b3JlIC0tc3Rh
Z2VkIG9uZSAmJgorCWdpdCBzdGF0dXMgLS1wb3JjZWxhaW4gLS11bnRyYWNrZWQtZmlsZXM9
bm8gfCBncmVwICJeIE0iICYmCisKKwk+b25lICYmCisJZ2l0IGFkZCBvbmUgJiYKKwlnaXQg
cmVzdG9yZSAtLXdvcmt0cmVlIC0tc3RhZ2VkIG9uZSAmJgorCWdpdCBzdGF0dXMgLS1wb3Jj
ZWxhaW4gLS11bnRyYWNrZWQtZmlsZXM9bm8gPnN0YXR1cyAmJgorCXRlc3RfbXVzdF9iZV9l
bXB0eSBzdGF0dXMgJiYKKwlybSBzdGF0dXMKKycKKwordGVzdF9leHBlY3Rfc3VjY2VzcyAn
cmVzdG9yZSB3aXRoIHJlc3RvcmUuZGVmYXVsdERlc3RpbmF0aW9uIHNldCB0byB3b3JrdHJl
ZSB3b3JrcyBhcyBpZiAtLXdvcmt0cmVlIGdpdmVuJyAnCisJdGVzdF93aGVuX2ZpbmlzaGVk
IGdpdCByZXNldCAtLWhhcmQgSEVBRF4gJiYKKwl0ZXN0X3doZW5fZmluaXNoZWQgZ2l0IGNv
bmZpZyAtLXVuc2V0IHJlc3RvcmUuZGVmYXVsdERlc3RpbmF0aW9uICYmCisJdGVzdF9jb21t
aXQgcm9vdC13b3JrdHJlZS1yZXN0b3JlLmRlZmF1bHREZXN0aW5hdGlvbiAmJgorCXRlc3Rf
Y29tbWl0IHdvcmt0cmVlLXJlc3RvcmUuZGVmYXVsdERlc3RpbmF0aW9uIG9uZSBvbmUgJiYK
KwlnaXQgY29uZmlnIHJlc3RvcmUuZGVmYXVsdERlc3RpbmF0aW9uIHdvcmt0cmVlICYmCisJ
Pm9uZSAmJgorCisJZ2l0IHJlc3RvcmUgb25lICYmCisJZ2l0IHN0YXR1cyAtLXBvcmNlbGFp
biAtLXVudHJhY2tlZC1maWxlcz1ubyA+c3RhdHVzICYmCisJdGVzdF9tdXN0X2JlX2VtcHR5
IHN0YXR1cyAmJgorCXJtIHN0YXR1cyAmJgorCisJPm9uZSAmJgorCWdpdCBhZGQgb25lICYm
CisJZ2l0IHJlc3RvcmUgb25lICYmCisJZ2l0IHN0YXR1cyAtLXBvcmNlbGFpbiAtLXVudHJh
Y2tlZC1maWxlcz1ubyB8IGdyZXAgIl5NICIgJiYKKworCT5vbmUgJiYKKwlnaXQgYWRkIG9u
ZSAmJgorCWdpdCByZXN0b3JlIC0td29ya3RyZWUgb25lICYmCisJZ2l0IHN0YXR1cyAtLXBv
cmNlbGFpbiAtLXVudHJhY2tlZC1maWxlcz1ubyB8IGdyZXAgIl5NICIgJiYKKworCWdpdCBy
ZXN0b3JlIC0tc3RhZ2VkIG9uZSAmJgorCWdpdCBzdGF0dXMgLS1wb3JjZWxhaW4gLS11bnRy
YWNrZWQtZmlsZXM9bm8gfCBncmVwICJeIE0iICYmCisKKwk+b25lICYmCisJZ2l0IGFkZCBv
bmUgJiYKKwlnaXQgcmVzdG9yZSAtLXdvcmt0cmVlIC0tc3RhZ2VkIG9uZSAmJgorCWdpdCBz
dGF0dXMgLS1wb3JjZWxhaW4gLS11bnRyYWNrZWQtZmlsZXM9bm8gPnN0YXR1cyAmJgorCXRl
c3RfbXVzdF9iZV9lbXB0eSBzdGF0dXMgJiYKKwlybSBzdGF0dXMKKycKKwordGVzdF9leHBl
Y3Rfc3VjY2VzcyAncmVzdG9yZSB3aXRoIHJlc3RvcmUuZGVmYXVsdERlc3RpbmF0aW9uIHNl
dCB0byBzdGFnZWQgd29ya3MgYXMgaWYgLS1zdGFnZWQgZ2l2ZW4nICcKKwl0ZXN0X3doZW5f
ZmluaXNoZWQgZ2l0IHJlc2V0IC0taGFyZCBIRUFEXiAmJgorCXRlc3Rfd2hlbl9maW5pc2hl
ZCBnaXQgY29uZmlnIC0tdW5zZXQgcmVzdG9yZS5kZWZhdWx0RGVzdGluYXRpb24gJiYKKwl0
ZXN0X2NvbW1pdCByb290LXN0YWdlZC1yZXN0b3JlLmRlZmF1bHREZXN0aW5hdGlvbiAmJgor
CXRlc3RfY29tbWl0IHN0YWdlZC1yZXN0b3JlLmRlZmF1bHREZXN0aW5hdGlvbiBvbmUgb25l
ICYmCisJZ2l0IGNvbmZpZyByZXN0b3JlLmRlZmF1bHREZXN0aW5hdGlvbiBzdGFnZWQgJiYK
Kwk+b25lICYmCisKKwlnaXQgcmVzdG9yZSBvbmUgJiYKKwlnaXQgc3RhdHVzIC0tcG9yY2Vs
YWluIC0tdW50cmFja2VkLWZpbGVzPW5vIHwgZ3JlcCAiXiBNIiAmJgorCisJZ2l0IHJlc3Rv
cmUgLS1zdGFnZWQgb25lICYmCisJZ2l0IHN0YXR1cyAtLXBvcmNlbGFpbiAtLXVudHJhY2tl
ZC1maWxlcz1ubyB8IGdyZXAgIl4gTSIgJiYKKworCWdpdCBhZGQgb25lICYmCisJZ2l0IHJl
c3RvcmUgb25lICYmCisJZ2l0IHN0YXR1cyAtLXBvcmNlbGFpbiAtLXVudHJhY2tlZC1maWxl
cz1ubyB8IGdyZXAgIl4gTSIgJiYKKworCWdpdCBhZGQgb25lICYmCisJZ2l0IHJlc3RvcmUg
LS1zdGFnZWQgb25lICYmCisJZ2l0IHN0YXR1cyAtLXBvcmNlbGFpbiAtLXVudHJhY2tlZC1m
aWxlcz1ubyB8IGdyZXAgIl4gTSIgJiYKKworCWdpdCByZXN0b3JlIC0td29ya3RyZWUgb25l
ICYmCisJZ2l0IHN0YXR1cyAtLXBvcmNlbGFpbiAtLXVudHJhY2tlZC1maWxlcz1ubyA+c3Rh
dHVzICYmCisJdGVzdF9tdXN0X2JlX2VtcHR5IHN0YXR1cyAmJgorCXJtIHN0YXR1cyAmJgor
CisJPm9uZSAmJgorCWdpdCBhZGQgb25lICYmCisJZ2l0IHJlc3RvcmUgLS13b3JrdHJlZSAt
LXN0YWdlZCBvbmUgJiYKKwlnaXQgc3RhdHVzIC0tcG9yY2VsYWluIC0tdW50cmFja2VkLWZp
bGVzPW5vID5zdGF0dXMgJiYKKwl0ZXN0X211c3RfYmVfZW1wdHkgc3RhdHVzICYmCisJcm0g
c3RhdHVzCisnCisKK3Rlc3RfZXhwZWN0X3N1Y2Nlc3MgJ3Jlc3RvcmUgd2l0aCByZXN0b3Jl
LmRlZmF1bHREZXN0aW5hdGlvbiBzZXQgdG8gYm90aCB3b3JrcyBhcyBpZiAtLXdvcmt0cmVl
IC0tc3RhZ2VkIGdpdmVuJyAnCisJdGVzdF93aGVuX2ZpbmlzaGVkIGdpdCByZXNldCAtLWhh
cmQgSEVBRF4gJiYKKwl0ZXN0X3doZW5fZmluaXNoZWQgZ2l0IGNvbmZpZyAtLXVuc2V0IHJl
c3RvcmUuZGVmYXVsdERlc3RpbmF0aW9uICYmCisJdGVzdF9jb21taXQgcm9vdC1ib3RoLXJl
c3RvcmUuZGVmYXVsdERlc3RpbmF0aW9uICYmCisJdGVzdF9jb21taXQgYm90aC1yZXN0b3Jl
LmRlZmF1bHREZXN0aW5hdGlvbiBvbmUgb25lICYmCisJZ2l0IGNvbmZpZyByZXN0b3JlLmRl
ZmF1bHREZXN0aW5hdGlvbiBib3RoICYmCisJPm9uZSAmJgorCisJZ2l0IHJlc3RvcmUgb25l
ICYmCisJZ2l0IHN0YXR1cyAtLXBvcmNlbGFpbiAtLXVudHJhY2tlZC1maWxlcz1ubyA+c3Rh
dHVzICYmCisJdGVzdF9tdXN0X2JlX2VtcHR5IHN0YXR1cyAmJgorCXJtIHN0YXR1cyAmJgor
CisJPm9uZSAmJgorCWdpdCBhZGQgb25lICYmCisJZ2l0IHJlc3RvcmUgLS1zdGFnZWQgb25l
ICYmCisJZ2l0IHN0YXR1cyAtLXBvcmNlbGFpbiAtLXVudHJhY2tlZC1maWxlcz1ubyB8IGdy
ZXAgIl4gTSIgICYmCisKKwlnaXQgYWRkIG9uZSAmJgorCWdpdCByZXN0b3JlIG9uZSAmJgor
CWdpdCBzdGF0dXMgLS1wb3JjZWxhaW4gLS11bnRyYWNrZWQtZmlsZXM9bm8gPnN0YXR1cyAm
JgorCXRlc3RfbXVzdF9iZV9lbXB0eSBzdGF0dXMgJiYKKwlybSBzdGF0dXMgJiYKKworCT5v
bmUgJiYKKwlnaXQgYWRkIG9uZSAmJgorCWdpdCByZXN0b3JlIC0tc3RhZ2VkIG9uZSAmJgor
CWdpdCBzdGF0dXMgLS1wb3JjZWxhaW4gLS11bnRyYWNrZWQtZmlsZXM9bm8gfCBncmVwICJe
IE0iICYmCisKKwlnaXQgcmVzdG9yZSAtLXdvcmt0cmVlIG9uZSAmJgorCWdpdCBzdGF0dXMg
LS1wb3JjZWxhaW4gLS11bnRyYWNrZWQtZmlsZXM9bm8gPnN0YXR1cyAmJgorCXRlc3RfbXVz
dF9iZV9lbXB0eSBzdGF0dXMgJiYKKwlybSBzdGF0dXMgJiYKKworCT5vbmUgJiYKKwlnaXQg
YWRkIG9uZSAmJgorCWdpdCByZXN0b3JlIC0td29ya3RyZWUgLS1zdGFnZWQgb25lICYmCisJ
Z2l0IHN0YXR1cyAtLXBvcmNlbGFpbiAtLXVudHJhY2tlZC1maWxlcz1ubyA+c3RhdHVzICYm
CisJdGVzdF9tdXN0X2JlX2VtcHR5IHN0YXR1cyAmJgorCXJtIHN0YXR1cworJworCiB0ZXN0
X2RvbmUKLS0gCjIuMzkuMgoK

--------------gvNbCHhIbLkAoyIAog1MW5h0--
