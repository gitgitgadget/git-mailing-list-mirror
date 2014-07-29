From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 05/10] abspath: convert real_path_internal() to strbuf
Date: Tue, 29 Jul 2014 09:44:06 -0700
Message-ID: <xmqqa97s3yjt.fsf@gitster.dls.corp.google.com>
References: <53D694A2.8030007@web.de> <53D6964E.1070100@web.de>
	<20140728191649.GE11265@peff.net>
	<xmqqiomh40ui.fsf@gitster.dls.corp.google.com>
	<53D6E52B.1050006@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
	Karsten Blees <karsten.blees@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkg?= =?utf-8?B?Tmfhu41j?= Duy 
	<pclouds@gmail.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Tue Jul 29 18:44:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCAVn-0007cp-Re
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jul 2014 18:44:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752527AbaG2QoW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Jul 2014 12:44:22 -0400
Received: from smtp.pobox.com ([208.72.237.35]:50019 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751890AbaG2QoS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Jul 2014 12:44:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 146F62BA1E;
	Tue, 29 Jul 2014 12:44:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=CZV3IsKtrFcH
	55UI3Q+qMsjbd8U=; b=aBW2bWWuVFe8XMjLhqwlUUmbQTci1b+nxDeQByo4KMbF
	EC8z52df/e4TCH4IFlzhME2IRXfgvlWIOVFSQ08DutTduYZWZ0SZZGPuvy6rqciu
	0qamIb6cqb8GCO4vqfm39am4Quh4W+6JB2IUFoQWwcnanoW94ndSElsQ1adxRL4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=fdNQec
	tfEzfRCmhfGyk8oVxrOy61MLPjdOnhufh3oYwhDCgPImEmAbZ64RR+0q6zYQfE3w
	DqqlmenTFKBjEzMaLDmeaNF28jNjyAevmhUgOKPhZl8ECaU6eN/s3e1rtIDk6Fed
	ivIh610Mse4lp+3Ah6BuQPRD8RDOC84Y+ERJM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 03AA42BA1C;
	Tue, 29 Jul 2014 12:44:17 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 27FC62BA0B;
	Tue, 29 Jul 2014 12:44:08 -0400 (EDT)
In-Reply-To: <53D6E52B.1050006@web.de> (=?utf-8?Q?=22Ren=C3=A9?= Scharfe"'s
 message of "Tue, 29
	Jul 2014 02:04:59 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 8F416D3A-173F-11E4-BE3D-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254446>

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

>> "Next call to the function invalidates the return value the last
>> caller received" feels like playing with fire.  Most existing
>> callers are safe in that the first thing they do to the returned
>> string is xstrdup() it, but we would need to check all the other
>> callers.
>
> That's the price we pay for using static variables, no?  Callers need
> to consume them as long as they're fresh and multi-threading is not
> allowed.

Yes, I didn't mean to say that fixing this leak by a static whose
lifetime rule is "alive until next call" is introducing a new
brittleness.  The existing callers have lived with that lifetime
rule with the callee without the changes in this series, and fixing
the leak by replacing _init() with _reset() will make the callee
give the same old "alive until next call" lifetime rule to its
callers.

> Getting a strbuf_add_real_path() in order to avoid static variables
> would be nice.  And it would also be nice if it worked without callin=
g
> chdir().  Nice topics for follow-up patches. :)

Yup.  Nice, but outside the scope.  Of course it is related and can
be done as a "while we know about the issue" close follow-up.

Thanks.
