From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH][RFC] git on Mac OS and precomposed unicode
Date: Sat, 07 Jan 2012 18:46:13 -0800
Message-ID: <7vboqehpxm.fsf@alter.siamese.dyndns.org>
References: <201201072059.19103.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun Jan 08 03:46:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rjim7-00043Q-Az
	for gcvg-git-2@lo.gmane.org; Sun, 08 Jan 2012 03:46:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752718Ab2AHCqS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Jan 2012 21:46:18 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57192 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751779Ab2AHCqR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Jan 2012 21:46:17 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 312CC7AF7;
	Sat,  7 Jan 2012 21:46:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=0pU5FGQYuDK6
	+40uReR68vNcf/g=; b=bNX1UGQKu0TGmMp7yw0dwJ3+Ld7Z09lXrfeUcWCizZmH
	6hvNsXRGw/nC+n8Mcl3uwPE3Fn11ZQJv6teipJ07leC8a13DCrAMGf8nLk+EJYel
	hnWVwIwB2GpWAC5y/1jrKIToSdFr6TnPu2fYPKnBiUSE061BNmpiimpl6cuezSs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Oas8D5
	P0f0MSAYlgLZ8UbD3zFBoUpSu/GImCNU0hlD+QYhueePtF5rNqWL/5vYNSvrNDDF
	USPRDWEvVFAvdG/SKT8q0JK7Yaiq77aj7Ky74O1xWa/AH4ElbpmIIw6Ed8LM5Ca/
	X7sHHW10M42kqXt8AaT2mLkBTmOZ139YOEFUk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 27B6B7AF6;
	Sat,  7 Jan 2012 21:46:16 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 469B07AF4; Sat,  7 Jan 2012
 21:46:15 -0500 (EST)
In-Reply-To: <201201072059.19103.tboegi@web.de> ("Torsten =?utf-8?Q?B?=
 =?utf-8?Q?=C3=B6gershausen=22's?= message of "Sat, 7 Jan 2012 20:59:18
 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EEE06CE6-39A2-11E1-A348-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188090>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> Implementation:
> Two files are added to the "compat" directory, darwin.h and darwin.c.
> They implement basically 3 new functions:
> darwin_opendir(), darwin_readdir() and darwin_closedir().

I haven't looked at the patch yet but that sounds exactly the right way=
 to
go about this. Nice.

> No decomposed file names in a git repository:
> In order to prevent that ever a file name in decomposed unicode is en=
tering
> the index, a "brute force" attempt is taken:
> all arguments into git (technically argv[1]..argv[n]) are converted i=
nto
> precomposed unicode.

That also sounds sensible, but...

> This is done in git.c by calling argv_precompose() for all commands
> except "git commit".

=2E.. I think it generally is a bad idea to say "all except foo". There=
 may
be a reason why "foo" happens to be special in today's code, but who sa=
ys
there won't be another command "bar" that shares the same reason with
"foo" to be treated specially? Or depending on the options, perhaps som=
e
codepath of "foo" may not want the special casing and want to go throug=
h
the argv_precompose(), no?

After all, "git commit -- pathspec" will have to get the pathspec from =
the
command line, and match them against the paths in the index, the latter=
 of
which you are keeping in the canonical form, so you would want the argv=
[]
also be in the same form, and applying your argv_precompose() would be =
a
sensible way to do so, no?

I would also suspect that the cleanest way to implement it is to replac=
e
the main() entry point (see how compat/mingw.h does this).
