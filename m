From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Custom merge driver with no rename detection
Date: Mon, 15 Feb 2016 03:03:44 -0800
Message-ID: <xmqqd1ryqlpr.fsf@gitster.mtv.corp.google.com>
References: <CALMa68ovz=VZYkCcUDvEn1d7=xJDx__71caqsPXUFASZ1phfdw@mail.gmail.com>
	<alpine.DEB.2.20.1602150858340.2964@virtualbox>
	<CALMa68p9jdO63k2NLTUJXyms=Fc+woXx00UXCxzJ5_zV8jO8Rw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Felipe =?utf-8?Q?Gon=C3=A7alves?= Assis <felipeg.assis@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 15 12:03:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVGwZ-0007RP-QZ
	for gcvg-git-2@plane.gmane.org; Mon, 15 Feb 2016 12:03:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751219AbcBOLDs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Feb 2016 06:03:48 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:51325 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751092AbcBOLDr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Feb 2016 06:03:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4AF2141217;
	Mon, 15 Feb 2016 06:03:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=8ISNAn/1qFUK
	4buhxcCPZXHjwCE=; b=iPluPLJgdjf4a19VmDXbfmpLcAQMnUoWvuAi+SApddgz
	oTkfxA8ro9kUX/f1FaCS3hoTFlyrJqwHRamLYK0uE8lIGkwS9vhW87QKi+Wm7kPj
	HcqNo9Tzh6iHafdCvPli2QZp/ByNZihqDMwsEVJDCoqCD01MmiuttjeCEjEOcic=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=XVUFwB
	9d3AjrTDEUdL7Kcgq7sksW9hqRO7F6KxWZWVwYR2eWp0GTkqI5k5lblCrHVf73d9
	SPw1ZnBe5k5EhXlXsq8QRor9ox3zFsEUXBvYCiuGab53dEoI/LAXO2vHJ05Nwk9H
	S61OP5qDkGS8fC6zurNyhV+yeQcolSAC80En4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 417AE41216;
	Mon, 15 Feb 2016 06:03:46 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id AC3F741215;
	Mon, 15 Feb 2016 06:03:45 -0500 (EST)
In-Reply-To: <CALMa68p9jdO63k2NLTUJXyms=Fc+woXx00UXCxzJ5_zV8jO8Rw@mail.gmail.com>
	("Felipe =?utf-8?Q?Gon=C3=A7alves?= Assis"'s message of "Mon, 15 Feb 2016
 08:42:34
	-0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C85496C2-D3D3-11E5-BFDE-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286202>

=46elipe Gon=C3=A7alves Assis <felipeg.assis@gmail.com> writes:

> However, if you do find this approach acceptable/desirable
> (rename-threshold > 100%), I can work on the issues pointed out and
> propose a proper patch.

The caller asks diffcore-rename to detect rename, and the algorithm
compares things to come up with a similarity score and match things
up.  And you add an option to the rename detection logic to forbid
finding any?

To be bluntly honest, the approach sounds like a crazy talk.

If your goal is not to allow rename detection at all, why not teach
the caller of the diff machinery not to even ask for rename
detection at all?  merge-recursive.c has a helper function called
get_renames(), and it calls into the diff machinery passing
DIFF_DETECT_RENAME option.  As a dirty hack, I think you would
achieve your desired result if you stop passing that option there.

I called that a "dirty hack", because for the purpose of not
allowing rename detection inside merge-recursive, I think an even
better thing to do is to teach the get_renames() helper to report to
its caller, under your new option, "I found no renames at all"
without doing anything.

It might be just a simple matter of teaching its callers (there
probably are two of them, one between the common ancestor and our
branch and the other between the common ancestor and their branch)
not call the get_renames() helper at all under your new option, but
I didn't check these callers closely.
