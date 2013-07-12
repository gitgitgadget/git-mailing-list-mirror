From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug in .mailmap handling?
Date: Fri, 12 Jul 2013 13:50:26 -0700
Message-ID: <7v4nbzjyel.fsf@alter.siamese.dyndns.org>
References: <51E029B9.20108@googlemail.com>
	<7vfvvjjzee.fsf@alter.siamese.dyndns.org>
	<7v8v1bjyyy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Jul 12 22:50:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxkIU-0004Nd-Eb
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 22:50:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965441Ab3GLUu3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jul 2013 16:50:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55267 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965378Ab3GLUu2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jul 2013 16:50:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5F94730DFA;
	Fri, 12 Jul 2013 20:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cBbvjg+G8eSSz5vg6PyQqHrxVuk=; b=OM3BjR
	RRKo0z2VXknteEXduRqlm81uUQYsJ5vW+cVB1Q9BAmpwsUEvoFXa1sS6/dr5OFt9
	QZf2mqihp6DohP/AY1ZR7LmYOyhC3SccJXyW0awD4Efc0Jb2Xdx1gEp+AFb0y6Ae
	JPMHyboezp+LN/T81Hpd/rq36T8ohBNmWNALU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uZjmtpn/XF6CdRpDGZDShHiKmuJi9W07
	eUr+LyrGr82n0t8na5UJvyGEmMVCule7uk8MT/ipPlIFnreM+UMch1AxtBTpywuT
	F6U3GvdisyG1PWz5UOGAS0B38DVJDb3S7dr49+6a0zaScp4+Z/SnkkW7SeUjIRHK
	1myF7dAo0uc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 56AFF30DF9;
	Fri, 12 Jul 2013 20:50:28 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9BBFF30DF8;
	Fri, 12 Jul 2013 20:50:27 +0000 (UTC)
In-Reply-To: <7v8v1bjyyy.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 12 Jul 2013 13:38:13 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AEB5349A-EB34-11E2-AAE5-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230254>

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Stefan Beller <stefanbeller@googlemail.com> writes:
>>
>>> 	git shortlog -sne
>>> 		 1  A <A@example.org>
>>> 		 1  A <a@example.org>
>>
>> This is coming from mailmap.c::add_mapping() that downcases the
>> e-mail address.
>>
>> changed_email@example.org is mapped to a@example.org because of this
>> downcasing, while "A <A@example.org>" does not have any entry for it
>> in the .mailmap file, so it is given back as-is.  Hence we see two
>> distinct entries.
>
> I think it is wrong for the parser to lose information by
> downcasing.
>
> It is perfectly fine to do the comparison case insensitively, to
> allow <changed_Email@example.org> in the input is mangled using the
> entry for <changed_email@example.org> in the .mailmap file; it is
> not fine to downcase the parsed result, especially the side that is
> used as the "rewritten result" (i.e. the tokens earlier on the line),
> as that would mean mangling the output.
>
> Let me see if I can quickly whip up a fix.

It might be just the matter of doing this.

I suspect that we could drop the downcasing of old-email, too, but
the new-email is supposed to be the rewritten result that appears on
the output, and downcasing it is very wrong.

I also suspect that this was an old workaround for the original
string-list that did not know how to match items case insensitively,
which we should have removed when we added case sensitivity support
to the string-list at around 577f63e7 (Merge branch
'ap/log-mailmap', 2013-01-20).

 mailmap.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/mailmap.c b/mailmap.c
index 418081e..c64a53d 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -56,9 +56,6 @@ static void add_mapping(struct string_list *map,
 	if (old_email)
 		for (p = old_email; *p; p++)
 			*p = tolower(*p);
-	if (new_email)
-		for (p = new_email; *p; p++)
-			*p = tolower(*p);
 
 	if (old_email == NULL) {
 		old_email = new_email;
