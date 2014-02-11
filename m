From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/2] daemon: move daemonize() to libgit.a
Date: Tue, 11 Feb 2014 10:08:20 -0800
Message-ID: <xmqq61olr08b.fsf@gitster.dls.corp.google.com>
References: <xmqqd2j2afup.fsf@gitster.dls.corp.google.com>
	<1391843332-20583-1-git-send-email-pclouds@gmail.com>
	<xmqqha86st5f.fsf@gitster.dls.corp.google.com>
	<CACsJy8Bq046c19T3RNQCvDHp8dA-Si_8k=R230ZHODiVu-1dZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>, chris <jugg@hotmail.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 11 19:08:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WDHkz-0006ZY-QD
	for gcvg-git-2@plane.gmane.org; Tue, 11 Feb 2014 19:08:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751416AbaBKSIZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Feb 2014 13:08:25 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47076 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751014AbaBKSIY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Feb 2014 13:08:24 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5DD5169C3B;
	Tue, 11 Feb 2014 13:08:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=iJRd669AHtKH
	8sJVxPly8iWIBf4=; b=hoAtF4K2LSi0DSY8um5GG6SvHIPEWYggc7z7MacTLTTi
	/vO1YpP0CHREaC/ejSAjMC0H3USl66oiAjA17wYn2L/pFjmRpE5OnT2CTXBUICmi
	NetYoY1PVvyMI7j+o7Bq+gl3kIk8jxUYZ9Wb9rVm7s7076GoH7OxctU9SjTW5Is=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=MIz8wW
	8ws8EqiyxMNPDUcNejd+blVx6W2QI/X8lN7SPNRCIumOKYXPsVUJIdD6ZE/miyMZ
	9nGBcb4BgopMoNhvLQw9JJa/MB2y6PiY06q/dUqfKX0wWdtbOf2+05pe1bNkRlLP
	jPt+UZ2Ek3xljxMUq2+IK8u48qopH6m+cv7rs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D90A69C3A;
	Tue, 11 Feb 2014 13:08:24 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 08CD369C39;
	Tue, 11 Feb 2014 13:08:22 -0500 (EST)
In-Reply-To: <CACsJy8Bq046c19T3RNQCvDHp8dA-Si_8k=R230ZHODiVu-1dZw@mail.gmail.com>
	(Duy Nguyen's message of "Tue, 11 Feb 2014 06:25:28 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7ECB6F36-9347-11E3-B7A2-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241952>

Duy Nguyen <pclouds@gmail.com> writes:

> On Tue, Feb 11, 2014 at 1:46 AM, Junio C Hamano <gitster@pobox.com> w=
rote:
>> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> write=
s:
>>
>>> diff --git a/setup.c b/setup.c
>>> index 6c3f85f..b09a412 100644
>>> --- a/setup.c
>>> +++ b/setup.c
>>> @@ -787,3 +787,27 @@ void sanitize_stdfds(void)
>>>       if (fd > 2)
>>>               close(fd);
>>>  }
>>> +
>>> +int daemonize(void)
>>> +{
>>> +#ifdef NO_POSIX_GOODIES
>>> +     errno =3D -ENOSYS;
>>
>> Negated?
>
> Facepalm. I remember I wrote this somewhere but don't remember what
> topic :( Should I resend?

I've already amended it here.
