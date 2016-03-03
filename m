From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v3 2/3] test: add test for --[no-]autostash flag
Date: Thu, 03 Mar 2016 18:31:01 +0100
Message-ID: <vpq1t7rii3u.fsf@anie.imag.fr>
References: <1456594902-21182-1-git-send-email-mehul.jain2029@gmail.com>
	<1457021601-9099-1-git-send-email-mehul.jain2029@gmail.com>
	<1457021601-9099-2-git-send-email-mehul.jain2029@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, pyokagan@gmail.com, gitster@pobox.com
To: Mehul Jain <mehul.jain2029@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 03 18:32:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abX6k-0000gc-E4
	for gcvg-git-2@plane.gmane.org; Thu, 03 Mar 2016 18:32:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756897AbcCCRcJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Mar 2016 12:32:09 -0500
Received: from mx1.imag.fr ([129.88.30.5]:37315 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753256AbcCCRcH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Mar 2016 12:32:07 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id u23HV0jn031141
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 3 Mar 2016 18:31:00 +0100
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u23HV1dU032660;
	Thu, 3 Mar 2016 18:31:01 +0100
In-Reply-To: <1457021601-9099-2-git-send-email-mehul.jain2029@gmail.com>
	(Mehul Jain's message of "Thu, 3 Mar 2016 21:43:20 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 03 Mar 2016 18:31:00 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u23HV0jn031141
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1457631061.51399@0FQlWWo7pzOj1aZ2U0xhNA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288195>

Mehul Jain <mehul.jain2029@gmail.com> writes:

> Signed-off-by: Mehul Jain <mehul.jain2029@gmail.com>
> ---
>  t/t5520-pull.sh         | 19 +++++++++++++++++++
>  t/t5521-pull-options.sh | 16 ++++++++++++++++

There's no need to split code/test/doc into separate patches, except if
your patches are getting really huge. As a reviewer, I like having tests
and doc in the same patch because they describe the intention of the
programmer.

We try to have a history where each commit is equally good, and with
your version there are two commits where --autostash exists and is
undocumented (which is not catastrophic, though).

> +test_expect_success 'pull --rebase --no-autostash fails with dirty working directory and rebase.autstash set true' '
> +	test_config rebase.autostash true &&
> +	git reset --hard before-rebase &&
> +	echo dirty >new_file &&
> +	git add new_file &&
> +	test_must_fail git pull --rebase --no-autostash . copy
> +'
> +
> +test_expect_success 'pull --rebase --autostash succeeds with dirty working directory and rebase.autstash set false' '
> +	test_config rebase.autostash false &&
> +	git reset --hard before-rebase &&
> +	echo dirty >new_file &&
> +	git add new_file &&
> +	git pull --rebase --autostash . copy &&
> +	test_cmp_rev HEAD^ copy &&
> +	test "$(cat new_file)" = dirty &&
> +	test "$(cat file)" = "modified again"
> +'

Sounds good.

> --- a/t/t5521-pull-options.sh
> +++ b/t/t5521-pull-options.sh
> @@ -62,6 +62,22 @@ test_expect_success 'git pull -v --rebase' '
>  	test_must_be_empty out)
>  '
>  
> +test_expect_success 'git pull --rebase --autostash' '
> +	mkdir clonedrbas &&
> +	(cd clonedrbas  && git init &&
> +	git pull --rebase --autostash "../parent" >out 2>err &&
> +	test -s err &&
> +	test_must_be_empty out)
> +'
> +
> +test_expect_success 'git pull --rebase --no-autostash' '
> +	mkdir clonedrbnas &&
> +	(cd clonedrbnas  && git init &&
> +	git pull --rebase --no-autostash "../parent" >out 2>err &&
> +	test -s err &&
> +	test_must_be_empty out)
> +'

Not sure these tests are needed if you have the ones in t/t5520-pull.sh.
More tests means more time to run so testing twice the same thing has a
cost.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
