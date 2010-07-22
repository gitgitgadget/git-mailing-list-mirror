From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] t/: work around one-shot variable assignment with test_must_fail
Date: Thu, 22 Jul 2010 13:21:10 -0500
Message-ID: <8myTzOiYB3ju-PTbbc8uT5rsI-P8hyc8F7UbDwbNzIh4Pa3k2_Uh2A@cipher.nrlssc.navy.mil>
References: <8HvhdiflWJtex2eC6n_6Q38YcvRRYhnh0scnq4s56M4wdwT_YlAiOw@cipher.nrlssc.navy.mil> <iU5XdZGtMeaspoCqSJIp6Y--60TPVkZUrm3SdW86dsTZkNYZWqbSppLBrMXyL1rVqqYtHm94ACo@cipher.nrlssc.navy.mil> <7v1vawk50n.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, erick.mattos@gmail.com, avarab@gmail.com,
	jrnieder@gmail.com, jaredhance@gmail.com, drafnel@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 22 20:22:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oc0Pl-0005co-Vy
	for gcvg-git-2@lo.gmane.org; Thu, 22 Jul 2010 20:22:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759324Ab0GVSWU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jul 2010 14:22:20 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:40375 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756445Ab0GVSWR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jul 2010 14:22:17 -0400
Received: by mail.nrlssc.navy.mil id o6MILAPf021833; Thu, 22 Jul 2010 13:21:10 -0500
In-Reply-To: <7v1vawk50n.fsf@alter.siamese.dyndns.org>
X-OriginalArrivalTime: 22 Jul 2010 18:21:10.0764 (UTC) FILETIME=[A91E02C0:01CB29CA]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151467>


btw, this works and is a definite improvement.

-Brandon

Junio C Hamano wrote:
> Brandon Casey <casey@nrlssc.navy.mil> writes:
> 
>> No time to investigate, but here is an example patch and the
>> results of running the affected tests.  Looks like reflog may
>> be creating a reflog when it is not supposed to.
> 
> Your later analysis is correct; "git reflog show <branch>" does not
> complain when there is no reflog for <branch>, which might or might not be
> a bug.
> 
> Because these tests are not about behaviour of "git reflog show" command,
> let's do this for now.
> 
> Thanks.
> 
> -- >8 --
> Subject: tests: correct "does reflog exist" tests
> 
> These two tests were not about how "git reflog show <branch>" exits when
> there is no reflog, but were about whether "checkout" and "branch" create
> or not create reflog when creating a new <branch>, update the tests to
> check it in a more direct way, namely using "git rev-parse --verify".
> 
> Also lose tests based on "test -f .git/logs/refs/heads/<branch>" from
> nearby, to avoid exposing this particular implementation detail
> unnecessarily.
> 
> ---
>  t/t2017-checkout-orphan.sh |   47 +++++++------------------------------------
>  t/t3200-branch.sh          |   13 ++---------
>  2 files changed, 11 insertions(+), 49 deletions(-)
> 
> diff --git a/t/t2017-checkout-orphan.sh b/t/t2017-checkout-orphan.sh
> index 81cb393..2d2f63f 100755
> --- a/t/t2017-checkout-orphan.sh
> +++ b/t/t2017-checkout-orphan.sh
> @@ -68,65 +68,34 @@ test_expect_success '--orphan makes reflog by default' '
>  	git checkout master &&
>  	git config --unset core.logAllRefUpdates &&
>  	git checkout --orphan delta &&
> -	! test -f .git/logs/refs/heads/delta &&
> -	(
> -		PAGER= &&
> -		export PAGER &&
> -		test_must_fail git reflog show delta
> -	) &&
> +	test_must_fail git rev-parse --verify delta@{0} &&
>  	git commit -m Delta &&
> -	test -f .git/logs/refs/heads/delta &&
> -	PAGER= git reflog show delta
> +	git rev-parse --verify delta@{0}
>  '
>  
>  test_expect_success '--orphan does not make reflog when core.logAllRefUpdates = false' '
>  	git checkout master &&
>  	git config core.logAllRefUpdates false &&
>  	git checkout --orphan epsilon &&
> -	! test -f .git/logs/refs/heads/epsilon &&
> -	(
> -		PAGER= &&
> -		export PAGER &&
> -		test_must_fail git reflog show epsilon
> -	) &&
> +	test_must_fail git rev-parse --verify epsilon@{0} &&
>  	git commit -m Epsilon &&
> -	! test -f .git/logs/refs/heads/epsilon &&
> -	(
> -		PAGER= &&
> -		export PAGER &&
> -		test_must_fail git reflog show epsilon
> -	)
> +	test_must_fail git rev-parse --verify epsilon@{0}
>  '
>  
>  test_expect_success '--orphan with -l makes reflog when core.logAllRefUpdates = false' '
>  	git checkout master &&
>  	git checkout -l --orphan zeta &&
> -	test -f .git/logs/refs/heads/zeta &&
> -	(
> -		PAGER= &&
> -		export PAGER &&
> -		test_must_fail git reflog show zeta
> -	) &&
> +	test_must_fail git rev-parse --verify zeta@{0} &&
>  	git commit -m Zeta &&
> -	PAGER= git reflog show zeta
> +	git rev-parse --verify zeta@{0}
>  '
>  
>  test_expect_success 'giving up --orphan not committed when -l and core.logAllRefUpdates = false deletes reflog' '
>  	git checkout master &&
>  	git checkout -l --orphan eta &&
> -	test -f .git/logs/refs/heads/eta &&
> -	(
> -		PAGER= &&
> -		export PAGER &&
> -		test_must_fail git reflog show eta
> -	) &&
> +	test_must_fail git rev-parse --verify eta@{0} &&
>  	git checkout master &&
> -	! test -f .git/logs/refs/heads/eta &&
> -	(
> -		PAGER= &&
> -		export PAGER &&
> -		test_must_fail git reflog show eta
> -	)
> +	test_must_fail git rev-parse --verify eta@{0}
>  '
>  
>  test_expect_success '--orphan is rejected with an existing name' '
> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
> index bf7747d..f54a533 100755
> --- a/t/t3200-branch.sh
> +++ b/t/t3200-branch.sh
> @@ -228,28 +228,21 @@ test_expect_success 'checkout -b makes reflog by default' '
>  	git checkout master &&
>  	git config --unset core.logAllRefUpdates &&
>  	git checkout -b alpha &&
> -	test -f .git/logs/refs/heads/alpha &&
> -	PAGER= git reflog show alpha
> +	git rev-parse --verify alpha@{0}
>  '
>  
>  test_expect_success 'checkout -b does not make reflog when core.logAllRefUpdates = false' '
>  	git checkout master &&
>  	git config core.logAllRefUpdates false &&
>  	git checkout -b beta &&
> -	! test -f .git/logs/refs/heads/beta &&
> -	(
> -		PAGER= &&
> -		export PAGER &&
> -		test_must_fail git reflog show beta
> -	)
> +	test_must_fail git rev-parse --verify beta@{0}
>  '
>  
>  test_expect_success 'checkout -b with -l makes reflog when core.logAllRefUpdates = false' '
>  	git checkout master &&
>  	git checkout -lb gamma &&
>  	git config --unset core.logAllRefUpdates &&
> -	test -f .git/logs/refs/heads/gamma &&
> -	PAGER= git reflog show gamma
> +	git rev-parse --verify gamma@{0}
>  '
>  
>  test_expect_success 'avoid ambiguous track' '
