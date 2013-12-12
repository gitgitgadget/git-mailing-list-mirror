From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 2/2] diff: don't read index when --no-index is given
Date: Thu, 12 Dec 2013 12:25:23 -0800
Message-ID: <xmqqwqj9stos.fsf@gitster.dls.corp.google.com>
References: <20131210181655.GB2311@google.com>
	<1386755923-22132-1-git-send-email-t.gummerer@gmail.com>
	<1386755923-22132-2-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 12 21:25:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VrCpA-0003ef-I8
	for gcvg-git-2@plane.gmane.org; Thu, 12 Dec 2013 21:25:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751924Ab3LLUZ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Dec 2013 15:25:28 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62412 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751585Ab3LLUZ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Dec 2013 15:25:27 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C36AD580C5;
	Thu, 12 Dec 2013 15:25:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eX3FfvDlCwbq26g6vRcjXVcPtDI=; b=BZ6sS4
	eIRzohRL42kGFQMm+RZL3fhzjDXg5ED+fcEMsyvI+tkMV+OF/KjSjuP7FSl1cEpt
	QEqi6qPo5NEaRKiPa0beCiNrUMIsRn+hkAeQE+hQyI+VYeG/OxLRNp9VBnoEKAoQ
	NccydTqrG+xNDr68uRbZGnFBB6GRVc/RPy43w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VPAcQib0FL7rCM/uwUe75MbcgmHUrUJQ
	k7iJuMIB3Eq5HUQzBQcHZorPGmakKCoeN6S7FMfl4qYLIbLijEsa250AVVacForJ
	0IQ4P269vAcwp7CV2cCEsxSJd5eAZ8mp6BiZmju40T66o52y69xPcs0rYfBP/cBw
	7BmZN9kOebc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AD950580C4;
	Thu, 12 Dec 2013 15:25:26 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B4E77580C0;
	Thu, 12 Dec 2013 15:25:25 -0500 (EST)
In-Reply-To: <1386755923-22132-2-git-send-email-t.gummerer@gmail.com> (Thomas
	Gummerer's message of "Wed, 11 Dec 2013 10:58:43 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 88C15548-636B-11E3-8E82-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239244>

Thomas Gummerer <t.gummerer@gmail.com> writes:

> git diff --no-index ... currently reads the index, during setup, when
> calling gitmodules_config().  This results in worse performance when the
> index is not actually needed.  This patch avoids calling
> gitmodules_config() when the --no-index option is given.  The times for
> executing "git diff --no-index" in the WebKit repository are improved as
> follows:
>
> Test                      HEAD~3            HEAD
> ------------------------------------------------------------------
> 4001.1: diff --no-index   0.24(0.15+0.09)   0.01(0.00+0.00) -95.8%
>
> An additional improvement of this patch is that "git diff --no-index" no
> longer breaks when the index file is corrupt, which makes it possible to
> use it for investigating the broken repository.
>
> To improve the possible usage as investigation tool for broken
> repositories, setup_git_directory_gently() is also not called when the
> --no-index option is given.
>
> Also add a test to guard against future breakages, and a performance
> test to show the improvements.
>
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---

Looks reasonable.

Thanks.  Will queue.

>  builtin/diff.c                |  7 +++++--
>  t/perf/p4001-diff-no-index.sh | 22 ++++++++++++++++++++++
>  t/t4053-diff-no-index.sh      | 15 +++++++++++++++
>  3 files changed, 42 insertions(+), 2 deletions(-)
>  create mode 100755 t/perf/p4001-diff-no-index.sh
>
> diff --git a/builtin/diff.c b/builtin/diff.c
> index da69e4a..ea1dd65 100644
> --- a/builtin/diff.c
> +++ b/builtin/diff.c
> @@ -298,7 +298,9 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
>  			break;
>  	}
>  
> -	prefix = setup_git_directory_gently(&nongit);
> +	if (!no_index)
> +		prefix = setup_git_directory_gently(&nongit);
> +
>  	/*
>  	 * Treat git diff with at least one path outside of the
>  	 * repo the same as if the command would have been executed
> @@ -311,7 +313,8 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
>  			!path_inside_repo(prefix, argv[i + 1]))))
>  		no_index = DIFF_NO_INDEX_IMPLICIT;
>  
> -	gitmodules_config();
> +	if (!no_index)
> +		gitmodules_config();
>  	git_config(git_diff_ui_config, NULL);
>  
>  	init_revisions(&rev, prefix);
> diff --git a/t/perf/p4001-diff-no-index.sh b/t/perf/p4001-diff-no-index.sh
> new file mode 100755
> index 0000000..683be69
> --- /dev/null
> +++ b/t/perf/p4001-diff-no-index.sh
> @@ -0,0 +1,22 @@
> +#!/bin/sh
> +
> +test_description="Test diff --no-index performance"
> +
> +. ./perf-lib.sh
> +
> +test_perf_large_repo
> +test_checkout_worktree
> +
> +file1=$(git ls-files | tail -n 2 | head -1)
> +file2=$(git ls-files | tail -n 1 | head -1)
> +
> +test_expect_success "empty files, so they take no time to diff" "
> +	echo >$file1 &&
> +	echo >$file2
> +"
> +
> +test_perf "diff --no-index" "
> +	git diff --no-index $file1 $file2 >/dev/null
> +"
> +
> +test_done
> diff --git a/t/t4053-diff-no-index.sh b/t/t4053-diff-no-index.sh
> index 979e983..077c775 100755
> --- a/t/t4053-diff-no-index.sh
> +++ b/t/t4053-diff-no-index.sh
> @@ -29,4 +29,19 @@ test_expect_success 'git diff --no-index relative path outside repo' '
>  	)
>  '
>  
> +test_expect_success 'git diff --no-index with broken index' '
> +	(
> +		cd repo &&
> +		echo broken >.git/index &&
> +		git diff --no-index a ../non/git/a
> +	)
> +'
> +
> +test_expect_success 'git diff outside repo with broken index' '
> +	(
> +		cd repo &&
> +		git diff ../non/git/a ../non/git/b
> +	)
> +'
> +
>  test_done
