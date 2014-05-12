From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Make it possible to update git_wcwidth()
Date: Mon, 12 May 2014 10:44:05 -0700
Message-ID: <xmqqegzyu96f.fsf@gitster.dls.corp.google.com>
References: <536D4DF0.3060301@web.de>
	<alpine.DEB.2.00.1405121334480.9884@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Git Mailing List <git@vger.kernel.org>, kevin@bracey.fi
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Mon May 12 20:46:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WjvFT-0005dq-O8
	for gcvg-git-2@plane.gmane.org; Mon, 12 May 2014 20:46:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753474AbaELSqo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 May 2014 14:46:44 -0400
Received: from smtp.pobox.com ([208.72.237.35]:56283 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753135AbaELSql convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 May 2014 14:46:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5AE7715E51;
	Mon, 12 May 2014 14:46:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:date:references:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=lhRWHP1V0W61
	ROcp1S4quIn4/oY=; b=yOOTsQhzPjI+wZ0StByGpXjLw3xFm56EbMChskCV6mDN
	WbBAXiol0ZywwAH3jCelWS7DcSQ95tCsMhjJ2pUUtqkEyS+Elqj07qJBEFeGP3mE
	d/f9DNplXJdsLENWhfUewMhBk8yBessMmAKxpuLmcHzXThYooM4qMvBm2O0XNtE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:date:references:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=dy4scj
	z+TiCWcg4OxD0LTvuZxBafwJfQnUswIJzC9jySxUJW9bn3jtARQPbY6tnPT8dBrH
	ntkgV2xWdJUrLO1qBoATe4Kv7TtouwCFQROi+G9NrDcaWZUPbgs5cvvFEQ23tvB/
	mAg2zxC+Emz/6YPxNbAtlGff32FZzP6WM1qR0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4C5D215E50;
	Mon, 12 May 2014 14:46:41 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 0227F15E2B;
	Mon, 12 May 2014 14:46:33 -0400 (EDT)
In-Reply-To: <alpine.DEB.2.00.1405121334480.9884@ds9.cixit.se> (Peter
	Krefting's message of "Mon, 12 May 2014 13:38:37 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: BD7FF51C-DA05-11E3-B7BB-9CEB01674E00-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248720>

Peter Krefting <peter@softwolves.pp.se> writes:

> Torsten B=C3=B6gershausen:
>
>> The function git_wcwidth() returns for a given unicode code point th=
e
>> width on the display:
>> -1 for control characters,
>> 0 for combining or other non-visible code points
>> 1 for e.g. ASCII
>> 2 for double-width code points.
>
> This all looks sane, but the problem is that this is also
> context-dependent since there are a lot of characters with "ambiguous=
"
> widths, i.e., characters that are "double" width for CJK locales (and
> fonts), but "single" width for others. This includes Greek and
> Cyrillic characters, which are encoded using the double-byte parts of
> the CJK DBCS encodings.
>
> I'm not quite sure how much impact this would have on day-to-day Git
> operation in a CJK locale, however, as I guess they would mostly
> encounter texts in their own language (which would mostly be "double"
> width) or English (which would be unambiguously "single" width).
>
> Anyone on the list running Git in a CJK locale that would like to
> weigh in here?

The issue does appear in the real life.  A solution I've seen used
in a terminaul emulator program was to give the user a choice to say
"I want ambiguous ones to be treated as double (or single)".  As a
J-locale user, I naturally set the configuration to double while
using that program (I no longer do).
