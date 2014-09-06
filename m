From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <l.s.r@web.de>
Subject: Re: [RFC PATCH 1/2] Makefile: add check-headers target
Date: Sat, 06 Sep 2014 23:20:32 +0200
Message-ID: <540B7AA0.4050208@web.de>
References: <1410031211-14599-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 06 23:20:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XQNPe-0002YO-4l
	for gcvg-git-2@plane.gmane.org; Sat, 06 Sep 2014 23:20:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751906AbaIFVUq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Sep 2014 17:20:46 -0400
Received: from mout.web.de ([212.227.15.4]:61459 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751532AbaIFVUq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Sep 2014 17:20:46 -0400
Received: from [192.168.178.27] ([79.253.165.27]) by smtp.web.de (mrweb001)
 with ESMTPSA (Nemesis) id 0M7Kek-1YMAzy1CRa-00x59A; Sat, 06 Sep 2014 23:20:44
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.1.0
In-Reply-To: <1410031211-14599-1-git-send-email-davvid@gmail.com>
X-Provags-ID: V03:K0:iU6c9PuVyJxp8WBl04VGOUQaM0yvJK6PU3Rm2gpZXpxG4HL9xGU
 uOkgw4DhHsaLlr6lMcXAYtJcQqX674Ggw/3AXqjc451c0XQ8E9TASnYJtS+k9jh2Dk/MPJC
 faSdNduUSX6Fc9az8xoHjC2DUAQdaaftc9ADAFO/jpWCFWYeZcSepvwLavJkmtJvYQ0YF7j
 AkJvoF+l5lcnwrZc3vUaQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256603>

Am 06.09.2014 um 21:20 schrieb David Aguilar:
> This allows us to ensure that each header can be included
> individually without needing to include other headers first.

Sounds like a good objective.

> Signed-off-by: David Aguilar <davvid@gmail.com>
> ---
> This patch demonstrates how to verify PATCH 2/2.
>
>   Makefile         |  6 ++++++
>   check-headers.sh | 26 ++++++++++++++++++++++++++
>   2 files changed, 32 insertions(+)
>   create mode 100755 check-headers.sh
>
> diff --git a/Makefile b/Makefile
> index 30cc622..bc54024 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2591,6 +2591,12 @@ check-docs::
>   check-builtins::
>   	./check-builtins.sh
>
> +### Make sure headers include their dependencies
> +#
> +check-headers::
> +	./check-headers.sh $(CC) $(ALL_CFLAGS)
> +
> +
>   ### Test suite coverage testing
>   #
>   .PHONY: coverage coverage-clean coverage-compile coverage-test coverage-report
> diff --git a/check-headers.sh b/check-headers.sh
> new file mode 100755
> index 0000000..bf85c41
> --- /dev/null
> +++ b/check-headers.sh
> @@ -0,0 +1,26 @@
> +#!/bin/sh
> +
> +exit_code=0
> +
> +maybe_exit () {
> +	status="$1"
> +	if test "$status" != 0
> +	then
> +		exit_code="$status"
> +		if test -n "$CHECK_HEADERS_STOP"
> +		then
> +			exit "$status"
> +		fi
> +	fi
> +}
> +
> +git ls-files *.h |

This checks all .h files in the top directory.  Would it be better to 
check all files in LIB_H instead?  Or even all .h files in the tree 
(using "git ls-files '*.h'")?  The latter might be difficult because 
some of the files in compat/ #include system-specific headers.

> +while read header
> +do
> +	echo "HEADER $header" &&
> +	"$@" -Wno-unused -x c -c -o "$header".bin - <"$header" &&
> +	rm "$header".bin ||
> +	maybe_exit $?
> +done
> +
> +exit $exit_code
>
