From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rev-list: estimate number of bisection step left
Date: Mon, 16 Feb 2009 23:28:18 -0800
Message-ID: <7vljs58qul.fsf@gitster.siamese.dyndns.org>
References: <20090217060944.488184b0.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Tue Feb 17 08:29:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZKOy-0005vS-3w
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 08:29:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751213AbZBQH22 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 02:28:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750973AbZBQH22
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 02:28:28 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40875 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750848AbZBQH21 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 02:28:27 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 3A69399473;
	Tue, 17 Feb 2009 02:28:26 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id CB79399472; Tue,
 17 Feb 2009 02:28:21 -0500 (EST)
In-Reply-To: <20090217060944.488184b0.chriscool@tuxfamily.org> (Christian
 Couder's message of "Tue, 17 Feb 2009 06:09:44 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 90AEFD36-FCC4-11DD-B807-0433C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110321>

Christian Couder <chriscool@tuxfamily.org> writes:

> +static int estimate_bisect_steps(int all)
> +{
> +	int log2 = 0;
> +	int left = (all >> 1) - 1;
> +
> +	if (left <= 0)
> +		return 0;
> +
> +	do {
> +		left = left >> 1;
> +		log2++;
> +	} while (left);
> +
> +	return log2;
> +}
> ...
> diff --git a/git-bisect.sh b/git-bisect.sh
> index 85db4ba..6b23439 100755
> --- a/git-bisect.sh
> +++ b/git-bisect.sh
> @@ -500,7 +500,7 @@ bisect_next() {
>  	# commit is also a "skip" commit (see above).
>  	exit_if_skipped_commits "$bisect_rev"
>  
> -	bisect_checkout "$bisect_rev" "$bisect_nr revisions left to test after this"
> +	bisect_checkout "$bisect_rev" "$bisect_nr revisions left to test after this (roughtly $bisect_steps steps)"

"roughly".

all	left
0	0
1	0
2	0
3	0
4	1
5	1
6	2
7	2
8	2
9	2

It seems that at the very low end the estimate is a bit too optimistic.
How about showing this number from the Porcelain only when $bisect_steps
is more than 2 (or all is more than 9)?
