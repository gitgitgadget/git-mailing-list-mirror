From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] index-pack: Create .keep files with same permissions
 and .pack/.idx
Date: Fri, 01 Apr 2011 14:39:21 -0700
Message-ID: <7v1v1lfy7q.fsf@alter.siamese.dyndns.org>
References: <201103311246.25645.johan@herland.net>
 <20110331190429.GC16981@sigill.intra.peff.net>
 <201104010329.05299.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Fri Apr 01 23:39:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5m4A-0001sA-UP
	for gcvg-git-2@lo.gmane.org; Fri, 01 Apr 2011 23:39:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757335Ab1DAVje (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2011 17:39:34 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:34766 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756799Ab1DAVjd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2011 17:39:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6D90C4292;
	Fri,  1 Apr 2011 17:41:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=R7C070UW63NlaHubR5KLCzz9Y5Y=; b=oEdyOp
	c5GeUn2wTP2yq5KTRIr7WNReFp6YyLMTQOsYRyfUaaZNMtUNJZQX83BWJcKmAspB
	ic8LWl5tLScIivsJ60i4cC0FgVkPoVVZG/tHMglp1oej3AaNeEHoxtm5zThc3CG/
	DQiuH2h1g3og03boIbrtMGLAsagQKX+gzKE8E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iNoVBtdPAdVyFpxcXniolUUx7zzWOjE4
	mo9EHC/0+QDOe9j4LXtf/BlzWRXeG8J+MIdJOtgymyoxPhM2d7XdX461kg+FelbU
	XOlsk1fJN01j+u9jf+2Kq6Cs9PmCzQUWuLbNM6fio3xbXi5rBsMu4AW6DCU8SUX5
	COLDYb90y1Y=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3BB4E428F;
	Fri,  1 Apr 2011 17:41:18 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 3644C428D; Fri,  1 Apr 2011
 17:41:13 -0400 (EDT)
In-Reply-To: <201104010329.05299.johan@herland.net> (Johan Herland's message
 of "Fri, 01 Apr 2011 03:29:05 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C6DB3578-5CA8-11E0-BFD3-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170625>

Johan Herland <johan@herland.net> writes:

> While pushing to a remote repo, Git transiently adds a .keep file for the
> pack being pushed, to protect it from a concurrent "git gc". However, the
> permissions on this .keep file are such that if a different user attempts
> a local cross-filesystem clone ("git clone --no-hardlinks") on the server
> while the .keep file is present (either because of a concurrent push, or
> because of a prior failed push that left a stale .keep file), the clone
> will fail because the second user cannot access the .keep file created by
> the first user.

While I am not sure if letting a clone proceed while there is a concurrent
push is even a good idea to begin with, I agree that a stale .keep file is
a problem.

I am kind of surprised that we are not using atexit(3) to clean them just
like we do for lockfiles; wouldn't that be a better solution?
