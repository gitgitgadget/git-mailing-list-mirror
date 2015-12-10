From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-clone fails when current user is not in /etc/passwd
Date: Thu, 10 Dec 2015 11:57:41 -0800
Message-ID: <xmqqtwnqgjpm.fsf@gitster.mtv.corp.google.com>
References: <CAKfKJYsyHn7FUOu65AqbvjZD-wAyRScjqUL6kgGDCVzG1myZTQ@mail.gmail.com>
	<CACsJy8AQFSvcxKqSdWfvGArV60RA96WcvvofpfJ4EuG+q_=t0Q@mail.gmail.com>
	<CACsJy8Dc3Lsqa2zccoqH7UkDitqDbOTX3EXsUCcN9OHY=LfaKw@mail.gmail.com>
	<CAKfKJYuP1E5aC7SPO91j-KS-P41pYaM7NkTJ9uG6b=VvxbOBwg@mail.gmail.com>
	<20151210183426.GA27609@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Taylor Braun-Jones <taylor@braun-jones.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 10 20:57:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a77LZ-0003mi-PV
	for gcvg-git-2@plane.gmane.org; Thu, 10 Dec 2015 20:57:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753203AbbLJT5q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Dec 2015 14:57:46 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:61905 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752482AbbLJT5o (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Dec 2015 14:57:44 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 76E9B33DFB;
	Thu, 10 Dec 2015 14:57:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/siUkob0UFxvqhOO1L03uM5wXZo=; b=PhCt34
	WqrRzc+I6SxN9h/Lrc7xJ408UOXUQDXaMFN4gheBb6LRlOUGGwg1iy7kQlaYgHK0
	FibDH+EV1ljWNK9oopHgsCSvIx+5u4Iuy1EqksmYuLXACC8xyaxakvEtl8Hc0McU
	nu+9+JKzQMzhe+X4tEEdJlSM+m/CMIfqkkrVQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vJiMLPr7f+GT3tjY4pNs1V1z22BmzQ2d
	5s8odgGLlD5K3NkcNhhZeygVEvga3hXxWO19OsQezfBnHajDz3rj67rVkbOhPdYn
	bDg5DpP+HdrSPxOe89GH7oFfg6NHJtLfD61d1PPZfy1DnOFL2R8QkiMvAVusMiai
	CuT0DhChQJM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6E5AF33DFA;
	Thu, 10 Dec 2015 14:57:43 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E6A8C33DF7;
	Thu, 10 Dec 2015 14:57:42 -0500 (EST)
In-Reply-To: <20151210183426.GA27609@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 10 Dec 2015 13:34:26 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 46557F68-9F78-11E5-AEEA-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282229>

Jeff King <peff@peff.net> writes:

> But before we even hit the strict-check, we call xgetpwuid_self(), which
> unconditionally dies on failure. I think that function needs to be
> taught a "gently" form which we use for non-strict ident lookups.
> Unfortunately it's a little non-trivial because the strictness will need
> to get passed all the way down to ident_default_name() (and we need to
> make sure that a non-strict check followed by a strict one does not
> fail; i.e., that the first does not pollute the contents of
> git_default_name).

All true.  The adding of "(none)" in add_domainname() I used as an
excuse to make the function stop barfing is a symptom coming from
the above.  That one should die when asked to do a strict thing
(there is a corresponding kludge to do strstr "(none)" to cover it
up, which is even uglier X-<).
