Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5744CC4332F
	for <git@archiver.kernel.org>; Mon, 14 Nov 2022 20:59:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236662AbiKNU7M (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Nov 2022 15:59:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236156AbiKNU7K (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Nov 2022 15:59:10 -0500
Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB9C167F1
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 12:59:09 -0800 (PST)
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 7A9C91F910;
        Mon, 14 Nov 2022 20:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
        s=selector1; t=1668459549;
        bh=9DYZlfwuvDdqT9l73ChfRudmMFhTFytPrNFL3aN6LQU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Sop+hH0qGKsH9YGfZZoutH2Ph4xcDt9rmzreFSDNByqh7s//d5Iq+LL59GjxWWZHX
         vuDVQLtvvr9D5Uzdan3lIqd/4tSgFUS5Beb3k6CDANrZmt7sRJwyGDRMgo7NhS3m+N
         t4YzyvT0kS5+TIVg0RIf3fXyajJLPq5zigyO0K0A=
Date:   Mon, 14 Nov 2022 20:59:09 +0000
From:   Eric Wong <e@80x24.org>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] format-patch: add --mboxrd alias for --pretty=mboxrd
Message-ID: <20221114205909.GA14736@dcvr>
References: <20221114094114.18986-1-e@80x24.org>
 <221114.86leodlbix.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <221114.86leodlbix.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> On Mon, Nov 14 2022, Eric Wong wrote:
> 
> > mboxrd is a superior output format when used with --stdout and
> > needs more exposure.  Including pretty-formats.txt would be
> > excessive, since documenting --pretty= for `git format-patch'
> > would likely be confusing to users.
> >
> > Instead of documenting --pretty, add an --mboxrd alias to save
> > keystrokes and improve documentation.
> >
> > Signed-off-by: Eric Wong <e@80x24.org>
> > ---
> >  Also, --mboxrd without --stdout makes no sense to me,
> >  so I'm considering warning on it...
> >
> >  Side note: some of the OPT_* switches might be misplaced
> >  under the "Messaging" OPT_GROUP...
> 
> Makes sense, but....
> 
> > +--mboxrd::
> > +	Use the robust "mboxrd" format with `--stdout` to escape
> > +	"^>+From " lines.
> > +
> 
> ...Rather than repeat ourselves, shouldn't we (or in addition to this)
> link to a manpage that discusses the --pretty=* formats. I was going to
> say that you can also use the "ifdef" asciidoc syntax, but for one
> paragraph that's probably overkill...

As I noted in the commit message, I think discussing --pretty=*
in the context of format-patch would be confusing for users.

> >  --attach[=<boundary>]::
> >  	Create multipart/mixed attachment, the first part of
> >  	which is the commit message and the patch itself in the
> > diff --git a/builtin/log.c b/builtin/log.c
> > index 5eafcf26b49b..13f5deb7a5c0 100644
> > --- a/builtin/log.c
> > +++ b/builtin/log.c
> > @@ -1872,6 +1872,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
> >  	struct strbuf rdiff2 = STRBUF_INIT;
> >  	struct strbuf rdiff_title = STRBUF_INIT;
> >  	int creation_factor = -1;
> > +	int mboxrd = 0;
> >  
> >  	const struct option builtin_format_patch_options[] = {
> >  		OPT_CALLBACK_F('n', "numbered", &numbered, NULL,
> > @@ -1883,6 +1884,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
> >  		OPT_BOOL('s', "signoff", &do_signoff, N_("add a Signed-off-by trailer")),
> >  		OPT_BOOL(0, "stdout", &use_stdout,
> >  			    N_("print patches to standard out")),
> > +		OPT_BOOL(0, "mboxrd", &mboxrd,
> > +			    N_("use the robust mboxrd format with --stdout")),
> >  		OPT_BOOL(0, "cover-letter", &cover_letter,
> >  			    N_("generate a cover letter")),
> >  		OPT_BOOL(0, "numbered-files", &just_numbers,
> > @@ -2106,6 +2109,10 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
> >  				  rev.diffopt.close_file, "--output",
> >  				  !!output_directory, "--output-directory");
> >  
> > +	/* should we warn on --mboxrd w/o --stdout? */
> 
> Does that go for --pretty=mboxrd too?

Again, I prefer to mention --pretty= as little as possible
when it comes to format-patch

> > +	if (mboxrd)
> > +		rev.commit_format = CMIT_FMT_MBOXRD;
> > +

It could be something like this:

	if (rev.commit_format == CMIT_FMT_MBOXRD && !use_stdout)
		warning("mboxrd without --stdout makes no sense\n");

But I'm on the fence about the warning.

> >  	if (use_stdout) {
> >  		setup_pager();
> >  	} else if (!rev.diffopt.close_file) {
> > diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> > index ba5c395d2d80..f6e2fbdcfa68 100644
> > --- a/contrib/completion/git-completion.bash
> > +++ b/contrib/completion/git-completion.bash
> > @@ -1815,7 +1815,7 @@ _git_fetch ()
> >  
> >  __git_format_patch_extra_options="
> >  	--full-index --not --all --no-prefix --src-prefix=
> > -	--dst-prefix= --notes
> > +	--dst-prefix= --notes --mboxrd
> >  "
> >  
> >  _git_format_patch ()
> > diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
> > index de1da4673da9..69ed8b1ffaa1 100755
> > --- a/t/t4014-format-patch.sh
> > +++ b/t/t4014-format-patch.sh
> > @@ -2281,7 +2281,7 @@ test_expect_success 'format-patch --attach cover-letter only is non-multipart' '
> >  	test_line_count = 1 output
> >  '
> >  
> > -test_expect_success 'format-patch --pretty=mboxrd' '
> > +test_expect_success 'format-patch --mboxrd' '
> >  	sp=" " &&
> >  	cat >msg <<-INPUT_END &&
> >  	mboxrd should escape the body
> > @@ -2316,7 +2316,9 @@ test_expect_success 'format-patch --pretty=mboxrd' '
> >  	INPUT_END
> >  
> >  	C=$(git commit-tree HEAD^^{tree} -p HEAD <msg) &&
> > -	git format-patch --pretty=mboxrd --stdout -1 $C~1..$C >patch &&
> > +	git format-patch --mboxrd --stdout -1 $C~1..$C >patch &&
> > +	git format-patch --pretty=mboxrd --stdout -1 $C~1..$C >compat &&
> > +	test_cmp patch compat &&
> >  	git grep -h --no-index -A11 \
> >  		"^>From could trip up a loose mbox parser" patch >actual &&
> >  	test_cmp expect actual
> > diff --git a/t/t4150-am.sh b/t/t4150-am.sh
> > index cdad4b688078..9a128c16a6ee 100755
> > --- a/t/t4150-am.sh
> > +++ b/t/t4150-am.sh
> > @@ -1033,7 +1033,7 @@ test_expect_success 'am --patch-format=mboxrd handles mboxrd' '
> >  	>From extra escape for reversibility
> >  	INPUT_END
> >  	git commit -F msg &&
> > -	git format-patch --pretty=mboxrd --stdout -1 >mboxrd1 &&
> > +	git format-patch --mboxrd --stdout -1 >mboxrd1 &&
> >  	grep "^>From could trip up a loose mbox parser" mboxrd1 &&
> >  	git checkout -f first &&
> >  	git am --patch-format=mboxrd mboxrd1 &&
> 
> Doesn't this leave us without coverage for the --pretty=mboxrd variant?

These two lines were added to t/t4014-format-patch.sh above to
test --pretty=mboxrd:

+	git format-patch --pretty=mboxrd --stdout -1 $C~1..$C >compat &&
+	test_cmp patch compat &&

> I must admit I'm not a big outright fan of this, the "log-like" is
> confusing enough, with those accepting some options, ignoring others
> etc, now we're adding command-specific aliases too...
> 
> Why not just document that we accept --pretty=<some subset>? E.g. see
> "range-diff"'s docs for an existing case where we discuss accepting a
> limited subset.

Again, I think discussing --pretty= is confusing to users
if they might end up using raw/full/fuller/etc
(especially if they're relying on tab completion).

I that was the reason --pretty= was never documented in the
format-patch manpage (which I had nothing to do with).

Which section of the range-diff man page are you referring to?
