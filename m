From: Junio C Hamano <gitster@pobox.com>
Subject: Re: jc/lookup-object-hash from pu crashes on ARM
Date: Mon, 31 Oct 2011 13:28:22 -0700
Message-ID: <7vhb2oq521.fsf@alter.siamese.dyndns.org>
References: <7vzkglrnmc.fsf@alter.siamese.dyndns.org>
 <20111031125648.GA1757@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 31 21:28:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RKyT9-0000Nn-L1
	for gcvg-git-2@lo.gmane.org; Mon, 31 Oct 2011 21:28:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934563Ab1JaU20 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Oct 2011 16:28:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64221 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933843Ab1JaU2Z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Oct 2011 16:28:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D3C3751A8;
	Mon, 31 Oct 2011 16:28:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZbGEewLG0jQ5Kpmnqdlps9+zmB8=; b=Qbyzhq
	OtbYbAVZEMNzgzYz7NpLR2VQ84461D7+JiMpH4oVATwVOLDZ+EREFvUXR1i1yHK2
	Ffe/+L4R9TduBvRcb3DvIGefyYJQV0PlBLCq7LolCjYobscQUpRu+Q+EN1XmI8B3
	0vExBvgpTbgrv75pxxyrX3GMnAr5kt/6UUF5U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=L0cvHulQLxSiCtoCFptMt8LttyIw7Pue
	cO4o+DWN8mBalQBm5LvH3QkhKbBbvuYd89poKejlG0fhlGtbQDaNtDQvWVr8otUK
	MozVC+Vyxiu6ZhspO602pOcoIDaEmfYq+9LOUxzWu9iCtmh77VKQ7gamkM2gjvYp
	GmVK7/h2GUc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C4E5E51A7;
	Mon, 31 Oct 2011 16:28:24 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3E86F51A6; Mon, 31 Oct 2011
 16:28:24 -0400 (EDT)
In-Reply-To: <20111031125648.GA1757@elie.hsd1.il.comcast.net> (Jonathan
 Nieder's message of "Mon, 31 Oct 2011 07:56:48 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E1CC4018-03FE-11E1-84AF-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184521>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Even better could be to start aligning the hashes we pass around,
> using something like this:
>
> 	union object_hash {
> 		unsigned char sha1[20];
> 		uint32_t chunk[5];
> 	};
>
> which could speed up functions like hashcpy(), hashcmp(), and
> hasheq().  But it's probably not worth the fuss.

The "flag" field in struct ref_list should be moved down to assure
alignment.

        struct ref_list {
                struct ref_list *next;
                unsigned char flag; /* ISSYMREF? ISPACKED? */
                unsigned char sha1[20];
                unsigned char peeled[20];
                char name[FLEX_ARRAY];
        };

I am very tempted to take that "union" approach (modulo that I would call
that an "object_name") in the longer run, though.
