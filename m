From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH 2/2] git-p4: Verify detection of "empty" branch creation
Date: Wed, 23 May 2012 21:13:38 -0400
Message-ID: <20120524011338.GB26443@padd.com>
References: <1337729891-27648-1-git-send-email-vitor.hda@gmail.com>
 <1337729891-27648-3-git-send-email-vitor.hda@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Luke Diamand <luke@diamand.org>
To: Vitor Antunes <vitor.hda@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 24 03:13:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXMcd-0000Xb-Q2
	for gcvg-git-2@plane.gmane.org; Thu, 24 May 2012 03:13:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754842Ab2EXBNn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 May 2012 21:13:43 -0400
Received: from honk.padd.com ([74.3.171.149]:46772 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752856Ab2EXBNm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2012 21:13:42 -0400
Received: from arf.padd.com (unknown [50.55.145.1])
	by honk.padd.com (Postfix) with ESMTPSA id 4C728D27;
	Wed, 23 May 2012 18:13:41 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id D7B1631600; Wed, 23 May 2012 21:13:38 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1337729891-27648-3-git-send-email-vitor.hda@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198340>

vitor.hda@gmail.com wrote on Wed, 23 May 2012 00:38 +0100:
> Current implementation of new branch parent detection works on the
> principle that the new branch is a complete integration, with no
> changes, of the original files.
> This test shows this deficiency in the particular case when the new
> branch is created from a subset of the original files.
> 
> Signed-off-by: Vitor Antunes <vitor.hda@gmail.com>
> ---
>  t/t9801-git-p4-branch.sh |   56 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 56 insertions(+), 0 deletions(-)
> 
> diff --git a/t/t9801-git-p4-branch.sh b/t/t9801-git-p4-branch.sh
> index 89d8c59..c8e4d86 100755
> --- a/t/t9801-git-p4-branch.sh
> +++ b/t/t9801-git-p4-branch.sh
> @@ -360,6 +360,62 @@ test_expect_success 'git p4 sync changes to two branches in the same changelist'
>  	)
>  '
>  
> +# Create a branch by integrating a single file
> +test_expect_success 'git p4 file subset branch' '
> +	test_when_finished cleanup_git &&
> +	test_create_repo "$git" &&

Ditto; no need for git here.

> +	(
> +		cd "$cli" &&
> +		p4 integrate //depot/branch1/file1 //depot/branch6/file1 &&
> +		p4 submit -d "Integrate file1 alone from branch1 to branch6"
> +	)
> +'
> +
> +# Check if git -p4 creates a new branch containing a single file,

Stray "-"  -------^

> +# instead of keeping the old files from the original branch
> +test_expect_failure 'git p4 clone file subset branch' '
> +	test_when_finished cleanup_git &&
> +	test_create_repo "$git" &&
> +	(
> +		cd "$git" &&
> +		git config git-p4.branchList branch1:branch2 &&
> +		git config --add git-p4.branchList branch1:branch3 &&
> +		git config --add git-p4.branchList branch1:branch4 &&
> +		git config --add git-p4.branchList branch1:branch5 &&
> +		git config --add git-p4.branchList branch1:branch6 &&
> +		"$GITP4" clone --dest=. --detect-branches //depot@all &&

Rebase error?  It fails because this should be "git p4".

> +		git log --all --graph --decorate --stat &&
> +		git reset --hard p4/depot/branch1 &&
> +		test_path_is_file file1 &&
> +		test_path_is_file file2 &&
> +		test_path_is_file file3 &&
> +		grep update file2 &&
> +		git reset --hard p4/depot/branch2 &&
> +		test_path_is_file file1 &&
> +		test_path_is_file file2 &&
> +		test_path_is_missing file3 &&
> +		! grep update file2 &&
> +		git reset --hard p4/depot/branch3 &&
> +		test_path_is_file file1 &&
> +		test_path_is_file file2 &&
> +		test_path_is_missing file3 &&
> +		grep update file2 &&
> +		git reset --hard p4/depot/branch4 &&
> +		test_path_is_file file1 &&
> +		test_path_is_file file2 &&
> +		test_path_is_file file3 &&
> +		! grep update file2 &&
> +		git reset --hard p4/depot/branch5 &&
> +		test_path_is_file file1 &&
> +		test_path_is_file file2 &&
> +		test_path_is_file file3 &&
> +		! grep update file2 &&
> +		git reset --hard p4/depot/branch6 &&
> +		test_path_is_file file1 &&
> +		! test_path_is_file file2 &&

But then it fails here too because the code is indeed buggy.
Nice to have this test too, to document the problem and maybe
prod someone to fix it someday.

> +		! test_path_is_file file3

Do use "test_path_is_missing" for these non-existant file
tests, though, please.

		-- Pete

> +	)
> +'
>  test_expect_success 'kill p4d' '
>  	kill_p4d
>  '
> -- 
> 1.7.7.rc2.14.g5e044.dirty
> 
