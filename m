From: Junio C Hamano <gitster@pobox.com>
Subject: Re: recognize loose local objects during repack
Date: Mon, 10 Nov 2008 13:03:10 -0800
Message-ID: <7vtzaf47ld.fsf@gitster.siamese.dyndns.org>
References: <7v8wrwidi3.fsf@gitster.siamese.dyndns.org>
 <2390436.1226296705080.JavaMail.teamon@b307.teamon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, spearce@spearce.org, nico@cam.org, ae@op5.se
To: drafnel@gmail.com
X-From: git-owner@vger.kernel.org Mon Nov 10 22:06:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kzdwr-00047S-Oh
	for gcvg-git-2@gmane.org; Mon, 10 Nov 2008 22:05:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752601AbYKJVEF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2008 16:04:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753054AbYKJVEE
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 16:04:04 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:61109 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752323AbYKJVED (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2008 16:04:03 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id DB055953E4;
	Mon, 10 Nov 2008 16:03:56 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id AAEA8953CC; Mon,
 10 Nov 2008 16:03:12 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 16BD1040-AF6B-11DD-B519-4F5276724C3F-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100574>

drafnel@gmail.com writes:

> This was developed on top of the previous repack/pack-objects series.

Thanks.  Looked alright from a cursory reading.

By the way, I've been meaning to suggest that we should straighten out the
semantics of "unpacked" vs "incremental".

What the latter means is quite clear.  We are creating a new packfile to
bundle loose ones into one, and after the new packfile is installed we can
remove the loose objects.

But what --unpacked means often confuses people, primarily because it is a
performance heuristics that makes certain assumptions on how the objects
are packed.

Namely, "unpacked" is about discovery process of objects to be packed.
Without the option, we enumerate all objects that are reachable from the
commits in the given range, excluding the trees and blobs that should
exist in commits that are excluded (e.g, if you say "--objects A..B", we
exclude trees and blobs referenced by commit A).

With the option, we also omit commits that are packed.  What's funny is
that their trees and blobs are omitted, even if they are loose ;-)

This is typically not an issue, because you do not say "pack only this
commit object, without its trees or blobs" when repacking, and because you
must have all the trees and blobs necessary for a commit available when
you pack a commit; for these reasons, the trees and blobs are typically
packed together with the commit.  It is not an issue that the rev-list
with --unpacked option does not list loose trees and blobs that belong to
a packed commit for this reason.

You could however arrange so that a commit itself is packed but some of
the tree and blob objects it refers to are loose, in which case these
loose objects may not ever get repacked incrementally.

In an empty directory, try this:

        git init &&
        echo 0 >file && git add file && git commit -m initial &&

        P=$(git rev-list HEAD | git pack-objects pack) &&
        mv pack-$P.* .git/objects/pack/ &&
        git prune && git count-objects -v

        git repack && git count-objects -v

It packs only the commit object (and prunes it), leaving a tree and a blob
loose.  The repack won't find anything to pack.

This is not so bad in the sense that it will never corrupt your
repository, but it is confusing.  Admittedly, not peeking into a commit
that is packed is a reasonable good heuristics for performance reasons.

Interestingly enough, the object listing machinery do traverse into
parents of packed commits when --unpacked is given.  So if you pack a
commit and arrange to keep its parents unpacked, they are subject to the
incremental repacking.  In other words, the performance heuristics may not
be buying us very much --- we are traversing the history down to the root
commits regardless.
