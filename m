From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH] git p4 test: fix failure in 9814-git-p4-rename.sh Was:
 Re: Test failure in t9814-git-p4-rename.sh - my environment or bad test?
Date: Wed, 23 Jul 2014 19:07:54 -0400
Message-ID: <20140723230754.GB10722@padd.com>
References: <CABUJjW8TFCw2wwAO83vMBPc7vQc+rvuPOAca-CNECEduUn19Ew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Christoph Bonitz <ml.christophbonitz@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 24 01:08:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XA5di-000504-2U
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jul 2014 01:08:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758495AbaGWXH6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2014 19:07:58 -0400
Received: from honk.padd.com ([71.19.245.7]:38601 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758326AbaGWXH5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2014 19:07:57 -0400
Received: from arf.padd.com (unknown [50.105.24.167])
	by honk.padd.com (Postfix) with ESMTPSA id B1A1970C8;
	Wed, 23 Jul 2014 16:07:56 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id A15EE201BD; Wed, 23 Jul 2014 19:07:54 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <CABUJjW8TFCw2wwAO83vMBPc7vQc+rvuPOAca-CNECEduUn19Ew@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254138>

ml.christophbonitz@gmail.com wrote on Wed, 23 Jul 2014 23:28 +0200:
> The scenario in the rename test makes unnecessary assumptions about
> which file git file-tree will detect as a source for a copy-operations.
> Furthermore, copy detection is not tested by checking the resulting
> perforce revision history via p4 filelog, but via git diff-tree.
> 
> This patch makes the test more robust by accepting each of the possible
> sources, and more rigorous by doing so via p4 filelog.

I see what you're doing here, and it all looks good.  The
diff-tree checks were mainly debugging, and if "p4 filelog"
shows the right "branch from", that means it works.

You might be able to firm up the "branch from" lines for file8
and file9 too, but those aren't likely to fail.

Indeed, as noted in the other thread, it would be better to make
these not so flaky, but your change here fixes a problem, and
doesn't do any harm.  And gives you an opportunity to fix it more
later.  :)

Be sure to fix the word-wrapping you have on two of the lines
below.  And be careful not to top post.

Here's my ack for when you decide to send it back to the list,
cc junio.

Acked-by: Pete Wyckoff <pw@padd.com>

> ---
>  t/t9814-git-p4-rename.sh | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/t/t9814-git-p4-rename.sh b/t/t9814-git-p4-rename.sh
> index 1fc1f5f..4068510 100755
> --- a/t/t9814-git-p4-rename.sh
> +++ b/t/t9814-git-p4-rename.sh
> @@ -156,18 +156,16 @@ test_expect_success 'detect copies' '
>   git diff-tree -r -C HEAD &&
>   git p4 submit &&
>   p4 filelog //depot/file10 &&
> - p4 filelog //depot/file10 | grep -q "branch from //depot/file" &&
> + p4 filelog //depot/file10 | grep -q "branch from //depot/file2" &&
> 
>   cp file2 file11 &&
>   git add file11 &&
>   git commit -a -m "Copy file2 to file11" &&
>   git diff-tree -r -C --find-copies-harder HEAD &&
> - src=$(git diff-tree -r -C --find-copies-harder HEAD | sed 1d | cut -f2) &&
> - test "$src" = file10 &&
>   git config git-p4.detectCopiesHarder true &&
>   git p4 submit &&
>   p4 filelog //depot/file11 &&
> - p4 filelog //depot/file11 | grep -q "branch from //depot/file" &&
> + p4 filelog //depot/file11 | grep -q -E "branch from //depot/file(2|10)" &&
> 
>   cp file2 file12 &&
>   echo "some text" >>file12 &&
> @@ -177,7 +175,7 @@ test_expect_success 'detect copies' '
>   level=$(git diff-tree -r -C --find-copies-harder HEAD | sed 1d | cut
> -f1 | cut -d" " -f5 | sed "s/C0*//") &&
>   test -n "$level" && test "$level" -gt 0 && test "$level" -lt 98 &&
>   src=$(git diff-tree -r -C --find-copies-harder HEAD | sed 1d | cut -f2) &&
> - test "$src" = file10 || test "$src" = file11 &&
> + test "$src" = file2 || test "$src" = file10 || test "$src" = file11 &&
>   git config git-p4.detectCopies $(($level + 2)) &&
>   git p4 submit &&
>   p4 filelog //depot/file12 &&
> @@ -190,12 +188,10 @@ test_expect_success 'detect copies' '
>   git diff-tree -r -C --find-copies-harder HEAD &&
>   level=$(git diff-tree -r -C --find-copies-harder HEAD | sed 1d | cut
> -f1 | cut -d" " -f5 | sed "s/C0*//") &&
>   test -n "$level" && test "$level" -gt 2 && test "$level" -lt 100 &&
> - src=$(git diff-tree -r -C --find-copies-harder HEAD | sed 1d | cut -f2) &&
> - test "$src" = file10 || test "$src" = file11 || test "$src" = file12 &&
>   git config git-p4.detectCopies $(($level - 2)) &&
>   git p4 submit &&
>   p4 filelog //depot/file13 &&
> - p4 filelog //depot/file13 | grep -q "branch from //depot/file"
> + p4 filelog //depot/file13 | grep -q -E "branch from //depot/file(2|10|11|12)"
>   )
>  '
> 
> -- 
> 2.0.1
