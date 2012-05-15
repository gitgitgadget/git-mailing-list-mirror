From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fetch/push: allow refs/*:refs/*
Date: Tue, 15 May 2012 08:19:01 -0700
Message-ID: <7vpqa5fp5m.fsf@alter.siamese.dyndns.org>
References: <7vsjfj7des.fsf@alter.siamese.dyndns.org>
 <7vwr4r8tpm.fsf@alter.siamese.dyndns.org> <4FA4C2CC.7080205@alum.mit.edu>
 <7vobq06jt7.fsf@alter.siamese.dyndns.org> <4FB218AA.2060006@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue May 15 17:19:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SUJWv-0006Rw-Hz
	for gcvg-git-2@plane.gmane.org; Tue, 15 May 2012 17:19:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965032Ab2EOPTM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 May 2012 11:19:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39061 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964804Ab2EOPTL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 May 2012 11:19:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 96AE86BFF;
	Tue, 15 May 2012 11:19:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AexcIAR+BlbrUjJFYUJirgSjn7Y=; b=OBhmbs
	N5ktOdd4MjHe/DoWWaLDmgf2PZ2fsvadPuXWkasyro6p+JHyArM+scLMeKa/Llmo
	mShPi/wjSY7ZW9Q8kJmUeDr/i8eNlPh280FtPb6cMTwmxQQfl5GWIwkVLBnJ3z8X
	wmp/bG9oexS5Ehv5vIC66526jbOFyRnY07KWQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uVUrWYYGQsy0qyboignVl8LpLL6m4Iq9
	Xa1y3tero5J8AjRoJRctFoVofIGJ7xr7MwCQvosrpJukSaA+HQq/JovGCboGeIdI
	YBKOLOn/T2DnMlmMO5Miiv9zZtKqYAfgrp6svstMYtjp7zTqolSqspZTQxmwkuDx
	Mktyo/K7iuc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8D6DC6BFE;
	Tue, 15 May 2012 11:19:10 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BC1626BF9; Tue, 15 May 2012
 11:19:08 -0400 (EDT)
In-Reply-To: <4FB218AA.2060006@alum.mit.edu> (Michael Haggerty's message of
 "Tue, 15 May 2012 10:49:46 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 51464FBE-9EA1-11E1-B590-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197836>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> * Full refnames like "refs/foo" or "refs/bar/baz" (starting with "refs/").

When reading any of these out of existing set of ref candidates (i.e. read
from readdir() recursing down from ".git/refs"), we shouldn't be rejecting
with format checks, but we may want to warn.

When creating, we have full refnames in this case, so we can just check.

> * Top-level special ALL_CAPS reference names like "MERGE_HEAD".

Similar.  These are "full refname" as far as ref format checking code is
concerned, and the format logic allows only ALL_CAPS at the top-level.
When reading any single-level out of existing set of ref candidates
(i.e. read from readdir() scanning ".git/"), malformed candidates should
be ignored without even warning (otherwise you will incorrectly complain
upon seeing ".git/config").  When creating, we have full refnames in this
case, so we can just check.

> * Refspec-style patterns with wildcards, like "refs/heads/*" or
> "refs/foo/*/bar".

As I said in the message you are replying to, the format check for these
should be a separate function (which might happen to share some code with
ref, but that is an implementation detail).

> * Short branch names with an implied "refs/heads/" prefix omitted;
> e.g., "master" meaning "refs/heads/master".
>
> * Short tag names with an implied "refs/tags/" prefix omitted; e.g.,
> "v1.2.3" meaning "refs/tags/v1.2.3".

Checking for the above two classes should conceptually happen with the
implied prefix.  When creating (i.e. git branch/git checkout -b/git tag),
you know what full refname the thing will become if you allow it to be
created.

As an optimization measure at the implementation level, being able to
check "frotz", knowing that the calling code wants to know that the name
is usable as a branch name, without having to do an allocation to hold
"refs/heads/frotz" somewhere to call the format-check function, options
like allow-onelevel is sometimes useful, but at the conceptual level it is
not strictly necessary.

> Currently, I believe that code usually handles the short branch/tag
> names via one of two mechanisms:
>
> * Explicitly prepend "refs/heads/" or "refs/tags/" to the short name
> to make the corresponding full name, then work exclusively with the
> full name.

Conceptually everybody should be doing that.

> * Use the ref_rev_parse_rules based functions like dwim_ref() to guess
> which prefix can be applied to a short refname to make it into a full
> refname, then work exclusively with the full name.

That is merely _matching_ with existing name, no?  Once you see an
existing name, you shouldn't be _rejecting_ anything.  If you see a
questionable name, you may warn.

I am not sure if these "two mechanisms" is a proper characterization of
the problem space.  Shouldn't you be separating between reading and
creating instead?

> * Refnames either have to start with "refs/" or have to be ALL_CAPS.

Sensible.

> * Refnames cannot be directly under "refs/" but should be in a
> namespace like "refs/heads/".  (This is implied by the old
> check-ref-format documentation:

Almost, but beware of stashes.
