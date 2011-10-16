From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/5] remote: separate out the remote_find_tracking logic
 into query_refspecs
Date: Sat, 15 Oct 2011 22:10:11 -0700
Message-ID: <7vhb39ttcc.fsf@alter.siamese.dyndns.org>
References: <1318655066-29001-1-git-send-email-cmn@elego.de>
 <1318655066-29001-4-git-send-email-cmn@elego.de>
 <7vobxhtugo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	Jeff King <peff@peff.net>, mathstuf@gmail.com
To: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sun Oct 16 07:10:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFIzT-0001yL-6A
	for gcvg-git-2@lo.gmane.org; Sun, 16 Oct 2011 07:10:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751542Ab1JPFKP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 16 Oct 2011 01:10:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51139 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751294Ab1JPFKO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Oct 2011 01:10:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4A5422A60;
	Sun, 16 Oct 2011 01:10:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=nbhcDJiyFDI3
	RJcgGCxdcAJmeLA=; b=tTv7ruvHHnmUtRxGl+blGpDZfH+CleuztSKYgHkMXIXg
	hkL5X2SKMdFoShwcirvNJDqdRKZyxiq0EpWYU1sjmDO8E5OHivI43k9Vcq8NCSNo
	CJSopZPocBSfrX26YdbtZXHHDY0OvKtSsYKqSkCrnWZB5aK69hEk5YYvzP1PWok=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=i1pF1b
	iHSR71koY+Qh04GE4HXvGvFW88Mk7ECLbT6/CNSugRBNS/JG0cX1QQLBBQiXeCLV
	W8yD3XS54WOSMYzhBgJOZHl7svS30zEEZEDY7BY1rKcINDRUqFcjIcHX+DDxUIFZ
	zkm6GnwjhmH58/Uafm35ENJV4gvBk/ZSyhYFg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4127B2A55;
	Sun, 16 Oct 2011 01:10:13 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B64B42A54; Sun, 16 Oct 2011
 01:10:12 -0400 (EDT)
In-Reply-To: <7vobxhtugo.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sat, 15 Oct 2011 21:45:59 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 20872EB8-F7B5-11E0-9D7B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183688>

Junio C Hamano <gitster@pobox.com> writes:

> Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:
>
>> Move the body of remote_find_tracking to a new function query_refspe=
cs
>> which does the same (find a refspec that matches and apply the
>> transformation) but explicitly wants the list of refspecs.
>>
>> Make remote_find_tracking and apply_refspecs use query_refspecs.
>>
>> Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@elego.de>
>> ---
>>  remote.c |   70 ++++++++++++++++++++++++++++++---------------------=
----------
>>  1 files changed, 34 insertions(+), 36 deletions(-)
>
> Looks very sensible, especially knowing what you want to do in the ne=
xt
> patch ;-).
>
> Thanks.

I notice that before this update, passing a refspec[] with an element t=
hat
lacks its dst side to apply_refspecs() would have segfaulted but with t=
his
update such an element in the refspec[] will simply be ignored.

This helper function was added in 72ff894 (Allow helper to map private =
ref
names into normal names, 2009-11-18) for transport-helper's use. I am s=
ure
the change will not introduce a regression due to this skippage (the co=
de
without this patch would have simply crashed with such an input anyway)=
,
but I thought people involved in the transport layer may want to know.
