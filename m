Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BBAF2047F
	for <e@80x24.org>; Mon, 24 Jul 2017 06:14:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752477AbdGXGOK convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 24 Jul 2017 02:14:10 -0400
Received: from mx-out.tlen.pl ([193.222.135.148]:40427 "EHLO mx-out.tlen.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752118AbdGXGOI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2017 02:14:08 -0400
Received: (wp-smtpd smtp.tlen.pl 24982 invoked from network); 24 Jul 2017 08:14:02 +0200
Received: from unknown (HELO [192.168.2.102]) (lukaszgryglicki@o2.pl@[85.222.70.18])
          (envelope-sender <lukaszgryglicki@o2.pl>)
          by smtp.tlen.pl (WP-SMTPD) with SMTP
          for <lukaszgryglicki@o2.pl>; 24 Jul 2017 08:14:02 +0200
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v3] merge: add a --signoff flag.
From:   lukaszgryglicki <lukaszgryglicki@o2.pl>
In-Reply-To: <0102015d0cf235f7-9be8e1fc-a926-4e6f-8180-c131da1c4161-000000@eu-west-1.amazonses.com>
Date:   Mon, 24 Jul 2017 08:14:01 +0200
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <FE86ED74-D646-4CA8-B931-26BC12B030CB@o2.pl>
References: <0102015d0c41db74-34ff8613-05e2-44bb-a05b-2624108c36c8-000000@eu-west-1.amazonses.com>
 <0102015d0cf235f7-9be8e1fc-a926-4e6f-8180-c131da1c4161-000000@eu-west-1.amazonses.com>
To:     =?utf-8?Q?=C5=81ukasz_Gryglicki?= <lukaszgryglicki@o2.pl>
X-Mailer: Apple Mail (2.3273)
X-WP-MailID: 2d3ab0184df6eb5c21496647be3d698f
X-WP-AV: skaner antywirusowy Poczty o2
X-WP-SPAM: NO 0000000 [scN0]                               
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, what is the state of this patch?
What else should I do to get it merged into git?
Thanks.

> On 4 Jul 2017, at 11:33, Łukasz Gryglicki <lukaszgryglicki@o2.pl> wrote:
> 
> Some projects require every commit to be signed off.
> Our workflow is to create feature branches and require every commit to
> be signed off. When feature is finally approved we need to merge it into
> master. Merge itself is usually trivial and is done by
> `git merge origin/master`.
> 
> Unfortunatelly `merge` command have no --signoff
> flag, so we need to either add signoff line manually or use
> `git commit --amend -s` after the merge.
> 
> First solution is not ideal because not all developers are familiar with
> exact sign-off syntax. The second solution works, but is obviously tedious.
> 
> This patch adds --signoff support to `git-merge` command.
> It works just like --signoff in `git-commit` command.
> 
> More details can be found here:
> https://public-inbox.org/git/CAHv71zK5SqbwrBFX=a8-DY9H3KT4FEyMgv__p2gZzNr0WUAPUw@mail.gmail.com/T/#u
> 
> Signed-off-by: lukaszgryglicki <lukaszgryglicki@o2.pl>
> ---
> Documentation/git-merge.txt |  8 ++++++
> builtin/merge.c             |  4 +++
> t/t7614-merge-signoff.sh    | 69 +++++++++++++++++++++++++++++++++++++++++++++
> 3 files changed, 81 insertions(+)
> create mode 100755 t/t7614-merge-signoff.sh
> 
> diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
> index 04fdd8cf086db..6b308ab6d0b52 100644
> --- a/Documentation/git-merge.txt
> +++ b/Documentation/git-merge.txt
> @@ -64,6 +64,14 @@ OPTIONS
> -------
> include::merge-options.txt[]
> 
> +--signoff::
> +	Add Signed-off-by line by the committer at the end of the commit
> +	log message.  The meaning of a signoff depends on the project,
> +	but it typically certifies that committer has
> +	the rights to submit this work under the same license and
> +	agrees to a Developer Certificate of Origin
> +	(see http://developercertificate.org/ for more information).
> +
> -S[<keyid>]::
> --gpg-sign[=<keyid>]::
> 	GPG-sign the resulting merge commit. The `keyid` argument is
> diff --git a/builtin/merge.c b/builtin/merge.c
> index 900bafdb45d0b..78c36e9bf353b 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -70,6 +70,7 @@ static int continue_current_merge;
> static int allow_unrelated_histories;
> static int show_progress = -1;
> static int default_to_upstream = 1;
> +static int signoff;
> static const char *sign_commit;
> 
> static struct strategy all_strategy[] = {
> @@ -233,6 +234,7 @@ static struct option builtin_merge_options[] = {
> 	{ OPTION_STRING, 'S', "gpg-sign", &sign_commit, N_("key-id"),
> 	  N_("GPG sign commit"), PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
> 	OPT_BOOL(0, "overwrite-ignore", &overwrite_ignore, N_("update ignored files (default)")),
> +	OPT_BOOL(0, "signoff", &signoff, N_("add Signed-off-by:")),
> 	OPT_END()
> };
> 
> @@ -763,6 +765,8 @@ static void prepare_to_commit(struct commit_list *remoteheads)
> 	strbuf_addch(&msg, '\n');
> 	if (0 < option_edit)
> 		strbuf_commented_addf(&msg, _(merge_editor_comment), comment_line_char);
> +	if (signoff)
> +		append_signoff(&msg, ignore_non_trailer(msg.buf, msg.len), 0);
> 	write_file_buf(git_path_merge_msg(), msg.buf, msg.len);
> 	if (run_commit_hook(0 < option_edit, get_index_file(), "prepare-commit-msg",
> 			    git_path_merge_msg(), "merge", NULL))
> diff --git a/t/t7614-merge-signoff.sh b/t/t7614-merge-signoff.sh
> new file mode 100755
> index 0000000000000..c1b8446f491dc
> --- /dev/null
> +++ b/t/t7614-merge-signoff.sh
> @@ -0,0 +1,69 @@
> +#!/bin/sh
> +
> +test_description='git merge --signoff
> +
> +This test runs git merge --signoff and makes sure that it works.
> +'
> +
> +. ./test-lib.sh
> +
> +# Setup test files
> +test_setup() {
> +	# Expected commit message after merge --signoff
> +	cat >expected-signed <<EOF &&
> +Merge branch 'master' into other-branch
> +
> +Signed-off-by: $(git var GIT_COMMITTER_IDENT | sed -e "s/>.*/>/")
> +EOF
> +
> +	# Expected commit message after merge without --signoff (or with --no-signoff)
> +	cat >expected-unsigned <<EOF &&
> +Merge branch 'master' into other-branch
> +EOF
> +
> +	# Initial commit and feature branch to merge master into it.
> +	git commit --allow-empty -m "Initial empty commit" &&
> +	git checkout -b other-branch &&
> +	test_commit other-branch file1 1
> +}
> +
> +# Setup repository, files & feature branch
> +# This step must be run if You want to test 2,3 or 4
> +# Order of 2,3,4 is not important, but 1 must be run before
> +# For example `-r 1,4` or `-r 1,4,2 -v` etc
> +# But not `-r 2` or `-r 4,3,2,1`
> +test_expect_success 'setup' '
> +	test_setup
> +'
> +
> +# Test with --signoff flag
> +test_expect_success 'git merge --signoff adds a sign-off line' '
> +	git checkout master &&
> +	test_commit master-branch-2 file2 2 &&
> +	git checkout other-branch &&
> +	git merge master --signoff --no-edit &&
> +	git cat-file commit HEAD | sed -e "1,/^\$/d" >actual &&
> +	test_cmp expected-signed actual
> +'
> +
> +# Test without --signoff flag
> +test_expect_success 'git merge does not add a sign-off line' '
> +	git checkout master &&
> +	test_commit master-branch-3 file3 3 &&
> +	git checkout other-branch &&
> +	git merge master --no-edit &&
> +	git cat-file commit HEAD | sed -e "1,/^\$/d" >actual &&
> +	test_cmp expected-unsigned actual
> +'
> +
> +# Test for --no-signoff flag
> +test_expect_success 'git merge --no-signoff flag cancels --signoff flag' '
> +	git checkout master &&
> +	test_commit master-branch-4 file4 4 &&
> +	git checkout other-branch &&
> +	git merge master --no-edit --signoff --no-signoff &&
> +	git cat-file commit HEAD | sed -e "1,/^\$/d" >actual &&
> +	test_cmp expected-unsigned actual
> +'
> +
> +test_done
> 
> --
> https://github.com/git/git/pull/383
> 

