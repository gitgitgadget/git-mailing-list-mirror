From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] decorate: allow storing values instead of pointers
Date: Mon, 11 Jul 2011 12:06:08 -0700
Message-ID: <7vr55wd1hw.fsf@alter.siamese.dyndns.org>
References: <20110711161332.GA10057@sigill.intra.peff.net>
 <20110711161649.GA10418@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Ted Ts'o <tytso@mit.edu>, Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?B?w4Z2?= =?utf-8?B?YXIgQXJuZmrDtnLDsA==?= Bjarmason 
	<avarab@gmail.com>, Clemens Buchacher <drizzd@aon.at>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jul 11 22:08:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgMmA-0005Gk-BX
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jul 2011 22:08:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753194Ab1GKUIP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jul 2011 16:08:15 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:45459 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752512Ab1GKUIN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2011 16:08:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 88C91626B;
	Mon, 11 Jul 2011 16:08:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=uyO4E87mcA2JBLnJcP0MCNh30Fs=; b=dzFKqJmXUNTr2+cPIOo9
	upEvkteCsk+X/SPo68j+YxXQZm+ZnEQydMo7xmLCaZ7daEcPRjh5jlVBo2+cxmFf
	eKVwyxxFx3zvSBKNobw3UMf1lpEonb4uKU9FQDtNMts4QxvJ7vfwuYYVrwpi+HD/
	nzJ3eY4kiX3F/cObfqOHp0g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=wcr+9ldTD4VIA5rLphsTRWKMBG8HWk6TMZAAdqQqpXbIBy
	CpKMqm0P3Zz7enZBErujnzZS9YdjyUkKeYiPDmSfE7IfiA3Zu6P0gxQcnJ8BUMK3
	dxfOwtb/SAZkeRo/Njhrw3h4PG6kMIk9URftBf2pUoHumyQ+wVvqRpDjfwoUY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8156E626A;
	Mon, 11 Jul 2011 16:08:13 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C87076269; Mon, 11 Jul 2011
 16:08:12 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8175E870-ABF9-11E0-862E-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176888>

Jeff King <peff@peff.net> writes:

>  static void grow_decoration(struct decoration *n)
>  {
> -	int i;
> -	int old_size = n->size;
> -	struct object_decoration *old_hash = n->hash;
> +	unsigned char *old_hash = n->hash;
> +	unsigned char *old_end = n->end;
> +	unsigned char *p;
>  
> -	n->size = (old_size + 1000) * 3 / 2;
> -	n->hash = xcalloc(n->size, sizeof(struct object_decoration));
> +	n->stride = sizeof(struct object_decoration) + WIDTH(n);

This value should not change once it is initialized, or all h*ll breaks
loose while accessing the old-hash, right?  Just wondering if it makes the
intention clearer if the function had something like this in it:

	if (!old_size) {
		/* initial */
                n->stride = ...
	} else {
		/* rehash to grow */
	}

I am mostly worried about both width and stride being assignable
fields. An alternative may be to expose

	int decoration_stride(struct decoration *n)
        {
        	return sizeof(struct object_decoration) + WIDTH(n);
	}

to the outside callers and drop "stride" field.
