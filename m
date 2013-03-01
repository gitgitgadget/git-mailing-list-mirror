From: Junio C Hamano <gitster@pobox.com>
Subject: Re: two-way merge corner case bug
Date: Fri, 01 Mar 2013 08:57:03 -0800
Message-ID: <7va9qngisg.fsf@alter.siamese.dyndns.org>
References: <7v7glun8kt.fsf@alter.siamese.dyndns.org>
 <20130226201820.GD13830@sigill.intra.peff.net>
 <7vwqtulplp.fsf@alter.siamese.dyndns.org>
 <20130301092201.GA17254@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 01 17:57:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UBTH5-00076a-E2
	for gcvg-git-2@plane.gmane.org; Fri, 01 Mar 2013 17:57:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751061Ab3CAQ5J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Mar 2013 11:57:09 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45305 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750968Ab3CAQ5I (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Mar 2013 11:57:08 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 53950BC54;
	Fri,  1 Mar 2013 11:57:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0+mOFghNhQxbrki8KhMKDWd309o=; b=iweUA9
	JunePyLnfgLf4vtcrarzZb8EG5lo6S3xXMGRo89TdiGu9tk9XgsqOIQKxwtwwD+o
	zMuhtCcZGob3Xj5xxryBEK8KTyRqNNkxEIOf24EX2y2VaWOiBZ92DlK4UF4JC6pT
	mUoqdoW/UgCwt5qzdtFo7dzInHuK+ptckiMt8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DJRzUH3QM/6S5DhqkEODc9yzj08gVLwD
	ol+MC0VYlbWTWg+xNDEzO+NUYm8ksiFHEyORZx1hQkKoEKwFkgmseW8uPlKPS51M
	+pgUE3SijeF04ZjZErK0QJPSKj1jN181YZqkZcwRuA/ZT/kX/0ts2UtzPb5M5xHx
	RbpxIez+RZA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4605CBC53;
	Fri,  1 Mar 2013 11:57:06 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A15ADBC4E; Fri,  1 Mar 2013
 11:57:05 -0500 (EST)
In-Reply-To: <20130301092201.GA17254@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 1 Mar 2013 04:22:01 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0BF00016-8291-11E2-A87B-7FA22E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217282>

Jeff King <peff@peff.net> writes:

> PS I wonder if the "initial_checkout" hack can just go away under this
>    new rule. Although we don't seem to use "o->reset" for the initial
>    checkout. Which seems kind of weird. I would think the initial
>    checkout would actually just be a oneway merge. Is the point to try
>    to leave any existing working tree contents untouched or something?

An initial checkout is *supposed* to happen in an empty working
tree, so if we code it not to overwrite an existing path in the
working tree, the user cannot lose possibly precious contents with
an mistaken initial checkout (they will instead appear as modified
relative to the index), while in the normal case we will write out
the contents from the HEAD through the index.  We could attempt "we
do not have to if the user behaves, but with this we could help
misbehaving users" if we used twoway merge for an initial checkout.

Having said that, I notice that in the normal codepath (e.g. "git
clone" without the "--no-checkout" option) we no longer use twoway
merge for the initial checkout.  Back when "git clone" was a
scripted Porcelain, I think we used to do a twoway read-tree.  It
may be that we broke it when "clone" was rewritten in C, but the
breakage is to the "we do not have to..." thing, so it may not be a
big deal.

The only case that matters in today's code is "git checkout"
(without any option or argument) immediately after "git clone -n", I
think.  The special casing for this initial checkout in twoway merge
is needed because we go from HEAD to HEAD in that case, and we do
not want to keep the artificial local removals from the index; we
start from not even having the $GIT_INDEX_FILE, so without the
special case all paths appear to have been "rm --cached", which is
usually not what the user would want to see ;-)

> ... My worry would be that somebody is
> using "--reset" but expecting the removal to be carried through
> (technically, "--reset" is documented as "-m but discard unmerged
> entries", but we are not really treating it that way here).

I've checked all in-tree uses of "read-tree --reset -u".

Nobody seems to use that combination, either from scripts or from C
(i.e. when opts.update==1 and opts.merge==1, opts.reset is not set)
with a twoway merge, other than "git am --abort/--skip".
