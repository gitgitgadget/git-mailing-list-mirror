From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] rebase -x: do not die without -i
Date: Thu, 17 Mar 2016 07:20:49 +0100
Message-ID: <56EA4CC1.9060602@kdbg.org>
References: <1458177584-11378-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org,
	Matthieu.Moy@grenoble-inp.fr, johannes.schindelin@gmail.com,
	Lucien.Kong@ensimag.imag.fr
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Mar 17 07:20:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agRIn-0005er-J1
	for gcvg-git-2@plane.gmane.org; Thu, 17 Mar 2016 07:20:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754808AbcCQGUx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2016 02:20:53 -0400
Received: from bsmtp8.bon.at ([213.33.87.20]:26529 "EHLO bsmtp8.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753153AbcCQGUx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2016 02:20:53 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp8.bon.at (Postfix) with ESMTPSA id 3qQdX24ZDVz5tlL;
	Thu, 17 Mar 2016 07:20:50 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 00F6653B6;
	Thu, 17 Mar 2016 07:20:49 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
In-Reply-To: <1458177584-11378-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289077>

Am 17.03.2016 um 02:19 schrieb Stefan Beller:
> -test_expect_success 'rebase --exec without -i shows error message' '
> +test_expect_success 'rebase --exec works without -i ' '
>   	git reset --hard execute &&
> -	set_fake_editor &&
> -	test_must_fail git rebase --exec "git show HEAD" HEAD~2 2>actual &&
> -	echo "The --exec option must be used with the --interactive option" >expected &&
> -	test_i18ncmp expected actual
> +	git rebase --exec true HEAD~2 2>actual2 >actual1 &&
> +	echo "Successfully rebased and updated refs/heads/autosquash_expected." >expected &&
> +	test_i18ncmp expected actual2 &&
> +	test_line_count = 2 actual1

We don't have an explicit guideline, but please do not check stderr 
output using test_cmp or test_i18ncmp. The reason is that some shells 
write trace output to stderr when run under 'set -x'. That is, when you 
run this test as

      ./t3404-rebase-interactive.sh -x -v

it will fail because there is now more text in actual2 than expected. We 
have a number of cases like this elsewhere, but we should not stack new 
cases on the pile.

Please use test_i18ngrep:

	test_i18ngrep "Successfully rebased and updated" actual2 &&
	test_line_count = 2 actual1

-- Hannes
