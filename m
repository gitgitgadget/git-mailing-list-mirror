From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 00/18] Extending the shelf-life of "git describe"
 output
Date: Tue, 03 Jul 2012 11:20:10 -0700
Message-ID: <7v3958wvtx.fsf@alter.siamese.dyndns.org>
References: <1341268449-27801-1-git-send-email-gitster@pobox.com>
 <20120703071940.GB16679@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 03 20:20:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sm7i2-0005sh-IJ
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jul 2012 20:20:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754256Ab2GCSUP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jul 2012 14:20:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46099 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752876Ab2GCSUO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2012 14:20:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 046EE97A3;
	Tue,  3 Jul 2012 14:20:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=nKMpVEfltR1O8ObbzrJI+RTb9Ok=; b=EOU/T0JA3+iEjWFdHADU
	puo5+eQELxrL0KYm/eIzIELqGomhyayG5lfBC4tvYoYCXjnHrOVXCgEPnkj4HMAn
	hr+PvwqueKd5ncmbTdchdqniGK+s/Ftp6WXzcL3qL8UcOB3QCjVdJjlEFxrw7uq2
	ZdHQcq7Pzsc2Tdf+pqhU1DI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=LalGIgMwy6+K6oF0ggaBxLDQhR/6O5zEMzcLGE3fjttoEe
	GmjRB9KY1XbmP9XcDqa5E4WE66qEclIWNMv6OXlCvGdSUBSaDeL6PhjMy+qCypOy
	NcziBPC03zQ2x51qsbw4TuaBRszayCkFFNp6HB0jCV+V9nOLsB94PxfdgQzv4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EF2EE97A2;
	Tue,  3 Jul 2012 14:20:12 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 55F7397A0; Tue,  3 Jul 2012
 14:20:12 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BAAF6E52-C53B-11E1-BFAA-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200926>

Jeff King <peff@peff.net> writes:

> However, if you feed a partial sha1 for which there are
> multiple matches, none of which satisfy the disambiguation hint, then we
> used to say "short SHA1 is ambiguous", and now we don't.

In finish_object_disambiguation(), if the candidate hasn't been
checked, there are two cases:

 - It is the first and only object that match the prefix; or
 - It replaced another object that matched the prefix but that
   object did not satisfy ds->fn() callback.

And the former case we set ds->candidate_ok to true without doing
anything else, while for the latter we check the candidate, which
may set ds->candidate_ok to false.

At this point in the code, ds->candidate_ok can be false only if
this last-round check found that the candidate does not pass the
check, because the state after update_candidates() returns cannot
satisfy

    !ds->ambiguous && ds->candidate_exists && ds->candidate_checked

and !ds->canidate_ok at the same time.

Hence, when we execute this "return", we know we have seen more than
one object that match the prefix (and none of them satisfied ds->fn),
meaning that we should say "the short name is ambiguous", not "there
is no object that matches the prefix".

Please sanity check; I think it is just this one-liner, but I am
having hard time convincing myself that it can be that simple.

 sha1_name.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sha1_name.c b/sha1_name.c
index 2e2dbb8..c824bdd 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -212,7 +212,7 @@ static int finish_object_disambiguation(struct disambiguate_state *ds,
 				    ds->fn(ds->candidate, ds->cb_data));
 
 	if (!ds->candidate_ok)
-		return SHORT_NAME_NOT_FOUND;
+		return SHORT_NAME_AMBIGUOUS;
 
 	hashcpy(sha1, ds->candidate);
 	return 0;
