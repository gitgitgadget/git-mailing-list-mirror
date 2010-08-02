From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 05/16] Hook up replace-object to allow bulk commit
 replacement
Date: Mon, 02 Aug 2010 12:58:23 -0700
Message-ID: <7v8w4olrc0.fsf@alter.siamese.dyndns.org>
References: <1280593105-22015-1-git-send-email-pclouds@gmail.com>
 <1280593105-22015-6-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 02 21:58:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Og19y-0005lI-22
	for gcvg-git-2@lo.gmane.org; Mon, 02 Aug 2010 21:58:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754948Ab0HBT6e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Aug 2010 15:58:34 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:35350 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754925Ab0HBT6c (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Aug 2010 15:58:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B3D01CA1B1;
	Mon,  2 Aug 2010 15:58:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NwZJ2LqoWABnhjxgA4ufJxhEJM4=; b=aGpsEc
	IwwnxGBePMA28sUH3k46+kta/vs1INsAthCodKFZa4nedZDwV9MICLOeQnwizOY8
	A2lAR1NAgGSWrsxpsJ93RAkRD5WgN86nIHzodVWWi8YR2sxDexaeCG+3E8CyOvmD
	t+NDLBRRaRC0ZPzOFFzaFFa7dbPnWi+ekcenk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=g8iZ0jdG7yxfSY33dUDroHo1OFCJKjtg
	MCr9ZDuxkoN6KAyZwYdcU2eV0Pp+mTKIGg/55fOOuRuT+pmXEKuj+lYzJVjpIzqx
	dQUGeID72KQy4O/XyDFsziJdblw78xrFvpviW+vJqsV3U+z80TUYwBwd9+xo/ylq
	oxiCAaZj0NA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9209FCA1B0;
	Mon,  2 Aug 2010 15:58:28 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AF90ACA1AC; Mon,  2 Aug
 2010 15:58:25 -0400 (EDT)
In-Reply-To: <1280593105-22015-6-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuIFRow6FpIE5n4buNYw==?= Duy"'s message of "Sat\, 31 Jul
 2010 23\:18\:14 +0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 51869A2A-9E70-11DF-8AF2-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152447>

I really do not like the use of "replace" for the purpose of narrow
clones.  While "replace" is about fixing a mistake by tweaking trees, a
desire to have a narrow clone at this moment is _not_ a mistake.  You may
want to have wider or full clone of the project tomorrow.  You may want to
push the result of committing on top of such a narrowed clone back to a
full repository.  My gut feeling is that that use of "replace" to stub out
the objects that you do not currently have would make it a nightmare when
you would want to widen (especially to widen over the wire while pushing
into a full repository on the other end), although I haven't looked at all
the patches in the series.

Can you back up a bit and give us a high-level overview of how various
operations in a narrowed clone should work, and how you achieve that
design goal?

Let's take an example of starting from git.git and narrow-clone only its
Documentation/ (as you seem to have used as a guinea-pig) subdirectory.
For the sake of simplicity, let's say the upstream project has only one
commit.

One plausible approach would be to have the commit, its top level tree
object, its Documentation/ tree object and all the blobs below that level,
while other blobs and trees that are reachable from the top level tree
object are left missing, but somehow are marked so that fsck would think
they are OK to be missing.  Your worktree would obviously be narrowed to
the same Documentation/ area, and unlike the narrow checkout codepath, you
do not widen on demand (unless you automatically fetch missing parts of
the tree, which I do not think you should do by default to help people who
work while at 30,000ft).  Instead, any operation that tries to modify
outside the "subtree" area should fail.

When you build a commit that represents a Documentation patch on top of
such a narrowed clone, because you have a full tree of Documentation/
area, you can come up with the updated tree object for that part of the
project.  If "subtree" mode (aka narrowed clone) rejects operation outside
the cloned area, your commit is guaranteed to touch only Documentation/
area and nothing outside.  You therefore should be able to compute the
tree object for the whole repository (i.e. all the other entries in the
top level tree object should be the same as those from HEAD).

Because the index is a flat structure, you would need to fudge the entries
that are missing-but-OK in there somehow, _and_ you would need to be able
to recompute the tree after updating Documentation/ area.  E.g. you may
know ppc/ is tree db31c066 but may not know that it has three blobs
underneath it nor what their object names are, so your index operating in
this mode would need to record (ppc -> db31c066) mapping in order to be
able to recreate the tree object out of it.

Using cache-tree data structure might help in doing this.  It so far has
been an optimization (i.e. when it says it has an up-to-date information,
it does, but if it doesn't you can always recompute what is needed from
the flat index entries), but I would imagine that you can add an "out of
cloned area" bit to cache-tree entries, and mark a subtree that represents
missing parts (e.g. 'ppc/') as such---anything that tries to invalidate
such a cache-tree entry would be an error anyway, and when you need to
write the index out as a tree, such cache-tree entries that record the
trees outside your cloned area can be reused, no?
