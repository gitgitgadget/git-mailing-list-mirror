From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [REROLL PATCH 2/8] Support mandatory capabilities
Date: Tue, 08 Dec 2009 15:34:34 -0800
Message-ID: <7vzl5t59bp.fsf@alter.siamese.dyndns.org>
References: <1260278177-9029-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <1260278177-9029-3-git-send-email-ilari.liusvaara@elisanet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Wed Dec 09 00:34:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NI9Zu-0004pd-AA
	for gcvg-git-2@lo.gmane.org; Wed, 09 Dec 2009 00:34:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965194AbZLHXeg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Dec 2009 18:34:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937006AbZLHXef
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Dec 2009 18:34:35 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:56046 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937002AbZLHXee (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Dec 2009 18:34:34 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3A823A52A3;
	Tue,  8 Dec 2009 18:34:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=Csb6UEz2WwbR7ry7tlvyUXzjNyE=; b=EUuKt+1q8P8mm89K4Rl/QRJ
	j2KSt/wEzPh6+UjixdwH/ZBqaGgPjfYL0tX1NgCIgKAne52MUcwEa6sbTO+cMBcc
	EPKOzu89jtUyMhgXwyS+UyYxEhJRleCiYVysAQaSSBHzfccc1/jaTvJpxZjaxOqe
	OKFNT3nuDCnhB2eGuFM8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=OFnGjXKV6jzPeTO4Kzaepu/VSCOqqL9cemL+Rl4Um/OwF1lWR
	OfWW0DLnXgNZMzdBRKGFh/qKh544TKQZkF0w6xFEZ3888oA7zgM+0S/yMtZ/wsVR
	4qujxqbf/jnUJtHfbETlkZ7UPUi84ICSiCH4FIAaIr6wUxyrAOnnw/NV5g=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1919CA52A2;
	Tue,  8 Dec 2009 18:34:39 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 224C3A52A1; Tue,  8 Dec 2009
 18:34:35 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 40A37508-E452-11DE-A6AE-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134922>

Ilari Liusvaara <ilari.liusvaara@elisanet.fi> writes:

> diff --git a/transport-helper.c b/transport-helper.c
> index a721dc2..f977d28 100644
> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -93,25 +93,39 @@ static struct child_process *get_helper(struct transport *transport)
>  
>  	data->out = xfdopen(helper->out, "r");
>  	while (1) {
> +		const char *capname;
> +		int mandatory = 0;
>  		recvline(data, &buf);
> ...
> +		} else if (mandatory) {
> +			fflush(stderr);
> +			die("Unknown madatory capability %s. This remote "
> +			    "helper probably needs newer version of Git.\n",
> +			    capname);

Why fflush() here?  Is the reason for needing to flush stderr before
letting die() to write into it very specific to this codepath, or shared
among other callers of die()?  I am wondering if we should add this
fflush() to report() in usage.c instead.
