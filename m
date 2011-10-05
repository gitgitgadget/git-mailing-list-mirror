From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH WIP 0/3] git log --exclude
Date: Wed, 05 Oct 2011 10:20:30 -0700
Message-ID: <7vhb3n8ie9.fsf@alter.siamese.dyndns.org>
References: <1317799088-26626-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 05 19:20:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBV95-0003DV-OW
	for gcvg-git-2@lo.gmane.org; Wed, 05 Oct 2011 19:20:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935184Ab1JERUe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Oct 2011 13:20:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47363 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935137Ab1JERUd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Oct 2011 13:20:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D9FB54AB6;
	Wed,  5 Oct 2011 13:20:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=7+W1oqrlz6Ap
	WEj//y70Ua1r6+c=; b=gxqISJ0CXr0YjXMZGjPzBE8Lqqb1yJvDzKFhV5DCB6LL
	6lW08rcF8dIKPcZc1z17jpXl7S3ndMt1kPmbvkZwSHNWRORLLtcEyoAJwQ7h+FXq
	FllZhj+6+NqfMzp2AP1PA4nx45e8+E/m5zl7PtNMt1X4Q/sHqxPpo5i/9eYyx+Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=QAk0FI
	PpD2rN3J3y37LTgGZDCUCg3XdyE3kAl4BYLk0puOMfRuOUUlCZlO/etaQ48lJwXJ
	DgxLSrOto1ohXwt1rq/iYbn7MdIFHiKcPFK8foEGN7wM8BcXRfqqjEfIpIzKzFb5
	veUQGUPpXDXZsCo7XjxqKglmZQFEVrY0GpQXY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D1A514AB5;
	Wed,  5 Oct 2011 13:20:32 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3B6364AB4; Wed,  5 Oct 2011
 13:20:32 -0400 (EDT)
In-Reply-To: <1317799088-26626-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Wed, 5 Oct
 2011 18:18:05 +1100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 546A37BC-EF76-11E0-A9AC-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182864>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> This series adds --exclude that uses .gitignore mechanism remove
> commits whose changes that are _entirely_ excluded.

I really do not want to see the exclude patterns nor mechanism used for
this. This will unnecessarily impact the long term design of narrow clo=
nes
I had in mind.

The way I envisioned the narrow cloning would work like this [*1*]:

 * The narrowed set of paths is an attribute of the local repository. I=
t
   is not tied to the history nor the current working tree state, so th=
e
   information does not live in the index or in the history. A new file
   $GIT_DIR/narrowed-paths specifies a list of pathspecs. We call a
   repository with such a file "a narrowed repository".

 * The objects that live in a narrowed repository are subset of the
   objects in an unnarrowed repository that records the same
   history. Objects are not modified in any way when transferring into
   a narrowed repository. E.g. if you clone git.git but limit the tree =
to
   Documentation/ and builtin/, you will get _all_ commit objects, even
   the ones that do _not_ touch these two directories, and the top leve=
l
   tree objects. These top level tree objects _do_ record the object na=
mes
   for paths outside the narrowed area. To facilitate local history
   traversal, we may add either grafts or replace entries to "gather" a=
way
   commits that do not touch the narrowed area, but this is not essenti=
al.

 * "struct pathspec" gains a handful of new fields to carry the set of
   narrowing pathspecs taken from $GIT_DIR/narrowed-paths file down the
   callchain. When we decide to see if a given path matches the pathspe=
c
   and/or is worth descending into, we use these pathspecs to reject
   anything that is outside of the narrowed area before applying user
   supplied pathspec. We use narrowing pathspecs even for the whole tre=
e
   operation.

 * "fsck", "prune" and friends that do not use user-supplied pathspec w=
ill
   learn the narrowed-paths so that the tree entries that describe obje=
cts
   outside the narrowed area (e.g. "Makefile" in the top-level tree in =
a
   repository narrowed to "Documentation/" and "builtin/") are ignored.

   I looked at fsck and unpack-objects (surprise, but it does seem to n=
eed
   some work) a few months ago for this exact purpose, and it appeared
   doable.

We may want to be able to say something like "I want Documentation/ but
not Documentaion/howto/", and for that to work, narrowed-paths needs to=
 be
able to express negative matches. And in _that_ context, we will need
negative pathspec matches (and I think during the last round of pathspe=
c
updates we identified where the support for ":(no):pathspec" needs to b=
e
added in the codepath).=20

You could say "Use pathspec for inclusion and ignore patterns for
exclusion", but I do not think that inconsistency has merits.

=46or the purpose of "log --exclude" [*2*], I do not mind too much if t=
he UI
expressed negative pathspecs using such a new command line option, but =
I
think it would be more natural to say (notations aside):

	$ git log -- ':(no):po' .

and define the behaviour of user-supplied pathspec limiter this way:

 * Paths are matched from left to right;

 * First match determines the fate of the path;

 * A match with negative pathspec means "the path in question does _not=
_
   match".


[Footnote]

*1* Unlike the "This is _one_ possible way" I usually give in discussio=
ns,
this is "The narrow clone _must_ work like this, if we were to add it".

*2* I would suggest not using --exclude to avoid giving users a wrong
impression that this might have something to do with exclude patterns. =
How
about calling it "--filter-out" instead?
