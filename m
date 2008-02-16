From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] http-push: avoid invalid memory accesses
Date: Fri, 15 Feb 2008 23:23:46 -0800
Message-ID: <7vabm1cqkd.fsf@gitster.siamese.dyndns.org>
References: <alpine.LSU.1.00.0802142319340.30505@racer.site>
 <alpine.LSU.1.00.0802142325120.30505@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mh@glandium.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Feb 16 08:24:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQHPt-0002FB-Ip
	for gcvg-git-2@gmane.org; Sat, 16 Feb 2008 08:24:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751288AbYBPHYV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Feb 2008 02:24:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751234AbYBPHYV
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Feb 2008 02:24:21 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:33793 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751170AbYBPHYV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Feb 2008 02:24:21 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 0126033A7;
	Sat, 16 Feb 2008 02:24:07 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 3441833A5; Sat, 16 Feb 2008 02:23:58 -0500 (EST)
In-Reply-To: <alpine.LSU.1.00.0802142325120.30505@racer.site> (Johannes
 Schindelin's message of "Thu, 14 Feb 2008 23:25:33 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74024>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Before objects are sent, the respective ref is locked.  However,
> without this patch, the lock is lifted before the last object for
> that ref was sent.  As a consequence, the lock data was accessed
> after the lock structure was free()d.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  http-push.c |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
>
> diff --git a/http-push.c b/http-push.c
> index b2b410d..7a6c669 100644
> --- a/http-push.c
> +++ b/http-push.c
> @@ -2398,7 +2398,10 @@ int main(int argc, char **argv)
>  		fill_active_slots();
>  		add_fill_function(NULL, fill_active_slot);
>  #endif
> -		finish_all_active_slots();
> +		do {
> +			finish_all_active_slots();
#ifdef CURL_MULTI
> +			fill_active_slots();
#endif
> +		} while (request_queue_head && !aborted);
>  
>  		/* Update the remote branch if all went well */
>  		if (aborted || !update_remote(ref->new_sha1, ref_lock)) {
> -- 
> 1.5.4.1.1353.g0d5dd

I wonder if we should define a no-op function fill_active_slots()
for non MULTI case...
