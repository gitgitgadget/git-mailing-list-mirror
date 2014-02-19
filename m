From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH] blame: add a failing test for a CRLF issue.
Date: Wed, 19 Feb 2014 21:16:22 +0100
Message-ID: <53051116.5010307@web.de>
References: <20140214191015.GG4582@vauxhall.crustytoothpaste.net> <1392752735-168203-1-git-send-email-sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Wed Feb 19 21:16:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WGDZQ-0002y0-EZ
	for gcvg-git-2@plane.gmane.org; Wed, 19 Feb 2014 21:16:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753573AbaBSUQg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Feb 2014 15:16:36 -0500
Received: from mout.web.de ([212.227.17.11]:60516 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752680AbaBSUQf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Feb 2014 15:16:35 -0500
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0MGAG3-1WScAJ0GCF-00FCVo for <git@vger.kernel.org>;
 Wed, 19 Feb 2014 21:16:33 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <1392752735-168203-1-git-send-email-sandals@crustytoothpaste.net>
X-Provags-ID: V03:K0:VYsYb7/D3SycjbVQiJ52g2EMzedQgZRiPq6dHxU5YPRadgZAfvz
 SCIVNU28H7fGZlMrbX6FjnNY7LzVhcXB/qUSnYhsOc/jk5bhUfYMi3yvSPaXMSLwyB1wM3F
 o05ZivfMPywIc5Pk2E16pXLg485GSNbBaoz8xdY4ykWaohQxhNS+00Ntar4rnsvF8Qmr6wc
 1OEoyuM+nc9+O1wrm77LA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242402>

On 02/18/2014 08:45 PM, brian m. carlson wrote:
> If a file contains CRLF line endings in a repository with
> core.autocrlf=input, then blame always marks the lines as "Not Committed
> Yet", even if they are unmodified.  Add a failing test for this case, so we
> are at least aware of this issue.
>
> Reported-by: Ephrim Khong <dr.khong@gmail.com>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>
> Obviously, this doesn't actually fix the issue, but at least we're aware of it
> so we don't lose track of it and can fix it.  A future patch can mark the test
> passing.
>
>   t/t8003-blame-corner-cases.sh | 10 ++++++++++
>   1 file changed, 10 insertions(+)
>
> diff --git a/t/t8003-blame-corner-cases.sh b/t/t8003-blame-corner-cases.sh
> index e7cac1d..903f775 100755
> --- a/t/t8003-blame-corner-cases.sh
> +++ b/t/t8003-blame-corner-cases.sh
> @@ -191,4 +191,14 @@ test_expect_success 'indent of line numbers, ten lines' '
>   	test $(grep -c "  " actual) = 9
>   '
>
> +test_expect_failure 'blaming files with CRLF newlines' '
> +	git config core.autocrlf false &&
> +	printf "testcase\r\n" >crlffile &&
> +	git add crlffile &&
> +	git commit -m testcase &&
> +	git config core.autocrlf input &&
> +	git blame crlffile >actual &&
> +	grep "A U Thor" actual
> +'
> +
>   test_done
>

We can test that git blame gives the same result with 
core.autocrlf=input  and core.autocrlf=false, and make the test case 
look like this:

test_expect_failure 'blaming files with CRLF newlines' '
	git config core.autocrlf false &&
	printf "testcase\r\n" >crlffile &&
	git add crlffile &&
	git commit -m testcase &&
	git blame crlffile >expected &&
	git -c core.autocrlf=input blame crlffile >actual &&
	test_cmp expected actual
'
