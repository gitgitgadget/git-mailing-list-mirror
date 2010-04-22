From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2 v3] Make diffcore_std only can run once before a
 diff_flush.
Date: Thu, 22 Apr 2010 13:41:12 -0700
Message-ID: <7v1ve743vb.fsf@alter.siamese.dyndns.org>
References: <1271945142-27015-1-git-send-email-struggleyb.nku@gmail.com>
 <1271945142-27015-2-git-send-email-struggleyb.nku@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, trast@student.ethz.ch
To: Bo Yang <struggleyb.nku@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 22 22:43:18 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O53Ez-0005Ji-AF
	for gcvg-git-2@lo.gmane.org; Thu, 22 Apr 2010 22:43:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757883Ab0DVUlZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Apr 2010 16:41:25 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:55280 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758582Ab0DVUlW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Apr 2010 16:41:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 92F67ADEEE;
	Thu, 22 Apr 2010 16:41:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YJeIypAnT3zqjHda4uztrIj1cEw=; b=LwZ9R2
	G/ZdM2MYfMFGGSl7vBibCKmBxpdLu8GRsxKD8fda98zAIIlkFt+7lfWJCkUnblxY
	VzMUWvVPN4j/RYioIihBvp2ZZEsChWB349vDFgM3QoL5sa3ZdBIemmS2rKv1RR/E
	yEeZvPqMLJzzj+XJXdIdKHBmCtVIsmN20sGwk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=R3CfKg0yPMf4/Eq1makAjCp9RvQ2ZDoB
	ChZnDKr4aVyQE5FlIF/gH1YCViYiLCB/+oe29CbbiJl3jubTsC3sDuOMdBWiA9Jt
	0IIJ9Q/Kfif9a+XIJP2j5TVsl0tpVkYuFsMUBg6EaKJZy2rXiRNGClqrehvRspbF
	6Es/o2IjUxY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 52AF3ADEEA;
	Thu, 22 Apr 2010 16:41:17 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7DF16ADEE4; Thu, 22 Apr
 2010 16:41:13 -0400 (EDT)
In-Reply-To: <1271945142-27015-2-git-send-email-struggleyb.nku@gmail.com> (Bo
 Yang's message of "Thu\, 22 Apr 2010 22\:05\:41 +0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 66792752-4E4F-11DF-A9D4-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145559>

Bo Yang <struggleyb.nku@gmail.com> writes:

> So, I think we really don't need to run diffcore_std more
> than one time.

It actually is stronger than that; we should never run it more than once,
and it would be a bug if we did so.  Which codepath tries to call *_std()
twice?

The standard calling sequence is:

 - start from an empty queue.

 - use diff_change() and diff_addremove() to populate the queue.

 - call diffcore_std(). if you need to use a non-standard chain of
   diffcore transformations, you _could_ call the diffcore_* routines that
   diffcore_std() calls, if you choose to, but as you found out, some of
   them are not idempotent operations, and shouldn't be called twice.

 - and finally call diffcore_flush().

> @@ -3745,6 +3742,12 @@ void diffcore_fix_diff_index(struct diff_options *options)
>  
>  void diffcore_std(struct diff_options *options)
>  {
> +	/* We never run this function more than one time, because the
> +	 * rename/copy detection logic can only run once.
> +	 */
> +	if (diff_queued_diff.run)
> +		return;

Shouldn't this be a BUG() instead?

The trivial rewrite to use this macro is a good idea, but it probably
should be a separate patch.

> +#define DIFF_QUEUE_CLEAR(q) \
> +	do { \
> +		(q)->queue = NULL; \
> +		(q)->nr = (q)->alloc = (q)->run = 0; \
> +	} while(0);
