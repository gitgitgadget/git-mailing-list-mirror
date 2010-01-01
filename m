From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Filename quoting / parsing problem
Date: Fri, 01 Jan 2010 11:50:27 -0800
Message-ID: <7vws01li4c.fsf@alter.siamese.dyndns.org>
References: <201001011844.23571.agruen@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andreas Gruenbacher <agruen@suse.de>
X-From: git-owner@vger.kernel.org Fri Jan 01 20:51:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NQnWu-00051f-L3
	for gcvg-git-2@lo.gmane.org; Fri, 01 Jan 2010 20:51:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752007Ab0AATuk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Jan 2010 14:50:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751993Ab0AATuj
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Jan 2010 14:50:39 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:56497 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751969Ab0AATui (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jan 2010 14:50:38 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 047ABACA44;
	Fri,  1 Jan 2010 14:50:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VeGEBZdLnX9vHgwJWneR0Zrbir4=; b=EnZCVG
	cj0nzlTZ+VHuajUYcdJkK187X6PIbtiaFGIXjpuDR9mVdcfreNWSc4jusyLnAfCw
	LijnJJwcPiLWKTUJCvNcvvreC/K8ic8yufR3tjkIfOaSw/NHSJwKITaYT+3UUTO9
	cXJwMeH+oLtJR8+4s06WJ5xvYZ5CdgLU7yHFA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YwMo5hLJEnc467e4ev+lfdHoV7m9DBfT
	om1AYdFuLPQNe6MDGhJWm0CrN3/aPuF6irwpNuMLriD4OEFSm6Sf1kdN+B3uvoOa
	3oszOEhqb8l9UUbmdfnRygwDyUH7U4jh5r/sWS69qN36S2tp0ox3DXaDSGHrMdNg
	Vo1/oh7e/RY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D9CE7ACA43;
	Fri,  1 Jan 2010 14:50:32 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D0836ACA42; Fri,  1 Jan 2010
 14:50:29 -0500 (EST)
In-Reply-To: <201001011844.23571.agruen@suse.de> (Andreas Gruenbacher's
 message of "Fri\, 1 Jan 2010 18\:44\:23 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: EBFD3B36-F70E-11DE-973D-465EBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136009>

Andreas Gruenbacher <agruen@suse.de> writes:

> Git quotes file names as documented in the git-diff manual page:
>
>   TAB, LF, double quote and backslash characters in pathnames are represented
>   as \t, \n, \" and \\, respectively.  If there is need for such substitution
>   then the whole pathname is put in double quotes.
>
> Spaces in file names currently do not trigger quoting.  (And \r triggers 
> quoting even though the man page doesn't say so).

Any control character is quoted; the documentation quoted above lists only
the common ones that have non-octal representation.

        $ git init one
        Initialized empty Git repository in /var/tmp/gomi/one/.git/
        $ cd one
        $ >hello && git add hello && git commit -m 'hello'
        [master (root-commit) 5338884] hello
         0 files changed, 0 insertions(+), 0 deletions(-)
         create mode 100644 hello
        $ >'a^Afile' ; >'b file' ; 'c file '
        $ git add 'a^Afile' 'b file' 'c file '

In the above sequence that attempts to reproduce the issue, "^A" actually
is a byte with value \001 (typically you would type ^V^A to get it from
the terminal on the shell).  "^G" seems to get "\a" even though it is not
in the list (that is why I said "only the common ones" above).

        $ git ls-files -s | cat -e
        100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0	"a\001file"$
        100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0	b file$
        100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0	c file $
        100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0	hello$

I used "cat -e" to make it easier to see that "c file " not only has SP in
it but it has trailing space.  Let's try the result.

        $ git diff --cached | cat -e
        diff --git "a/a\001file" "b/a\001file"$
        new file mode 100644$
        index 0000000..e69de29$
        diff --git a/b file b/b file$
        new file mode 100644$
        index 0000000..e69de29$
        diff --git a/c file  b/c file $
        new file mode 100644$
        index 0000000..e69de29$
        $ git diff --cached >P.diff

And as you described, "b file" and "c file " are not quoted and they do
not have ---/+++ lines.

But observe this:

	$ git reset --hard
        $ ls
        P.diff	hello
	$ git ls-files -s
        100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0	hello

We are now back in the state without any of these files, and P.diff records
a patch to recreate these three files, one with quoting and the other two
without.

	$ git apply --index P.diff
        $ git ls-files -s | cat -e
        100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0	"a\001file"$
        100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0	b file$
        100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0	c file $
        100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0	hello$

This demonstrates that The claim below is false, doesn't it?

> Not parseable:
>     diff --git a/baz  b/baz 
>     new file mode 100644
>     index 0000000..e69de29

Both "b file" and "c file " are parsed by "git apply" perfectly fine.
