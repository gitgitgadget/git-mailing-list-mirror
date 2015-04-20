From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Why does "git log -G<regex>" works with "regexp-ignore-case" but not with other regexp-related options?
Date: Mon, 20 Apr 2015 11:44:20 -0700
Message-ID: <xmqqtwwaljwb.fsf@gitster.dls.corp.google.com>
References: <1090496912.6338.1429264855691.JavaMail.open-xchange@ox1app>
	<55311831.6010004@drmicha.warpmail.net>
	<CAPc5daUULhhV0+kL_htLnA8Z_woFLjxg_pO_cB0KLAMuxJnsMQ@mail.gmail.com>
	<5534BD87.8020709@drmicha.warpmail.net>
	<xmqqbniin1cw.fsf@gitster.dls.corp.google.com>
	<CA+55aFzdSgvYo11PHamkOVASz61RUq26+s0na0Zh2RRwsEkrMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Tim Friske <me@tifr.de>, git <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Apr 20 20:44:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YkGgG-0003d5-8a
	for gcvg-git-2@plane.gmane.org; Mon, 20 Apr 2015 20:44:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752521AbbDTSoY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2015 14:44:24 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60116 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750998AbbDTSoX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2015 14:44:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9FCF146D8E;
	Mon, 20 Apr 2015 14:44:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IyVYzxY0vVJyd0nZwCVn1XNDTSg=; b=NpxBUp
	A7bnebd7nGFTd8sxolce6Y6B64qdmbuCUY54z23Vu0MuoCmbhhF+ib0528NrKAa2
	1+qYgYNqrVVbdk3QboeJGMDV8V85aJ3Ztz5ZUxN1rPizfHiftruIzUw1kYLA4xMm
	LBwcrN1ep9GtzdATt7+IGfCW94U44XxhOxsWg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vK0VWZOIaVDM+zfjnw/fxqqjwsdkshpq
	ftLsCWlmylg7qgJUUzhuHUszj01hFZWe4Qg87877i3a8uBzgL0UxHf/95+fJqYp8
	vOAMZIovaUxHx8YvkG42cWYS3tHmwDWhUjzbf6zxvBRo02vf+1P+cBl6+OxyzlYp
	/AM5YIvOjMs=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 97FF546D8D;
	Mon, 20 Apr 2015 14:44:22 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1BA2646D8A;
	Mon, 20 Apr 2015 14:44:22 -0400 (EDT)
In-Reply-To: <CA+55aFzdSgvYo11PHamkOVASz61RUq26+s0na0Zh2RRwsEkrMg@mail.gmail.com>
	(Linus Torvalds's message of "Mon, 20 Apr 2015 11:33:31 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4292C05A-E78D-11E4-8DE4-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267485>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> And to clarify: I don't suggest always building with libpcre. I
> literally suggest having something like
>
>      /* hacky mac-hack hack */
>     if (strncmp("(?i)", p->pattern, 4)) {
>         p->pattern += 4;
>         p->ignore_case = true;
>     }
>
> just in front of the "regcomp() call, and nothing more fancy than that.

Yeah, looking at the way grep.c:compile_regexp() is structured, we
are already prepared to allow

    $ git log --grep='(?i)torvalds' --grep='Linus'

that wants to find one piece of text case insensitively while
another case sensitively in the same text (i.e. the log message
part), so per-pattern customization may be a good way to do this.
