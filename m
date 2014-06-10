From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/6] pack-objects: stop respecting pack.writebitmaps
Date: Tue, 10 Jun 2014 14:07:37 -0700
Message-ID: <xmqqoay08odi.fsf@gitster.dls.corp.google.com>
References: <20140610200741.GA11248@sigill.intra.peff.net>
	<20140610201913.GD14974@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 10 23:07:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuTGp-0003F5-7y
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 23:07:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753271AbaFJVHp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 17:07:45 -0400
Received: from smtp.pobox.com ([208.72.237.35]:55718 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753009AbaFJVHo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 17:07:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2BF081E15A;
	Tue, 10 Jun 2014 17:07:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+xAaOs1jkSmE1ANchHnSFrzEUT8=; b=IjoP9p
	GTU8t9GC2SOqUgBKS3Bd75Tz1sTwlSapOjYWptftAME7eR3iVJX4a6u2EiJqPPMZ
	+RKO2H6dQpuZVDE2szgQb2Q9cpW43pcXYxz/3pdNyDFe2IyZa/fAdgyXG06rrQBj
	2rGOV1RN65DTfr22jESErqnf/1Yk13sqIo07c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sacK2avX4mQlvfmJJNcOYMxtWkPAFeK6
	0/btxRggOP4ao8LP9yakjBBkhQVtfo3hxzZIKyQD3mib2kiilfBaoIJ0BQiaiTKg
	mP8D0W4X5w4fF4WRGTT5Vtg0BP3wcVbpGwDSW0Jlat5TP/g0U4yA5TKWaORX54q5
	HmHxRbXUKpY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 239161E159;
	Tue, 10 Jun 2014 17:07:43 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2D4081E154;
	Tue, 10 Jun 2014 17:07:39 -0400 (EDT)
In-Reply-To: <20140610201913.GD14974@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 10 Jun 2014 16:19:13 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 411DA1AA-F0E3-11E3-A482-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251236>

Jeff King <peff@peff.net> writes:

> I'm not sure what we want to do with this. It _is_ a possible regression
> as explained above, but I really do find it improbable that anyone will
> care. Even at GitHub, where we use a custom script instead of running
> `git gc`, we hook into the repack code, and not directly into
> pack-objects.
>
> One option is obviously to drop it as not worth it (you don't see the
> benefit here, but it enables the cleanups in the rest of the series).
>
> Another option is noting that the regression is worth dealing with,
> adding a deprecation notice, and phasing it out eventually. I tend to
> think it's not worth the trouble here.
>
> Another option is to track it to graduate to master during the next
> cycle. I.e., decide that the possible regression isn't a big deal.

My gut feeling is that the last one is sufficient.  These low level
subcommands that are designed to be used by scripts (aka plumbing)
shouldn't have configuration options in the first place, and users
shouldn't depend on them even if they were added by design mistake.

> The final option is to track it for maint, along with the earlier
> patches.  The argument for that is:
>
>   1. It's not a regression worth caring about (i.e., if it's not worth
>      caring about for master, it's probably not worth caring about for
>      maint, either).
>
>   2. It shortens the window in which the old behavior is in a release,
>      making it less likely for somebody to try depending on it.

Yeah, probably.  But I am not sure if that is even needed.
