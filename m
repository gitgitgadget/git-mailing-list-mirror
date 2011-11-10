From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 14/14] clone: give advice on how to resume a failed clone
Date: Thu, 10 Nov 2011 13:21:38 -0800
Message-ID: <7vvcqrsmfx.fsf@alter.siamese.dyndns.org>
References: <20111110074330.GA27925@sigill.intra.peff.net>
 <20111110075654.GN27950@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 10 22:21:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ROc4B-0002GD-Oo
	for gcvg-git-2@lo.gmane.org; Thu, 10 Nov 2011 22:21:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756603Ab1KJVVn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Nov 2011 16:21:43 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55622 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752888Ab1KJVVl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Nov 2011 16:21:41 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7A76D6E28;
	Thu, 10 Nov 2011 16:21:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=N79i5VazOBtQaR0amBWxaDZMNts=; b=ri/RVI
	HGO+xrcuiqeMGZyt0SA8ZDVoo+bfMABSv95xL12Q5Y5gTYy5ofXXR22xKDgxXuYe
	6QN4jZsk72WjZBKG1VHXjlQwN1d5BkUqSqNxUE8sCrOD/iNudEZJylYSE4YeptUV
	KDJ2UCqsYln4oCmQhHTnAVGQQ2ZyRGAyUwNIQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mhFdHa8dJljXjOekADn+wiVQ3B9t85JX
	Txg/qniGFLGioNkfxhHPiGQVatHAiuMBOzMjYV/AViqQ330jRkbCQ/sve0VjV5uh
	2o24oeD9fSQFwVpQe0cP7RwMJic51FoguJEFu5YXYVFbNbotsPc47YoqQABG6cDd
	IIsujNq0bBQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7127E6E27;
	Thu, 10 Nov 2011 16:21:40 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6522E6E26; Thu, 10 Nov 2011
 16:21:39 -0500 (EST)
In-Reply-To: <20111110075654.GN27950@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 10 Nov 2011 02:56:55 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FA644C84-0BE1-11E1-8C52-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185244>

Jeff King <peff@peff.net> writes:

> We could make "git clone ..." automatically resume, but I'm a little
> nervous about that. I wrote a patch that did so, and it did work, but
> there are a lot of little hiccups as we violate the assumption that the
> directory didn't already exist (e.g., it writes multiple fetch refspec
> lines to the config).

Sorry, but I do not think the worry is quite justified.

The "assumption that directory didn't already exist" becomes an issue only
if you implement your "git clone" that automatically resumes as a thin
wrapper around the current "git clone" in the form of

    until git clone ...
    do
	echo retrying...
    done

Stepping back a bit, I think there are two different situations where
resumable clone is beneficial. The "git clone" process died either by the
machine crashing or the user hitting a \C-c, or the connection between the
server and the "git clone" got severed for some reason.

Right now, the "got disconnected" case results in "git clone" voluntarily
dying and as the result of this, the symptom appears the same.  But it
does not have to be that way.  If we know the underlying transport is
resumable, e.g. when you are fetching a prepared bundle over the wire.

I have this suspicion that in practice the "got disconnected" case is the
majority. If "git clone" does not die upon disconnect while fetching a
bundle, but instead the fetching of the bundle is resumed internally by
reconnecting to the server and requesting a range transfer, there is no
risk of "writes multiple fetch refspec lines" etc, no?

Of course, it is _also_ beneficial if we made "git clone" resumable after
you purposefully kill it (maybe you thought it will clone within minutes,
but it turns out that it may take hours and you have to turn off the
machine in the next five minutes before leaving the work, or something).
A solution for that case _could_ be used for the "got disconnected" case
by letting it voluntarily die as we currently do, but I do not think that
is an optimal solution to the "got disconnected" case.
