From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 12/12] t3901: test git-am encoding conversion
Date: Wed, 08 Jul 2015 22:44:16 +0200
Message-ID: <559D8BA0.5090701@kdbg.org>
References: <1435861000-25278-1-git-send-email-pyokagan@gmail.com> <1435861000-25278-13-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 08 22:44:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCwCg-0000dA-6x
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jul 2015 22:44:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758883AbbGHUoW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jul 2015 16:44:22 -0400
Received: from bsmtp8.bon.at ([213.33.87.20]:20015 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1758432AbbGHUoU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jul 2015 16:44:20 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 3mRXg60TRkz5tlF;
	Wed,  8 Jul 2015 22:44:18 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id DBF5F519D;
	Wed,  8 Jul 2015 22:44:16 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <1435861000-25278-13-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273709>

Am 02.07.2015 um 20:16 schrieb Paul Tan:
> Since d1c5f2a (Add git-am, applymbox replacement., 2005-10-07), git-am
> supported the --utf8 and --no-utf8 options, and if set, would pass the
> -u flag and the -k flag respectively.
>
> git mailinfo -u will re-code the commit log message and authorship info
> in the charset specified by i18n.commitencoding setting, while
> git mailinfo -n will disable the re-coding.
>
> Since d84029b (--utf8 is now default for 'git-am', 2007-01-08), --utf8
> is set by default in git-am.
>
> Add various encoding conversion tests to t3901 to test git-mailinfo's
> encoding conversion. In addition, add a test for --no-utf8 to check that
> no encoding conversion will occur if that option is set.
>
> Cc: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Paul Tan <pyokagan@gmail.com>
> ---
>   t/t3901-i18n-patch.sh | 62 +++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 62 insertions(+)
>
> diff --git a/t/t3901-i18n-patch.sh b/t/t3901-i18n-patch.sh
> index 75cf3ff..b49bdb7 100755
> --- a/t/t3901-i18n-patch.sh
> +++ b/t/t3901-i18n-patch.sh
> @@ -251,4 +251,66 @@ test_expect_success 'rebase --merge (L/U)' '
>   	check_encoding 2 8859
>   '
>
> +test_expect_success 'am (U/U)' '
> +	# Apply UTF-8 patches with UTF-8 commitencoding
> +	git config i18n.commitencoding UTF-8 &&
> +	. "$TEST_DIRECTORY"/t3901-utf8.txt &&
> +
> +	git reset --hard master &&
> +	git am out-u1 out-u2 &&
> +
> +	check_encoding 2
> +'
> +
> +test_expect_success 'am (L/L)' '
> +	# Apply ISO-8859-1 patches with ISO-8859-1 commitencoding
> +	git config i18n.commitencoding ISO8859-1 &&
> +	. "$TEST_DIRECTORY"/t3901-8859-1.txt &&
> +
> +	git reset --hard master &&
> +	git am out-l1 out-l2 &&
> +
> +	check_encoding 2 8859
> +'

This test case must be protected by !MINGW, just like the last case 
below and other cases that are already in the file. See 32f4cb6cee for 
details.

> +
> +test_expect_success 'am (U/L)' '
> +	# Apply ISO-8859-1 patches with UTF-8 commitencoding
> +	git config i18n.commitencoding UTF-8 &&
> +	. "$TEST_DIRECTORY"/t3901-utf8.txt &&
> +	git reset --hard master &&
> +
> +	# am specifies --utf8 by default.
> +	git am out-l1 out-l2 &&
> +
> +	check_encoding 2
> +'
> +
> +test_expect_success 'am --no-utf8 (U/L)' '
> +	# Apply ISO-8859-1 patches with UTF-8 commitencoding
> +	git config i18n.commitencoding UTF-8 &&
> +	. "$TEST_DIRECTORY"/t3901-utf8.txt &&
> +
> +	git reset --hard master &&
> +	git am --no-utf8 out-l1 out-l2 2>err &&
> +
> +	# commit-tree will warn that the commit message does not contain valid UTF-8
> +	# as mailinfo did not convert it
> +	grep "did not conform" err &&
> +
> +	check_encoding 2
> +'
> +
> +test_expect_success !MINGW 'am (L/U)' '
> +	# Apply UTF-8 patches with ISO-8859-1 commitencoding
> +	git config i18n.commitencoding ISO8859-1 &&
> +	. "$TEST_DIRECTORY"/t3901-8859-1.txt &&
> +
> +	git reset --hard master &&
> +	# mailinfo will re-code the commit message to the charset specified by
> +	# i18n.commitencoding
> +	git am out-u1 out-u2 &&
> +
> +	check_encoding 2 8859
> +'
> +
>   test_done
>

-- Hannes
