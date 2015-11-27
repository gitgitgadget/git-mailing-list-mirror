From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v1 1/2] implement test_might_fail using a refactored
 test_must_fail
Date: Fri, 27 Nov 2015 12:37:38 +0000
Message-ID: <56584E92.1030103@ramsayjones.plus.com>
References: <1448615714-43768-1-git-send-email-larsxschneider@gmail.com>
 <1448615714-43768-2-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: peff@peff.net, Junio C Hamano <gitster@pobox.com>
To: larsxschneider@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 27 13:38:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a2IIV-0002SJ-ST
	for gcvg-git-2@plane.gmane.org; Fri, 27 Nov 2015 13:38:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753705AbbK0Mii (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Nov 2015 07:38:38 -0500
Received: from avasout07.plus.net ([84.93.230.235]:38382 "EHLO
	avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751726AbbK0Mih (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Nov 2015 07:38:37 -0500
Received: from [10.0.2.15] ([146.200.5.254])
	by avasout07 with smtp
	id mcdk1r0045UqX4q01cdl5G; Fri, 27 Nov 2015 12:37:46 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=JN/GyJ+b c=1 sm=1 tr=0
 a=GKs3PHufgjMgxBavMeQJCg==:117 a=GKs3PHufgjMgxBavMeQJCg==:17 a=0Bzu9jTXAAAA:8
 a=EBOSESyhAAAA:8 a=N659UExz7-8A:10 a=pGLkceISAAAA:8 a=ybZZDoGAAAAA:8
 a=PKzvZo6CAAAA:8 a=o3FO-ax8Mc0QieEsRRwA:9 a=pILNOxqGKmIA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <1448615714-43768-2-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281773>



On 27/11/15 09:15, larsxschneider@gmail.com wrote:
> From: Lars Schneider <larsxschneider@gmail.com>
> 
> Add an (optional) first parameter "ok=<special case>" to test_must_fail
> and return success for "<special case>". Add "success" as
> "<special case>" and use it to implement "test_might_fail". This removes
> redundancies in test-lib-function.sh.
> 
> You can pass multiple <special case> arguments divided by comma (e.g.
> "test_must_fail ok=success,something")
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Jeff King <peff@peff.net>
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
>  t/test-lib-functions.sh | 47 +++++++++++++++++++++++++++++++++--------------
>  1 file changed, 33 insertions(+), 14 deletions(-)
> 
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index 73e37a1..94c449a 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -569,6 +569,21 @@ test_line_count () {
>  	fi
>  }
>  
> +# Returns success if a comma separated string of keywords ($1) contains a
> +# given keyword ($2).
> +# Examples:
> +# `list_contains "foo,bar" bar` returns 0
> +# `list_contains "foo" bar` returns 1
> +
> +list_contains () {
> +	case ",$1," in
> +	*,$2,*)
> +		return 0
> +		;;
> +	esac
> +	return 1
> +}
> +
>  # This is not among top-level (test_expect_success | test_expect_failure)
>  # but is a prefix that can be used in the test script, like:
>  #
> @@ -582,18 +597,31 @@ test_line_count () {
>  # the failure could be due to a segv.  We want a controlled failure.
>  
>  test_must_fail () {
> +	case "$1" in
> +	ok=*)
> +		_test_ok=${1#ok=}
> +		shift
> +		;;
> +	*)
> +		_test_ok=
> +		;;
> +	esac
>  	"$@"
>  	exit_code=$?
> -	if test $exit_code = 0; then
> +	if ! list_contains "$_test_ok" success && test "$exit_code" -eq 0
> +	then

minor nit:

I would prefer this was 'if test $exit_code -eq 0 && ! list_contains ...'

ie. the test on exit code comes first (and no need for the double quotes).
The whole if..elif.. chain is about testing the exit code, with a couple
of exceptions ...

The same comment applies to the second patch with exit code 141/SIGPIPE.

ATB,
Ramsay Jones
