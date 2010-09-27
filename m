From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] Add --exclude-dir option to git grep
Date: Sun, 26 Sep 2010 21:53:36 -0700
Message-ID: <7vzkv33hyn.fsf@alter.siamese.dyndns.org>
References: <20100924042614.GA25944@nulllenny.dreamhost.com>
 <7v1v8iq3tu.fsf@alter.siamese.dyndns.org>
 <20100925033530.GA21483@nulllenny.dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Ripton <dripton@ripton.net>
X-From: git-owner@vger.kernel.org Mon Sep 27 06:55:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P05kk-0003Ht-5n
	for gcvg-git-2@lo.gmane.org; Mon, 27 Sep 2010 06:55:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751821Ab0I0Exo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Sep 2010 00:53:44 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:45662 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751446Ab0I0Exo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Sep 2010 00:53:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 32894D92B0;
	Mon, 27 Sep 2010 00:53:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=m9AEHt15bcBdDM8ga5TXiLVEC4A=; b=fnyehCfT4ltqjBhI5bGQGs4
	u7ZAEepMOMyhFyzWv2htj8WfsR+s1VsorUGvzFBU3866dP6hY/kMV+oKvdpYfi2h
	GUUU6fqh6p3eZVQehajpVbaVenyHGTQNQfhXgfMaqxM4hehB6UBPx4GSCUIsTGHn
	Et1KlfgwaQGWablUJIGQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=Q/vI0/PYbA5F8BhjUkYNiVjgqB48dM/5S4xJochFCiut3nowF
	FvcS/ORyKMJ9cfuLY2IZnXN5B/rmASJqf3YrAMKPyAbEtQw/aGOdM3QyT9Bp46nE
	ZDzpv/4QFIpETWJPeq/F1JMG1Rtcse+NcYD/KOZEzPXOmqdOp6dK22Hda0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B394FD92AF;
	Mon, 27 Sep 2010 00:53:40 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BADABD92AE; Mon, 27 Sep
 2010 00:53:37 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3291F07A-C9F3-11DF-A32D-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157296>

David Ripton <dripton@ripton.net> writes:

> It works much like the same option in recent versions of GNU grep.
> Any directory name which matches the option will not be searched.
>
> For example, "git grep --exclude-dir Documentation malloc"
>
> Signed-off-by: David Ripton <dripton@ripton.net>
> ---
> Version 2 of this patch, following Junio's comments:
> strdup() -> xstrdup()
> Fixed a declaration after code.
> Removed basenames from subdirs()
> Do not call subdirs() at all if exclude_dir_list is empty.
>
> Unfortunately the other suggested optimization, moving the original test for
> max_depth < 0 in accept_subdir to the top, turned out to be unsafe.  And
> simplifying subdirs() to only deal with the last subdirectory rather than the
> whole path makes it difficult to exclude a multi-part directory like
> "Documentation/technical".

Doesn't the caller have the full path, relative to the root of the working
tree, at that point?  That is what the "name" parameter given to
pathspec_matches() is, and is given to accept_subdir().

If you are in "x/y/doc" and about to visit "tech", "x/y/doc/tech" is given
to you in "name" to see if it is worth going into that hierarchy.

Why isn't it enough to check that "tech", "doc/tech", "y/doc/tech", nor
"x/y/doc/tech" appear in the list of excluded patterns?  At that point,
you know none of "x", "x/y" nor "x/y/doc" appear in the exclude list;
otherwise you wouldn't be in "x/y/doc" in the first place, no?

And the beauty of not having to check anything but directory components at
the tail end is that you do not have to reallocate the strings nor stuff
them in a list at all.

You might need to restructure the loop that walks the index which is a
flat list needs to be restructured to match hierarchical tree walking code
that lets you skip the entries with the same prefix in one go, though.
