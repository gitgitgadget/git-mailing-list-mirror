From: Christoph Bonitz <ml.christophbonitz@gmail.com>
Subject: Re: [PATCH] git p4 test: fix failure in 9814-git-p4-rename.sh Was:
 Re: Test failure in t9814-git-p4-rename.sh - my environment or bad test?
Date: Wed, 30 Jul 2014 09:08:26 +0200
Message-ID: <CABUJjW_tnf2SRCyjRw1n+UbzLzTbmqW6XAJSJnZ5qszdpJ3SYA@mail.gmail.com>
References: <CABUJjW8TFCw2wwAO83vMBPc7vQc+rvuPOAca-CNECEduUn19Ew@mail.gmail.com>
	<53D1543F.50508@kdbg.org>
	<xmqq4my68la5.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Sixt <j6t@kdbg.org>, Pete Wyckoff <pw@padd.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 30 09:08:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCNzz-0002Nw-FV
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jul 2014 09:08:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754976AbaG3HI1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2014 03:08:27 -0400
Received: from mail-vc0-f179.google.com ([209.85.220.179]:60841 "EHLO
	mail-vc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754663AbaG3HI1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2014 03:08:27 -0400
Received: by mail-vc0-f179.google.com with SMTP id hq11so1161204vcb.10
        for <git@vger.kernel.org>; Wed, 30 Jul 2014 00:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=evoQ1YyqfY6yu+Xxolvx0E5F9FwEYb4ZRJKJGL+L+2Y=;
        b=o8eTGSBHuUXIrxMvdWZUqjCcUjJiWmSNgFxhlLeyxr4kaUow+M5lolTldORBqidFEw
         T8xNpRBZ8XnZhJWRkZHeTLFWFHVHWv1YKTF6JVxaQVE6cJWnVp7oO6+P0Pe6KyzJ9bF8
         93sVwKz3+QCQpA0UQbY3x+5l7GbQYVpd7xugJJqAaifsu9AVRQIxO9JEcsupl+nB+W3a
         ANYcYu3uNYOfR5M7vf1kPCT0HgqwiCdUp4fvNHNMI4cez0mwKd0iDkZuSXeP22/U3tl0
         UzqU3dHRk8qbVsv6lYwOp26uSm4FMTrRwhK1Vgs9FeJH3h8W824AC0s1UFd6wDTyTBmk
         oZNg==
X-Received: by 10.52.170.140 with SMTP id am12mr5741543vdc.10.1406704106447;
 Wed, 30 Jul 2014 00:08:26 -0700 (PDT)
Received: by 10.220.80.132 with HTTP; Wed, 30 Jul 2014 00:08:26 -0700 (PDT)
In-Reply-To: <xmqq4my68la5.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254479>

On Fri, Jul 25, 2014 at 12:05 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Johannes Sixt <j6t@kdbg.org> writes:
>> I see a few other no-nos in the context of the changes, in particular,
>> pipelines where git is not the last command; these would not catch
>> failures in the git commands. But a fix for that is certainly outside
>> the scope of this patch.
>
> Yuck.  Thanks for spotting.
>
> Perhaps we should apply a preliminary clean-up before doing anything
> else, perhaps?  The change in 9814 is a post 2.0 regression.

Apart from your change and the word wrap adjustments suggested by
Pete, would the following also make sense, to fix the other flaw
Johannes pointed out? With regards to failing, git diff-tree should be
idempotent. I think those are the two occurrences in this file:

diff --git a/t/t9814-git-p4-rename.sh b/t/t9814-git-p4-rename.sh
index 1fc1f5f..7815f9a 100755
--- a/t/t9814-git-p4-rename.sh
+++ b/t/t9814-git-p4-rename.sh
@@ -176,6 +176,7 @@ test_expect_success 'detect copies' '
                git diff-tree -r -C --find-copies-harder HEAD &&
                level=$(git diff-tree -r -C --find-copies-harder HEAD
| sed 1d | cut -f1 | cut -d" " -f5 | sed "s/C
                test -n "$level" && test "$level" -gt 0 && test
"$level" -lt 98 &&
+               git diff-tree -r -C --find-copies-harder HEAD &&
                src=$(git diff-tree -r -C --find-copies-harder HEAD |
sed 1d | cut -f2) &&
                test "$src" = file10 || test "$src" = file11 &&
                git config git-p4.detectCopies $(($level + 2)) &&
@@ -190,6 +191,7 @@ test_expect_success 'detect copies' '
                git diff-tree -r -C --find-copies-harder HEAD &&
                level=$(git diff-tree -r -C --find-copies-harder HEAD
| sed 1d | cut -f1 | cut -d" " -f5 | sed "s/C
                test -n "$level" && test "$level" -gt 2 && test
"$level" -lt 100 &&
+               git diff-tree -r -C --find-copies-harder HEAD &&
                src=$(git diff-tree -r -C --find-copies-harder HEAD |
sed 1d | cut -f2) &&
                test "$src" = file10 || test "$src" = file11 || test
"$src" = file12 &&
                git config git-p4.detectCopies $(($level - 2)) &&
