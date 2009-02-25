From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] git submodule: Add test cases for git submodule add
Date: Wed, 25 Feb 2009 13:24:57 -0800
Message-ID: <7vd4d61a6u.fsf@gitster.siamese.dyndns.org>
References: <80055d7c0902241556s4d24285bqd171275f58bdb37d@mail.gmail.com>
 <1235559820-3096-1-git-send-email-git@drmicha.warpmail.net>
 <1235559820-3096-2-git-send-email-git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Andrei Thorp <garoth@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Feb 25 22:27:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcRH7-0002em-8p
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 22:26:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752882AbZBYVZN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2009 16:25:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752325AbZBYVZM
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 16:25:12 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38532 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752132AbZBYVZK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2009 16:25:10 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 9009C9CEFE;
	Wed, 25 Feb 2009 16:25:08 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 3B7A59CEFD; Wed,
 25 Feb 2009 16:24:58 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C6EBCBB2-0382-11DE-ABCA-B26E209B64D9-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111496>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
> index b8cb2df..b154050 100755
> --- a/t/t7400-submodule-basic.sh
> +++ b/t/t7400-submodule-basic.sh
> @@ -47,6 +47,25 @@ test_expect_success 'Prepare submodule testing' '
>  	GIT_CONFIG=.gitmodules git config submodule.example.url git://example.com/init.git
>  '

Please don't chdir around in individual tests.  Instead have each test
begin and end in the original directory given.  Like:

> +test_expect_success 'Prepare submodule add testing' '
> +	submodurl=$(pwd)
> +	mkdir addtest &&
> +	pushd addtest &&
> +	git init
> +'

	(
        	mkdir addtest &&
                cd addtest &&
                git init
	)

> +test_expect_success 'submodule add' '
> +	git submodule add "$submodurl" submod &&
> +	git submodule init
> +'

	(
        	cd addtest &&
                git submodule add ...
	)                

> +test_expect_failure 'submodule add with ./ in path' '
> +	git submodule add "$submodurl" ././dotsubmod/./frotz/./ &&
> +	git submodule init
> +'
> +# end of submodule add testing
> +popd >/dev/null

The rule of thumb is minimize things done outside of tests, like this
popd.

This is to prevent mistaken test sequence to go up too many levels.  E.g.
an earlier test that is supposed to chdir down and make the subsequent
tests begin at one level deeper than the original could fail, but when
tests are run without the "-i" option, the failed test would not abort the
whole sequence.  The subsequent tests run in a wrong place, and one of
them would try to chdir up to come back to the original directory, but
their "cd .." will go up too high, because the first chdir that tried to
go down failed.
