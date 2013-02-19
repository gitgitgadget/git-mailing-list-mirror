From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Bugfix: undefined htmldir in config.mak.autogen
Date: Tue, 19 Feb 2013 14:59:52 -0800
Message-ID: <7v8v6j52qf.fsf@alter.siamese.dyndns.org>
References: <1be0a520b99fbfecd7255c1d26753015612856b3.1361272864.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Christoph J. Thompson" <cjsthompson@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 20 00:00:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7wAg-0002Z3-KI
	for gcvg-git-2@plane.gmane.org; Wed, 20 Feb 2013 00:00:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934821Ab3BSW76 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2013 17:59:58 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56502 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933463Ab3BSW75 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2013 17:59:57 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B2149A182;
	Tue, 19 Feb 2013 17:59:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YApELheNNIrgEtMOht2SHqoRqf0=; b=NF9ooB
	Xo+ahnRMMUfsMpjQaZ+LWOi1jXhaRHN6rkl8iHj03//zXFIS+hmZprzR8BvLyD3J
	ddpRFYmQw3jjR86N3pIsPi/pfT2SzTJxLvHdJ48J+C8N+PH6hl9pP91xAour85oE
	RCcVKuEc4koiqRTP1/j/KHhfL/A7YcmE2y7cY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dN1wf6M7Z/e19HdPCD72pjlxHeeeVpKo
	VTijrPCgEsB7Vy+HSl59YPdeOkAX6QxI11L0dBG70HjdJl7SbUNs2vzFbyQxeSey
	gNSV/R1m9gBJf5SSWDJQS3C5jG+BBmHNioA0KuheEiYzayb2065YHRtTOxma4n0R
	cJV2VtL5RfQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A570CA181;
	Tue, 19 Feb 2013 17:59:54 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 121EFA180; Tue, 19 Feb 2013
 17:59:53 -0500 (EST)
In-Reply-To: <1be0a520b99fbfecd7255c1d26753015612856b3.1361272864.git.worldhello.net@gmail.com> (Jiang Xin's message of "Tue, 19 Feb 2013 19:23:29 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 12CAD8EE-7AE8-11E2-AC92-21622E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216666>

Jiang Xin <worldhello.net@gmail.com> writes:

> Html documents will be installed to root dir (/) no matter what prefix
> is set, if run these commands before `make` and `make install-html`:
>
>     $ make configure
>     $ ./configure --prefix=<PREFIX>
>
> After the installation, all the html documents will copy to rootdir (/),
> and:
>
>     $ git --html-path
>     <PREFIX>
>
>     $ git help -w something
>     fatal: '<PREFIX>': not a documentation directory.

I am not sure if this description is correct.  The generated configure
seems to set

	datarootdir='${prefix}/share'
	htmldir='${docdir}'
        docdir='${datarootdir}/doc/${PACKAGE_TARNAME}'

so it is likely you would get not <PREFIX> but <PREFIX>/share, no?

In the main Makefile, we set htmldir to "share/doc/git-doc" and that
is supposed to be relative to PREFIX, so the above will be wrong in
multiple ways (it is an absolute path with <PREFIX>/ in front, and
it ends not with share/doc/git-doc but with share/doc/git).

And the worst part is that having to know that the file needs to
export docdir and PACKAGE_TARNAME feels to me that we are tying
ourselves to too much detail in the internal implementation detail
of versions of autoconf we happen to have for testing this change.

I am inclined to suggest that we probably should

 * revert fc1c5415d69d (Honor configure's htmldir switch,
   2013-02-02); and

 * fix generated "./configure --help" not to suggest that --htmldir
   can be overriden from its command line;

instead of piling on a broken "fix" like this one top of it.
