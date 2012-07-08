From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 1/2] rm: don't fail when removing populated
 submodules
Date: Sun, 08 Jul 2012 00:32:34 -0700
Message-ID: <7vsjd2n1wt.fsf@alter.siamese.dyndns.org>
References: <4FF4AAE7.40604@web.de> <4FF4AB1B.60805@web.de>
 <7v1ukppear.fsf@alter.siamese.dyndns.org> <4FF830D6.7080708@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?utf-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>,
	Phil Hord <phil.hord@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sun Jul 08 09:33:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Snlzd-0000Up-22
	for gcvg-git-2@plane.gmane.org; Sun, 08 Jul 2012 09:33:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751279Ab2GHHci (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jul 2012 03:32:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45376 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751245Ab2GHHch (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jul 2012 03:32:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8295F5CD2;
	Sun,  8 Jul 2012 03:32:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=khUw/I+wWIe7RW5iAMsTF80WXtA=; b=TAQ+XX
	wi4OdzQJIJr399bFsAuXqop6bN83oyx8yfRXTD9o3ucqkiDGGqfuVsyQ2fLO+sKz
	HRp0a5wXn8hAhb+pNsKE1mRz571pxXtzRcLebgCg5IoQGQYKfNC4M+Mk2kNRmd7+
	tNqsEXgN1/gX2OCBh26WnBMs8NfTsfWTlb+A8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=K0q3SEvWVt8TB9BOvHxTI903cX0w7kdN
	m2bBXLKmrpsVSM+xKHYPEWWc/X2Z+IMG/emxmzZfoKcdHORNwwN36wz7WMxAbQig
	yX1MM8OtL9X5znoMJQBt6omnksB1Ynz90uBxq8JBaJtWav3sI9PeeJGTCaOv6R+w
	IpFLQSUAyXY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6FFFF5CD1;
	Sun,  8 Jul 2012 03:32:36 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BC3235CD0; Sun,  8 Jul 2012
 03:32:35 -0400 (EDT)
In-Reply-To: <4FF830D6.7080708@web.de> (Jens Lehmann's message of "Sat, 07
 Jul 2012 14:51:34 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 166C7C8A-C8CF-11E1-A9DB-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201169>

Jens Lehmann <Jens.Lehmann@web.de> writes:

>> One possible sane behaviour of "git rm $path" might be:
>> 
>>  - If --force is given, remove it from the index and from the
>>    working tree (i.e. "rm -rf $path"), but use the "gitfile"
>>    facility to save $path/.git away to $GIT_DIR/modules/$name; error
>>    out if the submodule directory $path cannot be removed like this.
>>    We would probably want to remove "submodule.<name>.*" entries in
>>    .gitmodules for <name> for which "submodule.<name>.path" matches
>>    the $path.
>> 
>>  - If --cached is given, remove it from the index if the version in
>>    the index match either HEAD or the $path/.git/HEAD, without
>>    touching the working tree.  This is consistent with what happens
>>    to a regular file.
>> 
>>  - If neither --force nor --cached is given, run an equivalent of
>>    (cd $path && git status), and also check if $path/.git/HEAD
>>    matches the index version.  Error out if the submodule directory
>>    is dirty (again I am not sure about this part).  If the submodule
>>    directory is clean, do the same as the case with --force.
>
> What you describe here is exactly how I think "git submodule rm" and
> "git rm --recurse-submodules" should behave.

If you have a directory A with a file B in it (i.e. A/B), "git rm A"
is refused and you have to say "git rm -r A".  So I can see why the
above description of the mine is wrong with respect to "-r" option
(all cases should fail if you did not give "-r" option).

But I do not think "git rm" needs "--recurse-submodules".  Wasn't
"--recurse-submodules" the option to control, when you tell Git to
do something to submodule "A", what should happen to submodules
contained in the submodule "A" (e.g. "A/B" that appears at path "B"
that itself is a separate project bound as a submodule to "A")?

I can see what fetching or updating "A" (e.g. "git submodule
update") while leaving "A/B" intact means, so there is a reason to
have two ways (with or without --recurse-submodules) to such a
command, but I do not see any sensible definition of what it means
to "remove" (whether it is "git submodule rm" or just plain "git
rm") "A" without affecting "A/B", especially with respect to the
working tree files.  If you remove "A" and its working tree files,
is there a sensible way to keep "A/B" and its working tree files?

I am OK if you choose to implement the behaviour described above
only in "git submodule rm A" and not plain "git rm -r A", but if you
are going that route, I do not see how it is an improvement for it
to remove the index entry for A from the index if your "git rm -r A"
does not remove working tree files for submodule A.  The user asked
to remove A with a command that would remove both index entry and
working tree file for a regular file (or a directory), the command
may decide it is not prudent to do so for whatever reason.  Perhaps
the entity being asked to remove has local changes the user may
regret losing.  Perhaps we decided that such an opration to cause a
large structural change should not be done with a plain "rm" but
should be done with "git submodule rm".  The reasons do not matter
much, but for the end result to be consistent, shouldn't the command
keep the index entry intact if it does not remove the working tree?

Unless the user used "git rm --cached" to explicitly ask for the
index entry to be removed without touching the working tree files,
that is.
