From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <l.s.r@web.de>
Subject: Re: [PATCH v4 4/4] commit: support commit.verbose and --no-verbose
Date: Wed, 11 Jun 2014 22:41:02 +0200
Message-ID: <5398BEDE.1040305@web.de>
References: <1402511079-17735-1-git-send-email-caleb@calebthompson.io> <1402511079-17735-5-git-send-email-caleb@calebthompson.io>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Jeremiah Mahler <jmmahler@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	David Kastrup <dak@gnu.org>, Junio C Hamano <gitster@pobox.com>
To: caleb@calebthompson.io, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 11 22:41:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WupLK-0001p4-8a
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jun 2014 22:41:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754037AbaFKUly (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2014 16:41:54 -0400
Received: from mout.web.de ([212.227.17.12]:52712 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751220AbaFKUlx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2014 16:41:53 -0400
Received: from [192.168.178.27] ([79.253.162.202]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0M9XUJ-1X3Iqc1ptP-00CvgC; Wed, 11 Jun 2014 22:41:21
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <1402511079-17735-5-git-send-email-caleb@calebthompson.io>
X-Provags-ID: V03:K0:R07WLAMDS74E4iVqDQglCd4Ha/v4p2QjMDaUiLJbMKdiSxJ2tE5
 D/++Kny6JYnOWwjhUq1SndNrHbWFwG+9VlaBNQz6lxX55Yj2W9LVCvOt5CdEp4ZSV76sdb5
 dytBogYoN51xKAT6H1cX0WfjbHydVeFr+ieb1s+0rYBBkV3T10AmnwLbOkwu1n1N718TqSG
 V7pAd2bNv+/bqFftuhmWQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251385>

Am 11.06.2014 20:24, schrieb caleb@calebthompson.io:
> Add a new configuration variable commit.verbose to implicitly pass
> `--verbose` to `git-commit`. Add `--no-verbose` to commit to negate that
> setting.
>
> Signed-off-by: Caleb Thompson<caleb@calebthompson.io>
> ---
>   Documentation/config.txt               |  5 +++++
>   Documentation/git-commit.txt           |  8 +++++++-
>   builtin/commit.c                       |  6 +++++-
>   contrib/completion/git-completion.bash |  1 +
>   t/t7507-commit-verbose.sh              | 36 ++++++++++++++++++++++++++++++++++
>   5 files changed, 54 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index cd2d651..ec51e1c 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1017,6 +1017,11 @@ commit.template::
> 	"`~/`" is expanded to the value of `$HOME` and "`~user/`" to the
> 	specified user's home directory.
>
> +commit.verbose::
> +	A boolean to enable/disable inclusion of diff information in the
> +	commit message template when using an editor to prepare the commit
> +	message.  Defaults to false.
> +
>   credential.helper::
> 	Specify an external helper to be called when a username or
> 	password credential is needed; the helper may consult external
> diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
> index 0bbc8f5..8cb3439 100644
> --- a/Documentation/git-commit.txt
> +++ b/Documentation/git-commit.txt
> @@ -282,7 +282,13 @@ configuration variable documented in linkgit:git-config[1].
> 	Show unified diff between the HEAD commit and what
> 	would be committed at the bottom of the commit message
> 	template.  Note that this diff output doesn't have its
> -	lines prefixed with '#'.
> +	lines prefixed with '#'.  The `commit.verbose` configuration
> +	variable can be set to true to implicitly send this option.
> +
> +--no-verbose::
> +	Do not show the unified diff at the bottom of the commit message
> +	template.  This is the default behavior, but can be used to override
> +	the `commit.verbose` configuration variable.
>
>   -q::
>   --quiet::
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 99c2044..c5b20c6 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1489,6 +1489,10 @@ static int git_commit_config(const char *k, const char *v, void *cb)
> 		sign_commit = git_config_bool(k, v) ? "" : NULL;
> 		return 0;
> 	}
> +	if (!strcmp(k, "commit.verbose")) {
> +		verbose = git_config_bool(k, v);
> +		return 0;
> +	}
>
> 	status = git_gpg_config(k, v, NULL);
> 	if (status)

> @@ -1556,7 +1560,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
> 	static struct wt_status s;
> 	static struct option builtin_commit_options[] = {
> 		OPT__QUIET(&quiet, N_("suppress summary after successful commit")),
> -		OPT__VERBOSE(&verbose, N_("show diff in commit message template")),
> +		OPT_BOOL('v', "verbose", &verbose, N_("show diff in commit message template")),

Hmm, this hunk seems to make sure that there can only be two verbosity 
levels, 0 and 1, while before there could be higher levels (which 
produce the same output as verbose = 1).  This change is not mentioned 
in the commit message.  Why is it necessary?

NB: --no-verbose already works without this hunk.

> 		OPT_GROUP(N_("Commit message options")),
> 		OPT_FILENAME('F', "file", &logfile, N_("read message from file")),
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 2c59a76..b8f4b94 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1976,6 +1976,7 @@ _git_config ()
> 		color.ui
> 		commit.status
> 		commit.template
> +		commit.verbose
> 		core.abbrev
> 		core.askpass
> 		core.attributesfile
> diff --git a/t/t7507-commit-verbose.sh b/t/t7507-commit-verbose.sh
> index 35a4d06..512eef3 100755
> --- a/t/t7507-commit-verbose.sh
> +++ b/t/t7507-commit-verbose.sh
> @@ -7,6 +7,10 @@ write_script check-for-diff <<-'EOF'
> 	exec grep '^diff --git' "$1"
>   EOF
>
> +write_script check-for-no-diff <<-EOF
> +	exec grep -v '^diff --git' "\$1"
> +EOF
> +
>   cat >message <<'EOF'
>   subject
>
> @@ -48,6 +52,38 @@ test_expect_success 'verbose diff is stripped out (mnemonicprefix)' '
> 	check_message message
>   '
>
> +test_expect_success 'commit shows verbose diff with commit.verbose true' '
> +	echo morecontent >>file &&
> +	git add file &&
> +	test_config commit.verbose true &&
> +	test_set_editor "$PWD/check-for-diff" &&
> +	git commit --amend
> +'
> +
> +test_expect_success 'commit --verbose overrides commit.verbose false' '
> +	echo evenmorecontent >>file &&
> +	git add file &&
> +	test_config commit.verbose false  &&
> +	test_set_editor "$PWD/check-for-diff" &&
> +	git commit --amend --verbose
> +'
> +
> +test_expect_success 'commit does not show verbose diff with commit.verbose false' '
> +	echo evenmorecontent >>file &&
> +	git add file &&
> +	test_config commit.verbose false &&
> +	test_set_editor "$PWD/check-for-no-diff" &&
> +	git commit --amend
> +'
> +
> +test_expect_success 'commit --no-verbose overrides commit.verbose true' '
> +	echo evenmorecontent >>file &&
> +	git add file &&
> +	test_config commit.verbose true &&
> +	test_set_editor "$PWD/check-for-no-diff" &&
> +	git commit --amend --no-verbose
> +'
> +
>   cat >diff <<'EOF'
>   This is an example commit message that contains a diff.
>
> --
> 2.0.0
>
