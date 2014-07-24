From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] git p4 test: fix failure in 9814-git-p4-rename.sh Was:
 Re: Test failure in t9814-git-p4-rename.sh - my environment or bad test?
Date: Thu, 24 Jul 2014 20:45:19 +0200
Message-ID: <53D1543F.50508@kdbg.org>
References: <CABUJjW8TFCw2wwAO83vMBPc7vQc+rvuPOAca-CNECEduUn19Ew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Pete Wyckoff <pw@padd.com>, git@vger.kernel.org
To: Christoph Bonitz <ml.christophbonitz@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 24 20:45:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XAO1B-0003hw-Ad
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jul 2014 20:45:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934200AbaGXSpZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2014 14:45:25 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:39147 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S933154AbaGXSpY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2014 14:45:24 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 8312610012;
	Thu, 24 Jul 2014 20:45:20 +0200 (CEST)
Received: from dx.sixt.local (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id E869719F546;
	Thu, 24 Jul 2014 20:45:19 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <CABUJjW8TFCw2wwAO83vMBPc7vQc+rvuPOAca-CNECEduUn19Ew@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254177>

Am 23.07.2014 23:28, schrieb Christoph Bonitz:
> The scenario in the rename test makes unnecessary assumptions about
> which file git file-tree will detect as a source for a copy-operations.
> Furthermore, copy detection is not tested by checking the resulting
> perforce revision history via p4 filelog, but via git diff-tree.
> 
> This patch makes the test more robust by accepting each of the possible
> sources, and more rigorous by doing so via p4 filelog.
> ---

Please sign off your patch.

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
>   level=$(git diff-tree -r -C --find-copies-harder HEAD | sed 1d | cut -f1 | cut -d" " -f5 | sed "s/C0*//") &&
>   test -n "$level" && test "$level" -gt 0 && test "$level" -lt 98 &&
>   src=$(git diff-tree -r -C --find-copies-harder HEAD | sed 1d | cut -f2) &&
> - test "$src" = file10 || test "$src" = file11 &&
> + test "$src" = file2 || test "$src" = file10 || test "$src" = file11 &&

You can't test for alternatives in this way. It's already wrong in the
original line, which is from 795fcb0e (avoid "test <cond> -a/-o <cond>"),
and breaks the && chain. You need braces like this:

  { test "$src" = file2 || test "$src" = file10 || test "$src" = file11; } &&

or you wrap it up in a case statement.

>   git config git-p4.detectCopies $(($level + 2)) &&
>   git p4 submit &&
>   p4 filelog //depot/file12 &&
> @@ -190,12 +188,10 @@ test_expect_success 'detect copies' '
>   git diff-tree -r -C --find-copies-harder HEAD &&
>   level=$(git diff-tree -r -C --find-copies-harder HEAD | sed 1d | cut -f1 | cut -d" " -f5 | sed "s/C0*//") &&
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

I see a few other no-nos in the context of the changes, in particular,
pipelines where git is not the last command; these would not catch
failures in the git commands. But a fix for that is certainly outside
the scope of this patch.

-- Hannes
