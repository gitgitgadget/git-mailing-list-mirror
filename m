From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fetch-pack: fix unadvertised requests validation
Date: Sat, 27 Feb 2016 10:32:27 -0800
Message-ID: <xmqq60xagg1w.fsf@gitster.mtv.corp.google.com>
References: <1456577034-6494-1-git-send-email-gabrielfrancosouza@gmail.com>
	<xmqqd1riggd7.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Gabriel Souza Franco <gabrielfrancosouza@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 27 19:32:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZjfP-00045o-4L
	for gcvg-git-2@plane.gmane.org; Sat, 27 Feb 2016 19:32:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756732AbcB0Scb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Feb 2016 13:32:31 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:58772 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756657AbcB0Sca (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Feb 2016 13:32:30 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7C45C443E4;
	Sat, 27 Feb 2016 13:32:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=99Xgga4rxVNlvI+8miR4BxPSjSQ=; b=GBZ3Qd
	qvycKCE9IbC6yZQPlnIu5f5L1EzUWher3GsRbQnJCM19noy4Pe2lCMbzuE06sTed
	OPR98puUcUn+HceztiTGqQWtJr9AfMc8zkRm8T2p5d0BLEEdu2oEOvuBJKCVlmbz
	QKTmJ/8PGjg/YuRnjydFMcHgUFMMOENudVs60=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vSQW7PLgfvRYUBdnbgX1Y/xO8mQx0+yk
	ihLh0IUqjLlAT5KgcCyzBsxyz3pPmWSsbCc2PI7NJMkejX4uYBp7lPkA59oD9r+C
	bGOViR5V1qjQO6uDpopmuCXI1CWfQJP/a310W8u0yRTiCHSrG19zKC44CV/MxC7m
	lpMTCltj+P0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 722E0443E1;
	Sat, 27 Feb 2016 13:32:29 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E3310443DE;
	Sat, 27 Feb 2016 13:32:28 -0500 (EST)
In-Reply-To: <xmqqd1riggd7.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Sat, 27 Feb 2016 10:25:40 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 74C717D0-DD80-11E5-8284-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287719>

Junio C Hamano <gitster@pobox.com> writes:

> Gabriel Souza Franco <gabrielfrancosouza@gmail.com> writes:
>
>> Check was introduced in b791642 (filter_ref: avoid overwriting
>> ref->old_sha1 with garbage, 2015-03-19), but was always false because
>> ref->old_oid.hash is empty in this case. Instead copy sha1 from ref->name.
>>
>> Signed-off-by: Gabriel Souza Franco <gabrielfrancosouza@gmail.com>
>> ---
>
> Peff, that commit points me at your direction.  And I can see the
> original patch avoids overwriting old_sha1 by saving the result from
> get_sha1_hex() in a temporary, it is true that old_sha1 is not
> updated from the temporary.
>
> The original code before b791642 wanted to say "if ref->name is not
> 40-hex, continue, and otherwise, do the ref->matched thing" and an
> implementation of b791642 that is more faithful to the original
> would indeed have been the result of applying this patch from
> Gabriel, but I am scratching my head why we have hashcmp() there.
>
> Was it to avoid adding the same thing twice to the resulting list,
> or something?

Nah, I think you just misspelt hashcpy() as hashcmp().  The original
wanted to get the binary representation of the hex in old_sha1 when
it continued, and you wanted to delay the touching of old_sha1 until
we make sure that the input is valid 40-hex, so something like this
is what Gabriel wants to do (which I agree with), isn't it?

 fetch-pack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 058c258..bb5237f 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -551,7 +551,7 @@ static void filter_refs(struct fetch_pack_args *args,
 				continue;
 			if (get_sha1_hex(ref->name, sha1) ||
 			    ref->name[40] != '\0' ||
-			    hashcmp(sha1, ref->old_sha1))
+			    hashcpy(ref->old_sha1, sha1))
 				continue;
 
 			ref->matched = 1;
