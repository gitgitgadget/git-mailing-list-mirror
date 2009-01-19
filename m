From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] interpret_nth_last_branch(): avoid traversing the
 reflogs twice
Date: Mon, 19 Jan 2009 00:19:09 -0800
Message-ID: <7vljt7r9mq.fsf@gitster.siamese.dyndns.org>
References: <7v8wpcs38c.fsf@gitster.siamese.dyndns.org>
 <1232163011-20088-1-git-send-email-trast@student.ethz.ch>
 <alpine.DEB.1.00.0901170646560.3586@pacific.mpi-cbg.de>
 <200901171438.22504.trast@student.ethz.ch>
 <alpine.DEB.1.00.0901171602340.3586@pacific.mpi-cbg.de>
 <7vljt97nld.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0901172028470.3586@pacific.mpi-cbg.de>
 <7vmydp5tqj.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0901180201070.3586@pacific.mpi-cbg.de>
 <7vprilyt1w.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0901182152010.3586@pacific.mpi-cbg.de>
 <7vprijra52.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Johan Herland <johan@herland.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jan 19 09:20:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOpNE-0002P7-5D
	for gcvg-git-2@gmane.org; Mon, 19 Jan 2009 09:20:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753009AbZASITU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2009 03:19:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752968AbZASITU
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jan 2009 03:19:20 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:57583 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752630AbZASITT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jan 2009 03:19:19 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 60741917F1;
	Mon, 19 Jan 2009 03:19:17 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 28B46917EA; Mon,
 19 Jan 2009 03:19:11 -0500 (EST)
In-Reply-To: <7vprijra52.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 19 Jan 2009 00:08:09 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: DD57555E-E601-11DD-AA1A-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106333>

Junio C Hamano <gitster@pobox.com> writes:

> Well, I would rather be in favor of something like this.
>
> -- >8 --
> Subject: interpret_nth_last_branch(): avoid traversing the reflog twice
>
> You can have quite a many reflog entries, but you typically won't recall
> which branch you were on after switching branches for more than several
> times.
>
> Instead of reading the reflog twice, this reads the branch switching event
> and keeps the latest 16 (which is an arbitrary limitation that should be
> plenty) such entry, to switch back to the branch we were recently on.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  sha1_name.c              |   48 +++++++++++++++++++++------------------------
>  t/t2012-checkout-last.sh |   44 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 66 insertions(+), 26 deletions(-)
>
> diff --git a/sha1_name.c b/sha1_name.c
> index 9e1538e..d6622f2 100644
> --- a/sha1_name.c
> +++ b/sha1_name.c
> @@ -750,19 +746,19 @@ int interpret_nth_last_branch(const char *name, struct strbuf *buf)
>  	nth = strtol(name+3, &num_end, 10);
>  	if (num_end != brace)
>  		return -1;
> ...
> -	if (cb.nth < nth)
> -		return 0;
> ...
> +	if (cb.cnt < nth)
> +		return -1;

This should (obviously) be "return 0".
