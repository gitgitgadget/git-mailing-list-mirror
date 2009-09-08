From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Makefile: Add NEEDS_CRYPTO_WITH_SSL
Date: Tue, 08 Sep 2009 13:19:33 -0700
Message-ID: <7vhbvdyysq.fsf@alter.siamese.dyndns.org>
References: <1252418078-68650-1-git-send-email-brian@gernhardtsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Brian Gernhardt <brian@gernhardtsoftware.com>
X-From: git-owner@vger.kernel.org Tue Sep 08 22:19:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ml7AK-0008T9-BT
	for gcvg-git-2@lo.gmane.org; Tue, 08 Sep 2009 22:19:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752095AbZIHUTi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Sep 2009 16:19:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752039AbZIHUTi
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Sep 2009 16:19:38 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:57878 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751889AbZIHUTh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Sep 2009 16:19:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id ECEE52B4BA;
	Tue,  8 Sep 2009 16:19:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=DeN0Bd70aqJEapBwSEX9aeO0TXs=; b=eo+fcHHXXp6KCECUAwOL9Jj
	zdYSu6sBrEudFm1MFd0Rm4fKwdMhnmYbdFET7YEFpO/D0mzIG8DO9xPUvviWzooy
	/vj/gQbJXlIPjuZw+FLiAGNK5nzDZ4tMI+sA94iJyLiEytT1aPHhfJYrBobNnRlt
	yO7l0FzOckLWFL8xBPtk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=aYxFRFehsssnmzeDhA9ax/TPtxCqa9BaeFrC4yB3dalYKBf7G
	TkkmRdtAEXDaqR9rp01lkqIfujB9VketaMgadoCtmm0kkZhSm5eMTJvOoCExZ89l
	kOgllJV1bHVH7lStu6P/MJI1S20UHvDP6Ih7gSGOaeewJ2/s/RBxpvz/h8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D24492B4B9;
	Tue,  8 Sep 2009 16:19:37 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3B8BF2B4B6; Tue,  8 Sep
 2009 16:19:35 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: EE930CEA-9CB4-11DE-BDCC-A13518FFA523-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128029>

Brian Gernhardt <brian@gernhardtsoftware.com> writes:

> The Makefile comment for NEEDS_SSL_WITH_CRYPTO says to define it "if
> you need -lcrypto with -lssl (Darwin)."  However, what it actually
> does is add -lssl when you use -lcrypto and not the other way around.

Correct.  That is worth fixing.

> However, libcrypto contains a majority of the ERR_* functions from
> OpenSSL (at least on OS X) so we need it both ways.

I see.  We need to be able to see ERR_err_string(), whose caller happens
to be only imap-send.c for now, and that function is in -lcrypto together
with other ERR_* functions.

>  Compilation using BLK_SHA1 on OS X 10.5 and 10.6 (at least) is still
>  broken without this patch.
>
>  Alex Riesen <raa.lkml@gmail.com> pointed out that just adding LIB_4_CRYPTO
>  to git-imap-send is simpler, but judging from the fact that nobody else
>  has complained about this issue, I'm guessing that the need for -lcrypto
>  when using -lssl is not widespread.  (Or BLK_SHA1 isn't getting used much
>  or those who do don't compile git-imap-send with SSL.)

BLK_SHA1 is fairly new on 'master', so lack of breakage report is
expected.

The patch makes sense to me, but as the result, depending on platforms
and configuration, we would use three variations when linking imap-send
with no NO_OPENSSL defined:

 * Both -lcrypto -lssl
 * Only -lssl
 * Only -lcrypto

I wonder if we can simplify this in some way (not a 1.6.5 topic).

I am suspecting that the reason we do not say "always both" is because
depending on the vintage of OpenSSL one or the other is missing?
