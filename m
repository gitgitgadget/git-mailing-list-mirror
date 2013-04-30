From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] refs.c: interpret @ as HEAD
Date: Tue, 30 Apr 2013 09:09:57 -0700
Message-ID: <7vehdsf19m.fsf@alter.siamese.dyndns.org>
References: <1367324685-22788-1-git-send-email-artagnon@gmail.com>
	<87zjwguq8t.fsf@linux-k42r.v.cablecom.net>
	<20130430150430.GA13398@lanh>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@inf.ethz.ch>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 30 18:10:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXD83-0005fc-5t
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 18:10:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760934Ab3D3QKD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 12:10:03 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47382 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760331Ab3D3QKA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 12:10:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 26A4018757;
	Tue, 30 Apr 2013 16:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iCA/PL6r7ngWT9o08Jt6UQxOU2E=; b=HVcX7e
	PgO1FOZ5+kCnMn2DWD9/4EWGSGN4JdKelWXvF/r9xt7AjBmon1CExD7qbrCgMHYX
	R7PE6SfORgOR3iuUbHB31i4An05/4J2bEL4rLrVhjG0si9UNhw0s193YQXkYvdYA
	A9EOuwl9hOAL/BI6n7xgno/BAR+ksL+Y4VOKU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SzE2Qo7X+HCxZJUzKNUk2vY1vjG83D72
	YpYp/+FPtmo7K1y1zpoCGIxiGiTCNULX2o4YLtTGuK814IANrtJ3Di7jJC7boM0B
	u+Tk99JUTBHp1vUBuH8VQK8+Q+Gk//ZmMZ4JomdTCNPqoKkGP1thXTPWMFjqHE48
	WqgVPiaBpGc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1DB5818755;
	Tue, 30 Apr 2013 16:10:00 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 95A7C18753;
	Tue, 30 Apr 2013 16:09:59 +0000 (UTC)
In-Reply-To: <20130430150430.GA13398@lanh> (Duy Nguyen's message of "Tue, 30
	Apr 2013 22:04:31 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 68447E70-B1B0-11E2-86E5-A3355732AFBB-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222942>

Duy Nguyen <pclouds@gmail.com> writes:

> It's not hard to do. The below patch makes "." equivalent to HEAD and
> ".U" -> "@{u}". Refs are not supposed to have '.' at the beginning, so
> it's easy ...

How is the equivalent of master..@{u} expressed?  master...U?  How is
it disambiguated from a symmetric difference between master and U?

There are reasons why some characters are forbidden from appearing
at certain places in refname component. Anybody who designs a new
syntax needs to think _why_.

The restriction that a @ in refname cannot be followed by { is for
the same kind of disambiguation.  I do not mind a way to spell HEAD
with shorter than 4 keystrokes, and as I said I suspect "@" may be
the least bad one among what people may come up with in this thread,
but I do not think we can explain it as "@ is a synonym to HEAD"
[*1*].  We need to see if we can make the explanation we will give
to end users is understandable.


[Footnote]

*1* I do not think "@ is a new synonym for HEAD" would not be a good
explanation.  Some questions you should ask yourselves to see why:

"git update-ref HEAD $commit" is accepted.  If @ is a synonym for
HEAD, "git update-ref @ $commit" should work exactly the same way,
but is it desirable?  Would we have $GIT_DIR/@ as the result?  How
about "git symbolic-ref"?  Would @@{4} and HEAD@{4} be the same?
