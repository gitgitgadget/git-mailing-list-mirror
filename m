From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remote: filter out invalid remote configurations
Date: Fri, 30 Aug 2013 09:58:24 -0700
Message-ID: <xmqqwqn3yv2n.fsf@gitster.dls.corp.google.com>
References: <1377608796-13732-1-git-send-email-cmn@elego.de>
	<xmqqr4dffarq.fsf@gitster.dls.corp.google.com>
	<1377866509.1714.0.camel@centaur.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Fri Aug 30 18:59:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFS2E-0006Hq-F1
	for gcvg-git-2@plane.gmane.org; Fri, 30 Aug 2013 18:58:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756424Ab3H3Q6d convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Aug 2013 12:58:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45080 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755448Ab3H3Q6c convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Aug 2013 12:58:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6C5563D3D9;
	Fri, 30 Aug 2013 16:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=9SZmf7hucXOt
	Ng1qUotrJePBLRQ=; b=xWyVfXp1nQ0I8SvohaU9cgt7sbE2dX0j5HkFfZI+o3ZB
	RtSq12g+ecfz81Tcbi8iDnf9RDpHAG2bfDkmyQiEnTnPGtANtFGwSJxa2H1fQhXl
	Vl+MEhdyfkQ0riUl0jIg+eZ+jKEiKUw1fT6DRUL6UFP420+pNWIof9TqPrsChe8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=vcKCYJ
	p6X+wO7btq1Q/9wX74UNB/MtZ2/K0r50pcPki0qj8eC0VIvV7jmLUdE8wQdj/T0i
	F5QY++qtwmgj0LJfMl8MwtKkb+EnWnaLDNDcmbKMdfkE9trmJRf00Rhb3O4VbMA2
	FfeXQxIphkgt4wMfm3Va66zfd29HQB0LMGE6E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5F9793D3D7;
	Fri, 30 Aug 2013 16:58:31 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7EF143D3D1;
	Fri, 30 Aug 2013 16:58:29 +0000 (UTC)
In-Reply-To: <1377866509.1714.0.camel@centaur.cmartin.tk> ("Carlos
 =?utf-8?Q?Mart=C3=ADn?=
	Nieto"'s message of "Fri, 30 Aug 2013 14:41:49 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 651AC7AA-1195-11E3-9D4B-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233445>

Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:

> On Tue, 2013-08-27 at 07:50 -0700, Junio C Hamano wrote:
>> Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:
>>=20
>> > In remote's configuration callback, anything that looks like
>> > 'remote.<name>.*' creates a remote '<name>'. This remote may not e=
nd
>> > up having any configuration for a remote, but it's still in the li=
st,
>> > so 'git remote' shows it, which means something like
>> >
>> >     [remote "bogus"]
>> >         hocus =3D pocus
>> >
>> > will show a remote 'bogus' in the listing, even though it won't wo=
rk
>> > as a remote name for either git-fetch or git-push.
>>=20
>> Isn't this something the user may want to be aware of, though?
>> Hiding these would rob a chance for such an entry to be noticed from
>> the user---is it a good change?
>
> If we want to help the user know that there's something a bit odd in
> their configuration, shouldn't we tell them instead of hoping they
> stumble upon it?

Yeah, I agree that "git remote" that tells the above "bogus" is
fishy is better than just hides it.
