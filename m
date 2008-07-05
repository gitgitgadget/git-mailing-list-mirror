From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix t7601-merge-pull-config.sh on AIX
Date: Fri, 04 Jul 2008 18:49:03 -0700
Message-ID: <7vk5g1t81c.fsf@gitster.siamese.dyndns.org>
References: <20080705002634.GF4729@genesis.frugalware.org>
 <1215217920-8506-1-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Olivier Marin <dkr@freesurf.fr>, git@vger.kernel.org,
	Mike Ralphson <mike@abacus.co.uk>
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sat Jul 05 03:53:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEwxY-0000tA-BA
	for gcvg-git-2@gmane.org; Sat, 05 Jul 2008 03:53:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751415AbYGEBtU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jul 2008 21:49:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751262AbYGEBtT
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jul 2008 21:49:19 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:56197 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751246AbYGEBtT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jul 2008 21:49:19 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 2A33019AE9;
	Fri,  4 Jul 2008 21:49:17 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 4407219AE6; Fri,  4 Jul 2008 21:49:10 -0400 (EDT)
In-Reply-To: <1215217920-8506-1-git-send-email-vmiklos@frugalware.org>
 (Miklos Vajna's message of "Sat, 5 Jul 2008 02:32:00 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 93EE460C-4A34-11DD-8AFB-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87427>

Miklos Vajna <vmiklos@frugalware.org> writes:

> diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.sh
> index 32585f8..12f71ad 100755
> --- a/t/t7601-merge-pull-config.sh
> +++ b/t/t7601-merge-pull-config.sh
> @@ -70,10 +70,10 @@ test_expect_success 'merge c1 with c2 and c3 (recursive and octopus in pull.octo
>  
>  conflict_count()
>  {
> -	eval $1=`{
> +	eval $1=$({
>  		git diff-files --name-only
>  		git ls-files --unmerged
> -	} | wc -l`
> +	} | wc -l | tr -d \ )
>  }

In any case, this feels like an unnecessary use of eval.  The call site
you have look like this:

	conflict_count resolve_count

but it is more natural if you are programming in shell to call it like:

	resolve_count=$(count_conflicts)

and it is more natural to write count_conflicts like this:

	count_conflicts () {
		{
                	git diff-files --name-only --diff-filter=U
                        git ls-files --unmerged
                } | wc -l
        }

But I am puzzled about the alledged *breakage* -- look at your call
sites.

        reset --hard
	.. do a merge ..
        conflict_count count_one

	reset --hard
        .. do another merge ..
        conlict_count count_two

	reset --hard
        .. do yet another merge ..
        conlict_count count_three

	test "$count_three" = "$count_two"

At any point, you do not do numerical comparison, and I do not think extra
whitespace from other "wc" implementations matter, as long as they are
consistent.

If you are going to do numerical comparison in later versions, you can
just drop the dq around parameters of test:

	test $count_three = $count_two
