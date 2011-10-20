From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [IGNORETHIS/PATCH] Choosing the sha1 prefix of your commits
Date: Wed, 19 Oct 2011 23:57:17 -0700
Message-ID: <7vr5289mlu.fsf@alter.siamese.dyndns.org>
References: <CACBZZX5PqYa0uWiGgs952rk2cy+QRCU95kF63qzSi3fKK-YrCQ@mail.gmail.com>
 <20111019190114.GA4670@sigill.intra.peff.net>
 <20111019193834.GA14168@sigill.intra.peff.net>
 <7vvcrk9td7.fsf@alter.siamese.dyndns.org>
 <20111020043448.GA7628@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 20 08:57:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGmZB-0006MD-JL
	for gcvg-git-2@lo.gmane.org; Thu, 20 Oct 2011 08:57:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753647Ab1JTG5V convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Oct 2011 02:57:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41095 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751692Ab1JTG5U convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Oct 2011 02:57:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9C8AF4652;
	Thu, 20 Oct 2011 02:57:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=hpahUXrk/cQH
	R9UulN/veN5oC2s=; b=uy5zP6pGQht5cvH5Wwhj9TGUxKmd/c0V/D8CBg0CICLs
	ZtZnRoEwtPHz9m18goyCmRLa8OO+EaVvAJlTt6qk3KFG0a1kParDgqrSAi48oMnB
	XxF3bG5+jQRNsk9zFKquAmnrNvCufa8wjIFSeEzcPp5dwAKjGRATuvOGMhOMyMg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=xAlcpk
	9Oz8x8whS7sUlqpTrE74ted2ggZ7k4y2xCme0Oo5hCJIIFf82v3jPct+hGfNihVP
	ZZDagtHI/NeFe/ILCOFRGgVD86JHCKYGQafmJE8nUEo8jgGZJIGuR732ifed3YEv
	6Min62lR0OuSXVYvtMnGcnAjKZMxiNxbXdN5A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 94A8B4651;
	Thu, 20 Oct 2011 02:57:19 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 26DE64650; Thu, 20 Oct 2011
 02:57:19 -0400 (EDT)
In-Reply-To: <20111020043448.GA7628@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 20 Oct 2011 00:34:48 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C098A7DE-FAE8-11E0-9ABA-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184009>

Jeff King <peff@peff.net> writes:

> Agreed. Having hidden cruft makes birthday collision attacks easier (=
or
> it will, if sha1 ever gets broken to that point).  Unfortunately, the=
re
> is a _ton_ of code which assumes that commit messages are
> NUL-terminated, as they always have been since e871b64 (2005-05-25).

I think that commit is irrelevant, as long as read_sha1_file() returns =
the
contents as <ptr,len> pair, which has been the case forever. It's just =
the
matter of propagating the length back up the callchain.

A na=C3=AFve implementation to add "len" member to struct commit would =
increase
the size of the in-core commit object by sizeof(unsigned long), which w=
e
may want to avoid. Traversals that care nothing but the topology of the
history would have to waste that memory and these things tend to add up
(8-byte ulong * 250k commits =3D 2MB).

Perhaps change the type of "buf" member in struct commit to a pointer t=
o a
<ptr,len> pair, or something? Or perhaps a few megabytes wasted between
friends we do not care much about?
