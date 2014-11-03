From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 18/19] update-index: test the system before enabling untracked cache
Date: Mon, 03 Nov 2014 10:09:48 -0800
Message-ID: <xmqqr3xkrw9f.fsf@gitster.dls.corp.google.com>
References: <1414411846-4450-1-git-send-email-pclouds@gmail.com>
	<1414411846-4450-19-git-send-email-pclouds@gmail.com>
	<544FD474.3050805@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Nov 03 19:10:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XlM4t-0008AZ-4C
	for gcvg-git-2@plane.gmane.org; Mon, 03 Nov 2014 19:10:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753531AbaKCSKA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Nov 2014 13:10:00 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55803 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753409AbaKCSJ5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Nov 2014 13:09:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2F0491AEC9;
	Mon,  3 Nov 2014 13:09:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=4axMjFhr5XRD
	AIHRT4vzMpNDARE=; b=jw9Uuif891Rwx1xQKOH3uqwLPmEz1uLCCgndbv3UWsxr
	gIUPSVN0AzUf1QMLKvHKH4P532IHbK1z+bkkTny4oIr2ouBg5HFqs/JfidRFV5bf
	GFlg7s6JHOoJcgms0d9tmlkCjqES75O9uqhClvi/bQEyAVTtJUc5TGvew9KdRZ8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=IiMd08
	BphTyw8pEZvBsDxm2PhPw551wEUV7utdialWWSB3ZDegZkQRBqLXVLV5PmJybe2U
	8bbFLulH5uMjivbCW5m2ExNgc+vOjRDSMZMtaF0Ir/ELOwzgDpvVNW++E5mvVOKm
	1kho5IKKAp0C93BUWKdQTTeEbrFDF8jUxduKY=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 253371AEC8;
	Mon,  3 Nov 2014 13:09:50 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A20961AEC4;
	Mon,  3 Nov 2014 13:09:49 -0500 (EST)
In-Reply-To: <544FD474.3050805@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Tue, 28 Oct 2014 18:37:56 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 99E563FE-6384-11E4-A488-692F9F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> On 2014-10-27 13.10, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
> []
>
>> +static void xmkdir(const char *path)
>> +{
>> +	if (mkdir(path, 0700))
>> +		die_errno(_("failed to create directory %s"), path);
>> +}
>
> Does it makes sense to ignore EINTR and do a "retry" ?
> Another question is if the function could be called mkdir_or_die() in=
stead?

Probably.  It is in the same league as xread() and xwrite().

> I realized that there are 2 families of xfunc() in wrapper.c, some di=
e, some retry.

The general idea of wrapper.c is to free callers from coding
something they have only one sensible choice for.  The ones that
retry such as xread() and xwrite() are to free callers from
diagnosing and retrying upon EAGAIN/EINTR because they want to read
or write and there is no other thing they want to do.  The ones that
die such as xmkstemp() are for the failure modes that are likely
without any other choice.  xcalloc() and other allocators started as
(and still are) the latter, but instead of immediately dying they
know a last-ditch effort that is common to all Git operations.
