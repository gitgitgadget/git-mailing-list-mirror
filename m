From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-imap-send bugfix: Allow lines starting with "From "
 in  body
Date: Sun, 21 Mar 2010 15:05:36 -0700
Message-ID: <7vwrx5gwjz.fsf@alter.siamese.dyndns.org>
References: <f3271551003211147x538d7682wc67dcc4f914ed97c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>, me@mutt.org,
	ossi@users.sf.net, tytso@mit.edu, mike@codeweavers.com
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 21 23:06:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtTHf-0006dV-9R
	for gcvg-git-2@lo.gmane.org; Sun, 21 Mar 2010 23:06:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753482Ab0CUWGG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Mar 2010 18:06:06 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46057 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751874Ab0CUWGD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Mar 2010 18:06:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D559A34F3;
	Sun, 21 Mar 2010 18:05:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type; s=sasl; bh=moejNxVZj7eyq8l8UFGi1RmE6KI=; b=RwNALj
	C1FaNXZpvUFiWiCaQDU+HZqph6TVXy+HcBaJgLEWu1FkZoDLO/PfN0RZqSIGNRnW
	vyief7FETb4X+KR+oJTmo0Q7byOlDX9985CGb02nXLZsKrMrRkCmeNavsrR3TkDz
	0jXFyh7laY4eOa5G0RpEJBeQ1ag2IwjuJBiCo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sS97wbTIAZrPwmrsMcicc3w/Y3GCX7+L
	yFHvzekmNV7KDpUs3hRbtHsyosiTmv8nQTByFLzMcykJQYqdYk7Rpv9Ir/t+T2qe
	DRoCIF9bcTUyyY6rK7QEYt0wg636y8C5l9yvvynVDHSjqAHiJQwT3rEWSTopL0rL
	OTYIyty5zXc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D9ACA34F2;
	Sun, 21 Mar 2010 18:05:45 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 08256A34F1; Sun, 21 Mar
 2010 18:05:37 -0400 (EDT)
In-Reply-To: <f3271551003211147x538d7682wc67dcc4f914ed97c@mail.gmail.com>
 (Ramkumar Ramachandra's message of "Mon\, 22 Mar 2010 00\:17\:49 +0530")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E65E8E36-3535-11DF-96E2-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142866>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> diff --git a/imap-send.c b/imap-send.c
> index aeb2985..3163bb9 100644
> --- a/imap-send.c
> +++ b/imap-send.c
> @@ -1431,8 +1431,14 @@ static int count_messages(struct msg_data *msg)
>
>  	while (1) {
>  		if (!prefixcmp(p, "From ")) {
> +			p = strstr(p+5, "\nFrom: ");
> +			if (!p) break;
> +			p = strstr(p+7, "\nDate: ");
> +			if (!p) break;
> +			p = strstr(p+7, "\nSubject: ");
> +			if (!p) break;
>  			count++;
> -			p += 5;
> +			p += 10;

The last "increment by 10" is logically tied to the last string being
checked happens to be "\nSubject: ", so I would prefer to have the
"increment count" be done after that.  That way you will keep logically
close things physically close together.

As "git help imap-send" clearly says that this command is intended to be
used on output from format-patch (but it actually does not say "and
nothing else", which it should for your patch to make sense), I think the
code is allowed to assume _some_ fixed order of the header fields.  It
would break people's existing abuse to use imap-send to stuff random
pieces of messages in mbox to their IMAP server, though.

But does format-patch _always_ start each message with these and only with
these fields in this order?  Where would Message-Id:, References:, and Cc:
come when the user told format-patch to add them?
