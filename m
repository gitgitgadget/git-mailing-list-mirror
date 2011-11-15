From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix "is_refname_available(): query only
 possibly-conflicting references"
Date: Tue, 15 Nov 2011 11:19:53 -0800
Message-ID: <7vd3cturae.fsf@alter.siamese.dyndns.org>
References: <1319804921-17545-27-git-send-email-mhagger@alum.mit.edu>
 <1321336525-19374-1-git-send-email-mhagger@alum.mit.edu>
 <7vty65x2zl.fsf@alter.siamese.dyndns.org> <4EC29120.2020400@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Nov 15 20:20:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQOY6-0001Vu-M0
	for gcvg-git-2@lo.gmane.org; Tue, 15 Nov 2011 20:20:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757254Ab1KOTT4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Nov 2011 14:19:56 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60516 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757251Ab1KOTTz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2011 14:19:55 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 68CFA5032;
	Tue, 15 Nov 2011 14:19:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=g9lQPIGtImwrzX+YHWt6Yt1qr9g=; b=rnii4dSVumsajasmBw1j
	9kZOIIdsAg3iPw026YAkPvqBIj07kdIssjSkLm0W/86LeaQ7jsx+RBZVjh69tPCT
	F/m1R1efLkliAfYM8IakRorYV2iK6UUDk5P85vZqg4YdG/7OfjKjvUeFV5Mb6tSq
	k89HzL6cwLNrLJdJP2SBIK8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=vnfM8a18v1NV/FqERIae62ogg2FBdnfQgl7sMhY93VMnWH
	QOm4tk7C8bjEQ3t+L5/W0NQ/OH+cA7XYibDgBepfivSYBN+DcEm6DTV/EEKNqGW4
	UVf5FUkiwawXJPrEJvaQjxyyG0iS0tt7FXPSgaaWoMi5O3L/0ECZQh0kGXXyQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5F3665031;
	Tue, 15 Nov 2011 14:19:55 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DB09F502F; Tue, 15 Nov 2011
 14:19:54 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CCA41960-0FBE-11E1-927A-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185483>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> If you have a preference for which patch series you would like to
> integrate in which order (and especially if you think that there are
> gaps that need to be filled), please let me know.  It would be a lot
> less work to put them in the right order from the start rather than
> trying to keep them all synchronized with master and continually reroll
> them based on what you have merged so far.

I've re-read mh/ref-api-[23] a few times myself during this feature-freeze
period and found that the checks they enforce seemed to be sensible for
newly created refs. But I do not know if there are widespread mispractices
of using "wrong" refnames, created by either older versions of Git and
common third-party ones, that may make existing repository unusable
without first correcting them, and more importantly, I do not know if the
updated code is lenient enough to give users necessary escape hatches to
correct the existing problems. As we recently found out on the 'master'
front for your earlier topic, an updated check that is more strict and
saner than the older one is not necessarily an improvement, if it causes
pain to existing users to adjust to the new world order.

The output frm "git log --oneline --first-parent master..pu" should give
rough idea of what I have in mind. Obvious and nonintrusive clean-ups come
early, then features that are shown to be needed in the field and are with
user-facing design that are perfected come next to give them longer time
to fix potential issues in implemementation, followed by all the rest.
