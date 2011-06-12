From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/48] Handling more corner cases in merge-recursive.c
Date: Sat, 11 Jun 2011 23:28:54 -0700
Message-ID: <7vsjrfsgux.fsf@alter.siamese.dyndns.org>
References: <1307518278-23814-1-git-send-email-newren@gmail.com>
 <7vipsctez0.fsf@alter.siamese.dyndns.org>
 <BANLkTimd0O70e7KhT-G5quxQhF_Nwc30Hg@mail.gmail.com>
 <7vzklnshcm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jgfouca@sandia.gov, Jeff King <peff@peff.net>
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 12 08:34:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QVeFf-0003Z2-GE
	for gcvg-git-2@lo.gmane.org; Sun, 12 Jun 2011 08:34:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751732Ab1FLG3I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Jun 2011 02:29:08 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:34919 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751026Ab1FLG3G (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jun 2011 02:29:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8973F5AC4;
	Sun, 12 Jun 2011 02:31:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2NtkC1lt3LEBwG3Stuiim6VpSOA=; b=JJvgJM
	fi8cFo0X+T86z3ReZ/I5+Yxw9gmllLBAjB2o0zelp5A/NBRQiKa2Bo8l3eKFB2MC
	7ZKGI3MD8ZTn/8hgRDKg9FkLdVTY0ymXNQjPPlhzr0AZpvUq3GTzkT1PkAl3zz9K
	t+apUh20Eoih9ZJ8pAqy4S+ko23d9ETugRoLU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IIcjlBBIAx6br1DGkiAMvb6FA2V1E7nF
	cV2HGwQiAKHtQ6fp3TmQpjf1/A4IjI8HJYl2VHMFDBpiuftlmMCU9u6hgFGxW9Ff
	aeF9eShRd5lrsodRDHnA/+wjGFFT15N40Jk4fx9L6c6IzWvPBQGMiWLb66GAK1zN
	WBu6W+L2Uhc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2D9AF5AC2;
	Sun, 12 Jun 2011 02:31:11 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B1C135AC0; Sun, 12 Jun 2011
 02:31:05 -0400 (EDT)
In-Reply-To: <7vzklnshcm.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sat, 11 Jun 2011 23:18:17 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 904029B8-94BD-11E0-887B-C8CFB7AE1C3C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175653>

Junio C Hamano <gitster@pobox.com> writes:

> Elijah Newren <newren@gmail.com> writes:
>
>> It does sound potentially expensive, though, and might mean a lot
>> more work in merge-recursive to handle that extra information.  Is that a
>> path we want to take at some point?
>
> Probably you can start with backend specific option (e.g. -Xbreak=yes) to
> experiment. We made recursive the default not because it deals with
> renames (in a broken way) but primarily because it handles criss-cross
> better; at some point we might also want to add another backend specific
> option (e.g. -Xrename=off) to allow the users to keep the "recursive"
> aspect of the strategy while declining a more expensive (and brittle)
> rename handling to take effect.
>
> My gut feeling is that -Xbreak=yes, once the code does work well enough,
> would have to become the default. It would make the default mode of merge
> possibly quite expensive but it is Ok as long as we give projects with
> simple/clean history an easy way to use either "recursive -Xrename=off" or
> even "resolve" to avoid cost that is unnecessary to handle their needs.

I forgot to mention that there is jk/maint-merge-rename-create effort by
Peff already queued in 'pu' to use "break", which of course has
unfortunate conflicts with your series.
