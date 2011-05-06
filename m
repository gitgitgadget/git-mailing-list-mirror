From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Improvement of git commit interface
Date: Fri, 06 May 2011 09:10:21 -0700
Message-ID: <7vvcxn24k2.fsf@alter.siamese.dyndns.org>
References: <201105061403.27242.patrick.haecker@lss.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Patrick =?utf-8?Q?H=C3=A4cker?= 
	<patrick.haecker@lss.uni-stuttgart.de>
X-From: git-owner@vger.kernel.org Fri May 06 18:10:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QINbt-0004Mp-Gc
	for gcvg-git-2@lo.gmane.org; Fri, 06 May 2011 18:10:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756040Ab1EFQKa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 May 2011 12:10:30 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:57562 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755890Ab1EFQK3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 May 2011 12:10:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5E2435940;
	Fri,  6 May 2011 12:12:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=1uIx67khTTXEBb1nxapRWnGrK
	oY=; b=VCdsZ3BYE+C5qPMH+7mJvGBdooE0ukOyATZG0ES7MgksCHNiX/JdRmaPR
	uwLrB5NzAQ1PealOwkzYHpTC+0S70P0sMO8KJITI7vF/3pXfpJ8bM29luBnEh54N
	HdugRBcNY6s6gThs+guQSM3SM4UCdKLByv8Zx6zJgCi9dIVuAI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=k9iIm9TF5axBr/KLVUd
	gxNs8OoplbNSdCcs0648RrIw6UlAjEk4PK61KIlFxy8js37AREBHJq0fwWR2aql6
	dI4hfri1DAN7Wv3Iw+LIW/ImcjUnCt5+eAhz/Bn1bbCllueL4vQfuolvk1F1YA62
	PIU/WOQgtzUocccHyZwfehVs=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 36C5B593C;
	Fri,  6 May 2011 12:12:30 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 3C9CD593B; Fri,  6 May 2011
 12:12:26 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A47EE682-77FB-11E0-A2D5-90BEB0B5FC3A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172986>

Patrick H=C3=A4cker  <patrick.haecker@lss.uni-stuttgart.de> writes:

> After a file has been added to the repository once, you can use git w=
ithout=20
> knowing anything about the staging area, with "git commit <filename>"=
=2E=20
> Shouldn't we allow "git commit <filename>" for files never added to g=
it, as=20
> well?

This and its extreme form "git commit *" (also "git update-index *"), d=
o
not to touch untracked files. It was a very conscious and deliberate
design to avoid mistakenly adding unnecessary/unwanted cruft, e.g. obje=
ct
files and editor backups, to the index.  The primary reason we were ext=
ra
careful about adding cruft by fat fingers was because these operations
came before we had usable .gitignore support (in other words, this desi=
gn
is back from Linus's git days in early 2005).

In theory, as we have gitignore support, we now could change them and t=
he
end result would arguably be more consistent _as long as_ you always
maintain spiffy-clean gitignore list, but you need a very careful plann=
ing
to migrate existing scripts and millions of users' fingers without
breaking them.  Currently, the safety kicks in if you do this:

	$ >testing-01.c
        $ git commit *.c *.h
	error: pathspec 'testing-01.c' did ot match any file(s) known...

and people are used to and do rely on this safety to keep them from
accidentally committing throw-away experiments, debugging aids, etc.  Y=
ou
could argue that people _should_ teach their gitignore about "testing-*=
=2Ec"
but in practice that won't fly because throw-away stuff bye their own
nature come and go without planning, and catching things in gitingore
pattern is all about planning.

> I do _not_ suggest to change "git commit -a" to include all files nev=
er=20
> added to git, because that would be rather error prone.

We discussed "git commit -A" for this exact purpose in the past.  It is
just as error prone as making "git commit *" to add new paths, but "-A"
has a distinct advantage that it is _explicitly_ asking to add new path=
s,
and also it did not exist so there is no migration to worry about.

> P.S. Please CC, as I am not subscribed

No need to say this, as the convention on this list is never cull Cc:
unless there is a good reason.
