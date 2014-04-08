From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Race condition with git-status and git-rebase
Date: Tue, 08 Apr 2014 15:56:19 -0700
Message-ID: <xmqq1tx72zxo.fsf@gitster.dls.corp.google.com>
References: <20140408184421.GD5208@abyss.hitronhub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Yiannis Marangos <yiannis.marangos@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 09 00:56:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXewO-0001Xa-4B
	for gcvg-git-2@plane.gmane.org; Wed, 09 Apr 2014 00:56:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757154AbaDHW4X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Apr 2014 18:56:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52876 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756372AbaDHW4X (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Apr 2014 18:56:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AA4687B211;
	Tue,  8 Apr 2014 18:56:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GUmNujA21g87vpq80UQ90KC2gRw=; b=H8gqR6
	8e55CtGVT9gm4rGhcxnSnpziFNTy83DYMFjo/8bRYjHa+eqQixJnMQCoCRASk5K2
	N2FwXgKbV1auwfSQo0x4Hl1W16ualbfgZ0gLUzN7cxf6oJBLkwsZNsEGkTOrzlBy
	AlfU4gtkuE3H9JbGPeNvrC0m71OgnHk3KbBMM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Snif9zT0wJr6vPJRLrroyrF+gZQxU1Tv
	jGaqnahttdzy6oqbWBQ78pBiROwv/FqFkiI3OMIWT3wDXe2vSzfiFBgH4BD1/rug
	RZMKaHv4lhrpj0uDRmue8dNi40cmdha4hMyablTsTSfiRI1XcW6ICcqRu4uRlCFZ
	27/xzTorCCQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 975F37B210;
	Tue,  8 Apr 2014 18:56:22 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7B8407B20F;
	Tue,  8 Apr 2014 18:56:21 -0400 (EDT)
In-Reply-To: <20140408184421.GD5208@abyss.hitronhub.home> (Yiannis Marangos's
	message of "Tue, 8 Apr 2014 21:44:21 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 00B2DBEC-BF71-11E3-B526-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245965>

Yiannis Marangos <yiannis.marangos@gmail.com> writes:

> process A calls git-rebase
> process A applies the 1st commit
> process B calls git-status
> process B calls read_cache()
> process A applies the 2nd commit
> process B holds the index.lock
> process B writes back the old index (the one that was read from read_cache())
> process A applies the 3rd commit (now the 3rd commit contains also a revert of the 2nd)

The above sequence shows we are clearly doing it wrong.  B's taking
of the lock is not protecting anything from anybody.

We try minimizing the lock contention by delaying the taking of the
lock by B, but even if we leave it at the current location in the
above sequence, at least B must verify that the contents of the
index it just took the lock on still matches what it read with its
earlier call to read_cache(), which would make it pretend as if it
took the lock before it did read_cache(), before writing the
refreshed results back.

I think we have a checksum for the entire index file at the end, so
one fix might be to teach read_index_from() to read that and store
it in a new field in "struct index_state", and then make the
"opportunistic update" codepath to verify that the index on the
filesystem still has the same checksum.
