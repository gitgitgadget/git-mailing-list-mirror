From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] git-merge-file: do not add LF at EOF while applying unrelated change
Date: Tue, 01 Jul 2014 10:01:45 -0700
Message-ID: <xmqqa98txbba.fsf@gitster.dls.corp.google.com>
References: <1403993086-15625-1-git-send-email-max@max630.net>
	<1403993086-15625-3-git-send-email-max@max630.net>
	<alpine.DEB.1.00.1406301650430.14982@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Max Kirillov <max@max630.net>,
	Bert Wesarg <bert.wesarg@googlemail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 01 19:02:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X21RP-00087Z-Vr
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jul 2014 19:02:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932179AbaGARBy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jul 2014 13:01:54 -0400
Received: from smtp.pobox.com ([208.72.237.35]:51825 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932150AbaGARBw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jul 2014 13:01:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1D9F823D09;
	Tue,  1 Jul 2014 13:01:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=m0qCorKVBVLY7ojmVvNDJI+LJUQ=; b=possVt
	MftGxDbNO3xdsl2puElTOUOkeFQEPCR1XJ/AFyEDRQqFF8+NfgDSiTXNMnjl+pJr
	p3Nt290FkuQN+qG54y36PBPaxQRMjsCbtQEh3yHjJVk4Qr/RglaSHgz/iQjgNigG
	TLFC61IcuMKUhXaSIOaU5LhbfKixEr2bkq4QI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gu6lpwGrhUUa+Opl/PaV/UYqhlhQdTEi
	KTbOPsKVnh9iaqHmBNsBTjC79rcPJTjs3oqpdcnOXWqKHy+PEukwUIXAltLs69kW
	MsBglQJ/pds4kNAM2hzXw4fyuChIEVbywRjS0RAYd3af+V+rWfFaqLNAmIi6t/ni
	CskGA0ZfxhI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 114F823D08;
	Tue,  1 Jul 2014 13:01:41 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 1FEE623CFB;
	Tue,  1 Jul 2014 13:01:36 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.1406301650430.14982@s15462909.onlinehome-server.info>
	(Johannes Schindelin's message of "Mon, 30 Jun 2014 16:55:10 +0200
	(CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 5C539240-0141-11E4-BB0D-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252725>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Max,
>
> On Sun, 29 Jun 2014, Max Kirillov wrote:
>
>> diff --git a/xdiff/xmerge.c b/xdiff/xmerge.c
>> index 9e13b25..625198e 100644
>> --- a/xdiff/xmerge.c
>> +++ b/xdiff/xmerge.c
>> @@ -245,11 +245,11 @@ static int xdl_fill_merge_buffer(xdfenv_t *xe1, const char *name1,
>>  					      dest ? dest + size : NULL);
>>  			/* Postimage from side #1 */
>>  			if (m->mode & 1)
>> -				size += xdl_recs_copy(xe1, m->i1, m->chg1, 1,
>> +				size += xdl_recs_copy(xe1, m->i1, m->chg1, (m->mode & 2),
>>  						      dest ? dest + size : NULL);
>>  			/* Postimage from side #2 */
>>  			if (m->mode & 2)
>> -				size += xdl_recs_copy(xe2, m->i2, m->chg2, 1,
>> +				size += xdl_recs_copy(xe2, m->i2, m->chg2, 0,
>>  						      dest ? dest + size : NULL);
>>  		} else
>>  			continue;
>
> Makes sense to me, especially with the nice explanation in the commit
> message.

> Having said that, here is my ACK for the current revision of the patch
> series ...

Thanks, both.  Queued.
