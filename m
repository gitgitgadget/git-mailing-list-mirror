From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/7] archive: refactor format-guessing from filename
Date: Wed, 15 Jun 2011 16:48:32 -0700
Message-ID: <7vmxhiirlb.fsf@alter.siamese.dyndns.org>
References: <20110615223030.GA16110@sigill.intra.peff.net>
 <20110615223407.GE16807@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Junio C Hamano <gitster@pobox.com>,
	"J.H." <warthog19@eaglescrag.net>, git@vger.kernel.org,
	git-dev@github.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 16 01:48:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWzpA-000717-9M
	for gcvg-git-2@lo.gmane.org; Thu, 16 Jun 2011 01:48:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753456Ab1FOXsf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Jun 2011 19:48:35 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:65397 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752104Ab1FOXse convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Jun 2011 19:48:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A3F0264D2;
	Wed, 15 Jun 2011 19:50:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=+7DjY5mmvtwB
	uc2fRmhZeHndI8Q=; b=DPOsKzlOPfK35ZG8Ve4VEQMyb4lQ8ZzyjnXgvZF6oTau
	wYgP+JZ4VWRWDEhpJ/WOq1YHscFFP015NWZcnSquOK/AlKzanSrlAkhZLaDJ/7sQ
	gNgeENpeGOLNS53pvvUBdvx+bpnVZhonF+c5pfueKOSsiD4kk5fS45AUCcj/5RM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=bNwvof
	tkI/hQfnGJHpSb4LG9xdtHjrm42X7hpreO04VPk1F5lLtowqI/o8JvtKojfUxbQ6
	va7KEwYNj5xusKMQvXram0HE0XlsoGl+QCUoHk/beNdkOSWyxyIJDXlOLR9ezuKV
	brRfH8qE5H9gQLe/IXadTl8IYnhq7LIl2idTY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9D25264D1;
	Wed, 15 Jun 2011 19:50:44 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id F1D4564D0; Wed, 15 Jun 2011
 19:50:43 -0400 (EDT)
In-Reply-To: <20110615223407.GE16807@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 15 Jun 2011 18:34:07 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 48A313B4-97AA-11E0-A3F7-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175871>

Jeff King <peff@peff.net> writes:

> But more important is that the name hint is only a hint, and
> we default to the tar format. Which means that
> inconsistencies between the client's and server's set of
> formats will have confusing results. For example, imagine
> the client learns about "tar.gz" as an extension for gzip'd
> tar ("tgz") files, but the server does not. Locally,
> running:
>
>   git archive -o file.tar.gz HEAD
>
> will produce a gzip'd file. If we make the mapping decision
> locally, then running:
>
>   git archive --remote=3Dorigin -o file.tar.gz HEAD
>
> will send "--format=3Dtgz" to the remote side. The server will
> complain, saying that it doesn't know about the tgz format.

As long as that complaint is clearly marked as coming from the remote
side, the user now knows that tgz is not supported, and can fall back t=
o a
plain tar.

Am I being na=C3=AFve thinking that barfing (and assuming that the user
understands why the remote end barfed) actually is a good thing?
