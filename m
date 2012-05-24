From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH 1/2] git-p4: Test changelists touching two branches
Date: Wed, 23 May 2012 21:08:05 -0400
Message-ID: <20120524010805.GA26443@padd.com>
References: <1337729891-27648-1-git-send-email-vitor.hda@gmail.com>
 <1337729891-27648-2-git-send-email-vitor.hda@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Luke Diamand <luke@diamand.org>
To: Vitor Antunes <vitor.hda@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 24 03:08:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXMXG-0007z4-UF
	for gcvg-git-2@plane.gmane.org; Thu, 24 May 2012 03:08:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752329Ab2EXBIK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 May 2012 21:08:10 -0400
Received: from honk.padd.com ([74.3.171.149]:48970 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751357Ab2EXBIJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2012 21:08:09 -0400
Received: from arf.padd.com (unknown [50.55.145.1])
	by honk.padd.com (Postfix) with ESMTPSA id 1360FD27;
	Wed, 23 May 2012 18:08:08 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id D3C5631600; Wed, 23 May 2012 21:08:05 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1337729891-27648-2-git-send-email-vitor.hda@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198339>

vitor.hda@gmail.com wrote on Wed, 23 May 2012 00:38 +0100:
> It is possible to modify two different branches in P4 in a single
> changelist. git-p4 correctly detects this and commits the relevant
> changes to the different branches separately. This test proves that and
> avoid future regressions in this behavior.
> 
> Signed-off-by: Vitor Antunes <vitor.hda@gmail.com>
> ---
>  t/t9801-git-p4-branch.sh |   54 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 54 insertions(+), 0 deletions(-)
> 
> diff --git a/t/t9801-git-p4-branch.sh b/t/t9801-git-p4-branch.sh
> index 2859256..89d8c59 100755
> --- a/t/t9801-git-p4-branch.sh
> +++ b/t/t9801-git-p4-branch.sh
> @@ -306,6 +306,60 @@ test_expect_success 'git p4 clone complex branches' '
>  	)
>  '
>  
> +# Move branch3/file3 to branch4/file3 in a single changelist
> +test_expect_success 'git p4 submit to two branches in a single changelist' '
> +	test_when_finished cleanup_git &&
> +	test_create_repo "$git" &&

You can skip the git bits here.  This is just setup for the next
test.

Ack everything else.  Nice to have the extra tests.

		-- Pete

> +	(
> +		cd "$cli" &&
> +		p4 integrate //depot/branch3/file3 //depot/branch4/file3 &&
> +		p4 delete //depot/branch3/file3 &&
> +		p4 submit -d "Move branch3/file3 to branch4/file3"
> +	)
> +'
> +
> +# Confirm that changes to two branches done in a single changelist
> +# are correctly imported by git p4
> +test_expect_success 'git p4 sync changes to two branches in the same changelist' '
> +	test_when_finished cleanup_git &&
> +	test_create_repo "$git" &&
> +	(
> +		cd "$git" &&
> +		git config git-p4.branchList branch1:branch2 &&
> +		git config --add git-p4.branchList branch1:branch3 &&
> +		git config --add git-p4.branchList branch1:branch4 &&
> +		git config --add git-p4.branchList branch1:branch5 &&
> +		git p4 clone --dest=. --detect-branches //depot@all &&
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
> +		test_path_is_missing .git/git-p4-tmp
> +	)
> +'
> +
>  test_expect_success 'kill p4d' '
>  	kill_p4d
>  '
> -- 
> 1.7.7.rc2.14.g5e044.dirty
> 
