From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Confusing git pull error message
Date: Mon, 05 Oct 2009 14:13:18 +0200
Message-ID: <4AC9E2DE.8050108@viscovery.net>
References: <43d8ce650909121301i4450489dhf475ff6894394a5f@mail.gmail.com> <20090912211119.GA30966@coredump.intra.peff.net> <7v1vmar353.fsf@alter.siamese.dyndns.org> <4AC9D952.3050108@viscovery.net> <20091005115308.GA2122@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	John Tapsell <johnflux@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Oct 05 14:18:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MumW3-0002Oh-9j
	for gcvg-git-2@lo.gmane.org; Mon, 05 Oct 2009 14:18:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751255AbZJEMOJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2009 08:14:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751142AbZJEMOI
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Oct 2009 08:14:08 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:19155 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751042AbZJEMOH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2009 08:14:07 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1MumRK-0004vj-UH; Mon, 05 Oct 2009 14:13:26 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id ACE86BC81; Mon,  5 Oct 2009 14:13:18 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <20091005115308.GA2122@coredump.intra.peff.net>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129557>

Jeff King schrieb:
> On Mon, Oct 05, 2009 at 01:32:34PM +0200, Johannes Sixt wrote:
> Ah, yeah. Looking at %(upstream) from for-each-ref (which is how we
> determine to show that message) always uses the configured remote. But
> if we have asked for another remote, then that doesn't make much sense.
> 
> So I think we need something like this. I wasn't able to figure out a
> test case to trigger the first code path below, though. It may not be
> possible; if we give a refspec on the command line, either it will be a
> candidate for merging or, if it does not exist, fetch will barf. So it
> may be that we can just collapse it down to a single case.
> 
> diff --git a/git-pull.sh b/git-pull.sh
> index edf3ce3..a831db5 100755
> --- a/git-pull.sh
> +++ b/git-pull.sh
> @@ -97,6 +97,18 @@ error_on_no_merge_candidates () {
>  		echo "Please specify which branch you want to merge on the command"
>  		echo "line and try again (e.g. 'git pull <repository> <refspec>')."
>  		echo "See git-pull(1) for details."
> +	elif [ -n "$1" ]; then
> +		if [ $# -gt 1 ]; then
> +			echo "You asked to pull from the remote '$1', but none"
> +			echo "of the things you asked to fetch were candidates"
> +			echo "for merging."
> +		else
> +			echo "You asked to pull from the remote '$1', but did"
> +			echo "not specify a branch to merge. Because this is"
> +			echo "not the default configured remote for your current"
> +			echo "branch, you must specify a branch on the command"
> +			echo "line."
> +		fi
>  	elif [ -z "$upstream" ]; then
>  		echo "You asked me to pull without telling me which branch you"
>  		echo "want to merge with, and 'branch.${curr_branch}.merge' in"

Thanks, this gives a much better error message.

But, can we *please* have a more pleasantly wrapped message, even if this
grows lines in the source code beyond the 80 char limit? Like:

	echo "You asked to pull from the remote '$1',"
	echo "but did not specify a branch to merge. Because this is"
	echo "not the default configured remote for your current branch,"
	echo "you must specify a branch on the command line."

I.e.:

- Reserve more room for a long $1 in the first line.

- Don't wrap lines in "current branch" and "command line" when they are at
the end of a major logical unit of the sentence.

-- Hannes
