From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [RFC/PATCH] test: skip clean-up when running under --immediate
 mode
Date: Thu, 30 Jun 2011 08:45:34 +0200
Message-ID: <4E0C1B8E.5070507@drmicha.warpmail.net>
References: <7vmxh3xidt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 30 08:45:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QcB0S-0006Hv-Pa
	for gcvg-git-2@lo.gmane.org; Thu, 30 Jun 2011 08:45:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758034Ab1F3Gpj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jun 2011 02:45:39 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:49032 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751333Ab1F3Gpi (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Jun 2011 02:45:38 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 68A1A20CFD;
	Thu, 30 Jun 2011 02:45:37 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute3.internal (MEProxy); Thu, 30 Jun 2011 02:45:37 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=6P5X7z99xsukASKPZDvVl85SUoc=; b=C8UCe1MDkbnvDxxuHZQESYcHVt/9U2LzYtFgCwvrTqsdAVRXp2jgmcjPYGMeZOz4AG+bErZGjairIQftfqkCNv5Tjk3Tkw7YrX1mTagyuHWUM+nyAuz8oNED4xl0AGRSIHKUglfIcAwMiKCgNK7kW/EvcpbRKweZHOOGpzKK01c=
X-Sasl-enc: jVpNhXsrV4jU2TdCpeHHDEuSQZzExMGksP3dAW5GcXNh 1309416337
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id CA73F444113;
	Thu, 30 Jun 2011 02:45:36 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc15 Lightning/1.0b3pre Thunderbird/3.1.10
In-Reply-To: <7vmxh3xidt.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176477>

Junio C Hamano venit, vidit, dixit 27.06.2011 20:02:
> Some tests try to be too careful about cleaning themselves up and
> do
> 
>     test_expect_success description '
>         set-up some test refs and/or configuration &&
>         test_when_finished "revert the above changes" &&
> 	the real test
>     '
> 
> Which is nice to make sure that a potential failure would not have
> unexpected interaction with the next test. This however interferes when
> "the real test" fails and we want to see what is going on, by running the
> test with --immediate mode and descending into its trash directory after
> the test stops. The precondition to run the real test and cause it to fail
> is all gone after the clean-up procedure defined by test_when_finished is
> done.
> 
> Update test_run_ which is the workhorse of running a test script
> called from test_expect_success and test_expect_failure, so that we do not
> run clean-up script defined with test_when_finished when a test that is
> expected to succeed fails under the --immediate mode.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> 
>  * Likes, dislikes?

Likes!

> 
>  t/test-lib.sh |   12 ++++++++++--
>  1 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 8c57a00..e36e67a 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -446,9 +446,14 @@ test_debug () {
>  
>  test_run_ () {
>  	test_cleanup=:
> +	expecting_failure=$1
>  	eval >&3 2>&4 "$1"
>  	eval_ret=$?
> -	eval >&3 2>&4 "$test_cleanup"
> +
> +	if test -z "$immediate" || test $eval_ret = 0 || test -n "$expecting_failure"

One may argue that a "test_expect_failure" which succeeds is a fail and
should stop with --immediate (so that it's easier to spot fixed bugs),
but...

> +	then
> +		eval >&3 2>&4 "$test_cleanup"
> +	fi
>  	if test "$verbose" = "t" && test -n "$HARNESS_ACTIVE"; then
>  		echo ""
>  	fi
> @@ -497,7 +502,7 @@ test_expect_failure () {
>  	if ! test_skip "$@"
>  	then
>  		say >&3 "checking known breakage: $2"
> -		test_run_ "$2"
> +		test_run_ "$2" expecting_failure
>  		if [ "$?" = 0 -a "$eval_ret" = 0 ]
>  		then
>  			test_known_broken_ok_ "$1"

...we would have to change that here also, and it would be a change in
behaviour of the test suite. Anyway, that is orthogonal to this patch
which I do like.

> @@ -774,6 +779,9 @@ test_cmp() {
>  #
>  # except that the greeting and config --unset must both succeed for
>  # the test to pass.
> +#
> +# Note that under --immediate mode, no clean-up is done to help diagnose
> +# what went wrong.
>  
>  test_when_finished () {
>  	test_cleanup="{ $*
