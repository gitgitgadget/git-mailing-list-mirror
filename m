From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 1/2] rm: don't fail when removing populated
 submodules
Date: Thu, 05 Jul 2012 23:57:32 -0700
Message-ID: <7v1ukppear.fsf@alter.siamese.dyndns.org>
References: <4FF4AAE7.40604@web.de> <4FF4AB1B.60805@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?utf-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>,
	Phil Hord <phil.hord@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Fri Jul 06 08:57:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sn2U1-00034c-GZ
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jul 2012 08:57:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932589Ab2GFG5g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jul 2012 02:57:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36699 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932144Ab2GFG5f (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2012 02:57:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D6EA928A;
	Fri,  6 Jul 2012 02:57:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=reyvK3QA8+OTxDCdTGZnpYgFJjA=; b=nDRUHl
	b0zv46XRJ0rfSAL69MTWYpKOi9hyN5Lm6+uT8KsGDEc9TfROZNzuo6zNYBt0LKDk
	lm+JB/oZRss17q4zAQgBo4uCTFwBQO+MnuSeKulqOwmQJxeZNVzKnlYn9UXKfO2T
	MCMKt/6WCvcaDUlABXPeX1RECrlG7y5ORR0/s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Y7DSuzuFxeevkxQI6tNks/TeKHgRjduj
	tu/IaNEW4yZ1xItOOAZefzFgjwhWNYRWeMbOYPoTSSMFaFivqeGKfg5U8c+5hPdX
	MEAfiexHyyTpTBbk+B8Eh0w2pE42oz1MQ2kXvbVHw/hUsCwAItqxquR2q2whnr+R
	5DUY5FCKMbk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 021E89289;
	Fri,  6 Jul 2012 02:57:35 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1EA649288; Fri,  6 Jul 2012
 02:57:34 -0400 (EDT)
In-Reply-To: <4FF4AB1B.60805@web.de> (Jens Lehmann's message of "Wed, 04 Jul
 2012 22:44:11 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DCF0613A-C737-11E1-9B56-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201086>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Currently using "git rm" on a populated submodule produces this error:
> 	fatal: git rm: '<submodule path>': Is a directory
> Using it on an unpopulated submodule removes the empty directory silently
> and removes the gitlink from the index, while it doesn't do the latter
> when the submodule is populated but errors out.
>
> While the error technically correct (the submodule directory can't be
> removed because it still contains the checked out work tree) rm could do
> better because it knows it is a submodule.

Correct in principle, but the definition of "better" could be open
to discussion.

> It should remove the gitlink
> from the index no matter if it is populated or not.

Why?  If you have a regular file that has changes with respect to
the index entry, the index version is kept as well as the working
tree version.  You can "rm --cached" to remove the index entry, and
you can "rm --force" to remove both, nuking the change you made to
the working tree, but we do not touch such a "dirty" entry without
any explicit option.

> Also not being able to
> remove a submodule directory isn't an error but should only issue a
> warning to inform the user about that fact while removing the gitlink from
> the index nonetheless.

You are repeating yourself without justification.

> Change "git rm" so it only issues a warning if a populated submodule
> cannot be removed.

I find this part iffy due to the above.  With --cached, perhaps, but
without any option, I do not think I heard a sound justification
behind this change.

> Also apply the same policy as for regular files and
> require forcing when the submodules HEAD is different than what is
> recorded in the index. 

I think the "policy" for regular files is that "git rm $path" errors
out to avoid losing information in $path.  Even if the HEAD in the
submodule points at the same commit as recorded in the index, if the
submodule directory has other changes that (cd $path && git status)
would report, we would not want to remove it, no?

I am not sure if the difference between $path/.git/HEAD and :$path
(the version in the index) matters.  Maybe it does, maybe it
doesn't.

One possible sane behaviour of "git rm $path" might be:

 - If --force is given, remove it from the index and from the
   working tree (i.e. "rm -rf $path"), but use the "gitfile"
   facility to save $path/.git away to $GIT_DIR/modules/$name; error
   out if the submodule directory $path cannot be removed like this.
   We would probably want to remove "submodule.<name>.*" entries in
   .gitmodules for <name> for which "submodule.<name>.path" matches
   the $path.

 - If --cached is given, remove it from the index if the version in
   the index match either HEAD or the $path/.git/HEAD, without
   touching the working tree.  This is consistent with what happens
   to a regular file.

 - If neither --force nor --cached is given, run an equivalent of
   (cd $path && git status), and also check if $path/.git/HEAD
   matches the index version.  Error out if the submodule directory
   is dirty (again I am not sure about this part).  If the submodule
   directory is clean, do the same as the case with --force.

> While this changes behavior of "git rm", it only fixes an error where it
> never worked properly.

It stops an error from being issued, but I am not convinced that the
new behaviour is necessarily a sensible one.  A change that stops an
error and performs a random operation is not necessarily a "fix".
