From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Makefile: Remove excess backslashes from sed
Date: Thu, 08 Apr 2010 22:57:56 -0700
Message-ID: <7vvdc12mmz.fsf@alter.siamese.dyndns.org>
References: <1270783330-35215-1-git-send-email-brian@gernhardtsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Brian Gernhardt <brian@gernhardtsoftware.com>
X-From: git-owner@vger.kernel.org Fri Apr 09 07:58:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O07EL-0001tI-FK
	for gcvg-git-2@lo.gmane.org; Fri, 09 Apr 2010 07:58:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754532Ab0DIF6I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Apr 2010 01:58:08 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:48734 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750878Ab0DIF6E (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Apr 2010 01:58:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B15B1A91F7;
	Fri,  9 Apr 2010 01:58:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=D+JK/lZw0+rJCadvH4mXIUNhhKo=; b=H0PxoD
	yJaxPsUNCbEjVU26pLKygND+0qQsam9XuKME98UTe621RJay90wnlO4iLSPYqbKh
	lxzQjeWYEYcPCp4k8nR0GK2hv8LY/5oK109c0MG/0eyiyTWr2n+fZMbtPrQ+oToi
	ygdI6FD4mHxKu5HBWdRSgLqaDZSk5964GiQ98=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OYp8ZmHQDrSISA0XIljMDyghgN0Iu+Ws
	bibo3FkRmjLE/qSuPhjSyQ9VhVgG3/ANZ9wu8fyjyH6hOu/6xOs95qix9bjqKEB6
	NHa8WArxmZ1owN9AQsSQ0d+p08yj13ziNbG6u8vn3t7Wn38oMXLR0XqmL0wu3gt5
	L8MkXs6pEXk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8DCC0A91F2;
	Fri,  9 Apr 2010 01:58:00 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E1B45A91F1; Fri,  9 Apr
 2010 01:57:57 -0400 (EDT)
In-Reply-To: <1270783330-35215-1-git-send-email-brian@gernhardtsoftware.com>
 (Brian Gernhardt's message of "Thu\,  8 Apr 2010 23\:22\:10 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: DA944558-439C-11DF-8AF3-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144409>

Brian Gernhardt <brian@gernhardtsoftware.com> writes:

> The sed script that was intended to add lines altering the sys.path
> had extra backslashes in them.  Instead resulting in
>
>   import sys;  import os;  sys.path.insert( ... )
>
> It output
>
>   import sys; \ import os; \ sys.path.insert( ... )
>
> Unfortunately this caused python (2.6.1 on OS X 10.6.3) to error
>
>   SyntaxError: unexpected character after line continuation character
>
> Removing two of the backslashes solves this problem.

Traditionally, multi-line sed statements written in the Makefile were
portability nightmare, as the line folding rules (especially how the
backslash is treated in the output) in make implementations were subtly
different, and implementations of sed also got multi-line statement often
wrong.  These days, things might have gotten much better, but in olden
days (back when BSD vs SysV war was still raging), the trick to write
things like this portably was to invoke a shell script that has multi-line
sed statement from the Makefile.  It was painful.

I wonder if we can make this a lot simpler to avoid multi-line sed script.
For example, we could write the source Python script to always begin with:

	#!/usr/bin/python
        import sys;
        import os;
        sys.path.insert(0, os.getenv("GITPYTHONLIB","."));

and then do something like this in the Makefile:

	INSTLIBDIR=... && \
	sed -e '1s|#!.*python|#!$(PYTHON_PATH_SQ)|' \
        -e 's|\(os\.getenv("GITPYTHONLIB"\)[^)]*)|\1,"'"$$INSTLIBDIR"'")|' \
        <$@.py >$@+
	mv $@+ $@

Contributors can then run things in-place while developing the scripts,
perhaps setting GITPYTHONLIB to the source area.
