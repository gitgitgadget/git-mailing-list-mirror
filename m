From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] grep: stop looking at random places for
 .gitattributes
Date: Wed, 10 Oct 2012 12:44:46 -0700
Message-ID: <7vy5jeaz81.fsf@alter.siamese.dyndns.org>
References: <7vk3uzfp3p.fsf@alter.siamese.dyndns.org>
 <1349868894-3579-1-git-send-email-pclouds@gmail.com>
 <1349868894-3579-4-git-send-email-pclouds@gmail.com>
 <5075615B.8020702@viscovery.net>
 <CACsJy8BG0HJNePG-j27SrfEenEkZ5a5nCdMEuDGn=qXxq=VzhA@mail.gmail.com>
 <50756646.5060505@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Oct 10 21:45:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TM2DF-00011Y-9c
	for gcvg-git-2@plane.gmane.org; Wed, 10 Oct 2012 21:45:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756847Ab2JJTov (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2012 15:44:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52850 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756605Ab2JJTou (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2012 15:44:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6B332886F;
	Wed, 10 Oct 2012 15:44:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mwo66vGPLOdcO3pgu6gyp+XRhAM=; b=InVnkt
	5HoA/K6JGcBfXR/09od1Vbc5YHfCIlPuxFWA3j0/NUY5Y9+qM/r/jH497K/tjYxL
	6/82x8QljzjQH1GJsDytGRZWXeCWN84fUM7ISSD4A57xD5K6INYXOUZ0VcJtW1CF
	/YXAOexHaUZ2MlzWmC/3sb0d5rZFgwsfIRdeY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IrKAzzDrezkXHzoibcBMYD3ibesTdE8J
	C5csZAOuAX/EKgc45WCYfc98d55lTrpyWjr3EFZom7Dq6aM0RFH8Qyp0GWDZTowC
	FBvzAfLiSrNRrqLLWdY41gYkJM/FCvP/VkIPc4ndzp9O81y74+qIPdXaA4dzoKeb
	7EarnTNMwZc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 58410886E;
	Wed, 10 Oct 2012 15:44:49 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 80489886D; Wed, 10 Oct 2012
 15:44:48 -0400 (EDT)
In-Reply-To: <50756646.5060505@viscovery.net> (Johannes Sixt's message of
 "Wed, 10 Oct 2012 14:12:54 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F336E4EC-1312-11E2-ADBF-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207433>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Is there already an established definition which the "correct"
> .gitattributes are? IIRC, everywhere else we are looking at the
> .gitattributes in the worktree, regardless of whether the object at the
> path in question is in the worktree, the index, or in an old commit.

No, and it is deliberately kept vague while waiting for us to come
up with a clear definition of what is "correct".

We could declare, from a purist's point of view, that the attribute
should be taken from the same place as the path in question is taken
from.  When running "git add foo.c", we grab the contents of "foo.c"
from the working tree, so ".gitignore" from the working tree should
be applied when dealing with "foo.c".  Similarly, the contents of
blob "foo.c" that "git checkout foo.c" reads from the index would
get attributes from ".gitignore" in the index (to find what its
smudging semantics is) before it gets written out to the working
tree.  "git diff A B" may give the attributes from tree A to the
preimage side while using the attributes from tree B to the
postimage side.

But the last example has some practical issues.  Very often, people
retroactively define attributes to correct earlier mistakes.  If an
older tree A forgot to declare that a path mybank.gnucash is a
GnuCash ledger file, while a newer tree B (and the current checkout
that is even newer) does [*1*], it is more useful to apply the newer
definition from .gitattributes to both trees in practice (and in
practice, you are much less likely to have a check-out of ancient
tree while running "git diff A B" to compare two trees that are
newer than the current check-out).  Using the file from the working
tree is the best approximation of "we want to use the newer one",
both from the semantics (i.e. you are likely to have fresher tree
checked out) and the performance (i.e. reading from files in the
working tree is far more trivial than reading from historical trees)
point of view.

So it is not so cut-and-dried that "take the attributes from the
same place" is a good and "correct" definition [*2*].


[Footnote]

*1* GnuCash writes, by default, a gzip compressed xml file, so I
have in my .gitattributes file

	*.gnucash	filter=gnucash

and then in my .git/config

	[filter "gnucash"]
        	clean = gzip -dc
                smudge = gzip -c

This allows "git diff" to work reasonably well (if you do not mind
reading diff between two versions of xml files, that is) and also
helps delta compression when packing the repository.


*2* Besides, the attributes are primarily used to define the
semantics about the contents in question.  If one file is of
"gnucash" kind (i.e. has "filter=gnucash" attribute in the previous
example) in one tree, and the path is of a different kind
(e.g. "filter=ooo" that says "this is an Ooo file"), it is very
likely that it does not even make sense, with or without content
filtering, to compare them with "git diff", so "take the attributes
from the same place" would have to imply "if the attributes do not
match, say something similar to 'Binary files differ'", which is
just as useless as applying one attribute taken from a convenient
but random place (i.e. the working tree).
