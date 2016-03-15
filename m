From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH v7] commit: add a commit.verbose config variable
Date: Tue, 15 Mar 2016 12:31:26 +0100
Message-ID: <1458041486-7044-1-git-send-email-szeder@ira.uka.de>
References: <010201537710be08-f31428b3-5df3-4694-8c4a-0e8f058131b3-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 15 12:31:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afnCb-0003Kg-FA
	for gcvg-git-2@plane.gmane.org; Tue, 15 Mar 2016 12:31:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932452AbcCOLbs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2016 07:31:48 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:59256 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752925AbcCOLbr (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Mar 2016 07:31:47 -0400
Received: from x4db11d33.dyn.telefonica.de ([77.177.29.51] helo=localhost.localdomain)
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 587 
	iface 141.3.10.81 id 1afnCN-0006jg-BX; Tue, 15 Mar 2016 12:31:45 +0100
X-Mailer: git-send-email 2.8.0.rc2.45.g196ad62
In-Reply-To: <010201537710be08-f31428b3-5df3-4694-8c4a-0e8f058131b3-000000@eu-west-1.amazonses.com>
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1458041505.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288847>

> Add commit.verbose configuration variable as a convenience for those
> who always prefer --verbose.
> 
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
> 
> ---
> The previous versions of this patch are:
>  - [v6] $gmane/288811
>  - [v5] $gmane/288728
>  - [v4] $gmane/288652
>  - [v3] $gmane/288634
>  - [v2] $gmane/288569
>  - [v1] $gmane/287540
> 
> The changes with respect to the last version are :
>  - Add '-c commit.verbose true'
> 
> It is a mistake on my part. I was a bit sleepy.
> ---
>  Documentation/config.txt     |  4 ++++
>  Documentation/git-commit.txt |  3 ++-
>  builtin/commit.c             |  4 ++++
>  t/t7507-commit-verbose.sh    | 29 +++++++++++++++++++++++++++++
>  4 files changed, 39 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 01cca0a..9b93f6c 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1110,6 +1110,10 @@ commit.template::
>  	"`~/`" is expanded to the value of `$HOME` and "`~user/`" to the
>  	specified user's home directory.
>  
> +commit.verbose::
> +	A boolean to specify whether to always include the verbose option
> +	with `git commit`. See linkgit:git-commit[1].
> +

You made 'commit.verbose' a boolean, so either verbose or not, ...

>  credential.helper::
>  	Specify an external helper to be called when a username or
>  	password credential is needed; the helper may consult external
> diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
> index 9ec6b3c..d474226 100644
> --- a/Documentation/git-commit.txt
> +++ b/Documentation/git-commit.txt
> @@ -290,7 +290,8 @@ configuration variable documented in linkgit:git-config[1].
>  	what changes the commit has.
>  	Note that this diff output doesn't have its
>  	lines prefixed with '#'. This diff will not be a part
> -	of the commit message.
> +	of the commit message. See the `commit.verbose` configuration
> +	variable in linkgit:git-config[1].
>  +
>  If specified twice, show in addition the unified diff between
>  what would be committed and the worktree files, i.e. the unstaged

... but note these context lines telling us that --verbose can be
specified not just once but twice (and who knows what the future may
bring).  This raises some not entirely rhetorical questions:

  - What does 'git config commit.verbose true && git commit --verbose'
    do?

  - Should 'commit.verbose' only care about the convenience of those
    who always prever '--verbose', or about those who like '-v -v',
    too?

  - If the latter, i.e. 'commit.verbose' should cater for '-v -v' as
    well, then what should 'git config commit.verbose "<verbose level
    two>" && git commit --verbose' do?

> diff --git a/builtin/commit.c b/builtin/commit.c
> index b3bd2d4..e0b96231 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1505,6 +1505,10 @@ static int git_commit_config(const char *k, const char *v, void *cb)
>  		sign_commit = git_config_bool(k, v) ? "" : NULL;
>  		return 0;
>  	}
> +	if (!strcmp(k, "commit.verbose")) {
> +		verbose = git_config_bool(k, v);
> +		return 0;
> +	}
>  
>  	status = git_gpg_config(k, v, NULL);
>  	if (status)
> diff --git a/t/t7507-commit-verbose.sh b/t/t7507-commit-verbose.sh
> index 2ddf28c..5320f1e 100755
> --- a/t/t7507-commit-verbose.sh
> +++ b/t/t7507-commit-verbose.sh
> @@ -96,4 +96,33 @@ test_expect_success 'verbose diff is stripped out with set core.commentChar' '
>  	test_i18ngrep "Aborting commit due to empty commit message." err
>  '
>  
> +test_expect_success 'commit.verbose true and --verbose omitted' '
> +	git -c commit.verbose=true commit --amend
> +'
> +
> +test_expect_success 'commit.verbose true and --no-verbose' '
> +	test_must_fail git -c commit.verbose=true commit --amend --no-verbose
> +'
> +
> +test_expect_success 'commit.verbose false and --verbose' '
> +	git -c commit.verbose=false commit --amend --verbose
> +'
> +
> +test_expect_success 'commit.verbose false and --verbose omitted' '
> +	test_must_fail git -c commit.verbose=false commit --amend
> +'
> +
> +test_expect_success 'commit.verbose true and --verbose' '
> +	git -c commit.verbose=true commit --amend --verbose
> +'
> +
> +test_expect_success 'commit.verbose false and --no-verbose' '
> +	test_must_fail git -c commit.verbose=false commit --amend --no-verbose
> +'
> +
> +test_expect_success 'status ignores commit.verbose=true' '
> +	git -c commit.verbose=true status >actual &&
> +	! grep "^diff --git" actual
> +'
> +
>  test_done
> 
> --
> https://github.com/git/git/pull/205
