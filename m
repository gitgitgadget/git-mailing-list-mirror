From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Clear fd after closing to avoid double-close error
Date: Tue, 22 Oct 2013 11:42:30 -0700
Message-ID: <xmqq8uxltaeh.fsf@gitster.dls.corp.google.com>
References: <1382443823-31317-1-git-send-email-jl@opera.com>
	<CACsJy8DtvaojrrQr4=uYCRse7N+SXb+WdjY+C_0FRSjYsNC6zg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jens =?utf-8?Q?Lindstr=C3=B6m?= <jl@opera.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 22 20:42:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VYguc-0001LV-AO
	for gcvg-git-2@plane.gmane.org; Tue, 22 Oct 2013 20:42:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754353Ab3JVSme convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Oct 2013 14:42:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35070 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753511Ab3JVSmd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Oct 2013 14:42:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2FE134C9F1;
	Tue, 22 Oct 2013 18:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=C4qB9NQmw/ni
	U925MDJoSzpOpbM=; b=XAkEAJ9jc9BjMMHOh5J62QZhAA3Ha0uHg/2eJ/Z1ekAy
	AhVWdywOYc0iIrn4gzdvcWCnWDmiZD0IWkcTd8tiE59asqSCBsitWTSXBjydlywQ
	xhZ+9peVP2/bm+p3nFJDBLrmWyAGoMzPexErw9ItRJo1cLi8BG6mMsTTAcFDzk4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=rcemFI
	GM5A9u2AWgtKsleyurbGS+Yj35K0hTxqPJ0eMQRkllfLLda1ekZmQyfIrwj8wBe5
	uAE0rEC7mrjSmvO4gzgKjESLEkY99ysGgeVCaLuQExyNwiVAkxuhm+f7z79isIVd
	rPn6STNlls2t35MkVgdmYTXp3ojjrlKZo0wzY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 22A454C9F0;
	Tue, 22 Oct 2013 18:42:33 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7742B4C9E9;
	Tue, 22 Oct 2013 18:42:32 +0000 (UTC)
In-Reply-To: <CACsJy8DtvaojrrQr4=uYCRse7N+SXb+WdjY+C_0FRSjYsNC6zg@mail.gmail.com>
	(Duy Nguyen's message of "Tue, 22 Oct 2013 19:39:08 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B618F608-3B49-11E3-BF75-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236483>

Duy Nguyen <pclouds@gmail.com> writes:

> On Tue, Oct 22, 2013 at 7:10 PM, Jens Lindstr=C3=B6m <jl@opera.com> w=
rote:
> ...
>> +               if (!args->stateless_rpc)
>> +                       /* Closed by pack_objects() via start_comman=
d() */
>> +                       fd[1] =3D -1;
>>         }
> ...
> Life would have been simpler if fd[1] was _always_ closed by
> send_pack(), like in c20181e (start_command(), if .in/.out > 0, close=
s
> file descriptors, not the callers - 2008-02-21).

Yeah, that was also my first reaction when I saw the above three
lines after reading the discussion that led to the diagnosis.
