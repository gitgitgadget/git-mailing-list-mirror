From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Correct references to /usr/bin/python which may not
 exist on certain systems
Date: Sat, 20 Mar 2010 18:37:24 -0700
Message-ID: <7vaau278vf.fsf@alter.siamese.dyndns.org>
References: <20100320235105.GA30457@kiwi.sharlinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "R. Tyler Ballance" <tyler@monkeypox.org>
X-From: git-owner@vger.kernel.org Sun Mar 21 02:37:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtA6r-000521-1Z
	for gcvg-git-2@lo.gmane.org; Sun, 21 Mar 2010 02:37:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752549Ab0CUBhc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Mar 2010 21:37:32 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:45554 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752138Ab0CUBhc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Mar 2010 21:37:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6B2E9A3239;
	Sat, 20 Mar 2010 21:37:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5G+oDjJ4MlSP5g7XPn8MRhffZrw=; b=xkAY+H
	j/1Lkvz3/ysjOLO9jwksBcTz4rsBaMU6MVLcJTOeC6C2r/tadg5ma9iQxXTtcEYC
	AZQnaOo+w6NbYtFyOHwZ1QXCQZfSvL0IyhTR2YzbjSKlqIGN4fr0YsjZVN/59E91
	2U7E3RdJrYSWgFcquiIsB95yi6duPJHf/seA0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qa9WeHPo6qY/Y/8s9Ka8dm0LsnTVEO7Y
	5h4XLNzIioViwXvqrx07B3ZgoL+YVJhOspSIvFQQ/kIfe1m/SGFDsZCKOSk4Di3A
	wqr63GhBec0rCmPFphzVgUC+jmdqXk894xsXurrB2y7G7HOjjFm0wFQ0hFPWv7Zr
	mrZyWWrnBAg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 456B9A3238;
	Sat, 20 Mar 2010 21:37:29 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9A581A3233; Sat, 20 Mar
 2010 21:37:26 -0400 (EDT)
In-Reply-To: <20100320235105.GA30457@kiwi.sharlinx.com> (R. Tyler Ballance's
 message of "Sat\, 20 Mar 2010 16\:51\:11 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4FC08868-348A-11DF-AD0D-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142784>

"R. Tyler Ballance" <tyler@monkeypox.org> writes:

> FreeBSD for example does not ship with a /usr/bin/python such that Python
> installed from ports will be located by default in /usr/local/bin
> ---
> diff --git a/Makefile b/Makefile
> index 3a6c6ea..2b248b4 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -444,7 +444,7 @@ ifndef PERL_PATH
>  	PERL_PATH = /usr/bin/perl
>  endif
>  ifndef PYTHON_PATH
> -	PYTHON_PATH = /usr/bin/python
> +	PYTHON_PATH = /usr/bin/env python
>  endif

This wouldn't work very well, as XYZ_PATH is expected to point at full
path to the executable.  You should be able to say:

	test -f '$(XYZ_PATH_SQ)'

Yes, TCL_PATH and TCLTK_PATH may already be broken the same way, but I
don't think we want to make things worse.

I think setting PYTHON_PATH to /usr/local/bin/python inside

	ifeq ($(uname_S),FreeBSD)
        ...
        endif

block would be more in-line with the current design of the Makefile.

> diff --git a/contrib/fast-import/import-zips.py b/contrib/fast-import/import-zips.py
> index 7051a83..82f5ed3 100755
> --- a/contrib/fast-import/import-zips.py
> +++ b/contrib/fast-import/import-zips.py
> @@ -1,4 +1,4 @@
> -#!/usr/bin/python
> +#!/usr/bin/env python

These changes to contrib/ are correct and necessary, as we don't replace
them with Makefile targets like we do for the scripted Porcelains, if
people want to run them directly (or copy them out literally) out of
contrib/ area.  .
