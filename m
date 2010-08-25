From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Use of field flags in struct object
Date: Wed, 25 Aug 2010 11:55:51 -0700
Message-ID: <7v7hjesers.fsf@alter.siamese.dyndns.org>
References: <AANLkTikvP1oKAiFNVwZ+kqy=jLhUKP1RRET8cq=XeyzT@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 25 20:56:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OoL8m-00055w-KO
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 20:56:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752235Ab0HYS4A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Aug 2010 14:56:00 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:56259 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751696Ab0HYSz6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Aug 2010 14:55:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8D34FD0410;
	Wed, 25 Aug 2010 14:55:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xTgvIF3QyDBTCUF7MT9+kBM4BeY=; b=xFk8h0
	VMa7SHN2z7Fte5dsN0OzDkPHkPflz85qSk7/U4AvGjo3zWl8GOrbj80mVzei3ZgJ
	ncOwTqpcUd7XbkCwVO1c41BgEmEdABPvu3BpnP3t9udHHVJl1mFj2FErsrROxLV0
	3NkRslUndbLWq6dwI8bxWA7S8Hveh5vQrfXCs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lFcdznz8cm9Br3fk1mTAyu2i4nnmW3H9
	PmO0i+xlc+yuFSExrLICiW+1FtK48su83VP/yEHTu6TZIbEEkhoZ+3G0W1NY8HLm
	1NiZSGzGjjcAK2QCbyfjw8B9Oe+C+m5A3cdGENe+/eUtOcxPifdZCzvZapqm7t88
	T9sxd47wWGY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 630F7D0409;
	Wed, 25 Aug 2010 14:55:55 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B9526D0408; Wed, 25 Aug
 2010 14:55:52 -0400 (EDT)
In-Reply-To: <AANLkTikvP1oKAiFNVwZ+kqy=jLhUKP1RRET8cq=XeyzT@mail.gmail.com>
 (Nguyen Thai Ngoc Duy's message of "Mon\, 16 Aug 2010 18\:21\:04 +1000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 63F2B128-B07A-11DF-A79D-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154461>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> The "flags" field in struct object (object.h) is used in a lot of
> places. The thing is, the bit definition of this field is distributed
> across files (16 according to my "object.flags |=" grep). This makes
> it quite easy for one function to misunderstand a bit set by another
> function, for a different purpose. For instance, in upload-pack.c,
> there is a comment:
>
> /* bits #0..7 in revision.h, #8..10 in commit.c */
>
> which is no longer true as commit.c has moved on and used another set
> of bits (16..19). Luckily, commit.c seems to clean its flags. But
> there's a chance we will get bit definition overlap again.
>
> Should all of those bit definitions be gathered in one place instead?

In the medium term, probably yes.  In longer term, we would probably need
to rethink how these flag bits are managed.  Some users of these bits
might want to be migrated to the decorate API, for example.  It may also
be a possible improvement to move some bits that are only relevant to
commit objects (e.g.  left-right traversal, treesame, boundary) to struct
commit and additionally widen the bitfields there.
