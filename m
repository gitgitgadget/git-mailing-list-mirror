From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH 3/3] git-p4: Add test case for complex branch import
Date: Mon, 16 Jan 2012 14:12:54 -0500
Message-ID: <20120116191254.GB21996@padd.com>
References: <1326674360-2771-1-git-send-email-vitor.hda@gmail.com>
 <1326674360-2771-4-git-send-email-vitor.hda@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Vitor Antunes <vitor.hda@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 16 20:13:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RmrzL-00056n-SZ
	for gcvg-git-2@lo.gmane.org; Mon, 16 Jan 2012 20:13:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755933Ab2APTM7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jan 2012 14:12:59 -0500
Received: from honk.padd.com ([74.3.171.149]:37778 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755069Ab2APTM6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jan 2012 14:12:58 -0500
Received: from arf.padd.com (unknown [50.55.142.76])
	by honk.padd.com (Postfix) with ESMTPSA id D2ACDE8B;
	Mon, 16 Jan 2012 11:12:57 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 6C3C031446; Mon, 16 Jan 2012 14:12:54 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <1326674360-2771-4-git-send-email-vitor.hda@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188645>

vitor.hda@gmail.com wrote on Mon, 16 Jan 2012 00:39 +0000:
> diff --git a/t/t9801-git-p4-branch.sh b/t/t9801-git-p4-branch.sh
> +test_expect_success 'git-p4 add complex branches' '
> +	test_when_finished cleanup_git &&
> +	test_create_repo "$git" &&
> +	(
> +		cd "$cli" &&
> +		changelist=$(p4 changes -m1 //depot/... | cut -d" " -f2) &&
> +		changelist=$((changelist - 5)) &&
> +		p4 integrate //depot/branch1/...@$changelist //depot/branch4/... &&
> +		p4 submit -d "branch4" &&
> +		changelist=$((changelist + 2)) &&
> +		p4 integrate //depot/branch1/...@$changelist //depot/branch5/... &&
> +		p4 submit -d "branch5" &&
> +		cd "$TRASH_DIRECTORY"
> +	)
> +'

Sorry: I think I wanted the "$"s removed from inside $((..)).
Turns out that some shells don't grok that.  The above should be:

	changelist=$(($changelist - 5)) &&

You can drop the last cd to $TRASH_DIRECTORY since you're inside
a subshell.  (Nice addition of the subshells.)

> +
> +# Configure branches through git-config and clone them. git-p4 will only be able
> +# to clone the original structure if it is able to detect the origin changelist
> +# of each branch.
> +test_expect_success 'git-p4 clone complex branches' '
> +	test_when_finished cleanup_git &&
> +	test_create_repo "$git" &&
> +	(
> +		test_when_finished cleanup_git &&
> +		test_create_repo "$git" &&

These two lines can go; you already did it outside the subshell.

> +		cd "$git" &&
> +		git config git-p4.branchList branch1:branch2 &&
> +		git config --add git-p4.branchList branch1:branch3 &&
> +		git config --add git-p4.branchList branch1:branch4 &&
> +		git config --add git-p4.branchList branch1:branch5 &&
> +		"$GITP4" clone --dest=. --detect-branches //depot@all &&
> +		git log --all --graph --decorate --stat &&
> +		git reset --hard p4/depot/branch1 &&
> +		test -f file1 &&
> +		test -f file2 &&
> +		test -f file3 &&

There are preferred functions for these tests, I learned recently:

	test_path_is_file file1 &&

> +		grep -q update file2 &&
> +		git reset --hard p4/depot/branch2 &&
> +		test -f file1 &&
> +		test -f file2 &&
> +		test ! -f file3 &&

Similarly

	test_path_is_missing file3 &&

> +		! grep -q update file2 &&
> +		git reset --hard p4/depot/branch3 &&
> +		test -f file1 &&
> +		test -f file2 &&
> +		test -f file3 &&
> +		grep -q update file2 &&
> +		git reset --hard p4/depot/branch4 &&
> +		test -f file1 &&
> +		test -f file2 &&
> +		test ! -f file3 &&
> +		! grep -q update file2 &&
> +		git reset --hard p4/depot/branch5 &&
> +		test -f file1 &&
> +		test -f file2 &&
> +		test -f file3 &&
> +		! grep -q update file2 &&
> +		test ! -d .git/git-p4-tmp
> +	)
> +'
