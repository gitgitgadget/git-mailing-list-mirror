From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] builtin/push.c: make push_default a static variable
Date: Tue, 17 Feb 2015 09:45:07 -0800
Message-ID: <xmqqsie4300s.fsf@gitster.dls.corp.google.com>
References: <20150216054550.GA24611@peff.net>
	<20150216054754.GB25088@peff.net> <20150217104628.GA25978@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Dave Olszewski <cxreg@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 17 18:45:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNmD5-0007rv-9E
	for gcvg-git-2@plane.gmane.org; Tue, 17 Feb 2015 18:45:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752076AbbBQRpL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2015 12:45:11 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62979 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751591AbbBQRpK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2015 12:45:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8F17D37728;
	Tue, 17 Feb 2015 12:45:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/IY3901CRjd/jwkukW+2JSgrM3k=; b=hnl/hK
	g3gk+OXevuhXybcqN7k6Bzm7M00uXh4CKYWlRcB8scr9Rr+ABqgeIFeAzTLUjT0O
	vmNj6Oqc6sjnnPNRvykgkcG0v/YFkB33TaaX+vEXulP+uWm/aC6C+wjoLoYO017B
	2FNtX4UkCaMUjy5eaY6QBtARX+3Q607bVhBEM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gSuGVzldVpkGNNTI+7b6cd83tus+Z/Uv
	orDWOhAr9qyIYqMsCrFTN8Byy5n461BoBi+08o3hiHV0WeQoCITTqcNvc+pnTbXn
	0Rq5DUFTFJBsz4dNfwlypSUmpDSsen4a9JTRpgPQ3EyOXa0UOFUd+xr+CJw3DOio
	axIWOBZdtzs=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7696037727;
	Tue, 17 Feb 2015 12:45:09 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C4FE137726;
	Tue, 17 Feb 2015 12:45:08 -0500 (EST)
In-Reply-To: <20150217104628.GA25978@peff.net> (Jeff King's message of "Tue,
	17 Feb 2015 05:46:28 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B7065BD2-B6CC-11E4-929C-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263970>

Jeff King <peff@peff.net> writes:

> If we wanted to implement "@{push}" (or "@{publish}") to mean "the
> tracking ref of the remote ref you would push to if you ran git-push",
> then this is a step in the wrong direction.

Is that because push_default variable needs to be looked at from
sha1_name.c when resolving "@{push}", optionally prefixed with the
name of the branch?  I wonder if that codepath should know the gory
details of which ref at the remote the branch is pushed to and which
remote-tracking ref we use in the local repository to mirror that
remote ref in the first place?

What do we do for the @{upstream} side of the things---it calls
branch_get() and when the branch structure is returned, the details
have been computed for us so get_upstream_branch() only needs to use
the information already computed.  The interesting parts of the
computation all happen inside remote.c, it seems.

So we probably would do something similar to @{push} side, which
would mean that push_default variable and the logic needs to be
visible to remote.c if we want to have the helper that is similar to
set_merge() that is used from branch_get() to support @{upstream}.

Hmmm, I have a feeling that "with default configuration, where does
'git push' send this branch to?" logic should be contained within
the source file whose name has "push" in it and exposed as a helper
function, instead of exposing just one of the lowest level knob
push_default to outside callers and have them figure things out.

Viewed from that angle, it might be the case that remote.c knows too
much about what happens during fetch and pull, but I dunno.
