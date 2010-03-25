From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCHv2 2/2] tests for git alternate command
Date: Thu, 25 Mar 2010 08:38:09 +0100
Message-ID: <4BAB12E1.8070602@viscovery.net>
References: <a038bef51003241335l1623ade4i4a9b7269546739d4@mail.gmail.com> <1269497251-13103-3-git-send-email-judge.packham@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, jrnieder@gmail.com, gitster@pobox.com,
	bebarino@gmail.com
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 25 08:38:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nuhe6-0000w5-Sa
	for gcvg-git-2@lo.gmane.org; Thu, 25 Mar 2010 08:38:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753126Ab0CYHiQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Mar 2010 03:38:16 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:24778 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753036Ab0CYHiQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Mar 2010 03:38:16 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Nuhdq-00018n-Ji; Thu, 25 Mar 2010 08:38:10 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 4A3761660F;
	Thu, 25 Mar 2010 08:38:10 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.8) Gecko/20100227 Thunderbird/3.0.3
In-Reply-To: <1269497251-13103-3-git-send-email-judge.packham@gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143167>

Am 3/25/2010 7:07, schrieb Chris Packham:
> Signed-off-by: Chris Packham <judge.packham@gmail.com>

Your patches violate whitespace rules. Use 'git show --check' to see the
questionable lines.

> ---
> I wasn't sure about the test numbering so I just grabbed the highest one. Still
> need to add tests for the deletion use case.

According to t/README, t1* would be a suitable category, perhaps t1430.

>  t/t9800-git-alternate.sh |   95 ++++++++++++++++++++++++++++++++++++++++++++++

"git" in the name is redundant

> +test_expect_success \
> +	'Setup for rest of the test' '

The modern style for test headers is

test_expect_success 'Setup for rest of the test' '
	test goes here
'

It may improve readability if you insert a blank line after the headline.

> +	mkdir -p base &&
> +	cd base &&
> +	git init &&
> +	echo test > a.txt &&
> +	echo test > b.txt &&
> +	echo test > c.txt &&
> +	git add *.txt &&
> +	git commit -a -m "Initial Commit" &&
> +	cd .. &&

Do not use 'cd dir && ... && cd ..', use (cd dir && ...) like you did in
the rest of the tests.

> +test_expect_success \
> +	'Add alternate after clone' '
> +	(cd B &&
> +	git alternate -a ../base/.git/objects
> +	)

We saw tests like this written with more whitespace like:

	(
		cd B &&
		git alternate -a ../base/.git/objects
	)

> +test_expect_success \
> +	'add same alternate fails adding existing abs path' '
> +	(cd B &&
> +	test_must_fail git alternate -a $PWD/base/.git/objects

This use of $PWD is OK, but for consistency it should be $(pwd) like
below. Moreover, it needs double-quotes.

> +test_expect_success \
> +	'test git alternate display' '
> +	testbase=$PWD

You must write this as (d-quotes not needed here)

	testbase=$(pwd) &&

for the benefit of Windows. The difference is that $PWD returns /c/path,
but $(pwd) returns c:/path.

When the alternate was set up using the command, git has only ever seen a
c:/path style path (regardless of whether you used $PWD or $(pwd), because
the path is converted to c:/path by the shell before it invokes git), and
therefore the alternates file contains this style.

But when the expected result is constructed, the /c/path style is *not*
converted to c:/path; and a mismatch would be detected.

> +	(cd B &&
> +	git alternate >actual &&
> +	{
> +		echo "Object store $testbase/base/.git/objects"
> +		echo "    referenced via $testbase/B/.git"
> +	} >expect &&
> +	test_cmp expect actual
> +	)
> +'
> +
> +test_expect_success \
> +	'test git alternate recursive display' '
> +	testbase=$PWD

Ditto.

> +#rm -rf A B C D base
> \ No newline at end of file

test_done

-- Hannes
