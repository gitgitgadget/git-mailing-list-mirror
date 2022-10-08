Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A09C433FE
	for <git@archiver.kernel.org>; Sat,  8 Oct 2022 12:28:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbiJHM22 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Oct 2022 08:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiJHM21 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Oct 2022 08:28:27 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 388754D15B
        for <git@vger.kernel.org>; Sat,  8 Oct 2022 05:28:25 -0700 (PDT)
Received: from 88-110-102-84.dynamic.dsl.as9105.com ([88.110.102.84] helo=[192.168.1.57])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1oh8wH-0006Z6-8J;
        Sat, 08 Oct 2022 13:28:22 +0100
Message-ID: <86355292-cb54-32c8-abf5-542fb4cf9ade@iee.email>
Date:   Sat, 8 Oct 2022 13:28:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2] symbolic-ref: teach "--[no-]recurse" option
Content-Language: en-GB
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>
References: <xmqqleprcn08.fsf@gitster.g> <xmqqsfjzaq78.fsf@gitster.g>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <xmqqsfjzaq78.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

On 08/10/2022 05:34, Junio C Hamano wrote:
> Suppose you are managing many maintenance tracks in your project,
> and some of the more recent ones are maint-2.36 and maint-2.37.
> Further imagine that your project recently tagged the official 2.38
> release, which means you would need to start maint-2.38 track soon,
> by doing:
>
>   $ git checkout -b maint-2.38 v2.38.0^0
>   $ git branch --list 'maint-2.3[6-9]'
>   * maint-2.38
>     maint-2.36
>     maint-2.37
>
> So far, so good.  But it also is reasonable to want not to have to
> worry about which maintenance track is the latest, by pointing a
> more generic-sounding 'maint' branch at it, by doing:
>
>   $ git symbolic-ref refs/heads/maint refs/heads/maint-2.38
>
> which would allow you to say "whichever it is, check out the latest
> maintenance track", by doing:
>
>   $ git checkout maint
>   $ git branch --show-current
>   maint-2.38
>
> It is arguably better to say that we are on 'maint-2.38' rather than
> on 'maint', and "git merge/pull" would record "into maint-2.38" and
> not "into maint", so I think what we have is a good behaviour.
>
> One thing that is slightly irritating, however, is that I do not
> think there is a good way (other than "cat .git/HEAD") to learn that
> you checked out 'maint' to get into that state.  Just like the output
> of "git branch --show-current" shows above, "git symbolic-ref HEAD"
> would report 'refs/heads/maint-2.38', bypassing the intermediate
> symbolic ref at 'refs/heads/maint' that is pointed at by HEAD.
>
> The internal resolve_ref() API already has the necessary support for
> stopping after resolving a single level of a symbolic-ref, and we
> can expose it by adding a "--[no-]recurse" option to the command.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>
>  * Updates documentation, which was entirely lacking in v1, with no
>    other changes.
>
>  Documentation/git-symbolic-ref.txt |  9 +++++++++

Is there also a need to update SubmittingPatches to clarify the
distinctions between the generic name 'maint', the specific `maint-xx`
branches, and the symbolic ref linkages from `maint`.

The existence of the `maint-xx` branches, and where they came from, was
something that eluded me for a long time.

The descriptions give the impression there is just a single main branch,
with a singular name, and that was the end of it. It was only much later
when some security patches were pushed down to numerous older `maint-xx`
branches. The use of the singular `maint` is also used in examples a
number of places further cementing the singular maintenance view.

A few words clarifying the `maint` vs `maint-x.yy` branches could help
users past the confusion.
--
Philip

>  builtin/symbolic-ref.c             | 16 ++++++++++------
>  t/t1401-symbolic-ref.sh            | 14 ++++++++++++++
>  3 files changed, 33 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/git-symbolic-ref.txt b/Documentation/git-symbolic-ref.txt
> index ef68ad2b71..3b5a97ea2b 100644
> --- a/Documentation/git-symbolic-ref.txt
> +++ b/Documentation/git-symbolic-ref.txt
> @@ -46,6 +46,15 @@ OPTIONS
>  	When showing the value of <name> as a symbolic ref, try to shorten the
>  	value, e.g. from `refs/heads/master` to `master`.
>  
> +--recurse::
> +--no-recurse::
> +	When showing the value of <name> as a symbolic ref, if
> +	<name> refers to another symbolic ref, follow such a chain
> +	of symbolic refs until the result no longer points at a
> +	symbolic ref (`--recurse`, which is the default).
> +	`--no-recurse` stops after dereferencing only a single level
> +	of symbolic ref.
> +
>  -m::
>  	Update the reflog for <name> with <reason>.  This is valid only
>  	when creating or updating a symbolic ref.
> diff --git a/builtin/symbolic-ref.c b/builtin/symbolic-ref.c
> index e547a08d6c..1af27b3a68 100644
> --- a/builtin/symbolic-ref.c
> +++ b/builtin/symbolic-ref.c
> @@ -10,10 +10,13 @@ static const char * const git_symbolic_ref_usage[] = {
>  	NULL
>  };
>  
> -static int check_symref(const char *HEAD, int quiet, int shorten, int print)
> +static int check_symref(const char *HEAD, int quiet, int shorten, int recurse, int print)
>  {
> -	int flag;
> -	const char *refname = resolve_ref_unsafe(HEAD, 0, NULL, &flag);
> +	int resolve_flags, flag;
> +	const char *refname;
> +
> +	resolve_flags = (recurse ? 0 : RESOLVE_REF_NO_RECURSE);
> +	refname = resolve_ref_unsafe(HEAD, resolve_flags, NULL, &flag);
>  
>  	if (!refname)
>  		die("No such ref: %s", HEAD);
> @@ -35,13 +38,14 @@ static int check_symref(const char *HEAD, int quiet, int shorten, int print)
>  
>  int cmd_symbolic_ref(int argc, const char **argv, const char *prefix)
>  {
> -	int quiet = 0, delete = 0, shorten = 0, ret = 0;
> +	int quiet = 0, delete = 0, shorten = 0, recurse = 1, ret = 0;
>  	const char *msg = NULL;
>  	struct option options[] = {
>  		OPT__QUIET(&quiet,
>  			N_("suppress error message for non-symbolic (detached) refs")),
>  		OPT_BOOL('d', "delete", &delete, N_("delete symbolic ref")),
>  		OPT_BOOL(0, "short", &shorten, N_("shorten ref output")),
> +		OPT_BOOL(0, "recurse", &recurse, N_("recursively dereference (default)")),
>  		OPT_STRING('m', NULL, &msg, N_("reason"), N_("reason of the update")),
>  		OPT_END(),
>  	};
> @@ -55,7 +59,7 @@ int cmd_symbolic_ref(int argc, const char **argv, const char *prefix)
>  	if (delete) {
>  		if (argc != 1)
>  			usage_with_options(git_symbolic_ref_usage, options);
> -		ret = check_symref(argv[0], 1, 0, 0);
> +		ret = check_symref(argv[0], 1, 0, 0, 0);
>  		if (ret)
>  			die("Cannot delete %s, not a symbolic ref", argv[0]);
>  		if (!strcmp(argv[0], "HEAD"))
> @@ -65,7 +69,7 @@ int cmd_symbolic_ref(int argc, const char **argv, const char *prefix)
>  
>  	switch (argc) {
>  	case 1:
> -		ret = check_symref(argv[0], quiet, shorten, 1);
> +		ret = check_symref(argv[0], quiet, shorten, recurse, 1);
>  		break;
>  	case 2:
>  		if (!strcmp(argv[0], "HEAD") &&
> diff --git a/t/t1401-symbolic-ref.sh b/t/t1401-symbolic-ref.sh
> index 132a1b885a..773a6e8e01 100755
> --- a/t/t1401-symbolic-ref.sh
> +++ b/t/t1401-symbolic-ref.sh
> @@ -163,4 +163,18 @@ test_expect_success 'symbolic-ref can resolve d/f name (ENOTDIR)' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'symbolic-ref pointing at another' '
> +	git update-ref refs/heads/maint-2.37 HEAD &&
> +	git symbolic-ref refs/heads/maint refs/heads/maint-2.37 &&
> +	git checkout maint &&
> +
> +	git symbolic-ref HEAD >actual &&
> +	echo refs/heads/maint-2.37 >expect &&
> +	test_cmp expect actual &&
> +
> +	git symbolic-ref --no-recurse HEAD >actual &&
> +	echo refs/heads/maint >expect &&
> +	test_cmp expect actual
> +'
> +
>  test_done

