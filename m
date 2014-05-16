From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] commit: allow core.commentChar=auto for character auto selection
Date: Fri, 16 May 2014 10:38:08 -0700
Message-ID: <xmqqoayxaakf.fsf@gitster.dls.corp.google.com>
References: <1400237982-5842-1-git-send-email-pclouds@gmail.com>
	<1400248283-303-1-git-send-email-pclouds@gmail.com>
	<1400248283-303-2-git-send-email-pclouds@gmail.com>
	<20140516164053.GB12314@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 16 20:27:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlMrL-0007jw-Jy
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 20:27:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757580AbaEPS1w convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 May 2014 14:27:52 -0400
Received: from smtp.pobox.com ([208.72.237.35]:64420 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752716AbaEPS1v convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 May 2014 14:27:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4720D19E5C;
	Fri, 16 May 2014 14:27:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=XGmRxo3dLfMJ
	cQyVSxzJLrK93dM=; b=HRYV6eKUZalgK0oQyPxmRt6IMkbBcQkA9ekOdhX7PICM
	LrLSIGKMldpJ6HXgS9IOIu0uwMO6oWmpGp6SUtPQC5KkUIDGa3OJIXG3DU10rO45
	Pno5CYbcREuQvrUmPykfgi7Z21eK5XzV9NGG/52A6vr/pJX9MgS9nSBzoW7o/cA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Pon/XA
	H8uM+u2iKda+u26Ixn1/oepfpWycXRdzy2oGF7TgTFPZSCtn9nRxKHwsZ+hWpVb5
	9ejWqnH9CL+5zYb9GD3A+ScZU1dX0VrLDfTI1fxGps/e2/+w7tWxNRZQr9Lq0bjd
	0T6mBdoEkxfbq87nLlVGcVObtyYKZiG/EapRE=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 395E119E5B;
	Fri, 16 May 2014 14:27:51 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 3D10D17B16;
	Fri, 16 May 2014 13:38:11 -0400 (EDT)
In-Reply-To: <20140516164053.GB12314@google.com> (Jonathan Nieder's message of
	"Fri, 16 May 2014 09:40:53 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D9C48210-DD20-11E3-A94B-B784E8FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249406>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>
>> core.commentChar starts with '#' as in default but if it's already i=
n
>> the prepared message, find another one among a small subset. This
>> should stop surprises because git strips some lines unexpectedly.
>
> Probably worth mentioning this only kicks in if someone explicitly
> configures [core] commentchar =3D auto.
>
> Would it be a goal to make 'auto' the default eventually if people
> turn out to like it?
>
> [...]
>> --- a/builtin/commit.c
>> +++ b/builtin/commit.c
>> @@ -594,6 +594,40 @@ static char *cut_ident_timestamp_part(char *str=
ing)
>>  	return ket;
>>  }
>> =20
>> +static void adjust_comment_line_char(const struct strbuf *sb)
>> +{
>> +	char candidates[] =3D " @!#$%^&|:;~";
>
> This prefers '@' over '#'.  Intended?

I think the candidates[0] will almost always be overridden with "#"
so it probably does not matter in practice, but I tend to agree that
"#" (and probably ";") should come before all others.
