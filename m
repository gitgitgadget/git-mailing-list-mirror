From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFH] unpack-trees: cache_entry lifetime issue?
Date: Fri, 02 Mar 2012 11:17:26 -0800
Message-ID: <7vk432dd89.fsf@alter.siamese.dyndns.org>
References: <4F5102A2.70303@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Fri Mar 02 20:17:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3Xyx-0005hl-B9
	for gcvg-git-2@plane.gmane.org; Fri, 02 Mar 2012 20:17:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759084Ab2CBTR3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Mar 2012 14:17:29 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47670 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753273Ab2CBTR2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Mar 2012 14:17:28 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 755CF6D21;
	Fri,  2 Mar 2012 14:17:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=d9OB5sRT8FWAgfmSSj9kk4pd3
	xI=; b=TQhv3u4NkVldRFKFvS9laVxRfbgzj1ygjnEebNEToAFHuxaSEzA8nHJ/W
	w9GNGRdsKb2jLHxk83H0FfKNWOWwzSnAwoBbWwtVzUF+wZppD0uaW91e1fCc/kCr
	OUpdLXB3uVEC8UDHORLL1lTCZ4LMOcnrbd7X4AuwuMY9wl33iw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=b1+0jv8VcXVKTWFsAGp
	NXY4LJ8z18argWkNvsoMig+m9lFqnWIC60i+bB5g9i3Lip2YkIzBNRNmb8P6O8Y1
	uIi6H5BBc6s48Ncq612hlevt9ryE3g9n2qL1Rt/OhVuFqP27P/0iHeqyPFFIhznR
	4Cp86zWjZE42mK47BMbUiPeo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6BFAB6D20;
	Fri,  2 Mar 2012 14:17:28 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 017F66D1F; Fri,  2 Mar 2012
 14:17:27 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 59AF8268-649C-11E1-987E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192064>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> which shows some parts of unpack-trees.c that I use as context to
> ask: Should we check for o->merge in line 775, before using src[0]?
>
> If o->merge is 0, the src[0] will be NULL right up to the call of
> unpack_nondirectories() in line 772.  There it may be set (in line
> 582).  In that case we'll end up at line 779, where mark_ce_used()
> is applied to it.
>
> I suspect that this is unintended and that line 775 should rather
> read "if (o->merge && src[0]) {".  Can someone with a better
> understanding of unpack-trees confirm or refute that suspicion?

Yeah, src[0] is meant to hold the entry from the current index to take =
it
as well as our tree into account during o->merge, and I do not think it
should affect when we are only reading tree(s) into the index.

I think da165f4 (unpack-trees.c: prepare for looking ahead in the index=
,
2010-01-07) simply forgot that the codepath also has to work when it is
not merging.

Having said that, I do not know offhand if we just should nothing in
no-merge case, or we should be doing something else instead, without
thinking a bit more.
