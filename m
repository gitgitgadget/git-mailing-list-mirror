From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fix segfault with git log -c --follow
Date: Tue, 28 May 2013 16:24:55 -0700
Message-ID: <7vr4gqwuuw.fsf@alter.siamese.dyndns.org>
References: <20130527224957.GA7492@ecki>
	<7vk3mj10l2.fsf@alter.siamese.dyndns.org> <20130528225453.GA9820@ecki>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Wed May 29 01:25:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhTGJ-0005Ue-0W
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 01:25:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759260Ab3E1XY7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 May 2013 19:24:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58850 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759227Ab3E1XY6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 May 2013 19:24:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 82815238F8;
	Tue, 28 May 2013 23:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3gkxICUS/ZQjfTvZBYYT83IdudU=; b=yShqlW
	HfgfgIpQGb6KS7x442yBN8f9wpO5AKRg8iWpoIztFg2rdXtDJJ17lIAZptugOgtq
	SZlwLh/Ju3jbT0Vnvzncl/Py6AFqYnO1ehM+/RM5wmJpw+skTsUKdu9qswO6AMhx
	004+6HvKP93iRrJ7JDi9B6pnEKISvvfF9xw/M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rryYm9/vh727Qk0SwQdbk9N6ml6WgqHY
	spF91K8puWEEAlzZNxGPzQNxYVmbqtbMXbGgKToBvD0WQnKfizLDv7cfePcVMDAN
	CEO20vdDP6oOJKnrYuxoggjmGlLen+s25871Zdfzac9Rf37B4hH/r9QSjlIcI69f
	5F8F5KN3Yww=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 77D1C238F4;
	Tue, 28 May 2013 23:24:57 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CA445238F1;
	Tue, 28 May 2013 23:24:56 +0000 (UTC)
In-Reply-To: <20130528225453.GA9820@ecki> (Clemens Buchacher's message of
	"Wed, 29 May 2013 00:54:54 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CEFD03C8-C7ED-11E2-AAD7-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225697>

Clemens Buchacher <drizzd@aon.at> writes:

>> I wonder, just like we force recursive and disable external on the
>> copy before we use it to call diff_tree_sha1(), if we should disable
>> follow-renames on it.  "--follow" is an option that is given to the
>> history traversal part and it should not play any role in getting the
>> pairwise diff with all parents diff_tree_combined() does.
>
> Can't parse that last sentence.
>
> In any case, I don't think disabling diff_tree_sha1 is a solution. The
> bug is in diff_tree_sha1 and its subfunctions, because they manipulate a
> data structures such that it becomes corrupt. And they do so in an
> obfuscated and clearly unintentional manner. So we should not blame the
> user for calling diff_tree_sha1 in such a way that it causes corruption.
>
>> Besides,
>> 
>>  - "--follow" hack lets us keep track of only one path; and
>
> Ok. Good to know it is considered a hack. The code is quite strange
> indeed.

The problem with --follow is that it only tracks one path globally.
In a history like this, suppose that a path X long time ago was
renamed to Y at commit B:

    ---o---A---B---C---o HEAD

and you start digging with "log --follow -c HEAD -- Y".  When
looking at C, because it and its parent B both have path Y, the
try-to-follow hack does not kick in, and when trying to show C, we
will show the change in Y (because that is the pathspec).

Then we look at B.  Because B has path we are following, i.e. Y, and
its parent A does not, try-to-follow hack kicks in, and it mangles
the pathspec that is used globally for history traversal to X while
showing the difference between A's X and B's Y.  Then we dig further
to find A; at this point the global pathspec is swapped and now it
is X.

That makes --follow a working hack for a simplest single strand of
pearls.  But if you have a mergy history, e.g.

    ---o---A---------------B---C---o HEAD
            \                 /
             D---E---F---G---H

it can break in interesting ways.  We are likely to have looked at H
before looking at B and used pathspec Y while inspecting H, but
after looking at B, the global pathspec is swapped to X, and then we
try to look at G, F, E and D, none of which may have renamed the
original X, so you would likely miss the change to the path Y you
wanted to follow.

To fix this, we would need to keep "what path are we following" not
in the global revs->pathspec, but per the traversal paths that are
currently active (e.g. when we look at C and H, it is Y, when we
look at B, it is X, when we look at G, that is inherited from H and
still Y, not affected by the rename at B.  And then when we look at
A (we need topo-order traversal to do this), it needs to notice that
one child (i.e. B) has been following X while the other (i.e. D) Y,
and merge the "I've been following this path" information in a
sensible way (e.g. look at its own tree and see what is available,
in this case X).
