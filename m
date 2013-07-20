From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/7] fetch-pack: support fetching from a shallow repository
Date: Fri, 19 Jul 2013 20:17:03 -0700
Message-ID: <7v61w5udhs.fsf@alter.siamese.dyndns.org>
References: <1374065234-870-1-git-send-email-pclouds@gmail.com>
	<1374065234-870-6-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 20 05:17:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0NfV-0008Kh-Mt
	for gcvg-git-2@plane.gmane.org; Sat, 20 Jul 2013 05:17:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753589Ab3GTDRI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Jul 2013 23:17:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50524 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753539Ab3GTDRH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Jul 2013 23:17:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A696A2ACC2;
	Sat, 20 Jul 2013 03:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Sctdho8n9qTH
	NwECgIw82fy7Nws=; b=eqr0xnycVYnFrMOkEitS7bRFnzhDdKFDfNdG7Nmezg9f
	DZgiP68AoF354N379LR8tz7da6ZxA7W4/Ys8OZaRlFH7JRrFyjiHmkS5cHuOEBz4
	8cVHbPrQN519DqkuazPEHeZJygCmEWbOkm3T09NqjfAcAE/0DGRL4cSy7qSEsPg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=PDUNqm
	uv/0gCzARhXsohgEkGTkGY7W5qPeWfZiqqAPstoZskSTeBZQAqeLvw4zgghIe56b
	ewrQTTtKnsGnuxFpRLSZe5FW8Yjcep8sFVdHECs5OeHtkMVPZK1o5Zf4QLxcYaMA
	8mKTmbU9dmVeG3jc6B5RArlkaleDGWY33AwN0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9DA032ACC1;
	Sat, 20 Jul 2013 03:17:05 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 01F322ACBF;
	Sat, 20 Jul 2013 03:17:04 +0000 (UTC)
In-Reply-To: <1374065234-870-6-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuIFRow6FpCU5n4buNYw==?= Duy"'s message of "Wed, 17
 Jul 2013 19:47:12 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DA4F31A8-F0EA-11E2-843E-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230870>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Only server graft points that do not have corresponding SHA-1s in
> local repo are added to the temp shallow file because we don't want t=
o
> accidentally cut the client history because the server's is
> shorter. The client cutting can only happen when --depth is requested=
=2E

This "have corresponding SHA-1" is iffy from connectivity point of view=
,
isn't it?  That is,...

> +	for (i =3D 0; i < extra->nr; i++) {
> +		if (!remove_unused_grafts && has_sha1_file(extra->array[i]))

=2E..shouldn't this require much more than "has_sha1_file()", like
"has it, and we have everything behind it with respect to the
shallow graft points we started with" or something?

Otherwise an isolated island that was left behind by an earlier
aborted commit walker fetch may mislead us to believe that we have
the complete history behind this commit object.
