From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-p4: Improve client path detection when branches are used
Date: Sat, 18 Apr 2015 17:58:11 -0700
Message-ID: <xmqqk2x9ndcs.fsf@gitster.dls.corp.google.com>
References: <xmqqsic44rw5.fsf@gitster.dls.corp.google.com>
	<1429399445-11024-1-git-send-email-vitor.hda@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Luke Diamand <luke@diamand.org>
To: Vitor Antunes <vitor.hda@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 19 02:58:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YjdZ3-0003jp-E1
	for gcvg-git-2@plane.gmane.org; Sun, 19 Apr 2015 02:58:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752179AbbDSA6U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Apr 2015 20:58:20 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61162 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751197AbbDSA6T (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Apr 2015 20:58:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 058B2499C6;
	Sat, 18 Apr 2015 20:58:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nXipAVcU6BJJb/VIb2Di4dgghBc=; b=B/OKzF
	065/CXrz8ROmSQHLUeSZIxGJNIVituX9jZ/4PbYRSyWrtf5GkZByVskKWuDEA0xe
	OMozGshVAt4SseZyF+/mz+HRJ2PHUCkpYkUdjTKs6q3CjHxYalRu0ZSKgKpctQ0Z
	gQVK1lh7E28G9W5X76ZQGYEcBR+TcJF/u1Cmw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VpVkOw4gxYFHBH7MvuW2gdx6I35rVhQB
	4r1q18kQPuyQa9z6pZTxKxJWtyh8CvNxZs13KlLBZU6EQFrYnCOtTf1Boe0HZLcT
	IhCCGf4dupoi9R6gv0fHuPzEhRQBhubEfi20p8NsC6EybsW1kCSGRU1MZiX0n543
	p0BuhEHlLCY=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F0A26499C5;
	Sat, 18 Apr 2015 20:58:12 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 70AD2499C4;
	Sat, 18 Apr 2015 20:58:12 -0400 (EDT)
In-Reply-To: <1429399445-11024-1-git-send-email-vitor.hda@gmail.com> (Vitor
	Antunes's message of "Sun, 19 Apr 2015 00:24:05 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2746B61C-E62F-11E4-ACB2-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267430>

Vitor Antunes <vitor.hda@gmail.com> writes:

> This patch makes the client path detection more robust by limiting the valid
> results from p4 where. The test case is also made more complex, to guarantee
> that such client views are supported.
>
> Signed-off-by: Vitor Antunes <vitor.hda@gmail.com>
> ---

Was this designed to be squashed into the previous 2/2 patch?  I
do not think either 1/2 or 2/2 is in 'next' yet, and if this was
to correct mistakes in the 2/2 that was posted earlier, it would
be nicer to have a replacement patch with corrected log message.

Thanks.


>  git-p4.py                |    4 +++-
>  t/t9801-git-p4-branch.sh |   12 ++++++++++--
>  2 files changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/git-p4.py b/git-p4.py
> index 262a95b..28d0d90 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -507,7 +507,9 @@ def p4Where(depotPath):
>      output = None
>      for entry in outputList:
>          if "depotFile" in entry:
> -            if entry["depotFile"].find(depotPath) >= 0:
> +            # Search for the base client side depot path, as long as it starts with the branch's P4 path.
> +            # The base path always ends with "/...".
> +            if entry["depotFile"].find(depotPath) == 0 and entry["depotFile"][-4:] == "/...":
>                  output = entry
>                  break
>          elif "data" in entry:
> diff --git a/t/t9801-git-p4-branch.sh b/t/t9801-git-p4-branch.sh
> index 4fe4e18..0aafd03 100755
> --- a/t/t9801-git-p4-branch.sh
> +++ b/t/t9801-git-p4-branch.sh
> @@ -512,23 +512,28 @@ test_expect_success 'restart p4d' '
>  #
>  # 1: //depot/branch1/base/file1
>  #    //depot/branch1/base/file2
> +#    //depot/branch1/base/dir/sub_file1
>  # 2: integrate //depot/branch1/base/... -> //depot/branch2/base/...
>  # 3: //depot/branch1/base/file3
>  # 4: //depot/branch1/base/file2 (edit)
>  # 5: integrate //depot/branch1/base/... -> //depot/branch3/base/...
>  #
> -# Note: the client view remove the "base" folder from the workspace
> +# Note: the client view removes the "base" folder from the workspace
> +#       and moves sub_file1 one level up.
>  test_expect_success 'add simple p4 branches with common base folder on each branch' '
>  	(
>  		cd "$cli" &&
>  		client_view "//depot/branch1/base/... //client/branch1/..." \
> +			    "//depot/branch1/base/dir/sub_file1 //client/branch1/sub_file1" \
>  			    "//depot/branch2/base/... //client/branch2/..." \
>  			    "//depot/branch3/base/... //client/branch3/..." &&
>  		mkdir -p branch1 &&
>  		cd branch1 &&
>  		echo file1 >file1 &&
>  		echo file2 >file2 &&
> -		p4 add file1 file2 &&
> +		mkdir dir &&
> +		echo sub_file1 >sub_file1 &&
> +		p4 add file1 file2 sub_file1 &&
>  		p4 submit -d "Create branch1" &&
>  		p4 integrate //depot/branch1/base/... //depot/branch2/base/... &&
>  		p4 submit -d "Integrate branch2 from branch1" &&
> @@ -561,16 +566,19 @@ test_expect_success 'git p4 clone simple branches with base folder on server sid
>  		test -f file1 &&
>  		test -f file2 &&
>  		test -f file3 &&
> +		test -f sub_file1 &&
>  		grep update file2 &&
>  		git reset --hard p4/depot/branch2 &&
>  		test -f file1 &&
>  		test -f file2 &&
>  		test ! -f file3 &&
> +		test -f sub_file1 &&
>  		! grep update file2 &&
>  		git reset --hard p4/depot/branch3 &&
>  		test -f file1 &&
>  		test -f file2 &&
>  		test -f file3 &&
> +		test -f sub_file1 &&
>  		grep update file2 &&
>  		cd "$cli" &&
>  		cd branch1 &&
