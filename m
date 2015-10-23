From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-cherry doesn't detect a "copied" commit
Date: Fri, 23 Oct 2015 15:41:45 -0700
Message-ID: <xmqq37x1nr6e.fsf@gitster.mtv.corp.google.com>
References: <CAC9WiBhM4edBFCYx35xZJB79AZWo49mkO-Pxnb1q4aLDmBufWQ@mail.gmail.com>
	<20151023105756.GB12622@ikke.info>
	<CAC9WiBjub2oBBaM7KxcE2Jv7QgGyvmPzEBU7WcSEk5huGzx+zg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Kevin Daudt <me@ikke.info>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Francis Moreau <francis.moro@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 24 00:42:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zpl1z-00031c-KL
	for gcvg-git-2@plane.gmane.org; Sat, 24 Oct 2015 00:41:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752787AbbJWWls (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Oct 2015 18:41:48 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:50339 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752721AbbJWWlr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Oct 2015 18:41:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E195325D3F;
	Fri, 23 Oct 2015 18:41:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=IIm1Z1r4nLzLrjgOfA6mM69DTeE=; b=JgNLYZ/4r3v1A0nWkLcA
	vqK8hh8ia7/2iW3rru5sGJ4Wn583lywh9Div2caMMDHrtQT8y58/xdmerjp9Hspr
	bCNA5yAmyumBba8eZDZJ2UVtHme8Xxw+uAuDt3Luw3scSnGxqjVd+QwWxBH1Bh4A
	hA3dYBemBvKJfWSWzR764ig=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=gvRcQOm980NXKnXLH+d6WirvNueCRNI+mVcwZOuFAE6ikk
	M+sAdZdzVTSBlonxsqEaf1aJc77xT30013HTAyQf9ffpO1UaM2/yJXRvDb/sDcbG
	rl5TINhCZgiBt8iOV0Yf7N5/HpIEfrYSJn5v06uA2te5yu8GKCfkqnPxEKOiY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D568425D3E;
	Fri, 23 Oct 2015 18:41:46 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5BEAD25D3D;
	Fri, 23 Oct 2015 18:41:46 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3DA5CC36-79D7-11E5-AFE5-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280111>

Francis Moreau <francis.moro@gmail.com> writes:

> I was mislead by the git-cherry manpage somehow which says:
>
>     "git-cherry therefore
>      detects when commits have been "copied" by means of git-cherry-pick(1),
>
> which is not exactly true.

Yeah, I agree; the sentence is merely giving a description from
layperson's point of view, and it should have expressed it as such,
e.g. "roughly speaking, you can think of it like so", not sounding
as if it is giving a strictly correct and authoritative statement.

> Would it make sense to add a "--fuzz" option which would reduce the
> diff context area used to generate the hash ?

There could be situations where such fuzzing might be useful, but I
do not think this particular use case of yours is one of them.

I'd imagine that you had two branches A (with "Unkown") and B (with
"Unknown"), and wanted to apply changes in them to your integration
branch (let's call that 'master').  You ask cherry "what commits in
A are missing in my 'master'?" and apply them.  Next you ask cherry
"what commits in B are missing in my 'master' now?" and apply them.

Because "Unkown" and "Unknown" are not considered the "same" patches
(one is most likely an update to the other), you get conflict when
applying the second copy, and that is how you can notice that one of
them is a stale and buggy one.  If you haven't made your interim
integration result available to others after processing branch A,
you even have a chance to replace the "Unkown" one you already
applied with the corrected "Unknown" one before continuing.  Even if
you choose not to bother and skip the "Unknown" one from branch B,
at least you know that in the end result you have a typo that would
eventually need to be fixed from "Unkown" into "Unknown".

If you did a fuzzy version and ignored s/Unkown/Unknown/ typofix
between the "same" patches, you can avoid the conflict and all
patches from branch B may apply cleanly and automatically on top of
applying changes from branch A.  But depending on the order you
processed A and B, you have a 50% chance of keeping the buggy
version without even realizing.

So erring on the safe side and judging "Unkown" and "Unknown" are
different changes, inducing one extra conflict you had to look at,
is actively a good thing in this case.

One thing that helps to know while learning Git is that we try to
avoid being overly clever and outsmarting human users.  Instead, we
err on the safe side to avoid silently doing a wrong thing.

This is because a tool that automates 100% of cases with 2% chance
of producing wrong result cannot be trusted---you have to manually
inspect all 100% cases it automatically handled to make sure it did
the right thing.  We instead automate 98% of simple cases where it
is obvious what the right result is, and ask the human user for help
on the remaining 2%.

And this design principle is not limited to cherry.  The design of
our merge algorithms is the same way, for example.
