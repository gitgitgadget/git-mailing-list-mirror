From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RFC] git-am: support any number of signatures
Date: Fri, 13 Jun 2014 10:32:09 -0700
Message-ID: <xmqqy4x03ecm.fsf@gitster.dls.corp.google.com>
References: <1402589505-27632-1-git-send-email-mst@redhat.com>
	<xmqqioo654mg.fsf@gitster.dls.corp.google.com>
	<20140613080036.GA2117@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Fri Jun 13 19:32:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvVKv-00062D-5d
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 19:32:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753530AbaFMRcR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2014 13:32:17 -0400
Received: from smtp.pobox.com ([208.72.237.35]:64895 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753406AbaFMRcQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2014 13:32:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EF0DF1F9FF;
	Fri, 13 Jun 2014 13:32:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mdOXOO7Q87W3U32Jj8hiZO2XYx8=; b=OIg7hN
	jX/N5D6UI05ooPmWdmUVNeao/veS1x+Zs7LzquiRmv/l7cVp35yuA6EJ+89XlMD1
	EzEegKg0x80iFOOwqydn21Aa19c7eK2FxqKEzLu+CW+hzYuDqShPUBa+tvwjJteA
	jzbCzgc3BGkw/onudDz3sHD9rJTe+mtgNbAoY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=r8zm9Bu9h6Py2eLl9whum2QTmqxQfsh3
	7eWp6bPK3qk8BQwMM0aCI2ZvUr57Scw55aKA12l/4ZIbftlRS3M4u8ni34sjZw1v
	KY5WypYhq5o6Oi9xiuIHJAhRCmoA+0JLPbe5A60d06mnxW+JJA3qGq4gT6FMcre1
	NOrnHoQfkpQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E3FAD1F9FE;
	Fri, 13 Jun 2014 13:32:15 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A916D1F9DC;
	Fri, 13 Jun 2014 13:32:11 -0400 (EDT)
In-Reply-To: <20140613080036.GA2117@redhat.com> (Michael S. Tsirkin's message
	of "Fri, 13 Jun 2014 11:00:36 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A6F8117E-F320-11E3-9039-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251618>

"Michael S. Tsirkin" <mst@redhat.com> writes:

> On Thu, Jun 12, 2014 at 12:07:03PM -0700, Junio C Hamano wrote:
>> "Michael S. Tsirkin" <mst@redhat.com> writes:
>> ...
>> > 1.  new parameter am.signoff can be used any number
>> > 	of times:
>> >
>> > [am]
>> > 	signoff = "Reviewed-by: Michael S. Tsirkin <mst@redhat.com>"
>> > 	signoff = "Signed-off-by: Michael S. Tsirkin <mst@redhat.com>"
>> >
>> > 	if set all signatures are picked up when git am -s is used.
>> 
>> How does this interact with the logic to avoid appending the same
>> Signed-off-by: line as the last one the incoming message already
>> has?
>
> Not handled if you have multiple signatures.
> That will have to be fixed.
> Do we only care about the last line?
>
> Signed-off-by: A
> Signed-off-by: B
>
> do we want to add
>
> Signed-off-by: A
>
> or would it be better to replace with
> Signed-off-by: B
> Signed-off-by: A
>
> ?
>
> Current git am will add A twice, I wonder if this is
> a feature or a bug.

This is very much deliberate.

Appending A after existing A and B is meant to record that the patch
originated from A, passed thru B possibly with changes by B, came
back to A who wants to assert that the result is still under DCO.

The only case we can safely omit appending A's sign-off is when the
last one in the chain is by A.  Imagine that you had a patch signed
off by B, which A may have tweaked and forwarded under DCO with A's
sign-off.  Such a patch would have sign-off chain B-A.

Now A makes further changes to the patch and says "the further
change is also something I am authorized to release as open source"
with the "-s" option or some other way.  It would not change that A
can contribute under DCO if we did not add an extra A after existing
B-A sign-off chain in that case.
