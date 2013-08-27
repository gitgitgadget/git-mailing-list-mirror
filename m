From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] core.precomposeunicode is true by default
Date: Tue, 27 Aug 2013 07:49:02 -0700
Message-ID: <xmqqvc2rfau9.fsf@gitster.dls.corp.google.com>
References: <201307270321.32398.tboegi@web.de>
	<7vmwp5z3iu.fsf@alter.siamese.dyndns.org> <521CAD88.4080609@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Aug 27 16:49:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEKaH-0005my-5j
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 16:49:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753917Ab3H0OtI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Aug 2013 10:49:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45604 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753154Ab3H0OtG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Aug 2013 10:49:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0966C3C777;
	Tue, 27 Aug 2013 14:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=oIon2t6Eaq72
	DBp+f346Wj/iIuE=; b=dKdcYN/t8Hz2d5KOBEJMZWU15QWYpvvj881Y4JnrB0pm
	y3/x5T2l6QOOTIOUFIaHW4n8m84BS/TQ/FOneNSUmwCxsuznjuJkCYElsZfPg8zY
	sbdWqZ5pvVATUDxuOPX6zCOBvu5jSVRGxv83NoWnmGzg6Wc6NAr571F//+uWyUM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Drl8Hw
	yL6v2LolpmsPhUDov2RUf8MadQ45U/A5xfmkYVrbCsVBAcn6wnWxbOFF1zjE+tk+
	IPpk7+NtKsQuOPEob44RT2FSNtfRHPXQgZ+pa9UtYEGoUVc9m94CXom5nk+svGIm
	03FX0ifQC2Liugy+UkzbCZhocxrx10o0mDQHo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F199B3C776;
	Tue, 27 Aug 2013 14:49:05 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 43AA63C775;
	Tue, 27 Aug 2013 14:49:05 +0000 (UTC)
In-Reply-To: <521CAD88.4080609@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Tue, 27 Aug 2013 15:45:44 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D203B98C-0F27-11E3-80B9-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233093>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

>>... see if that path can be seen under its alias.  Why do we set it
>>to "false"?  Isn't this the true culprit?
>>
>>After all, this is not in the "reinit" codepath, so we know we are
>>dealing with a repository that was created afresh.
>
> There is nothing wrong with the auto-sensing as such.
> The problem for many users today is that we set core.precomposeunicod=
e
> to false, when it should be true.

I think we are in agreement then.

The code detects a broken filesystem just fine, but what it does
when it finds the filesystem is broken is wrong---it sets the
variable to false.  That makes the whole auto-sensing wrong, and I
think it makes sense to correct that behaviour.

> Let's look what precomposed_unicode does and go through a couple
> of git operations.
>
> 1)
> When we create a repo under Mac OS using HFS+,
> we want to have precomposed_unicode =3D 1

Yes.

> 2)
> When we access a repo from Windows/Linux using SAMBA,

You mean s/repo/repository that resides on HFS+/?

> readdir() will return decomposed.
> When the repo is created by nonMacOS, core.precomposeunicode is undef=
ined.
> The precomposition is off, but should be on,=20
> precomposed_unicode =3D -1, but should be =3D 1

I do not think UTF-8-MAC is widely available; even if you flip the
bit on, would it help much?
