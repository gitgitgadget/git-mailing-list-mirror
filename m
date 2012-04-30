From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] create_ref_entry(): move check_refname_format() call to
 callers
Date: Mon, 30 Apr 2012 10:14:41 -0700
Message-ID: <7vd36pgn0e.fsf@alter.siamese.dyndns.org>
References: <1335680288-5128-1-git-send-email-mhagger@alum.mit.edu>
 <20120429115831.GC24254@sigill.intra.peff.net>
 <4F9EBB6D.3090900@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Apr 30 19:14:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOuBV-0006eb-RI
	for gcvg-git-2@plane.gmane.org; Mon, 30 Apr 2012 19:14:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755564Ab2D3ROp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Apr 2012 13:14:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52534 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753988Ab2D3ROo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2012 13:14:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A08C871F8;
	Mon, 30 Apr 2012 13:14:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=amMTByZqrRLwsnGpwH2NHVbasJM=; b=GNSkrS
	PrOMqalwnPBsiADEYSRuT+gvhzK3ninSHEqDYn06wT1ctyhltuSLWYpQMfkBDQq8
	IA5a63d1xlz7QpJDwl6Aq5eobV020q7pDpFbUQ33WztK6/gy0hYb83hV/TpT90IO
	Ppc72G7O2tkRq6wV7k2IqFwJWulQMYqbrGFaE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XqWMgxddF8i9IxxRAkJzU5frrbEIbFMT
	H97jwUVoqS07lVe6zgwahSkLAn0irm0wuCCuUwbAd2RNeIhpryHiR/V50VrAe5Rz
	Tl07bHgl6qdR97qDhC0L3Tye7oSpcadHBoCxJ4wtEhjjYcwFsIPV3FpdbChRUBcl
	TU5OAcQgN5c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 95B0871F7;
	Mon, 30 Apr 2012 13:14:43 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0C0AC71F5; Mon, 30 Apr 2012
 13:14:42 -0400 (EDT)
In-Reply-To: <4F9EBB6D.3090900@alum.mit.edu> (Michael Haggerty's message of
 "Mon, 30 Apr 2012 18:18:53 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FA336442-92E7-11E1-A74D-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196579>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> There are not two but three classes of refnames:
>
> 1. Fully legal refnames (according to the rules of check-ref-format).
>
> 2. Refnames that might cause parsing trouble in some circumstances but
> could otherwise be tolerated (with a warning) in the hope that the
> user can delete them before they cause further confusion.  These
> include all illegal refnames that aren't covered by (3).
>
> 3. Refnames that are so pathological that we don't want to let them
> into our code at all, under any circumstances.  This category, I
> think, includes refnames that include "/../" (because they could cause
> our code to walk up the filesystem) or LF (because if written to a
> packed-refs file they would make it unreadable) and perhaps "//"
> (because they would confuse the loose reference code and the
> hierarchical reference cache code).  And depending on how much you
> trust shell scripts to do quoting correctly, other patterns might also
> be risky.

I can buy that we would want to reject /../ or // from the command line
even when we are not creating such a ref (e.g. "git symbolic-ref HEAD
refs/heads/../heads/foo"). Note that even though we won't read any loose
ref of that form from the repository ever (unless your recent ref API
updates broke it ;-), we _could_ see them in .git/packed-refs if the user
manually edited the file. In such a case, I would say that recovering from
such a corruption is totally up to the user, just like it is up to you
after you edit the bits on the disk platter to confuse the filesystem
code.

But if we were to do so, class (3) needs to be tightly controlled. For
example, a ref "refs/heads/m${LF}aster", e.g.

    $ git update-ref 'refs/heads/m
    aster' HEAD

may have been usable with an ancient git, and as long as the you never
packed your refs, you should be able to see it with 'git branch', and you
should be able to fix it with 'git branch master "m${LF}aster"'.

> I would like to be able to distinguish between (2) and (3) before
> deciding what to do in any specific cases.  References in category (2)
> can probably be accepted (with a warning) in old data but we should
> not allow the user to create new ones.

There is no probably about it.  We should warn and accept---anything else
is a regression---and refuse to create.

> References in category (3) are
> more critical; I see three options for dealing with them: die(), emit
> a warning then drop them on the floor, or emit a warning but handle
> them somehow (for example, by URL-encoding them).

As long as class (3) is tightly controlled, die() until the corruption is
sorted out (if it is coming to us by reading from existing data) would be
the best option to avoid spreading the breakage further.

> Treating category (3) the same as category (2) was more or less the
> status quo before the changes, but I think it is dangerous, especially
> when dealing with references that might come from remote sources (do
> you disagree?).

I actually do. You say "parsing trouble" in (2), but what are the examples
of "parsing trouble" you have in mind?  "refs/heads/a..b" is an illegal
name per check-ref-format and is (and should be) in class (2), but as long
as we do not create such a ref, if we happen to be able to read it (maybe
"git rev-parse HEAD >.git/refs/heads/a..b" dropped it there), the user
should be able to see it with "git branch", and should be able to recover
with "git branch -m a..b a-dot-dot-b". Until the user does so, we cannot
sensibly respond to "git log a..b" (which is the "parsing trouble" you are
referring to, I think), of course, but that is to be expected.

What kind of "danger" do you have in mind?

> Regarding create_ref_entry(), there are three callers:
>
> * read_packed_refs(): Only used to read references from local
>   packed-refs files.  Seems uncritical in terms of security, so for now
>   I suppose we could change this caller to emit a warning but use the
>   reference anyway.

There is no _could_.  This must show it with a warning and let the caller
use its value.

> * get_ref_dir(): Only used to read loose references from the local
>   filesystem.

Likewise.

> * add_packed_ref(): Used by write_remote_refs() to insert references
>   from a cloned repository into the local packed-refs file.

The caller should be checking the names and rejecting the attempt to
create a ref with a bogus name.

I think create_ref_entry(), if the reader does not pay much attention to
the "_entry" part of its name, gives a false impression that this is about
"creating a ref", but it isn't.  It is actually about keeping an in-core
image of the outside world, and the one that affects the outside world
(either loose or packed refs) should be making sure the names are safe
ones to use.

Thanks for a good summary.
