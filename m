From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jun 2016, #01; Thu, 2)
Date: Fri, 03 Jun 2016 08:59:46 -0700
Message-ID: <xmqq4m9aqn4d.fsf@gitster.mtv.corp.google.com>
References: <xmqqa8j3ryo6.fsf@gitster.mtv.corp.google.com>
	<20160602231315.GA22864@glandium.org> <57511086.40206@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mike Hommey <mh@glandium.org>, git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Fri Jun 03 18:00:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8rVs-0005ED-5i
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 17:59:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932167AbcFCP7w convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Jun 2016 11:59:52 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59877 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752137AbcFCP7v convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Jun 2016 11:59:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 17D0B1F569;
	Fri,  3 Jun 2016 11:59:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=IWbjcGIX/Tce
	PmiDp0/4DJTWI/I=; b=RVwMU9HuSjc9QB/Nmo/nuYf3cF1IE9xLamDOR4UpTN3z
	Vl12CluBMI+x068fuS/BDVPzkxdR6CZc16rneOn+BZTVkfIzYQgBEy+FL6Hh+DRt
	IvtnwuKYvyVnawyBjJdXgNzKn9zrbTo9RJHCs4kepjCCNbVbwVwSotKx3kzk2Dc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=NfrwWq
	UfGYE0evz47B0yLPasuD/wV5tF/mspshfZeRrVChZXBiovWx+EEBg4CduenVAf1g
	H9t8zu0jnxly4Wl9dwLsAQUvjedhXQnGl8QmYRTRTIzT27dLMSdswk2IELYhdu5D
	6lBP+b1OeUbCRigkCvPKCyLqAGWZJ413C7jSw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 106351F568;
	Fri,  3 Jun 2016 11:59:49 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8DDB01F567;
	Fri,  3 Jun 2016 11:59:48 -0400 (EDT)
In-Reply-To: <57511086.40206@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershausen?=
 =?utf-8?Q?=22's?= message of
	"Fri, 3 Jun 2016 07:07:18 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 32DA1DD4-29A4-11E6-9298-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296342>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> There where 2 comments in the review.
> The most important thing is that now
> git://[example.com:123]/path/to/repo is valid, but it shouldn't.
> This patch fixes it:
>
> @@ -673,7 +669,7 @@ static enum protocol parse_connect_url(const char=
 *url_orig, char **ret_user,
>          * "host:port" and NULL.
>          * To support this undocumented legacy we still need to split=
 the port.
>          */
> -       if (!port)
> +       if (!port && protocol =3D=3D PROTO_SSH)

Hmph, which one of these (if any) is valid, which ones aren't and
why?

    git://[example.com:123]/path/to/repo
    ssh://[example.com:123]/path/to/repo
    [example.com:123]:/path/to/repo

I am wondering about the latter two, because both of them would
become PROTO_SSH at some point in the codepath.  And I am wondering
about the first two, because they look the same at the syntactic
level and if one is allowed the users would expect the other would
also be (or vice versa).
