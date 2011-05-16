From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 09/11] streaming: read non-delta incrementally from a
 pack
Date: Sun, 15 May 2011 22:00:50 -0700
Message-ID: <7v62pbnssd.fsf@alter.siamese.dyndns.org>
References: <1305505831-31587-1-git-send-email-gitster@pobox.com>
 <1305505831-31587-10-git-send-email-gitster@pobox.com>
 <BANLkTin7DALU8sfFxzJo62DGtNE2fsZxXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon May 16 07:01:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLpvW-0005pU-4n
	for gcvg-git-2@lo.gmane.org; Mon, 16 May 2011 07:01:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750984Ab1EPFA6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2011 01:00:58 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:59387 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750938Ab1EPFA6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2011 01:00:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0432832C8;
	Mon, 16 May 2011 01:03:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1CswdtOONJ3MoX2iE7BAeib02Qk=; b=H8ff5a
	AdFbwpSetTwUMK8CSbmNL+praXXoTe6Df31fKUDUTY7tLmjEuJhDcDU10PXQfEIH
	rhOAOXS9wu7VxBjlPN71MRK7m2t9hK5/3P4EaSLv/C9o+g6VwvCz0ArgTKNSRYEu
	oTlnk9OOpT0hgOIU+IQBiOozXzQJY9El2Amdk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PQTwTLuQgXpbsFc7hLqmVGO7mKpofFOv
	KQBn6l/zM2VE2W8F2fuau1s7zaTTGvn9/JvZm+ZGzeKLnVGg3KFcur8FCvWVuOMb
	V76rK1Zjnp+fiCI1PnM1ZXCpZ70xeUqHDjES+8q9xdBo0TjxXpvXN7pRqWP2nVUX
	3A3A2gV9GdA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C626032C7;
	Mon, 16 May 2011 01:03:01 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id BC87332C5; Mon, 16 May 2011
 01:02:58 -0400 (EDT)
In-Reply-To: <BANLkTin7DALU8sfFxzJo62DGtNE2fsZxXw@mail.gmail.com> (Shawn
 Pearce's message of "Sun, 15 May 2011 17:58:46 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C65D7F86-7F79-11E0-B03F-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173702>

Shawn Pearce <spearce@spearce.org> writes:

> On Sun, May 15, 2011 at 17:30, Junio C Hamano <gitster@pobox.com> wrote:
>> +static read_method_decl(pack_non_delta)
>
> I am not a huge fan of these decl macros... but I can see how writing
> out the same function prototype 3 times is annoying.

More importantly, it helped greatly while re-rolling this series literally
several times until I nailed the right set of parameters these methods
should take.

> I think the better strategy is to avoid delta compression altogether
> for objects that are so big we cannot materialize them as a contiguous
> buffer.

Yes, that is what I am aiming for in the recent topics around this area.
