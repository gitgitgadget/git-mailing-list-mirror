From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] commit: ensure correct permissions of the commit message
Date: Mon, 21 Dec 2015 09:22:48 -0800
Message-ID: <xmqqio3rhg2f.fsf@gitster.mtv.corp.google.com>
References: <4aa11f02f4de113bf38152b8815658da42690f43.1450549280.git.johannes.schindelin@gmx.de>
	<20151220074559.GF30662@sigill.intra.peff.net>
	<xmqq7fk8io3f.fsf@gitster.mtv.corp.google.com>
	<20151221065944.GA3550@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org, Yaroslav Halchenko <yoh@onerussian.com>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Dec 21 18:22:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aB4Ag-0004gV-TD
	for gcvg-git-2@plane.gmane.org; Mon, 21 Dec 2015 18:22:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751401AbbLURWv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Dec 2015 12:22:51 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:61128 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751233AbbLURWu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Dec 2015 12:22:50 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id F27653255C;
	Mon, 21 Dec 2015 12:22:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=j9essSjzTpjH46kGBp8OIY1MZZI=; b=cPslqx
	mnGhpdQ1yi236GtcrBEI9gSzdFF77DCMjHl7vUgENU/LaCHvzf5O/kNJ1AupesXs
	1eK8OoqNunVdOvVDL0JyF0fKoAVr/pROkrURLa1Ridgmrj7vMFrEVM4bx14MURZq
	QHp7an7TFweIOL+r0I1jX+guk3kn4Lux18vJg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=b7fo/YcgQ0e5ByQxizp7d85RsQJtkOxF
	BsGBExSaxgrRDTpAyFkYMJIqci6ideQv4M46GXLgCdD/FXpqUndgks/jYQaqd2SZ
	bVSiIdIGrxy3wnjMNb8OFM+fwzggWpmYi0av47LG56XLvXWHcYhP4it/FfLpbEyq
	pDd44O48nOQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EA6303255B;
	Mon, 21 Dec 2015 12:22:49 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6FB1C3255A;
	Mon, 21 Dec 2015 12:22:49 -0500 (EST)
In-Reply-To: <20151221065944.GA3550@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 21 Dec 2015 01:59:44 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7587463A-A807-11E5-844E-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282801>

Jeff King <peff@peff.net> writes:

> On Sun, Dec 20, 2015 at 05:31:48PM -0800, Junio C Hamano wrote:
>
>> Actually, we do not even _need_ a sharedness for this ephemeral
>> file.  The additional "adjust-shared-perm" is merely a workaround
>> for the fact the next person cannot write into it when it is left
>> behind, and because we do not want to remove it when we are done.
>> 
>> That does not measn that the next person cannot remove it when she
>> finds there is a file there left behind.  So alternatively, we could
>> do something like this, perhaps?
>> 
>>         FILE *fopen_forcibly(const char *path, const char *mode)
>>         {
>>                 FILE *ret = fopen(path, mode);
>> 
>>                 if (!ret && errno == EPERM) {
>>                         if (!unlink(path))
>>                                 ret = fopen(path, mode);
>>                         else
>>                                 errno = EPERM;
>>                 }
>>                 return ret;
>>         }
>
> Yeah, I think that is a much nicer solution for this case. It should
> work even in a shared repo, since we set the permissions for the
> surrounding $GIT_DIR appropriately[1].
>
> I guess it would not apply to any files that do not want to truncate the
> existing contents. Probably it should drop the "mode" parameter at all,
> since anything but "w" would be crazy?

Absolutely.  Thanks for spotting.
