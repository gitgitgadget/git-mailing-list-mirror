From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RFC] CYGWIN: avoid implicit declaration warning
Date: Mon, 24 Nov 2014 14:50:01 -0800
Message-ID: <xmqqlhn0usbq.fsf@gitster.dls.corp.google.com>
References: <5471EC26.3040705@web.de> <5472159B.4060905@ramsay1.demon.co.uk>
	<xmqqegstychq.fsf@gitster.dls.corp.google.com>
	<54726A8C.4040600@ramsay1.demon.co.uk>
	<5473B0E4.9090900@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Mon Nov 24 23:50:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xt2SS-0004OB-H8
	for gcvg-git-2@plane.gmane.org; Mon, 24 Nov 2014 23:50:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750968AbaKXWuG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Nov 2014 17:50:06 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62524 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750878AbaKXWuE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Nov 2014 17:50:04 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A5878210BA;
	Mon, 24 Nov 2014 17:50:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kJ4d5VRePfJBGLW8zln8WpBwe6Y=; b=E+k+Ra
	P3JcdM1RyP/ivIiBgx1r5k34h+YA0Q28pPLCzIhlW0qLC0JZ669Mz3L2O9U7xPr7
	pWaPcHVoUeKX8p2LdSk8p4o3OP4nFHWzSQ/yA0z3L/x6gGPQVAUnBPf4vdyW8444
	UCnOS79Xfvq0T8Pud7nOj9NbU/e7lu+WJqeEI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=htnz15AKSOV6L8OwqYrCyB6KabZWQUxW
	vVCpL/OiVKm/UHXZHo4S/yx2i8VQJavuGfkQBf9PwxQJxrLJAsFGUhS7TRXxTAmS
	7fu0EkFcLBMbk0pkXp8j9e/66405PpoH1WZzPDT0VFEkbrhS2IaeaymNXpRlmH4i
	jALt77iNMkE=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9662E210B8;
	Mon, 24 Nov 2014 17:50:03 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 09A5F210B5;
	Mon, 24 Nov 2014 17:50:02 -0500 (EST)
In-Reply-To: <5473B0E4.9090900@ramsay1.demon.co.uk> (Ramsay Jones's message of
	"Mon, 24 Nov 2014 22:27:48 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3A1FAF3E-742C-11E4-AF55-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260162>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

> ...
> Although I have not done an actual diff of the various cdef.h files, they
> do appear to be more or less the same. In other words, I no longer think
> that the change results from a 'change in priority of _XOPEN_SOURCE'. The
> issue is simply that in the old <string.h> header these functions were
> declared unconditionally; in the new headers the are contained within
> preprocessor conditionals using the __GNU_VISIBLE and __BSD_VISIBLE macros
> which are not set when _XOPEN_SOURCE is set (despite _GNU_SOURCE and
> _BSD_SOURCE being set).

So I can take your version [*1*], drop this bit from the log:

    This seems to be caused by a change to the system headers which
    results in the _XOPEN_SOURCE macro now having prioity over the
    _GNU_SOURCE and _BSD_SOURCE macros (they are simply ignored).
    This in turn leads to the declarations of the above functions
    to be suppressed.

and replace it with something like:

    <string.h> on Cygwin used to always declare the above functions,
    but a recent version of it no longer make them visible when
    _XOPEN_SOURCE is set (even if _GNU_SOURCE and _BSD_SOURCE is
    set).

and keep the rest, I think.

Thanks for digging this thoroughly.


[Reference]

*1* http://article.gmane.org/gmane.comp.version-control.git/260091
