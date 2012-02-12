From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] Auto detection in Makefile if msgfmt is not
 available
Date: Sun, 12 Feb 2012 09:22:51 -0800
Message-ID: <7vr4y0j79w.fsf@alter.siamese.dyndns.org>
References: <201202121342.25113.tboegi@web.de>
 <CACBZZX4W0onNOstQqNethDBv1tZSijt8Q_HDrcuWr+Z8WYV90w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 12 18:23:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rwd8c-0005Zm-Jr
	for gcvg-git-2@plane.gmane.org; Sun, 12 Feb 2012 18:22:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755590Ab2BLRWy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Feb 2012 12:22:54 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45412 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755565Ab2BLRWx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Feb 2012 12:22:53 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 217E07FF7;
	Sun, 12 Feb 2012 12:22:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=DQgKkvlkGBYtnHbklavOkebLc
	F8=; b=b9q2HNmP5v5xvOmHDx6YjW2GZlGli6vT28Z+1K6Rnxg+HMNGcbVYjsGYc
	SpOSpYHBbdBHUdjF3w0VPhHeD2KiozjPDDuI487ZF8L5aqBzG1zuCJIPDd+9OPPD
	bpxT5LBEZKtdN17s3ZiaCFPrR1gpdGgU8PLWL7nOTvfa/r2ZKs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=i1r5mg/5gwZNHdlGq0y
	9ZW+ic1Q0Q656jW8tubjdu+BLyf3gpETyxXzV6UOBdAibnKFU1vQFjNYftf79yxv
	+u8ypAqVspvOcuhF6VGxH6z/oGto7Nrk7i4xxJQkZ8zJifXMRd1ieBkyybOebKp3
	hCx1Ai+0DxIx0mUCFdGp+CHM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 193E57FF6;
	Sun, 12 Feb 2012 12:22:53 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9CBBC7FF5; Sun, 12 Feb 2012
 12:22:52 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 31CCC204-559E-11E1-B737-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190583>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> 2012/2/12 Torsten B=C3=B6gershausen <tboegi@web.de>:
>> Added a simple auto-detection and switch to NO_GETTEXT when
>> msgfmt could not be found on the system
>
> Oh look, a start at our very own autoconf replacement :)

It is a bad idea for the Makefile to silently decide to flip NO_GETTEXT
when the system happens to be missing msgfmt without letting the user k=
now
what is happening.  Current behaviour to error out will at least give a=
n
opportunity to stop and think if installing gettext suite on the system
makes sense before proceeding.

Given that the Makefile only has this to say:

    # Define NO_GETTEXT if you don't want Git output to be translated.
    # A translated Git requires GNU libintl or another gettext implemen=
tation,
    # plus libintl-perl at runtime.

expecting that "msgfmt: no such command" clicks "Ah, I do not have gett=
ext
suite" for anybody who attempts to build (and fail) Git, it however is
also a bit unfair and unhelpful.

Perhaps something like this is necessary and sufficient.

    # Define NO_GETTEXT if you don't want Git output to be translated o=
r if
    # you do not have gettext suite (e.g. "msgfmt" and "gettext" comman=
ds).
    # A translated Git requires GNU libintl or another gettext implemen=
tation,
    # plus libintl-perl at runtime.
