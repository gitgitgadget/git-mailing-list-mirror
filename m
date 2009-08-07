From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] clarify error message when an abbreviated non-existent 
 commit was specified
Date: Thu, 06 Aug 2009 22:36:41 -0700
Message-ID: <7vk51g5gnq.fsf@alter.siamese.dyndns.org>
References: <20090806193413.GJ1033@spearce.org>
 <1249588435-23400-1-git-send-email-timcharper@gmail.com>
 <e1a5e9a00908062217q4bd1ecafm5fd5e060aecfa467@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Tim Harper <timcharper@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 07 07:36:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZI8P-0004mP-09
	for gcvg-git-2@gmane.org; Fri, 07 Aug 2009 07:36:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752239AbZHGFgt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Aug 2009 01:36:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751808AbZHGFgt
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Aug 2009 01:36:49 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:53461 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750810AbZHGFgt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Aug 2009 01:36:49 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 62E28205B9;
	Fri,  7 Aug 2009 01:36:49 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 4BAC0205B8; Fri,  7 Aug 2009
 01:36:42 -0400 (EDT)
In-Reply-To: <e1a5e9a00908062217q4bd1ecafm5fd5e060aecfa467@mail.gmail.com>
 (Tim Harper's message of "Thu\, 6 Aug 2009 23\:17\:48 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4DAB7D26-8314-11DE-ADBB-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125182>

Tim Harper <timcharper@gmail.com> writes:

>> diff --git a/parse-options.c b/parse-options.c
>> index 3b71fbb..95eb1c4 100644
>> --- a/parse-options.c
>> +++ b/parse-options.c
>> @@ -615,7 +615,7 @@ int parse_opt_with_commit(const struct option *o=
pt, const char *arg, int unset)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!arg)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (get_sha1(arg, sha1))
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return error("mal=
formed object name %s", arg);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return error("mal=
formed object name or no such commit: %s", arg);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0commit =3D lookup_commit_reference(sha1);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!commit)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return error(=
"no such commit %s", arg);
>> --
>> 1.6.4
>
> Does nobody think this is a good idea?

Probably people don't care enough.  I certainly didn't pay much attenti=
on
to the discussion on a rather trivial patch that was not yet signed off=
=2E

I'd probably write along this line instead, if I cared enough. =20

	if (get_sha1(arg, sha1) ||
            !(commit =3D lookup_commit_reference(sha1)))
		return error("no such commit: %s", arg);

I think the important part of the message is that whatever the user gav=
e
us when we expected to see a string that names a commit was not a commi=
t;
it is immaterial if the failure was because an abbreviated hexadecimal
form was mistyped (get_sha1() would fail in this case) or because a tag
that points at a non commit, e.g. "v2.6.11-tree", was given (l-c-r will
fail in that case).

Giving two different messages depending on the nature of an error will
help debugging parse_opt_with_commit(), but that benefit is secondary.
