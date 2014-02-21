From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] sha1_file: fix delta_stack memory leak in unpack_entry
Date: Fri, 21 Feb 2014 10:09:33 -0800
Message-ID: <xmqqmwhk49sy.fsf@gitster.dls.corp.google.com>
References: <1392940067-4830-1-git-send-email-pclouds@gmail.com>
	<20140221054148.GA24882@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 21 19:09:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WGuXg-0008Oc-QL
	for gcvg-git-2@plane.gmane.org; Fri, 21 Feb 2014 19:09:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755305AbaBUSJl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 Feb 2014 13:09:41 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:32831 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754253AbaBUSJk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Feb 2014 13:09:40 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 60FB06C2CF;
	Fri, 21 Feb 2014 13:09:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=A6R6m6kR471g
	1QJOkMSltNoqhBQ=; b=WGV7T/E1nygwMz4BVQ/PTvIRkn7OzkuGyjBMXtM22aGQ
	rNBpdQT8zFRhTWqZ4KSX2FNa/GqMVTpBh6VoYjGVEHc3vOJU/WszCmGoFxNJH03A
	ohCZc5SGoLhpQ9a86waW6bBSeHbi9quOKQodrump0he9BDCTvW7byansxhYIK0k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=mZscH7
	pPhpkJXPGJ44+QFdI1oPgfd573A+JLsONf7RSRf/RsuwLi4q+opf9ZPgmmHJkWaY
	OcvAUkPMEZ8/Qbi/XQbo81k0JLtL7/z88/EEfK6W4Kw4/a0hYpWm5dKIlQsOP+Je
	pwfQdQt8Ley/kLU4/U61lxIXs+tqY1zMYXNJA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8AB916C2CE;
	Fri, 21 Feb 2014 13:09:38 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F04C66C2CC;
	Fri, 21 Feb 2014 13:09:36 -0500 (EST)
In-Reply-To: <20140221054148.GA24882@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 21 Feb 2014 00:41:48 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 530010D0-9B23-11E3-B3B3-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242484>

Jeff King <peff@peff.net> writes:

> On Fri, Feb 21, 2014 at 06:47:47AM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=
=E1=BB=8Dc Duy wrote:
>
>> This delta_stack array can grow to any length depending on the actua=
l
>> delta chain, but we forget to free it. Normally it does not matter
>> because we use small_delta_stack[] from stack and small_delta_stack
>> can hold 64-delta chains, more than standard --depth=3D50 in pack-ob=
jects.
>>=20
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>> ---
>>  Found when trying to see if making some objects loose at this phase
>>  could help git-blame and how many objects will be loosened. Gotta g=
o
>>  soon, didn't really test it, but I bet it'll work.
>
> This looks correct to me.

This comes from abe601bb, right?  The change looks correct to me, too.

> For fun, I measured "git fsck" on linux.git via massif. The peak memo=
ry
> usage dropped from 368MB to 306MB. That's probably an extreme case
> because it's a big repo and was packed with "--aggressive", but it's
> still a nice improvement.

Thanks.
