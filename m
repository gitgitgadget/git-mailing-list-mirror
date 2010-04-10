From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 4/8] diff: Filter files that have changed only due to
 conversion changes.
Date: Sat, 10 Apr 2010 15:37:25 -0700
Message-ID: <7vvdbzszmi.fsf@alter.siamese.dyndns.org>
References: <cover.1270554878.git.grubba@grubba.org>
 <3daab2593b3f83971c6da6cfcd3d56046c84477a.1270554878.git.grubba@grubba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Henrik_Grubbstr=C3=B6m_=28Grubba=29?= <grubba@grubba.org>
X-From: git-owner@vger.kernel.org Sun Apr 11 00:37:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0jJA-0005oG-Hy
	for gcvg-git-2@lo.gmane.org; Sun, 11 Apr 2010 00:37:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752334Ab0DJWhd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Apr 2010 18:37:33 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46707 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751177Ab0DJWhc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Apr 2010 18:37:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3A958A97E3;
	Sat, 10 Apr 2010 18:37:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=kRNOTnm2YDZz6HwLNQI4J2nxL
	/U=; b=nHVN8+Ik29wyDpUfAGuksnau7ZRSjn5AcI5z9S0wH76rzpIwUBPr5eFam
	/ULHy4f4twXY8NHERdDNI8usI8KBF8Ut+osyx54D3bP8Yv21ISWAgMI6elMxK4xO
	UmWk0hvcyoxX5yoaIit8xvQlWVVCpuy4U1/fBiegPkRahnnV9A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=DO6pwF/R1L7Nd5wyPtV
	FbaGtmVcm+PqP4rO/SX4LeJM/5+IuUhF56uZ16OYXr8JNBmw9IZziZrNuRubXdF2
	EYB5FcaIZUUO8W0pqKLkg7VPjMamd8ld6PXTaf5W4YJiwsjjL3kzTexQ7VDKX++k
	bH7zwwwo/32E9VgKp2ldmD5A=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 13A60A97E2;
	Sat, 10 Apr 2010 18:37:30 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6CEFFA97E1; Sat, 10 Apr
 2010 18:37:27 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A5999B5E-44F1-11DF-BB0E-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144609>

"Henrik Grubbstr=C3=B6m (Grubba)"  <grubba@grubba.org> writes:

> When the conversion filter for a file is changed, files may get liste=
d
> as modified even though the user has not made any changes to them.
> This patch adds a configuration option 'core.refilterOnDiff', which
> performs an extra renormalization pass to filter out such files.
>
> Signed-off-by: Henrik Grubbstr=C3=B6m <grubba@grubba.org>

Does this really have to be done for every invocation of diff?

It is a problem worthy of a clean solution that changing the filtering
options makes files that are not really different (from the end user's
point of view).

But the problem feels very similar to the issue that touching the inode
information would make the cached stat information in the index invalid
and plumbing commands such as "diff-files" would report phantom changes=
=2E

And the way we solve the latter issue without undue overhead for all
command invocations is with "update-index --refresh" (either run direct=
ly
as a command inside Porcelain scripts that work with the plumbing, or
internally by calling refresh_cache() API in the C implementations of
Porcelain commands).  Hence:

	$ cat Makefile >Makefile+
        $ mv Makefile+ Makefile
        $ git diff-files --name-only
        Makefile
        $ git update-index --refresh
        $ git diff-files --name-only

once we spend cycles to revalidate the cached information in the index,
subsequent commands can trust the validity information without recomput=
ing
the phantom differences that do not exist over and over.

I wonder if we can solve this in a similar way.  Especially, because
changing filtering options like the core.crlf settings is a one-off eve=
nt
that is done even rarely than "touch Makefile", it doesn't feel right t=
o
add an extra configuration that makes people pay the penalty during
everyday use just in case such a one-off event might have happened.

> The typical reason to enable this option is when you have lots of fil=
es
> that have been affected by a configuration change (eg crlf convention
> or ident expansion), but don't want to recommit the otherwise unchang=
ed
> files just to get them on canonic form in the repository.

Of course you do not want to re-commit.  If however these files that ar=
e
unchanged from the end-user's point of view can be re-checked out safel=
y,
then that would be similar to what "update-index --refresh" does for pa=
ths
that are stat-dirty.

        =20
