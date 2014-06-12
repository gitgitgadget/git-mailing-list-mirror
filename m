From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/2] add strbuf_set operations
Date: Thu, 12 Jun 2014 11:51:19 -0700
Message-ID: <xmqqmwdi55co.fsf@gitster.dls.corp.google.com>
References: <cover.1402557437.git.jmmahler@gmail.com>
	<f4d043b7c1e00f9c967faff39244274fe40fd371.1402557437.git.jmmahler@gmail.com>
	<539960B8.1080709@virtuell-zuhause.de>
	<20140612082218.GA5419@hudson.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Braun <thomas.braun@virtuell-zuhause.de>,
	git@vger.kernel.org
To: Jeremiah Mahler <jmmahler@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 12 20:51:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvA61-0006rT-7L
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jun 2014 20:51:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752390AbaFLSv2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2014 14:51:28 -0400
Received: from smtp.pobox.com ([208.72.237.35]:62543 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752371AbaFLSvZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2014 14:51:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7ADCF1E5FB;
	Thu, 12 Jun 2014 14:51:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=duubJfQsfX0PuLwxdQFjesasx+I=; b=NYT1ny
	hHpvFy506E59Gp6o/wTaaoSFbNd4EgdbvtXDi73FnYi5PYbfrodWg6XmkiRhaAWJ
	IkKMnouTJplSorEauUJRutfs5L9dYsNTQKIOHUrkOMpZZXIixuPjxVORHRJdUHls
	Z6R7DB9Xr1HQl998G+Z0Q4c7ds58uzmO88PCA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=H3YkxRYydtH6FzPdBfli13k7UByGFAnx
	/eDclQ5kQ4OZjLdIIVTBn1DfBn9wSKopdHn1DCkMGpVjejDwWrWbvgSxi8FnMJWb
	z6kMKlxLxASnGY5D5XPpZtMYH2wflA7RMy0BPfqRAFoGiic1HOJkL9ujySqkuF+y
	3Dsje/MQwK4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6EF3B1E5F9;
	Thu, 12 Jun 2014 14:51:25 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 7373C1E5EE;
	Thu, 12 Jun 2014 14:51:21 -0400 (EDT)
In-Reply-To: <20140612082218.GA5419@hudson.localdomain> (Jeremiah Mahler's
	message of "Thu, 12 Jun 2014 01:22:18 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 8BA59B1C-F262-11E3-BCB1-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251479>

Jeremiah Mahler <jmmahler@gmail.com> writes:

> Thomas,
>
> On Thu, Jun 12, 2014 at 10:11:36AM +0200, Thomas Braun wrote:
>> Am 12.06.2014 09:29, schrieb Jeremiah Mahler:
>> > A common use case with strubfs is to set the buffer to a new value.

strubfs???

>> > This must be done in two steps: a reset followed by an add.
>> > 
>> >   strbuf_reset(buf);
>> >   strbuf_add(buf, new_buf, len);
>> > 
>> > In cases where the buffer is being built up in steps, these operations
>> > make sense and correctly convey what is being performed.
>> > 
>> >   strbuf_reset(buf);
>> >   strbuf_add(buf, data1, len1);
>> >   strbuf_add(buf, data2, len2);
>> >   strbuf_add(buf, data3, len3);
>> > 
>> > However, in other cases, it can be confusing and is not very concise.
>> > 
>> >   strbuf_reset(buf);
>> >   strbuf_add(buf, default, len1);
>> > 
>> >   if (cond1) {
>> >     strbuf_reset(buf);
>> >     strbuf_add(buf, data2, len2);
>> >   }
>> > 
>> >   if (cond2) {
>> >     strbuf_reset(buf);
>> >     strbuf_add(buf, data3, len3);
>> >   }
>> > 
>> > Add strbuf_set operations so that it can be re-written in a clear and
>> > concise way.
>> > 
>> >   strbuf_set(buf, default len1);
>> very minor nit: missing comma between default and len1.
>
> I can't believe I missed that.  Good catch ;-)
