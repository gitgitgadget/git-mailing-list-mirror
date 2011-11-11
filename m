From: Junio C Hamano <gitster@pobox.com>
Subject: Re: reset reports file as modified when it's in fact deleted
Date: Fri, 11 Nov 2011 08:43:34 -0800
Message-ID: <7vr51er4nd.fsf@alter.siamese.dyndns.org>
References: <20111107094330.GB10936@beez.lab.cmartin.tk>
 <20111107162642.GA27055@sigill.intra.peff.net>
 <20111111140834.GA10025@beez.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Fri Nov 11 17:43:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ROuCc-0007U4-EZ
	for gcvg-git-2@lo.gmane.org; Fri, 11 Nov 2011 17:43:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757979Ab1KKQnh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Nov 2011 11:43:37 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42543 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757266Ab1KKQnh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Nov 2011 11:43:37 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A6CE95CD3;
	Fri, 11 Nov 2011 11:43:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=P5saHkqp1vFC
	LXTY4YPrgJpywUM=; b=F3qSSWn1H92Zq1LLHXwSWwhsWhd4TmCTt9COBOuDbngI
	v+KlrNVaiTHxyqzLw8kZzJmqf8IXXAn37Mw7YbahyYg+Lcjo514vmol8idjPO/09
	a4OOliJfvsl4RTbxPJUJYFG82hKBKDFZNgqGeSwxDbXFvZMOvv9MHVFXKPHTnpU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=dQ5U8v
	CtgwmdcVivMdutz5Jca6J1qDSf25+GlRGIy1tY5EyRfslz2znIXUg0BiZEYImcYr
	Eh5dFGa1N8UiQCZiH3js7lvlVjmpv+P1HLaSoZSb6y4W+OeSitEdJ+oWcYx1Ec/G
	qAwn1JXoK64WL8Xt1RyZErvCHlB5hUvStgRTA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9FAB75CD2;
	Fri, 11 Nov 2011 11:43:36 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 35CDD5CD1; Fri, 11 Nov 2011
 11:43:36 -0500 (EST)
In-Reply-To: <20111111140834.GA10025@beez.lab.cmartin.tk> ("Carlos
 =?utf-8?Q?Mart=C3=ADn?= Nieto"'s message of "Fri, 11 Nov 2011 15:08:34
 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4CD8C9DE-0C84-11E1-9385-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185275>

Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:

> On Mon, Nov 07, 2011 at 11:26:42AM -0500, Jeff King wrote:
> ...
>> The patch to do "D"eleted is pretty simple:
>>=20
>> diff --git a/read-cache.c b/read-cache.c
>> index dea7cd8..cc1ebdf 100644
>> --- a/read-cache.c
>> +++ b/read-cache.c
>> @@ -1103,9 +1103,11 @@ int refresh_index(struct index_state *istate,=
 unsigned int flags, const char **p
>>  	int in_porcelain =3D (flags & REFRESH_IN_PORCELAIN);
>>  	unsigned int options =3D really ? CE_MATCH_IGNORE_VALID : 0;
>>  	const char *needs_update_fmt;
>> +	const char *needs_rm_fmt;
>>  	const char *needs_merge_fmt;
>> =20
>>  	needs_update_fmt =3D (in_porcelain ? "M\t%s\n" : "%s: needs update=
\n");
>> +	needs_rm_fmt =3D (in_porcelain ? "D\t%s\n" : "%s: needs update\n")=
;
>>  	needs_merge_fmt =3D (in_porcelain ? "U\t%s\n" : "%s: needs merge\n=
");
>
> While the name fits in with the rest of the variables, it's kind of
> the wrong way around, isn't it? It doesn't need an 'rm', it /was/
> rm'd.

The variable names were chosen to mean "In a situation where the plumbi=
ng
traditionally would have said X, use this format to describe it". This =
is
the first topic to separate a single situation (from the plumbing's poi=
nt
of view) into two and say different things at Porcelain, and the variab=
le
naming no longer works.

An obvious solution would be to rename all of them to be based on "what
happened to the path". E.g. "modified_fmt" would be set to either "M" o=
r
"needs update", and "removed_fmt" would be set to either "D" or "needs
update", etc.
