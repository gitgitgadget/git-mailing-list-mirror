From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git format-patch doesn't exclude merged hunks
Date: Wed, 16 May 2012 11:49:43 -0700
Message-ID: <7vhavgc660.fsf@alter.siamese.dyndns.org>
References: <4FB3CAE3.6040608@draigBrady.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?P=C3=A1draig?= Brady <P@draigBrady.com>
X-From: git-owner@vger.kernel.org Wed May 16 20:50:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SUjIQ-0003PM-7o
	for gcvg-git-2@plane.gmane.org; Wed, 16 May 2012 20:50:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932100Ab2EPStz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 May 2012 14:49:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49633 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755159Ab2EPSty convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 May 2012 14:49:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 80E008F4B;
	Wed, 16 May 2012 14:49:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=nlc4Eb9dEcK8
	2xvY4BlF1L8tFfA=; b=Fehqi1ishBPKbyqjxPxdESDmWil3OXmPwI/L9RPsJCjf
	LeLo0QFrzGtRB3hykexdVQHwkIE2A+s59zeXNnGqN+LoaE+5DySmGINSUGolJNyL
	5P9CkWw3p4hhJMOZKHGPxl9vdkTNCp6fcfSGPywHZaBCVFlllKYMx6CuzgFKwYE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=rBTYuB
	WyegHEPImm0LtMglhS7wZFDaEl8yN1wT3kU0pUSyPyz7WQiYW7GbT1FgtE3hwJg4
	e6dA01NG69XG69A1abB3a//Ehg246uievnnllLsjVJU7CdVDRPxsIkQW9PG7iRb4
	hYUziJT4J1SBN2WSAxMtY4ZjPeuJW/7ZDsGZY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7837C8F4A;
	Wed, 16 May 2012 14:49:53 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8D5E48F43; Wed, 16 May 2012
 14:49:48 -0400 (EDT)
In-Reply-To: <4FB3CAE3.6040608@draigBrady.com> (=?utf-8?Q?=22P=C3=A1draig?=
 Brady"'s message of "Wed, 16 May 2012 16:42:27 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EA2ACDF4-9F87-11E1-91CE-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197890>

P=C3=A1draig Brady <P@draigBrady.com> writes:

> For reference the two commits in question are:
> https://github.com/openstack/nova/commit/7028d66
> https://github.com/openstack/nova/commit/26dc6b7
> Notice how both make the same change to Authors.

If you compare the changes these two commits introduce, you will also
notice that the "Authors" file is the _only_ common part of them.

"format-patch" (more precicely, the "git cherry" machinery that identif=
ies
the same patch) does not _selectively_ drop only a part of a patch whil=
e
keeping the other parts.  It is not per "hunk", it is not even per "fil=
e".

This is very much on purpose, and I think it is a good design decision.

In this particular case, the behaviour does look suboptimal, but if you
think about it harder, you will realize that the perception comes large=
ly
because in this particular commit, the change to the "Authors" file is =
the
least interesting part of the change.

Imagine a case where you were replaying a commit that changes a file
significantly and also changes another file in a trivial way, and where=
 it
were the significant change that has already been applied to the receiv=
ing
codebase, not the insignificant change to "Authors" file.

Now imagine that format-patch dropped the part that brings in the
significant change as duplicate, and replayed only the insignificant pa=
rt.
Most likely, the log message of the original commit explains what issue
that significant change tried to solve, and how the implementation in t=
he
patch was determined to be an acceptable approach to solve it, and that=
 is
what you will be recording for the replayed commit that only introduces
the remaining insignificant change.

I am not fundamentally opposed to the idea of (optionally) detecting an=
d
selectively dropping parts of a patch to an entire file or even hunks t=
hat
have already applied, but it needs to have a way remind the user somewh=
ere
in the workflow that it did so and the log message may no longer descri=
be
what the change does.  Most likely it would have to be done when produc=
ing
format-patch output, but an approach to make it a responsibility to not=
ice
and fix the resulting log message to the person who applies the output,=
 I
would imagine.
