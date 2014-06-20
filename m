From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 1/2] name-hash.c: replace cache_name_compare() with memcmp()
Date: Fri, 20 Jun 2014 10:10:56 -0700
Message-ID: <xmqqvbro7k54.fsf@gitster.dls.corp.google.com>
References: <1403230004-11034-1-git-send-email-jmmahler@gmail.com>
	<1403230004-11034-2-git-send-email-jmmahler@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Jeremiah Mahler <jmmahler@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 23:29:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WzulO-00053F-DA
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jun 2014 23:29:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755675AbaFYV3u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2014 17:29:50 -0400
Received: from smtp.pobox.com ([208.72.237.35]:60112 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754823AbaFYV3t (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2014 17:29:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id F1A8621E06;
	Wed, 25 Jun 2014 17:29:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=DvKhNXhSPi1blQK3i8SiQ0SU0Cc=; b=Lp4uDJliqeo0sxz3+9wk
	LgsrUJwlpkko2BZxQzUboKppSX/FbvTKYXWyL8iMqG05dmpSQBhDGhb2d/N7nt34
	ZlebY/TOW5WhKEL4QQEKFQM3jfU/lzyHBAC4hp5KArd4FuP8Qc5nqFOYwU0OSMFl
	8htmVPcx9QL46K+DLUGDk7w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=ycXb8xFVA41G+XH5iOmvb6uPtGi45FiIhQDRuVxFc8zWgv
	Gr9TNVbpDGsGZWy3z4KCb4npp4PKwuuVzcTwQfEh11coi3vGLD00pPRJbluxV1Ay
	c6BoP6yRzAv38UeYGbsdIfrHorkaQji668B/QVguAmGgEydng+Oz29R1uKG1g=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E7AA921E05;
	Wed, 25 Jun 2014 17:29:42 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 50CC321E02;
	Wed, 25 Jun 2014 17:29:38 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: CF959870-FCAF-11E3-AE14-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252463>

Jeremiah Mahler <jmmahler@gmail.com> writes:

> When cache_name_compare() is used on counted strings of the same
> length, it is equivalent to a memcmp().  Since the one use of
> cache_name_compare() in name-hash.c requires that the lengths are
> equal, just replace it with memcmp().

I do not think it is not "requires that the lengths are equal"; it
merely is a premature optimization, as it wants to catch only the
case where the names are the same.

Your patch is not wrong per-se, but with the above justification of
yours, I would actually have expected to see it updated to use
!cache_name_compare() and then later !name_compare().  That way, if
it ever turns out that giving name_compare() semantics specific to
"name" (as opposed to just byte-for-byte comparison given by
memcmp(3)) is a good idea, we will use that comparison with
semantics specific to "name"s here, without having to change it from
memcmp().

Having said all that, I think we see a more correct justification
for this change in the pre-context of the patch.  We want the exact
comparison, without any funky "name"-specific semantics in the
quick-and-exact case.

I've queued it like this (no need to reroll).
Thanks.

    name-hash.c: replace cache_name_compare() with memcmp(3)
    
    The same_name() private function wants a quick-and-exact check to
    see if they two names are byte-for-byte identical first and then
    fall back to the slow path.  Use memcmp(3) for the former to make it
    clear that we do not want any "name" specific comparison.
    
    Signed-off-by: Jeremiah Mahler <jmmahler@gmail.com>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

diff --git a/name-hash.c b/name-hash.c
index 97444d0..49fd508 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -179,7 +179,7 @@ static int same_name(const struct cache_entry *ce, const char *name, int namelen
 	 * Always do exact compare, even if we want a case-ignoring comparison;
 	 * we do the quick exact one first, because it will be the common case.
 	 */
-	if (len == namelen && !cache_name_compare(name, namelen, ce->name, len))
+	if (len == namelen && !memcmp(name, ce->name, len))
 		return 1;
 
 	if (!icase)
