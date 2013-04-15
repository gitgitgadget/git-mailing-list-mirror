From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] bisect: Store first bad commit as comment in log file
Date: Sun, 14 Apr 2013 23:50:37 -0700
Message-ID: <7v4nf82soy.fsf@alter.siamese.dyndns.org>
References: <20130413152257.GB16040@pvv.ntnu.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
To: Torstein Hegge <hegge@resisty.net>
X-From: git-owner@vger.kernel.org Mon Apr 15 08:50:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URdFV-0008Uf-Cq
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 08:50:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753214Ab3DOGul (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 02:50:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55291 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752386Ab3DOGuk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 02:50:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0E058111C1;
	Mon, 15 Apr 2013 06:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fngAKd9XRvsEYemRa4a0yh8nJT8=; b=CjglZJ
	njaMdCOcGQcE5X/Vq2Rqwon6CyQPSdts0OSAAv5Nkfeoc1CTw0BhTSOm2vW84VQh
	ibHLZVva4+sRjH0GIKjt+4YZpxpe7Jie2wCF3cnQybta75K0ivds7Mqov8yTDzbv
	O7rtAvZQ9g+gaxhGHfe1MWOCjtbCGqyMY5Bag=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JIhPNrwmfXsSuyOoUq2MwdfqNuQ5rqmA
	AdDhjwtKAamR7n22BSRy9TXP8hB67hrKpslH8GbQtFho03OAFd5oScGLjbAE1Dp5
	a9d7CXZkhFWsGpaVsZ7t8sz0lUXzgOEAyetuz6O3bSRboBXOh45yz638jaFhIueU
	bLZIsyQbiBU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0552D111C0;
	Mon, 15 Apr 2013 06:50:40 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5FCEA111BC; Mon, 15 Apr
 2013 06:50:39 +0000 (UTC)
In-Reply-To: <20130413152257.GB16040@pvv.ntnu.no> (Torstein Hegge's message
 of "Sat, 13 Apr 2013 17:22:57 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C89EFF3A-A598-11E2-BD6F-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221194>

Torstein Hegge <hegge@resisty.net> writes:

> When bisect successfully finds a single revision, the first bad commit
> should be shown to human readers of 'git bisect log'.
>
> This resolves the apparent disconnect between the bisection result and
> the log when a bug reporter says "I know that the first bad commit is
> $rev, as you can see from $(git bisect log)".
>
> Signed-off-by: Torstein Hegge <hegge@resisty.net>
> ---
> I don't know how useful the added test is, I didn't find any existing
> tests that looks at the comment parts of bisect log.
>
>  git-bisect.sh               |    8 +++++++-
>  t/t6030-bisect-porcelain.sh |   18 ++++++++++++++++++
>  2 files changed, 25 insertions(+), 1 deletion(-)
>
> diff --git a/git-bisect.sh b/git-bisect.sh
> index 99efbe8..c58eea7 100755
> --- a/git-bisect.sh
> +++ b/git-bisect.sh
> @@ -311,7 +311,13 @@ bisect_next() {
>  	res=$?
>  
>  	# Check if we should exit because bisection is finished
> -	test $res -eq 10 && exit 0
> +	if test $res -eq 10
> +	then
> +		bad_rev=$(git show-ref --hash --verify refs/bisect/bad)
> +		bad_commit=$(git show-branch $bad_rev)
> +		echo "# first bad commit: $bad_commit" >>"$GIT_DIR/BISECT_LOG"

As this is "# commented out", replaying will safely ignore this new
record, so this should be safe.
