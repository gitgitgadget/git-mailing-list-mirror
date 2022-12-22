Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42659C4332F
	for <git@archiver.kernel.org>; Thu, 22 Dec 2022 20:16:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbiLVUQY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Dec 2022 15:16:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiLVUQW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Dec 2022 15:16:22 -0500
Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC92CFD06
        for <git@vger.kernel.org>; Thu, 22 Dec 2022 12:16:19 -0800 (PST)
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 839231F852;
        Thu, 22 Dec 2022 20:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
        s=selector1; t=1671740179;
        bh=gr8/XXou85fa4ohfJU2rTZkSXVHxGURLV5Fi2xeCJJ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rmZK0aK5LQQ5IDVx0SxkLF/HmEdkqoTbthTKcw7ke+15ZtQ25KDWYOmn/aUYp2AyG
         UGSE4JcQjYObdoywQ9AZhBa7leW7pMIQaIpFHCKybE4HCRv3UQ++lF9gql2mxBVxzm
         ZGqEO6//gcNim60jzj4Lior+P8EyiveCaCk4mz00=
Date:   Thu, 22 Dec 2022 20:16:19 +0000
From:   Eric Wong <e@80x24.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: [PATCH v2] format-patch: support format.mboxrd with --stdout
Message-ID: <20221222201619.M435985@dcvr>
References: <20221114094114.18986-1-e@80x24.org>
 <221114.86leodlbix.gmgdl@evledraar.gmail.com>
 <20221114205909.GA14736@dcvr>
 <xmqqv8m9wd7r.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqv8m9wd7r.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> wrote:
> Eric Wong <e@80x24.org> writes:
> >> > +	if (mboxrd)
> >> > +		rev.commit_format = CMIT_FMT_MBOXRD;
> >> > +
> >
> > It could be something like this:
> >
> > 	if (rev.commit_format == CMIT_FMT_MBOXRD && !use_stdout)
> > 		warning("mboxrd without --stdout makes no sense\n");
> >
> > But I'm on the fence about the warning.

OK, so the warning won't be necessary if using format.mboxrd
via config.

> Does it really hurt when generating individual files, or does it
> naturally degenerate to the same as the plain old mbox, or
> something?  If it does not hurt, then let's not clutter the output
> with a message that may make the user worried unnecessarily.

mboxrd is bad for individual files since it can leave '>From'
escaping if applied w/o `--patch-format mboxrd".  My revised
patch only enables mboxrd if --stdout is in use.

> Having said all that, if --pretty=mboxrd is usable, do we really
> need the --mboxrd short-hand?  If we plan to eventually switch the
> default output format to mboxrd (which I am assuming your longer
> term vision), wouldn't it be the traditional format that may need a
> short-hand when something goes wrong?

Actually, I never considered making mboxrd a config file knob.
But yes, it seems like a good idea.

I hadn't considered making it the default, actually.  The current
`--pretty=email --stdout' is probably "good enough" for many
users since the "From "-splitting in mailsplit is strict and
legitimate commit messages are unlikely to have splittable "From "
lines.

> This change does not seem to be something we cannot live without,

That double negative confused me :x

"This change seems to be something we can live without"

Yes, I agree.

> and as a step in the direction to move all of us to mboxrd, this
> feels somewhat a roundabout step.  I wonder if it would be more
> direct to
> 
>  - declare that we will eventually switch to use mboxrd by default;
> 
>  - give a configuration knob to retain the current email as default;
> 
>  - do the usual deprecation dance.

I don't know if changing the default+deprecation is necessary,
but thanks for suggesting a config knob.

> After all, between email and mboxrd, the e-mailed patch format is
> not something we choose per-invocation basis, is it?

Right.

> Picking a suitable format per project and setting it in .git/config,
> or picking a suitble format for yourself and setting it in
> ~/.gitconfig, and not having to think about it afterwards may be a
> better use of our users' time.

Agreed.  Thanks for the suggestions.

------------8<-------------
Subject: [PATCH v2] format-patch: support format.mboxrd with --stdout

mboxrd is a more robust output format when used with --stdout
and needs more exposure.  Introducing this config knob lets
users choose the more robust format for all their --stdout
uses.

Relying on --pretty=mboxrd and including all of pretty-formats.txt
in the `git format-patch' documentation would likely be
confusing to users.  Furthermore, this setting is useful across
multiple invocations.  So introduce `format.mboxrd' as a boolean
configuration knob that changes the default --pretty=email format
to --pretty=mboxrd when (and only when) --stdout is in use.

Signed-off-by: Eric Wong <e@80x24.org>
---
Interdiff:
  diff --git a/Documentation/config/format.txt b/Documentation/config/format.txt
  index c7303d8d9f..3bd78269e2 100644
  --- a/Documentation/config/format.txt
  +++ b/Documentation/config/format.txt
  @@ -139,3 +139,7 @@ For example,
   ------------
   +
   will only show notes from `refs/notes/bar`.
  +
  +format.mboxrd::
  +	A boolean value which enables the robust "mboxrd" format when
  +	`--stdout` is in use to escape "^>+From " lines.
  diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
  index b080d3c61e..dfcc7da4c2 100644
  --- a/Documentation/git-format-patch.txt
  +++ b/Documentation/git-format-patch.txt
  @@ -9,7 +9,7 @@ git-format-patch - Prepare patches for e-mail submission
   SYNOPSIS
   --------
   [verse]
  -'git format-patch' [-k] [(-o|--output-directory) <dir> | --stdout] [--mboxrd]
  +'git format-patch' [-k] [(-o|--output-directory) <dir> | --stdout]
   		   [--no-thread | --thread[=<style>]]
   		   [(--attach|--inline)[=<boundary>] | --no-attach]
   		   [-s | --signoff]
  @@ -145,10 +145,6 @@ include::diff-options.txt[]
   	Print all commits to the standard output in mbox format,
   	instead of creating a file for each one.
   
  ---mboxrd::
  -	Use the robust "mboxrd" format with `--stdout` to escape
  -	"^>+From " lines.
  -
   --attach[=<boundary>]::
   	Create multipart/mixed attachment, the first part of
   	which is the commit message and the patch itself in the
  diff --git a/builtin/log.c b/builtin/log.c
  index 387560cc89..057e299c24 100644
  --- a/builtin/log.c
  +++ b/builtin/log.c
  @@ -52,6 +52,7 @@ static int decoration_style;
   static int decoration_given;
   static int use_mailmap_config = 1;
   static unsigned int force_in_body_from;
  +static int stdout_mboxrd;
   static const char *fmt_patch_subject_prefix = "PATCH";
   static int fmt_patch_name_max = FORMAT_PATCH_NAME_MAX_DEFAULT;
   static const char *fmt_pretty;
  @@ -1077,6 +1078,10 @@ static int git_format_config(const char *var, const char *value, void *cb)
   		cover_from_description_mode = parse_cover_from_description(value);
   		return 0;
   	}
  +	if (!strcmp(var, "format.mboxrd")) {
  +		stdout_mboxrd = git_config_bool(var, value);
  +		return 0;
  +	}
   
   	return git_log_config(var, value, cb);
   }
  @@ -1871,7 +1876,6 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
   	struct strbuf rdiff2 = STRBUF_INIT;
   	struct strbuf rdiff_title = STRBUF_INIT;
   	int creation_factor = -1;
  -	int mboxrd = 0;
   
   	const struct option builtin_format_patch_options[] = {
   		OPT_CALLBACK_F('n', "numbered", &numbered, NULL,
  @@ -1883,8 +1887,6 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
   		OPT_BOOL('s', "signoff", &do_signoff, N_("add a Signed-off-by trailer")),
   		OPT_BOOL(0, "stdout", &use_stdout,
   			    N_("print patches to standard out")),
  -		OPT_BOOL(0, "mboxrd", &mboxrd,
  -			    N_("use the robust mboxrd format with --stdout")),
   		OPT_BOOL(0, "cover-letter", &cover_letter,
   			    N_("generate a cover letter")),
   		OPT_BOOL(0, "numbered-files", &just_numbers,
  @@ -2108,8 +2110,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
   				  rev.diffopt.close_file, "--output",
   				  !!output_directory, "--output-directory");
   
  -	/* should we warn on --mboxrd w/o --stdout? */
  -	if (mboxrd)
  +	if (use_stdout && stdout_mboxrd)
   		rev.commit_format = CMIT_FMT_MBOXRD;
   
   	if (use_stdout) {
  diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
  index 73cbbd0ff8..dc95c34cc8 100644
  --- a/contrib/completion/git-completion.bash
  +++ b/contrib/completion/git-completion.bash
  @@ -1835,7 +1835,7 @@ _git_fetch ()
   
   __git_format_patch_extra_options="
   	--full-index --not --all --no-prefix --src-prefix=
  -	--dst-prefix= --notes --mboxrd
  +	--dst-prefix= --notes
   "
   
   _git_format_patch ()
  diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
  index 69ed8b1ffa..012f155e10 100755
  --- a/t/t4014-format-patch.sh
  +++ b/t/t4014-format-patch.sh
  @@ -2281,7 +2281,7 @@ test_expect_success 'format-patch --attach cover-letter only is non-multipart' '
   	test_line_count = 1 output
   '
   
  -test_expect_success 'format-patch --mboxrd' '
  +test_expect_success '-c format.mboxrd format-patch' '
   	sp=" " &&
   	cat >msg <<-INPUT_END &&
   	mboxrd should escape the body
  @@ -2316,7 +2316,7 @@ test_expect_success 'format-patch --mboxrd' '
   	INPUT_END
   
   	C=$(git commit-tree HEAD^^{tree} -p HEAD <msg) &&
  -	git format-patch --mboxrd --stdout -1 $C~1..$C >patch &&
  +	git -c format.mboxrd format-patch --stdout -1 $C~1..$C >patch &&
   	git format-patch --pretty=mboxrd --stdout -1 $C~1..$C >compat &&
   	test_cmp patch compat &&
   	git grep -h --no-index -A11 \
  diff --git a/t/t4150-am.sh b/t/t4150-am.sh
  index 9a128c16a6..7646e856d5 100755
  --- a/t/t4150-am.sh
  +++ b/t/t4150-am.sh
  @@ -1033,7 +1033,7 @@ test_expect_success 'am --patch-format=mboxrd handles mboxrd' '
   	>From extra escape for reversibility
   	INPUT_END
   	git commit -F msg &&
  -	git format-patch --mboxrd --stdout -1 >mboxrd1 &&
  +	git -c format.mboxrd format-patch --stdout -1 >mboxrd1 &&
   	grep "^>From could trip up a loose mbox parser" mboxrd1 &&
   	git checkout -f first &&
   	git am --patch-format=mboxrd mboxrd1 &&

 Documentation/config/format.txt | 4 ++++
 builtin/log.c                   | 8 ++++++++
 t/t4014-format-patch.sh         | 6 ++++--
 t/t4150-am.sh                   | 2 +-
 4 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/Documentation/config/format.txt b/Documentation/config/format.txt
index c7303d8d9f..3bd78269e2 100644
--- a/Documentation/config/format.txt
+++ b/Documentation/config/format.txt
@@ -139,3 +139,7 @@ For example,
 ------------
 +
 will only show notes from `refs/notes/bar`.
+
+format.mboxrd::
+	A boolean value which enables the robust "mboxrd" format when
+	`--stdout` is in use to escape "^>+From " lines.
diff --git a/builtin/log.c b/builtin/log.c
index 89447a5083..057e299c24 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -52,6 +52,7 @@ static int decoration_style;
 static int decoration_given;
 static int use_mailmap_config = 1;
 static unsigned int force_in_body_from;
+static int stdout_mboxrd;
 static const char *fmt_patch_subject_prefix = "PATCH";
 static int fmt_patch_name_max = FORMAT_PATCH_NAME_MAX_DEFAULT;
 static const char *fmt_pretty;
@@ -1077,6 +1078,10 @@ static int git_format_config(const char *var, const char *value, void *cb)
 		cover_from_description_mode = parse_cover_from_description(value);
 		return 0;
 	}
+	if (!strcmp(var, "format.mboxrd")) {
+		stdout_mboxrd = git_config_bool(var, value);
+		return 0;
+	}
 
 	return git_log_config(var, value, cb);
 }
@@ -2105,6 +2110,9 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 				  rev.diffopt.close_file, "--output",
 				  !!output_directory, "--output-directory");
 
+	if (use_stdout && stdout_mboxrd)
+		rev.commit_format = CMIT_FMT_MBOXRD;
+
 	if (use_stdout) {
 		setup_pager();
 	} else if (!rev.diffopt.close_file) {
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index de1da4673d..012f155e10 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -2281,7 +2281,7 @@ test_expect_success 'format-patch --attach cover-letter only is non-multipart' '
 	test_line_count = 1 output
 '
 
-test_expect_success 'format-patch --pretty=mboxrd' '
+test_expect_success '-c format.mboxrd format-patch' '
 	sp=" " &&
 	cat >msg <<-INPUT_END &&
 	mboxrd should escape the body
@@ -2316,7 +2316,9 @@ test_expect_success 'format-patch --pretty=mboxrd' '
 	INPUT_END
 
 	C=$(git commit-tree HEAD^^{tree} -p HEAD <msg) &&
-	git format-patch --pretty=mboxrd --stdout -1 $C~1..$C >patch &&
+	git -c format.mboxrd format-patch --stdout -1 $C~1..$C >patch &&
+	git format-patch --pretty=mboxrd --stdout -1 $C~1..$C >compat &&
+	test_cmp patch compat &&
 	git grep -h --no-index -A11 \
 		"^>From could trip up a loose mbox parser" patch >actual &&
 	test_cmp expect actual
diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index cdad4b6880..7646e856d5 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -1033,7 +1033,7 @@ test_expect_success 'am --patch-format=mboxrd handles mboxrd' '
 	>From extra escape for reversibility
 	INPUT_END
 	git commit -F msg &&
-	git format-patch --pretty=mboxrd --stdout -1 >mboxrd1 &&
+	git -c format.mboxrd format-patch --stdout -1 >mboxrd1 &&
 	grep "^>From could trip up a loose mbox parser" mboxrd1 &&
 	git checkout -f first &&
 	git am --patch-format=mboxrd mboxrd1 &&
