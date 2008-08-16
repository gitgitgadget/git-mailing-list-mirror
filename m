From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Plumbing-only support for storing object metadata
Date: Sat, 16 Aug 2008 02:55:51 -0700
Message-ID: <7vd4k9e120.fsf@gitster.siamese.dyndns.org>
References: <20080810145019.GC3955@efreet.light.src>
 <20080809210733.GA6637@oh.minilop.net>
 <d411cc4a0808091449n7e0c9b7et7980cf668106aead@mail.gmail.com>
 <20080810035101.GA22664@spearce.org> <20080810112038.GB30892@cuci.nl>
 <20080809210733.GA6637@oh.minilop.net>
 <d411cc4a0808091449n7e0c9b7et7980cf668106aead@mail.gmail.com>
 <20080810035101.GA22664@spearce.org> <20080809210733.GA6637@oh.minilop.net>
 <20080810110925.GB3955@efreet.light.src>
 <20080816062130.GA4554@oh.minilop.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jamey Sharp <jamey@minilop.net>, Jan Hudec <bulb@ucw.cz>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Stephen R. van den Berg" <srb@cuci.nl>, david@lang.hm,
	Scott Chacon <schacon@gmail.com>, git@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
X-From: git-owner@vger.kernel.org Sat Aug 16 11:58:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUIY8-0005re-5g
	for gcvg-git-2@gmane.org; Sat, 16 Aug 2008 11:58:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752153AbYHPJ4H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Aug 2008 05:56:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752125AbYHPJ4H
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Aug 2008 05:56:07 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:36781 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751864AbYHPJ4E (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Aug 2008 05:56:04 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 1D77D5B42A;
	Sat, 16 Aug 2008 05:56:03 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 490FB5B428; Sat, 16 Aug 2008 05:55:53 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 89622788-6B79-11DD-A213-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92540>

Josh Triplett <josh@freedesktop.org>, Jamey Sharp <jamey@minilop.net>
writes:

> This hook would need to provide a way to process these updates before
> the blob or tree contents get put into place.  For example, if you check
> out /etc/shadow, you need to apply the non-world-readable permissions
> *before* you write out the contents.

I think such atomicity or "checkout race problem" is irrelevant.

I'd like to make a comment on this point, even though at the moment
(especially before the real release), I am not very interested in where
this "proposal" is going.

You mention that you would resolve attribute conflicts just the same way
you would resolve contents conflicts, which in turn means that you would
check out a half-merged state with conflict markers to the working tree,
fix up the filesystem entity (both contents and presumably its attributes
like perm bits, ownership, xa and whatnot), and mark the path resolved.
Even without talking about attributes conflicts, what's your position on
the time-window during which the contents of /etc/shadow and /etc/password
have conflict markers in them?

Luckily, the markers do not have sufficient number of colons, and that
would protect your system from attempts to break into it with a phoney
username '=======' with an empty password ;-), but I think you get the
idea.  Anything that has to be in some consistent state that cannot see
conflicted state in the middle should not be merged in-place [*1*], [*2*].

So please simplify your requirements and at least drop atomicity argument.

I am _not_ fundamentally opposed to somebody who wants to use git or any
other SCM as a cooler representation of snapshots than a sequence of
tarballs.  I however would be unhappy if your design and implementation
becomes more complicated than otherwise only because you try to deal with
the atomicity issue.  IOW, if your solution would become much simpler once
you pare down the atomicity requirement, then I'd reject the more complex
variant with atomicity in any second, even though I might still find the
simpler variant that does not care about atomicity worth considering.


[Footnotes]

*1* That is why people often frown upon "using SCM to track changes of a
live system in-place", and suggest tracking source material in SCM, and
build material to deploy from the source and install into the final
destination (not limited to /etc but more often so for e.g. web server
assets) as a better practice.

*2* Also you should realize your "/etc/shadow must be non-world-readable
from the beginning" is a very application specific wish.  What if the
attribute you are trying to enforce is "this path must always be
world-readable"?  Are you going to limit this "attribute enhancements" to
what you can specify at creat(2) time only?  How would you handle "this
path must be owned by user 'www-data' (assuming root drives git)", which
would be done by creat(2) followed by chown(2)?
