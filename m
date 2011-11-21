From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH] Add test that checkout does not overwrite entries in .git/info/exclude
Date: Mon, 21 Nov 2011 07:45:01 -0000
Organization: OPDS
Message-ID: <00392567F0B045E38A429F95594C1BD2@PhilipOakley>
References: <CAPRVejcpAZrLWCeHTZJr9Uk6_z6hTPQLLd6pCOKteYnRGMQ5ig@mail.gmail.com> <7vehx2ijf8.fsf@alter.siamese.dyndns.org> <20111120221930.GF14902@foodlogiq3-xp-d620.thebe.ath.cx> <7vzkfqgn91.fsf@alter.siamese.dyndns.org> <4EC9FC81.3080306@viscovery.net>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Taylor Hedberg" <tmhedberg@gmail.com>,
	"Bertrand BENOIT" <projettwk@users.sourceforge.net>,
	<git@vger.kernel.org>
To: "Johannes Sixt" <j.sixt@viscovery.net>,
	"Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 21 08:45:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RSOYy-0003KP-EJ
	for gcvg-git-2@lo.gmane.org; Mon, 21 Nov 2011 08:45:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754322Ab1KUHpH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Nov 2011 02:45:07 -0500
Received: from out1.ip03ir2.opaltelecom.net ([62.24.128.239]:19882 "EHLO
	out1.ip03ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754024Ab1KUHpF (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Nov 2011 02:45:05 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AnAGADYByk5cHKew/2dsb2JhbABDik6cbYMAgQaBbQEEAQEFCAEBLhEFCAEBIQsCAwUCAQMOBgEMJRQBBBgCBgcXBgEHCwgCAQIDAQwEhSeCMwoGtB6DWYVbYwSHaYRwKJlA
X-IronPort-AV: E=Sophos;i="4.69,545,1315177200"; 
   d="scan'208";a="367211788"
Received: from host-92-28-167-176.as13285.net (HELO PhilipOakley) ([92.28.167.176])
  by out1.ip03ir2.opaltelecom.net with SMTP; 21 Nov 2011 07:45:01 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185734>

From: "Johannes Sixt" <j.sixt@viscovery.net>
> From: Johannes Sixt <j6t@kdbg.org>
>
> It is an unintended accident that entries matched by .git/info/exclude are
> considered precious, but entries matched by .gitignore are not. That is,
> 'git checkout' will overwrite untracked files matched by .gitignore, but
> refuses to overwrite files matched by .git/info/exclude.
>
> It is a lucky accident: it allows the distinction between "untracked but
> precious" and "untracked and garbage". And it is a doubly lucky accident:
> .gitignore entries are meant for files like build products, which usually
> affect all consumers of a repository, whereas .git/info/exclude is
> intended for personal files, which frequently are precious (think of a
> TODO file).
>
> Add a test that codifies the accident as wanted behavior.
>
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
> Am 11/21/2011 4:36, schrieb Junio C Hamano:
>> As far as I am aware, info/exclude should work exactly the same as having
>> a .gitignore file at the root level of the working tree. Can you show a
>> minimum reproduction recipe in a form of a patch to our test scripts in 
>> t/
>> hierarchy?
>
> Here you are. As you can see from my commit message, IMO, this is
> a very useful accident. Therefore, there is no 'test_expect_failure'
> in the test script :-)

Shouldn't there be some documentation changes to support this very useful 
feature. By documenting the existing code functionality  we get the double 
benefit of no code changes and we publish the existance of a desired bit of 
functionality.
Philip

>
> -- Hannes
>
> t/t2023-checkout-ignored.sh |   51 
> +++++++++++++++++++++++++++++++++++++++++++
> 1 files changed, 51 insertions(+), 0 deletions(-)
> create mode 100755 t/t2023-checkout-ignored.sh
>
> diff --git a/t/t2023-checkout-ignored.sh b/t/t2023-checkout-ignored.sh
> new file mode 100755
> index 0000000..03a5a56
> --- /dev/null
> +++ b/t/t2023-checkout-ignored.sh
> @@ -0,0 +1,51 @@
> +#!/bin/sh
> +
> +test_description='checkout overwrites or preserves ignored files
> +
> +`git checkout` makes a distinction between files mentioned in
> +.gitignore and .git/info/exclude in that untracked files matched
> +by the latter are considered precious and are not overwritten.
> +'
> +
> +. ./test-lib.sh
> +
> +test_expect_success setup '
> +
> + echo excluded > excluded &&
> + echo ignored > ignored &&
> + git add . &&
> + test_commit initial &&
> + git checkout -b side &&
> + git rm excluded &&
> + git mv ignored .gitignore &&
> + test_commit side &&
> + echo excluded >> .git/info/exclude
> +'
> +
> +test_expect_success 'files are ignored' '
> +
> + echo keep > excluded &&
> + echo overwrite > ignored &&
> + list=$(git ls-files --others --exclude-standard) &&
> + test -z "$list"
> +'
> +
> +test_expect_success 'entries in .git/info/exclude are precious' '
> +
> + test_must_fail git checkout master 2>errors &&
> + test_i18ngrep "would be overwritten" errors &&
> + grep " excluded" errors &&
> + ! grep " ignored" errors &&
> + grep keep excluded &&
> + grep overwrite ignored
> +'
> +
> +test_expect_success 'entries in .gitignore are not precious' '
> +
> + rm -f excluded &&
> + git checkout master &&
> + grep excluded excluded &&
> + grep ignored ignored
> +'
> +
> +test_done
> -- 
> 1.7.8.rc0.126.gd15506
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
> -----
> No virus found in this message.
> Checked by AVG - www.avg.com
> Version: 2012.0.1872 / Virus Database: 2092/4628 - Release Date: 11/20/11
> 
