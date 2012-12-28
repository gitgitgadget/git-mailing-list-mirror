From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Lockless Refs?
Date: Fri, 28 Dec 2012 08:58:36 -0800
Message-ID: <7vlicijepv.fsf@alter.siamese.dyndns.org>
References: <20121221080449.GA21741@sigill.intra.peff.net>
 <50DAB447.8000101@alum.mit.edu> <201212271611.52203.mfick@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Martin Fick <mfick@codeaurora.org>
X-From: git-owner@vger.kernel.org Fri Dec 28 17:59:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TodH0-00057e-0w
	for gcvg-git-2@plane.gmane.org; Fri, 28 Dec 2012 17:59:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753915Ab2L1Q6n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Dec 2012 11:58:43 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37799 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753914Ab2L1Q6k (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Dec 2012 11:58:40 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5DD87AE71;
	Fri, 28 Dec 2012 11:58:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MfusVQXiuUI4xVkpVI7g7Qg3WR4=; b=CdV10P
	dCI0lkt2aLA76FDWZzrAcWI5sTmtuTfaUpbL3O5hyGFX+NbZKzLzEDQie67BPXed
	HndUi6heSc1P9U6goMdohRFoSd+1KTtOtTjPVdK3NNLwzIfyBhqDdBy8t1wwPCIP
	jAcll/DpVYzXLyczUkUq6AIsWJ+QlNaYtQjSo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tEUjYyGX6R5RNnhHhoOWRBkEe7HkZjcr
	Qgf+J9TeuFYyYoL1xo5E5Z+Nuq3toQG1ObAWCSiuBsP99v/aK2APfLcW8X0atJ3X
	L4PwKmIxZiON21gnwZEZL8E6tYEPud3iIir88G3/Rl57TdCErco9fIPxGy0008xw
	mbtA2cwyKBg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4BC60AE6F;
	Fri, 28 Dec 2012 11:58:39 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A548CAE6E; Fri, 28 Dec 2012
 11:58:38 -0500 (EST)
In-Reply-To: <201212271611.52203.mfick@codeaurora.org> (Martin Fick's message
 of "Thu, 27 Dec 2012 16:11:51 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D35B041A-510F-11E2-A70A-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212246>

Martin Fick <mfick@codeaurora.org> writes:

> 3) To create a ref, it must be renamed from the null file (sha 
> 0000...) to the new value just as if it were being updated 
> from any other value, but there is one extra condition: 
> before renaming the null file, a full directory scan must be 
> done to ensure that the null file is the only file in the 
> directory...

While you are scanning this directory to make sure it is empty, I am
contemplating to create the same ref with a different value.  You
finished checking but haven't created the null. I have also scanned,
created the null and renamed it to my value.  Now you try to create
the null, succeed, and then rename.  We won't know which of the two
non-null values are valid, but worse yet, I think one of them should
have failed in the first place.

Sounds like we would need some form of locking around here.  Is your
goal "no locks", or "less locks"?

> I don't know how this new scheme could be made to work with 
> the current scheme,...

It is much more important to know if/why yours is better than the
current scheme in the first place.  Without an analysis on how the
new scheme interacts with the packed refs and gives better
behaviour, that is kinda difficult.

I think transition plans can wait until that is done.  If it is not
even marginally better, we do not have to worry about transitioning
at all.  If it is only marginally better, the transition has to be
designed to be no impact to the existing repositories.  If it is
vastly better, we might be able to afford a flag day.
