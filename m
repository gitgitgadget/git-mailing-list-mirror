From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 05/21] git p4 test: use client_view to build the initial
 client
Date: Fri, 28 Sep 2012 12:06:03 -0700
Message-ID: <7va9waklbv.fsf@alter.siamese.dyndns.org>
References: <1348833865-6093-1-git-send-email-pw@padd.com>
 <1348833865-6093-6-git-send-email-pw@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Fri Sep 28 21:19:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THg5X-0007hH-0i
	for gcvg-git-2@plane.gmane.org; Fri, 28 Sep 2012 21:19:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030936Ab2I1TSq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2012 15:18:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:32825 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031062Ab2I1TSb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2012 15:18:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B74458159;
	Fri, 28 Sep 2012 15:18:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=v1XumYmonzt7Fe3CEy4s7+8ebww=; b=rdB8sD6HRqghDkoET6xq
	P4gLns1oq/N6jjvHLWXXsyXTzeV7ad3uMemqcNIKGPRAa3GqL5m2dWxXp9qiO52Z
	bK1sHQFMT/aS9KwOiVvx8sHrpi8FrKyEp5Kk5+p8CPTt87mG7EF+7rT/rN446DM0
	fwj42nBhYRay6bkcgqTtSDQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=VJxwc7R66P/Gec3csEV7Fsvfk0e+BVhY1vp2r9Tr8eSSNx
	BTgICHzXpavOD77ZHTW6a1S9C/75I/jJel+ASveFuuyLOdSl9CfcE1MUUJ743I1b
	Xu4bIjVqFMOnGDeTmaxVUSycUDRMBYcmhyJzXsmkkqF0r/5AsrYP8VbbaWsCo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A67AA8158;
	Fri, 28 Sep 2012 15:18:30 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 09A988157; Fri, 28 Sep 2012
 15:18:29 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4967E850-09A1-11E2-8BFB-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206598>

Pete Wyckoff <pw@padd.com> writes:

> Simplify the code a bit by using an existing function.
>
> Signed-off-by: Pete Wyckoff <pw@padd.com>
> ---
>  t/lib-git-p4.sh | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
>
> diff --git a/t/lib-git-p4.sh b/t/lib-git-p4.sh
> index 7061dce..890ee60 100644
> --- a/t/lib-git-p4.sh
> +++ b/t/lib-git-p4.sh
> @@ -74,15 +74,8 @@ start_p4d() {
>  	fi
>  
>  	# build a client
> -	(
> -		cd "$cli" &&
> -		p4 client -i <<-EOF
> -		Client: client
> -		Description: client
> -		Root: $cli
> -		View: //depot/... //client/...
> -		EOF
> -	)
> +	client_view "//depot/... //client/..." &&
> +
>  	return 0
>  }

Assuming that writing //depot/... //client/... on the next line
indented by a tab is equivalent to writing it on View: line (which I
think it is), this looks like an obviously good reuse of the code.

I have to wonder if the use of printf in client_view implementation
should be tighted up, though.

diff --git i/t/lib-git-p4.sh w/t/lib-git-p4.sh
index 7061dce..4e58289 100644
--- i/t/lib-git-p4.sh
+++ w/t/lib-git-p4.sh
@@ -128,8 +128,6 @@ client_view() {
 		Root: $cli
 		View:
 		EOF
-		for arg ; do
-			printf "\t$arg\n"
-		done
+		printf "\t%s\n" "$@"
 	) | p4 client -i
 }
