From: Junio C Hamano <gitster@pobox.com>
Subject: Re: t0005-signals.sh fails with ksh
Date: Fri, 08 May 2015 14:39:32 -0700
Message-ID: <xmqqk2wiiwa3.fsf@gitster.dls.corp.google.com>
References: <31108626.20150508231514@gmail.com>
	<xmqq1tiqkdue.fsf@gitster.dls.corp.google.com>
	<20150508205548.GB13457@peff.net> <20150508211453.GA11594@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: evgeny <illumsoft.org@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 08 23:39:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yqpzf-0004ag-EQ
	for gcvg-git-2@plane.gmane.org; Fri, 08 May 2015 23:39:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752933AbbEHVjf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2015 17:39:35 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52179 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751568AbbEHVje (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2015 17:39:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0BC3C4E7F6;
	Fri,  8 May 2015 17:39:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pFtdg7ev5yWk8hSJlY6cu35yWf8=; b=UDFzKj
	vXf831jgrp0o3mztBZdFn7CcktDMin69nVlC8f3tRfqJPtdT5O6LI/JOTaaEXxSg
	NkvJx4mwjROZOmueuy5JIHUXFsjFrbPrvCa9HjKLEOH4vYbEdrA1f3xDHZ2ZiY3A
	OOdmKiKOb5rUG8HRcVnlERIdPIY+LpqqMwk5s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eIgKaqt4p9ff6Ta5/6i1wOkZZOKKo0Ep
	hte+x3O8Rf9DigzktBWHc6NujNsz/PkZZrbjsSWBG7LJLQQ0sYR8iWUGgLHewVvF
	8eyLICiSIlFZgVRLnwh29P3qCOHJkJ0O8eQc2yLjv3Ejjc2VAc8jBVNNaJoVjty9
	/srOODUxI/A=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 03C094E7F5;
	Fri,  8 May 2015 17:39:34 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7C00D4E7F4;
	Fri,  8 May 2015 17:39:33 -0400 (EDT)
In-Reply-To: <20150508211453.GA11594@peff.net> (Jeff King's message of "Fri, 8
	May 2015 17:14:54 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B7498B5E-F5CA-11E4-A8A3-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268677>

Jeff King <peff@peff.net> writes:

> Here's an oddity I isolated based on a failure in t5502:
>
>   $ git init foo && cd foo
>   Initialized empty Git repository in /home/peff/foo/.git/
>
>   $ (cd .git/objects && ls)
>   info pack
>
> OK, makes sense. Now...
>
>   $ mkdir subdir && cd subdir
>   $ ls ../.git/objects
>   info  pack
>   $ cd ../.git/objects
>   ksh: cd: /home/peff/foo/git/objects: [No such file or directory]
>
> Um, what? Apparently using "../.foo" will eat the "." off of "foo"?

That is fun.  And doing

    $ mkdir -p git/objects

just before you create and chdir into subdir does tell me that the
last "cd ../.git/objects" is turned into "cd ../git/objects".

Actually, with that extra thing, changing the last one to

    $ cd ../..git/objects

still takes me to ../git/objects, it seems.  But lookie here:

    $ cd ../.....git/objects
    ksh: cd: /var/tmp/x/ksh/...git/objects: [No such file or directory]

WAT.

I am tempted to say that we should write it off as utterly broken.
