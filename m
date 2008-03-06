From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] format-patch: add --reviewed-by=<ident>
Date: Wed, 05 Mar 2008 18:40:20 -0800
Message-ID: <7v8x0wh8x7.fsf@gitster.siamese.dyndns.org>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at>
 <1204138503-6126-4-git-send-email-johannes.sixt@telecom.at>
 <alpine.LSU.1.00.0802281159550.22527@racer.site>
 <200803052221.12495.johannes.sixt@telecom.at>
 <alpine.LSU.1.00.0803052317350.15786@racer.site>
 <7vir00lski.fsf@gitster.siamese.dyndns.org>
 <alpine.LSU.1.00.0803052327570.15786@racer.site>
 <alpine.LSU.1.00.0803060214520.15786@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 06 03:41:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JX62f-0004W3-8Y
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 03:41:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761308AbYCFCkb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2008 21:40:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759545AbYCFCka
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 21:40:30 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:39212 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756132AbYCFCk3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2008 21:40:29 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 52B8A24A7;
	Wed,  5 Mar 2008 21:40:27 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 19D9F24A6; Wed,  5 Mar 2008 21:40:22 -0500 (EST)
In-Reply-To: <alpine.LSU.1.00.0803060214520.15786@racer.site> (Johannes
 Schindelin's message of "Thu, 6 Mar 2008 02:15:24 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76313>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>  'git-format-patch' [-k] [-o <dir> | --stdout] [--thread]
>  		   [--attach[=<boundary>] | --inline[=<boundary>]]
> +		   [--reviewed-by=<ident>]
>  		   [-s | --signoff] [<common diff options>]
>  		   [-n | --numbered | -N | --no-numbered]
>  		   [--start-number <n>] [--numbered-files]

What's the expected workflow this patch intends to help?

 - You see a patch by somebody, you look at it deeply, you apply to your
   tree (presumably with your own Signed-off-by).

 - You inspect the result further, and decide it is good.

 - You format-patch with the option, which would now have a Reviewed-by:
   too.

 - You send it out.

If so, it might make sense to simply always use the committer ident.

If the person who adds the reviewed-by is trusted so much that her
reviewed-by counts, the commits might even be transfered with "Please
pull".  In such a case, the workflow might become:

 - You see a patch by somebody, you look at it deeply, you apply to your
   tree (presumably with your own Signed-off-by).

 - You inspect the result further, and decide it is good.

 - You run "rebase --add-reviewed-by" to prepare a series on a branch to
   be pulled from.

 - You send a request-pull.

In that workflow, it would also make sense to use the committer ident.

I am trying to come up with a plausible workflow that wants to add
somebody else's reviewed-by.

 - You send out your patch to the list.  People give comments, you reroll,
   you get more comments, eventually people say "Ah, that's good, Ack."
   and/or "I am not the primary person who knows this area, but I reviewed
   it and I know my reviewed-by would count, so here is my Ok".

 - You format-patch the final version, with Acked-by and Reviewed-by
   adding other people's names.

Then I think it makes sense to take names of other people if that is the
case.

You probably meant that that is the expected workflow, as you can give
more than one of these options.

But people who read the documentation should not have to guess.

> diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
> index b2b7a8d..e2ff94f 100755
> --- a/t/t4014-format-patch.sh
> +++ b/t/t4014-format-patch.sh
> @@ -230,4 +230,30 @@ test_expect_success 'shortlog of cover-letter wraps overly-long onelines' '
>  
>  '
>  
> +cat > expect << EOF
> +
> +Reviewed-by: Ken Robinson
> +
> +Reviewed-by: Sergey Rachmaninov
> +
> +Reviewed-by: Ronny O Sullivan
> +Reviewed-by: Mickey Mouse
> +Reviewed-by: Mahatma Gandhi
> +EOF
> +
> +test_expect_success '--reviewed-by' '
> +
> +	echo reviewed > foo &&
> +	test_tick &&
> +	git commit -m "Reviewed" -m "Reviewed-by: Ken Robinson" \
> +		-m "Reviewed-by: Sergey Rachmaninov" \
> +		-m "Reviewed-by: Ronny O Sullivan" foo &&
> +	git format-patch --reviewed-by="Mickey Mouse" \
> +		--reviewed-by="Sergey Rachmaninov" \
> +		--reviewed-by="Mahatma Gandhi" -1 HEAD &&
> +	sed -e "1,/^Cc: /d" -e "/^---/,\$d" < 0001-Reviewed.patch > output &&
> +	git diff expect output
> +
> +'

Why not use a single -m for the first three reviewed-bys, instead of
making them into separate paragraphs using multiple -m?

