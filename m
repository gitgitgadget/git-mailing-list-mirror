From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] tag: die when listing missing or corrupt objects
Date: Mon, 06 Feb 2012 00:36:05 -0800
Message-ID: <7vfweo8ikq.fsf@alter.siamese.dyndns.org>
References: <20120206081119.GA3939@sigill.intra.peff.net>
 <20120206081342.GB3966@sigill.intra.peff.net>
 <7vk4408ir6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tom Grennan <tmgrennan@gmail.com>, git@vger.kernel.org,
	jasampler@gmail.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 06 09:36:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuK3Z-0000tn-Vf
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 09:36:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754157Ab2BFIgJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Feb 2012 03:36:09 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61437 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750928Ab2BFIgH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Feb 2012 03:36:07 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 390645563;
	Mon,  6 Feb 2012 03:36:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PHBnd6P/PfYaGGwZizNUpt2GRDE=; b=u20maC
	R4FMg2uBI4bl5FTCURnYYCjwbGQWMaLD1MU5QSZuM5UhVYN5HmiTvOytxPVikaHx
	zLCm+tk61aXB8mWNVC/SVq+hSy5PpEoeB+V2DMSG9v80W6KiTS6pmUhp3icBobWo
	gGFFdOW0xkpCHF6eOtZ4E+TVaaAYOAnJITMoQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rcRH3q1yE5gYq56C+CVixOKUcS3iUea0
	vOCKb4GLyl4ZtVHpHKu3xZcSpKxVB+leQXFtlCHDxSu7AqhElj2DFSphp+/jbl7d
	gpIf4Rps0vF6SMSflM8xoV1b/CgEenARH1vXaLDFMgARSYi66BhE29/kTq/2p+vu
	piZt46aFhNA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2F61A5562;
	Mon,  6 Feb 2012 03:36:07 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BBEC45560; Mon,  6 Feb 2012
 03:36:06 -0500 (EST)
In-Reply-To: <7vk4408ir6.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 06 Feb 2012 00:32:13 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9CC106B6-509D-11E1-942E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190047>

Junio C Hamano <gitster@pobox.com> writes:

> Hmm, a pedant in me says a tag object cannot have zero length, so the
> second case is also an indication of a corrupt repository, unless the tag
> happens to be a lightweight one that refers directly to a blob object that
> is empty.
>
> For that matter, shouldn't we make sure that the type is OBJ_TAG? It might
> make sense to allow OBJ_COMMIT (i.e. lightweight tag to a commit) as well,
> because the definition of "first N lines" is compatible between tag and
> commit for the purpose of the -n option.

Ahh, Ok, your 3/3 addresses this exact issue.

I do not object to silently return when the object is not OBJ_TAG (even
though I slightly prefer showing the first N lines of commit log contents
for OBJ_COMMIT lightweight tag), but I still think it should be warned
just like a corruption when we see (type == OBJ_TAG && !size).
