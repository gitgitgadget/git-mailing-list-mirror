From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] tag: add -i and --introduced modifier for --contains
Date: Wed, 16 Apr 2014 15:02:20 -0700
Message-ID: <xmqqppkhexw3.fsf@gitster.dls.corp.google.com>
References: <1397681938-18594-1-git-send-email-mcgrof@do-not-panic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Luis R. Rodriguez" <mcgrof@suse.com>,
	Jiri Slaby <jslaby@suse.cz>, Andreas Schwab <schwab@suse.de>,
	Jan Kara <jack@suse.cz>
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
X-From: git-owner@vger.kernel.org Thu Apr 17 00:02:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WaXuX-0005Bg-LO
	for gcvg-git-2@plane.gmane.org; Thu, 17 Apr 2014 00:02:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161329AbaDPWC0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2014 18:02:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62029 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756724AbaDPWCY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2014 18:02:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 369F87D131;
	Wed, 16 Apr 2014 18:02:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZnDQ0N4iyse/nSyJhpxlxCWcDUU=; b=N8Tb1l
	D6TeuVsCsOFp/PwYWLENd1e1rHNzkhWYcycMBDOwxAD1SLds8DcInN+HINPB5dGM
	6ZeHHpOPWVjjT+5wjBKRY34zwTqdKQW7KLx8m8uYz30ysmr24hXbjNKRDjVN3oMK
	8p4kpjdYcQCB0Qryx+0sOhUvYMMWDSirhZg+A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=t6/r9CSdzAMAbTrcJOw9XwH6OpaHCBcf
	kB7fOR7UxRkI0GaJAPiR+DwyxZxQhbQy/oIIO6P6sOmf9lYoGw6Ji/nz1XQXSe/G
	alvDG9xXfh0ueeHamBKfsaqYPR1RbwEblZMBMkSel0hm4XeydXmBVQuxhwYUNJw0
	0pfNoQk7PBY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1A42C7D12F;
	Wed, 16 Apr 2014 18:02:24 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 95A727D12D;
	Wed, 16 Apr 2014 18:02:22 -0400 (EDT)
In-Reply-To: <1397681938-18594-1-git-send-email-mcgrof@do-not-panic.com> (Luis
	R. Rodriguez's message of "Wed, 16 Apr 2014 13:58:58 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C982A9F2-C5B2-11E3-BCA2-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246386>

"Luis R. Rodriguez" <mcgrof@do-not-panic.com> writes:

> From: "Luis R. Rodriguez" <mcgrof@suse.com>
>
> Upstream Linux kernel commit c5905afb was introduced on v3.4 but
> git describe --contains yields v3.5

Actually, "describe --contains" should yield v3.5-rc1~120^3~76^2,
not v3.5.

And you are right that the commit is contained in v3.4, so we also
should be able to describe it as v3.4~479^2~9^2 as well.

And between v3.4 and v3.5-rc1, the latter is a closer anchor point
for that commit (v3.5-rc1 only needs about 200 hops to reach the
commit, while from v3.4 you would need close to 500 hops), hence we
end up picking the latter as "a better answer".

Now, with the explanation of how/why this happens behind us, I see
two possible issues with this patch:

 - The reason a human-user rejects v3.5-rc1~120^3~76^2 as the
   solution and favor v3.4~479^2~9^2 could be because of the -rc1
   part in the answer.  Perhaps we would want an option that affects
   which tags are to be used (and which tags are to be excluded) as
   anchoring points?

 - If we are truly interested in finding out the "earliest tag that
   contains the given commit", shouldn't we be ignoring the tagname
   and go with the tag with the oldest timestamp?  After all, there
   may be a fix merged to v7.0 first on April 1st, and then on a
   later date the same fix may be merged to the maintenance track to
   be tagged as v6.9.1 on May 5th, and in such a case, wouldn't you
   want to say that the fix first appeared on v7.0 on April 1st,
   instead of on May 5th?

Thanks.
