From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] Handle more file writes correctly in shared repos
Date: Fri, 08 Jan 2016 09:59:09 -0800
Message-ID: <xmqqbn8w2brm.fsf@gitster.mtv.corp.google.com>
References: <4aa11f02f4de113bf38152b8815658da42690f43.1450549280.git.johannes.schindelin@gmx.de>
	<cover.1452085713.git.johannes.schindelin@gmx.de>
	<c03e5a9d367b76d8a249680c752b4c4d935e9b91.1452085713.git.johannes.schindelin@gmx.de>
	<xmqq1t9t3vn8.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1601081704280.2964@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Yaroslav Halchenko <yoh@onerussian.com>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Jeff King <peff@peff.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jan 08 18:59:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aHbK4-0001bv-7C
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jan 2016 18:59:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753400AbcAHR7N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2016 12:59:13 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:57732 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751191AbcAHR7M (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2016 12:59:12 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E8B9C39ECE;
	Fri,  8 Jan 2016 12:59:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MhskRy2b7Ck3D4WrQO0hLRvihGg=; b=RYXLPa
	0IhVIjv60vI1K+ylUhMezCZ+LMdg14PP2ugB7ufe19EyU1YzWolpZdtQuPzB0TlW
	xmKWzPuC6GQmQrlalclrr5/kpk6mkGNgEU797CwTbPqgXEJDrS2z3eGGXCGsn8T0
	uxYoJTR6Zfh1dFRDF2010YyNwk49ME0kdOmVw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IEmrLn3+4fOZYCJuBph7fQBcghEFnBvE
	H8U54t6qTJ+CeJ1Ia2fCWcDieTScvyaWmYmvn4NtHbzJJcHF4ZRi24hang4g89vn
	dE762XyxlFxslZvbadOUGdUsciJg1e7JduFjEwaphYxfdcjvK0xycbdiDB5iKj2X
	GnryVHGWZp0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D129339ECA;
	Fri,  8 Jan 2016 12:59:10 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4679539EC7;
	Fri,  8 Jan 2016 12:59:10 -0500 (EST)
In-Reply-To: <alpine.DEB.2.20.1601081704280.2964@virtualbox> (Johannes
	Schindelin's message of "Fri, 8 Jan 2016 17:05:49 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 84E1F5A2-B631-11E5-899B-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283570>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Thu, 7 Jan 2016, Junio C Hamano wrote:
>
>> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>> 
>> > - git apply, when writing rejected hunks
>> 
>> Today I may try to apply and leave hello.c.rej; tomorrow you may try to
>> apply a different patch and get rejection for the same file.  And you
>> would not be able to if my umask is 077.
>
> As I just wrote in my reply to Peff: my experience with .rej files is that
> I want to inspect them, and then delete them once I addressed them. I do
> not want anybody to interfere with that, as the presence of .rej files
> serves also as a TODO list.

That argues for protecting .rej files against overwriting by myself,
too, which means (1) we do not want to loosen it by using
fopen_for_writing(), and (2) relying on permission bits and
ownership is not sufficient, i.e. just using regular fopen(3) is
wrong.

I think it is correct not to touch this codepath in this patch,
because of the above two reasons, but more simply and generally, it
is correct not to touch this codepath because core.sharedRepository
is not about working tree files, and .rej is a file you use in your
working tree.

As the log messages are often used to guide future developers, I
think the log message of this commit should mention that criterion.
It would cover multiple codepaths you listed in your proposed log
message in a more generic way, helping other people to reason about
when they see other instances of fopen(..., "w") and wonder if it
should become fopen_for_writing().

Thanks.
