From: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v3 0/3] Improve robustness of putty detection
Date: Mon, 27 Apr 2015 17:46:13 +0200
Message-ID: <553E59C5.1000706@web.de>
References: <1429914505-325708-1-git-send-email-sandals@crustytoothpaste.net>	<1430080212-396370-1-git-send-email-sandals@crustytoothpaste.net> <xmqq4mo2zgtz.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	=?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
To: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Mon Apr 27 17:46:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YmlEt-0002SV-D1
	for gcvg-git-2@plane.gmane.org; Mon, 27 Apr 2015 17:46:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753016AbbD0Pq1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Apr 2015 11:46:27 -0400
Received: from mout.web.de ([212.227.15.4]:55678 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752897AbbD0Pq0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Apr 2015 11:46:26 -0400
Received: from [192.168.209.17] ([217.211.68.12]) by smtp.web.de (mrweb003)
 with ESMTPSA (Nemesis) id 0LtFVL-1ZSNVP1nLP-012pIB; Mon, 27 Apr 2015 17:46:20
 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.6.0
In-Reply-To: <xmqq4mo2zgtz.fsf@gitster.dls.corp.google.com>
X-Provags-ID: V03:K0:BTkGmYbVsvaYsiaronsk/BFswSyGAHsCrrRoTL4Ie7KmLMq6To1
 Uk4g3JA60YxgOZGTJjPDTgqkOfBKTUkRQ/U55pNhaN1K5KC201B9jvPtWfecVpnj5Rpeffn
 owlKOaECBSO/GyYk5rflJwlrRK+NbpLONbxwlUVqjpyzNv6bgNn4SuecPxdqIggwiUTOBJw
 GdTX9yvko+zYXYRxobOIg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267856>

On 04/27/2015 12:04 AM, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> 
>> While I was adding tests, I noticed that we had a broken test due to the
>> use of single quotes within a test, which resulted in the test always
>> being skipped.
> 
> Good eyes.  While fixing the test is necessary, we should also be
> able to improve the test framework to prevent such mistakes at the
> same time.
> 
> ok 38 # skip
>         git clone "[myhost:123]:src" ssh-bracket-clone &&
>         expect_ssh myhost -p (missing bracketed hostnames are still
>         ssh)
> 
> The test scripts are expected to take either 3 or 4 parameters, and
> the extra parameter when it takes 4 is the comma separated list of
> prerequisites.  "bracketed hostnames are still ssh" does not look
> like prerequisites at all to us humans, and the framework should
> also be able to notice that and barf, I would think.
> 
> Perhaps something like this?
> 
>  t/test-lib-functions.sh | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index 0698ce7..0e4f2a6 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -348,11 +348,18 @@ test_declared_prereq () {
>  	return 1
>  }
>  
> +test_verify_prereq () {
> +	test -z "$test_prereq" ||
> +	expr >/dev/null "$test_prereq" : '^[A-Z0-9_,!]*$' ||
> +	error "bug in the test script: '$test_prereq' does not look like a prereq"
> +}
> +
>  test_expect_failure () {
>  	test_start_
>  	test "$#" = 3 && { test_prereq=$1; shift; } || test_prereq=
>  	test "$#" = 2 ||
>  	error "bug in the test script: not 2 or 3 parameters to test-expect-failure"
> +	test_verify_prereq
>  	export test_prereq
>  	if ! test_skip "$@"
>  	then
> @@ -372,6 +379,7 @@ test_expect_success () {
>  	test "$#" = 3 && { test_prereq=$1; shift; } || test_prereq=
>  	test "$#" = 2 ||
>  	error "bug in the test script: not 2 or 3 parameters to test-expect-success"
> +	test_verify_prereq
>  	export test_prereq
>  	if ! test_skip "$@"
>  	then
> @@ -400,6 +408,7 @@ test_external () {
>  	error >&5 "bug in the test script: not 3 or 4 parameters to test_external"
>  	descr="$1"
>  	shift
> +	test_verify_prereq
>  	export test_prereq
>  	if ! test_skip "$descr" "$@"
>  	then
> 
Thanks for fixing my bugs :-)
