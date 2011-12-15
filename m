From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] Do not create commits whose message contains NUL
Date: Thu, 15 Dec 2011 10:46:32 -0800
Message-ID: <7vehw5oepj.fsf@alter.siamese.dyndns.org>
References: <1323777368-19697-1-git-send-email-pclouds@gmail.com>
 <1323871699-8839-1-git-send-email-pclouds@gmail.com>
 <1323871699-8839-4-git-send-email-pclouds@gmail.com>
 <7vzkevow2j.fsf@alter.siamese.dyndns.org>
 <20111214182953.GA6469@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Miles Bader <miles@gnu.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 15 19:46:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbGKG-0006fs-21
	for gcvg-git-2@lo.gmane.org; Thu, 15 Dec 2011 19:46:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759277Ab1LOSqf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Dec 2011 13:46:35 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37431 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759063Ab1LOSqe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Dec 2011 13:46:34 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3194758A5;
	Thu, 15 Dec 2011 13:46:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=g+MyN2q40V6E
	51wZ1EmMKUNrJbA=; b=uVlqIxKpNxUMd4r2NqGukw/Q7akH7aEZ0puAH7OHxxZo
	3UIiRPPSHHHl3tRivYJXtncNKwHfX0Z3AHW6ZaADu4gDTaOky+apETKBBlVpEkRM
	r5Fvm8cDg+12yA2iRLat56CVQZyZpUsUjg/aPy6GLI55CFhVEdsx7zmug6u8Jzc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=e1Ekub
	dtK9J69XFo2uxC0n2fc/v28AA+0ruTiPnW+KAYCNd7hjHP1vaZhD2d3JADVQKvk6
	5RRwpdnsYoRWGCw/IaYsnzr+oaa57bhU3RK7gqh63Q+wBjWs8roJ0iG1lDSvdfeB
	qWCxRhGAzKpXCEoK7pK3qLrlHIms9LSuTXBlQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2839958A4;
	Thu, 15 Dec 2011 13:46:34 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8FDF758A3; Thu, 15 Dec 2011
 13:46:33 -0500 (EST)
In-Reply-To: <20111214182953.GA6469@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 14 Dec 2011 13:29:53 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1C256962-274D-11E1-8191-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187222>

Jeff King <peff@peff.net> writes:

> I'm happy to ignore custom programs linking against internal git code=
,
> but what should "git commit-tree" do?
>
> My gut feeling is that it should store the literal binary contents.
> However, I don't think this has ever been the case. Even in the initi=
al
> version of commit-tree.c, we read the input line-by-line and sprintf =
it
> into place.

Yeah, you are right. Perhaps we should tweak updated 3/3 to check at th=
e
lower level commit_tree() then.

I've rewrote the log message for 2/3 as follows so we can go either way
;-)

    Convert commit_tree() to take strbuf as message
   =20
    There wan't a way for commit_tree() to notice if the message the ca=
ller
    prepared contained a NUL byte, as it did not take the length of the
    message as a parameter. Use a pointer to a strbuf instead, so that =
we can
    either choose to allow low-level plumbing commands to make commits
    that contain NUL byte in its message, or forbid NUL everywhere by
    adding the check in commit_tree(), in later patches.
   =20
    Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@g=
mail.com>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>
