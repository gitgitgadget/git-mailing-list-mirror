From: Stefan Beller <sbeller@google.com>
Subject: Re: [RFC/PATCH] log: add log.firstparent option
Date: Thu, 23 Jul 2015 15:14:50 -0700
Message-ID: <CAGZ79kbY8hAom+voAOourkDy34nwaACQEM-n=f25Qbg0+ha_8g@mail.gmail.com>
References: <20150723012343.GA21000@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Josh Bleecher Snyder <josharian@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jul 24 00:14:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIOlV-0006yI-N4
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jul 2015 00:14:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753878AbbGWWOx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jul 2015 18:14:53 -0400
Received: from mail-yk0-f174.google.com ([209.85.160.174]:33378 "EHLO
	mail-yk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753716AbbGWWOu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jul 2015 18:14:50 -0400
Received: by ykfw194 with SMTP id w194so5542068ykf.0
        for <git@vger.kernel.org>; Thu, 23 Jul 2015 15:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=7CCtExSR3mFpYztRpyX/5WRvYxROHcxE078Z0ePz9R4=;
        b=YDS/sIDwYEKD5/6LplYunfmwJPdQ9EM9ebaz7E8/lfwwzbkdJq5WdnWYeiobZSV1d5
         BphDWGUcBz4MIlh5a3LzXyHoErW9ZENWPEkP5oAxu83sIsbtqa/g3RfRUU+WBFtDYw2Z
         OJLCN4SLdmfEUK72CDLxucLY87eyBOrIpd80MSjloLbPFCkl96Plh3LvnO0tSpgWUEPh
         pMZLF0JscgbaxxArhO8Yeg+nSLC8f6hSn1VdUl8osDTbJO6nuyI5FCDzTXieKTlKrNen
         ObcB+xDhJLc+sp/ckuiGK22l6qYsqMyuYgqHhhGx/7Re9Swq1Ccay1b1vdeoBBsauYlZ
         3Aag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=7CCtExSR3mFpYztRpyX/5WRvYxROHcxE078Z0ePz9R4=;
        b=FmOMB/9zkiA436Rty559pRusxHTwBGk1nkkKnppgOo94eZnKMbWipkYczWcDXBecMX
         lQJxKXzBMOrc1YrzytY5RI8YDqSjRQymIbpBmJ3Q+PIMXimthk7MWiLp4/fmeJMoRzrq
         3V/liLnE8iCRjVEJFcWYCp46hveHOVQoaIWQhsA/O67c38UjtaBnRcmh5+4pF5WKJmn4
         gKzIJSunipBtkLZLCIjjBmPE1jl91cZix8UUMeKZkcBpC2P08CuQQ52svVuVNfkX9QyX
         2rPX+mnaOE7n2i3PA8nEWipLW5zPEvbAPHC3xKSCqj4At6raBZlOVJvSWn45PSTZI+4/
         j4VQ==
X-Gm-Message-State: ALoCoQlTy+3mOV89/zYs3uPnAqjQGlLfH5JsfHYSJmKvBFFE15BurZlkKEgG2PFWIIq59k1G6g2Z
X-Received: by 10.170.82.131 with SMTP id y125mr11307223yky.115.1437689690115;
 Thu, 23 Jul 2015 15:14:50 -0700 (PDT)
Received: by 10.37.21.129 with HTTP; Thu, 23 Jul 2015 15:14:50 -0700 (PDT)
In-Reply-To: <20150723012343.GA21000@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274530>

On Wed, Jul 22, 2015 at 6:23 PM, Jeff King <peff@peff.net> wrote:
> This patch adds an option to turn on --first-parent all the
> time, along with the corresponding --no-first-parent to
> disable it. The "why" of this requires a bit of backstory.
>
> Some projects (like git.git) encourage frequent rebasing to
> generate a set of clean, bisectable patches for each topic.
> The messy sequence of bug-ridden and bug-fixup commits is
> lost in the rebase, and not part of the final history.
>
> But other projects prefer to keep the messy history intact.
> For one thing, it makes collaboration on a topic easier, as
> developers can simply pull from each other during the messy
> development. And two, that history may later be useful when
> tracking down a bug, because it gives more insight into the
> actual thought process of the developer.
>
> But in this latter case you want _two_ views of history. You
> may want to see the "simple" version in which a series of
> fully-formed topics hit the branch (and you would like to
> see the diff of their final form). Or you may want to see
> the messy details, because you are digging into a bug
> related to the topic.
>
> One proposal we have seen in the past is to keep the messy
> history as a "shadow" parent of the real commits. That is,
> to introduce a new parent-like header into the commit
> object, but not traverse it by default in "git log". So it
> remains hidden until you ask to dig into a particular topic
> (presumably with a "log --show-messy-parents" option or
> similar). So by default you get the simple view, but can dig
> further if you wish.
>
> But we can observe that such shadow parents can be
> implemented as real parents; the problem isn't one of the
> underlying data structure, but how we present it in "git
> log". In other words, a perfectly reasonable workflow is:
>
>   - make your messy commits on a side branch
>
>   - do a non-fast-forward merge to bring them into master.
>     The commit message for this merge should be meaningful
>     and describe the topic as a whole.
>
>   - view the simple history with "git log --first-parent -m"
>
>   - view the complex history with "git log"
>
> But since you probably want to view the simple history most
> of the time, it would be nice to be able to default to that,
> and switch to the more complicated view with a command line
> option. Hence this patch.
>
> Suggested-by: Josh Bleecher Snyder <josharian@gmail.com>
> ---
> This came out of a discussion I had with Josh as OSCON. I
> don't think I would personally use it, because git.git is
> not a messy-workflow project. But I think that GitHub pushes
> people into this sort of workflow (the PR becomes the
> interesting unit of change), and my understanding is that
> Gerrit does, as well.

Github pull request messages
are similar to cover letters, so you could send a series with a
good cover letter, but crappy unfinished patches inside the series.
After applying all patches it could be all nice, i.e. compiles, tests, adds the
new functionality. It might be just a commit in between which may not even
compile. That's my understanding of the messy-workflow.

Gerrit cannot provide such a workflow easily as it's rather commit
centric and not branch centered. So you need to approve each
commit on its own and until 2 weeks ago you even needed to submit
each commit. (By now Gerrit has learned to submit a full branch, that
is you submit a commit and all its ancestors will integrate as well if they
were approved.)
Previously when the ancestors were not approved the commit would be
"submitted, merge pending", so it would wait for each commit to be approved
and submitted.
And because of this commit-centric workflow, the crappy commit in the series
is put into spot light.

Apart from that, the first-parent option gains some traction currently, Compare
https://git.eclipse.org/r/#/c/52381/ for example ;)

>
> There are probably some other things we (and others) could
> do to help support it:
>
>   - currently "--first-parent -p" needs "-m" to show
>     anything useful; this is being discussed elsewhere, and
>     it would be nice if it Just Worked (and showed the diff
>     between the merge and the first-parent)
>
>   - the commit messages for merges are often not great. A
>     few versions ago, I think, we started opening the editor
>     for merges, which is good. GitHub's PR-merge includes
>     the PR subject in the commit message, but not all of the
>     rationale and discussion. And in both git-generated and
>     GitHub-generated messages, the subject isn't amazing
>     (it's "merge topic jk/some-shorthand", which is barely
>     tolerable if you use good branch names; it could be
>     something like the subject-line of the cover letter for
>     the patch series).
>
>     So I think this could easily be improved by GitHub (we
>     have the PR subject and body, after all). It's harder
>     for a mailing list project like git.git, because Git
>     never actually sees the subject line. I think it would
>     require teaching git-am the concept of a patch series.

This would be cool I would imagine.

>
>     I don't know offhand what Gerrit merges look like.

Let's say it's complicated. Depending on configuration a few things
may happen. There are different integration strategies
* merge always
* merge if necessary (fastforward else)
* fastforward only
* rebase if necessary (to make it a linear history)
* cherrypick (which may add footers like Reviewed-by: to have that
information in the git history)

I think the "merge always" strategy would comfort from this patch.

>
>   - we already have merge.ff to default to making extra
>     merge commits. And if you use GitHub's UI to do the
>     merge, it uses --no-ff. I don't think we would want
>     these to become the default, so there's probably nothing
>     else to be done there.
>
> Signed-off-by: Jeff King <peff@peff.net>

The signoff is better placed above :)

> ---
>  Documentation/config.txt |  4 ++++
>  builtin/log.c            |  6 ++++++
>  revision.c               |  2 ++
>  t/t4202-log.sh           | 30 ++++++++++++++++++++++++++++++
>  4 files changed, 42 insertions(+)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 3e37b93..e9c3763 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1802,6 +1802,10 @@ log.mailmap::
>         If true, makes linkgit:git-log[1], linkgit:git-show[1], and
>         linkgit:git-whatchanged[1] assume `--use-mailmap`.
>
> +log.firstparent::
> +       If true, linkgit:git-log[1] will default to `--first-parent`;
> +       can be overridden by supplying `--no-first-parent`.
> +
>  mailinfo.scissors::
>         If true, makes linkgit:git-mailinfo[1] (and therefore
>         linkgit:git-am[1]) act by default as if the --scissors option
> diff --git a/builtin/log.c b/builtin/log.c
> index 8781049..3e9b034 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -31,6 +31,7 @@ static const char *default_date_mode = NULL;
>
>  static int default_abbrev_commit;
>  static int default_show_root = 1;
> +static int default_first_parent;
>  static int decoration_style;
>  static int decoration_given;
>  static int use_mailmap_config;
> @@ -109,6 +110,7 @@ static void cmd_log_init_defaults(struct rev_info *rev)
>         rev->abbrev_commit = default_abbrev_commit;
>         rev->show_root_diff = default_show_root;
>         rev->subject_prefix = fmt_patch_subject_prefix;
> +       rev->first_parent_only = default_first_parent;
>         DIFF_OPT_SET(&rev->diffopt, ALLOW_TEXTCONV);
>
>         if (default_date_mode)
> @@ -396,6 +398,10 @@ static int git_log_config(const char *var, const char *value, void *cb)
>                 use_mailmap_config = git_config_bool(var, value);
>                 return 0;
>         }
> +       if (!strcmp(var, "log.firstparent")) {
> +               default_first_parent = git_config_bool(var, value);
> +               return 0;
> +       }
>
>         if (grep_config(var, value, cb) < 0)
>                 return -1;
> diff --git a/revision.c b/revision.c
> index ab97ffd..a03a84b 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -1760,6 +1760,8 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
>                 return argcount;
>         } else if (!strcmp(arg, "--first-parent")) {
>                 revs->first_parent_only = 1;
> +       } else if (!strcmp(arg, "--no-first-parent")) {
> +               revs->first_parent_only = 0;
>         } else if (!strcmp(arg, "--ancestry-path")) {
>                 revs->ancestry_path = 1;
>                 revs->simplify_history = 0;
> diff --git a/t/t4202-log.sh b/t/t4202-log.sh
> index 1b2e981..de1c35d 100755
> --- a/t/t4202-log.sh
> +++ b/t/t4202-log.sh
> @@ -871,4 +871,34 @@ test_expect_success 'log --graph --no-walk is forbidden' '
>         test_must_fail git log --graph --no-walk
>  '
>
> +test_expect_success 'setup simple merge for first-parent tests' '
> +       git tag fp-base &&
> +       test_commit master &&
> +       git checkout -b fp-side &&
> +       test_commit side &&
> +       git checkout master &&
> +       git merge --no-ff fp-side
> +'
> +
> +test_expect_success 'log.firstparent config turns on first-parent' '
> +       test_config log.firstparent true &&
> +       cat >expect <<-\EOF &&
> +       Merge branch '\''fp-side'\''
> +       master
> +       EOF
> +       git log --format=%s fp-base.. >actual &&
> +       test_cmp expect actual
> +'
> +
> +test_expect_success 'log --no-first-parent override log.firstparent' '
> +       test_config log.firstparent true &&
> +       cat >expect <<-\EOF &&
> +       Merge branch '\''fp-side'\''
> +       side
> +       master
> +       EOF
> +       git log --no-first-parent --format=%s fp-base.. >actual &&
> +       test_cmp expect actual
> +'
> +
>  test_done
> --
> 2.5.0.rc2.540.ge5d4f14
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
