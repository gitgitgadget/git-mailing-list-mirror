From: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v2 01/12] t5520: implement tests for no merge candidates
 cases
Date: Thu, 07 May 2015 11:05:47 +0200
Message-ID: <554B2AEB.3020608@web.de>
References: <1430988248-18285-1-git-send-email-pyokagan@gmail.com> <1430988248-18285-2-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>
To: Paul Tan <pyokagan@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 07 11:07:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqHmF-0003Qf-1j
	for gcvg-git-2@plane.gmane.org; Thu, 07 May 2015 11:07:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751035AbbEGJH1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2015 05:07:27 -0400
Received: from mout.web.de ([212.227.17.12]:53424 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750806AbbEGJHZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2015 05:07:25 -0400
Received: from [192.168.88.199] ([194.47.243.242]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0MV4bp-1YkYbh3jzR-00YRcF; Thu, 07 May 2015 11:07:17
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:31.0) Gecko/20100101 Icedove/31.6.0
In-Reply-To: <1430988248-18285-2-git-send-email-pyokagan@gmail.com>
X-Provags-ID: V03:K0:ypp5p0fwC/HURYPEWo3NnSv105TpwCoupijs6iYXXAJZfG+89gS
 uRxljJMtZvpchu3bl/Iu5xLaBK+Ery84gNkAKaJwZnQTmh98K8e0V0qa3MiH8djw7gWnHxk
 cBlxsaWNdgG59w2/HzetRLZV+Hic6u+HeC52IDRmqPYDWdmTf2j3VN3DEe/YJA/GBOhRK5u
 tFQ7Uc3w9/Me5Yk9MP8jQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268524>

On 05/07/2015 10:43 AM, Paul Tan wrote:
> Commit a8c9bef4 fully established the current advices given by git-pull
> for the different cases where git-fetch will not have anything marked
> for merge:
>
> 1. We fetched from a specific remote, and a refspec was given, but it
>     ended up not fetching anything. This is usually because the user
>     provided a wildcard refspec which had no matches on the remote end.
>
> 2. We fetched from a non-default remote, but didn't specify a branch to
>     merge. We can't use the configured one because it applies to the
>     default remote, and thus the user must specify the branches to merge.
>
> 3. We fetched from the branch's or repo's default remote, but:
>
>     a. We are not on a branch, so there will never be a configured branch
>        to merge with.
>
>     b. We are on a branch, but there is no configured branch to merge
>        with.
>
> 4. We fetched from the branch's or repo's default remote, but the
>     configured branch to merge didn't get fetched (either it doesn't
>     exist, or wasn't part of the configured fetch refspec)
>
> Implement tests for the above 5 cases to ensure that the correct code
> paths are triggered for each of these cases.
>
> Signed-off-by: Paul Tan <pyokagan@gmail.com>
> ---
>
> Notes:
>      * Re-worded commit message to match the logic used in git-pull.sh's
>        error_on_no_merge_candidates().
>      
>      * The tests have thus also been reordered to match the commit message.
>      
>      * Non-hackish solution for case 3a.
>      
>      * Add more checks to ensure that git-pull does not touch any files it
>        should not be touching on failure.
>
>   t/t5520-pull.sh | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 55 insertions(+)
>
> diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
> index 7efd45b..5add900 100755
> --- a/t/t5520-pull.sh
> +++ b/t/t5520-pull.sh
> @@ -109,6 +109,61 @@ test_expect_success 'the default remote . should not break explicit pull' '
>   	test `cat file` = modified
>   '
>   
> +test_expect_success 'fail if wildcard spec does not match any refs' '
> +	git checkout -b test copy^ &&
> +	test_when_finished "git checkout -f copy && git branch -D test" &&
> +	test `cat file` = file &&
Minor nit, please see Documentation/CodingGuidelines:
  - We prefer $( ... ) for command substitution; unlike ``, it
    properly nests.  It should have been the way Bourne spelled
    it from day one, but unfortunately isn't.
In other words:
test $(cat file) = file &&
