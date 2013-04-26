From: Junio C Hamano <gitster@pobox.com>
Subject: Re: "git grep" parallelism question
Date: Fri, 26 Apr 2013 11:47:10 -0700
Message-ID: <7vr4hxw2mp.fsf@alter.siamese.dyndns.org>
References: <CA+55aFxY2PJ+L=vCfvQ39UGBr7E6m5q76hO=z3Mqm6vTQmmMbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Apr 26 20:47:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVnfy-0000GK-Eh
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 20:47:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757299Ab3DZSrO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Apr 2013 14:47:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36583 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756319Ab3DZSrN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Apr 2013 14:47:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EF09419B57;
	Fri, 26 Apr 2013 18:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=n5B9xptiJfefq+piR4JlohGhAK8=; b=lDR7EZ
	yuhxYNi30Fqr7FSBLz17s9SZoitvG+sqTqj/YGJPgtygxEcnWu64+h0xg6VHtR3N
	KPm7ehgsA05qI3yVcwweima1ybDwqQSW1dpQ2Y0gULOmoO4z998IYx0gS4EN+C0D
	b7TMn9P9dxEQNUolNXgObWd3aAO2IpGDYeKj4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZfiNuk5aYgyEa50lO3v93DFFCUzkXDoC
	mDmfeaHDyQPmDhfGyPNY8SpwEbd8S5x+QSo73vx8E+jwPzCZot70WS8WeirvMrhx
	uGvJvTbknTpX0fL+wjafs/cv7ZOSaieU/pQSS07WY23WdaBZb4EwY7Lcu/70c7ez
	qsUbJeU+2IU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E5B3919B52;
	Fri, 26 Apr 2013 18:47:12 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6C26719B4E;
	Fri, 26 Apr 2013 18:47:12 +0000 (UTC)
In-Reply-To: <CA+55aFxY2PJ+L=vCfvQ39UGBr7E6m5q76hO=z3Mqm6vTQmmMbw@mail.gmail.com>
	(Linus Torvalds's message of "Fri, 26 Apr 2013 10:31:40 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B5055AAC-AEA1-11E2-94DA-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222551>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Wouldn't it be lovely if it was slightly smarter (something more akin
> to the index preloading that takes number of files into account) or at
> least allowed people to set the parallelism explicitly with a command
> line switch?

Yeah, a reasonable starting point for auto-tuning may be to use the
same kind of parameters and heuristics (i.e. max parallel of 20
threads, assume a cost to use an extra thread is the same as running
500 greps), and then tweak them (for example, thread cost of 500 may
be reasonable for lstat() but it would be way too big for grep()).

The real issue may be that we do not have a good estimate of how
many paths are involved in the request before starting these
threads, though.
