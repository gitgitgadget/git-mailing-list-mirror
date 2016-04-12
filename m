From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 03/16] index-helper: new daemon for caching index and related stuff
Date: Tue, 12 Apr 2016 11:05:41 -0700
Message-ID: <xmqqfuuqr9ca.fsf@gitster.mtv.corp.google.com>
References: <1459980722-4836-1-git-send-email-dturner@twopensource.com>
	<1459980722-4836-4-git-send-email-dturner@twopensource.com>
	<CACsJy8C5NhaAAW=wzpwkBdLvVZz8wVM7QX==n_CL5g+LLAKY=A@mail.gmail.com>
	<1460153784.5540.19.camel@twopensource.com>
	<1460417232.5540.53.camel@twopensource.com>
	<CACsJy8C2FtdetQ_NJSKR_JCZ5Ju0E3rV7Du=J4f2_kn5qrcHxg@mail.gmail.com>
	<1460482108.5540.59.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>, aevarb@gmail.com,
	jeffhost@microsoft.com
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue Apr 12 20:05:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aq2hB-0000z3-OI
	for gcvg-git-2@plane.gmane.org; Tue, 12 Apr 2016 20:05:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965238AbcDLSFp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2016 14:05:45 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:63624 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S965083AbcDLSFo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2016 14:05:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3BEF0534B2;
	Tue, 12 Apr 2016 14:05:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gaZZjI8wgCfPbCntQXv+mPAaAx8=; b=HcZrFZ
	p0U2EPwV93zj5+zzDcxCoBkoGdpWs8eP0fGiec/40QSFjYutZEclRtkJ6XMgUH1j
	Jij6zVCBZz+Dlhao2/8VRiWz/4HrfmBT1TUSKJ3wCqHAgPJ9TQY5QeYo9HvnZcBe
	RP3XO0nfmyW+zWch+g3j44sbFUar+eehjwXIM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sZkmIlkx7lmvRunJcE1wx4w3PEclseXl
	WYcZPFggSvJX1/k9AMyKLL48fArtcQdqUPTQUIsmLVK/gKznV0aWcSat0a9Lp4qm
	AupPAo7+rVJGkM6RKua9dVGmt8BlLi28KHgJjwghUH+RqBeXv4luqKgZafHXB+54
	+pijR96g1Hs=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 32283534B1;
	Tue, 12 Apr 2016 14:05:43 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 91722534AF;
	Tue, 12 Apr 2016 14:05:42 -0400 (EDT)
In-Reply-To: <1460482108.5540.59.camel@twopensource.com> (David Turner's
	message of "Tue, 12 Apr 2016 13:28:28 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2BEB46C2-00D9-11E6-B362-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291286>

David Turner <dturner@twopensource.com> writes:

>> I avoided actual files for two reasons
>> 
>>  - disk error rate is higher than memory one, and we might need
>> trailing SHA-1 back
>
> This only matters if we ever *read* the mmap off disk.  But that will
> rarely happen -- usually, everything will stay in memory.

True, and I do not think I'd terribly mind if we decided to use a
on-disk file mmaped with MAP_SHARED as a more portable substitute
for shm_* for this reason.

> Also, we
> never worry about disk errors for other git objects (e.g. blobs,
> commits, or trees), so it seems silly to worry for the index.

The objects are protected by checksums and fsck will notice errors,
so the argument itself is bogus, I'd think, but you do not have to
depend on that argument to support "let's use a mmaped file as a
more portable substitute for shm*" in the first place, I would say.

>>  - access is slow (unless cached, but we can't be sure)
>
> We could solve this (and the other problem) with mlock.

Probably you meant madvise(2)?

For something of a size comparable to the index file held by
index-helper-daemon in-core, I'd expect we wouldn't page too
badly.
