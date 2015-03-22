From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [RFC/PATCH] align D/F handling of "diff --no-index" with that
 of normal Git
Date: Sun, 22 Mar 2015 12:37:19 +0000
Message-ID: <550EB77F.3040005@ramsay1.demon.co.uk>
References: <xmqqiodtd3b4.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 22 13:43:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZfDa-0001ph-S9
	for gcvg-git-2@plane.gmane.org; Sun, 22 Mar 2015 13:43:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751674AbbCVMm5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2015 08:42:57 -0400
Received: from mdfmta005.mxout.tch.inty.net ([91.221.169.46]:59584 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751661AbbCVMm4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2015 08:42:56 -0400
X-Greylist: delayed 335 seconds by postgrey-1.27 at vger.kernel.org; Sun, 22 Mar 2015 08:42:56 EDT
Received: from mdfmta005.tch.inty.net (unknown [127.0.0.1])
	by mdfmta005.tch.inty.net (Postfix) with ESMTP id 30F8718CCF4;
	Sun, 22 Mar 2015 12:37:18 +0000 (GMT)
Received: from mdfmta005.tch.inty.net (unknown [127.0.0.1])
	by mdfmta005.tch.inty.net (Postfix) with ESMTP id E427018CCF0;
	Sun, 22 Mar 2015 12:37:17 +0000 (GMT)
Received: from [10.0.2.15] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mdfmta005.tch.inty.net (Postfix) with ESMTP;
	Sun, 22 Mar 2015 12:37:17 +0000 (GMT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <xmqqiodtd3b4.fsf@gitster.dls.corp.google.com>
X-MDF-HostID: 18
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266071>

On 22/03/15 05:11, Junio C Hamano wrote:
> When a commit changes a path P that used to be a file to a directory
> and create a new path P/X in it, "git show" would say that file P
> was removed and file P/X was created for such a commit.
> 
> However, if we compare two directories, D1 and D2, where D1 has a
> file D1/P in it and D2 has a directory D2/P under which there is a
> file D2/P/X, and ask "git diff --no-index D1 D2" to show their
> differences, we simply get a refusal "file/directory conflict".
> 
> The "diff --no-index" implementation has an underlying machinery
> that can make it more in line with the normal Git if it wanted to,
> but somehow it is not being exercised.  The only thing we need to
> do, when we see a file P and a directory P/ (or the other way
> around) is to show the removal of a file P and then pretend as if we
> are comparing nothing with a whole directory P/, as the code is
> fully prepared to express a creation of everything in a directory
> (and if the comparison is between a directory P/ and a file P, then
> show the creation of the file and then let the existing code remove
> everything in P/).
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  diff-no-index.c | 23 +++++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/diff-no-index.c b/diff-no-index.c
> index 265709b..52e9546 100644
> --- a/diff-no-index.c
> +++ b/diff-no-index.c
> @@ -97,8 +97,27 @@ static int queue_diff(struct diff_options *o,
>  	if (get_mode(name1, &mode1) || get_mode(name2, &mode2))
>  		return -1;
>  
> -	if (mode1 && mode2 && S_ISDIR(mode1) != S_ISDIR(mode2))
> -		return error("file/directory conflict: %s, %s", name1, name2);
> +	if (mode1 && mode2 && S_ISDIR(mode1) != S_ISDIR(mode2)) {
> +		struct diff_filespec *d1, *d2;
> +
> +		if (S_ISDIR(mode1)) {
> +			/* 2 is file that is created */
> +			d1 = noindex_filespec(NULL, 0);
> +			d2 = noindex_filespec(name2, mode2);
> +			name2 = NULL;
> +			mode2 = 0;
> +		} else {
> +			/* 1 is file that is deleted */
> +			d1 = noindex_filespec(name1, mode2);
-----------------------------------------------------^^^^^

I have not been following the discussion (or even really
studied this patch), but the asymmetry here caught my eye
as I was skimming the email.

[So, if this is actually correct, sorry for the noise!]

ATB,
Ramsay Jones

> +			d2 = noindex_filespec(NULL, 0);
> +			name1 = NULL;
> +			mode1 = 0;
> +		}
> +		/* emit that file */
> +		diff_queue(&diff_queued_diff, d1, d2);
> +
> +		/* and then let the entire directory created or deleted */
> +	}
>  
>  	if (S_ISDIR(mode1) || S_ISDIR(mode2)) {
>  		struct strbuf buffer1 = STRBUF_INIT;
