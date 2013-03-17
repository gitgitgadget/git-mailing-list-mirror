From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Preallocate hash tables when the number of inserts are
 known in advance
Date: Sat, 16 Mar 2013 22:34:06 -0700
Message-ID: <7vzjy2si7l.fsf@alter.siamese.dyndns.org>
References: <1363490886-29729-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 17 06:34:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UH6Ev-00043l-Ow
	for gcvg-git-2@plane.gmane.org; Sun, 17 Mar 2013 06:34:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750896Ab3CQFeL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 17 Mar 2013 01:34:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39946 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750802Ab3CQFeJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Mar 2013 01:34:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6B23F94CD;
	Sun, 17 Mar 2013 01:34:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=xl4oYTzg7CMN
	rEiHFlkeSfKLMsM=; b=sZabZwk9dOn5PzujMzNJ0PHCHFKd1P9mWW+MhUzFBEso
	UgnAk3rGg5pmlSsJ79Bef+1xqINTNilXu40/KcWOEzokjoY04SeKAzKi0fizH8vj
	hj8BI+pr1+xkyNngAGXkdOcQ95+cTsAzYt6ATglLxnBoRmzaP5dRy5a9ewqKT8Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=kc4DJK
	A6lGzGuPQ6K9bpmnb+RLEUe+Sp6KwDvFxW+aJt7l/1yEkVnitWEYyHyAQqrWaVvn
	j/Oks0N3EWe8+BlKhgtYyBDffXc6oWkm+4PfpnrBWwlfCU8wa9aUj08fe3ucosv4
	0M+aaAuuYKtDTYJtyVeSOc3AvsiOP9CHMqR3g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5F46694CC;
	Sun, 17 Mar 2013 01:34:08 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D815D94CB; Sun, 17 Mar 2013
 01:34:07 -0400 (EDT)
In-Reply-To: <1363490886-29729-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sun, 17 Mar
 2013 10:28:06 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 49E3B414-8EC4-11E2-AB16-4AAA2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218331>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> This avoids unnecessary re-allocations and reinsertions. On webkit.gi=
t
> (i.e. about 182k inserts to the name hash table), this reduces about
> 100ms out of 3s user time.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>

I think this is a very good idea, but I would prefer the second
parameter to the "preallocate" to be "expected number of entries"
and have the preallocate, which is a part of the hash API, decide
how to inflate that number to adjust to the desired load factor of
the hash table.  We shouldn't have to adjust the caller when the
internal implementation of the hash table changes.

> ---
>  nd/read-directory-recursive-optim reduces the number of input (from
>  182k to 11k on webkit) to exclude machinery that all patches in the
>  exclude optimization series I posted seem insignificant. So I won't
>  repost them for inclusion unless you think it has cleanup values.

Sorry, without a pointer, it is unclear what "exclude optimization
series" you are referring to.
