From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] multi-commit cherry-pick messes up the order of commits
Date: Thu, 12 Jan 2012 12:11:57 -0800
Message-ID: <7vpqeo1y0i.fsf@alter.siamese.dyndns.org>
References: <20120111173101.GQ30469@goldbirke>
 <CAP8UFD2uLoqzXRxssjwwW1Vk8RuNF_5OT1d7Z7hiRQ+Rq=UM1A@mail.gmail.com>
 <20120112144409.GV30469@goldbirke>
 <20120112165329.GA17173@sigill.intra.peff.net>
 <CALkWK0=Mv_tzNw-hN_9fAr+vABappndEK5iSWQHDk8Yk6Z-stw@mail.gmail.com>
 <7vaa5s3hiq.fsf@alter.siamese.dyndns.org>
 <CALkWK0kk0mVNaetr=triuVYva7inyx2aZvam81qTVA9=Q=UzGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 12 21:12:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RlR0H-0002p7-Gd
	for gcvg-git-2@lo.gmane.org; Thu, 12 Jan 2012 21:12:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755274Ab2ALUMC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jan 2012 15:12:02 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50413 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755222Ab2ALUMB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jan 2012 15:12:01 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ED53B7FD3;
	Thu, 12 Jan 2012 15:11:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tZOnlmvCfL6AgY7o83DYiZfGoEk=; b=ShuS4d
	Tkhj9G8H1zXF+y39CoZ95i4E4uE9AlluAkp59GG3SmdgZz/X7M5X4tR3CuRZHoRM
	Kk6fPPLdzhJUS/TQloNtHVIJMtcsc7PS9wn+upFu3oyWkaaTObjvhdkXJFwkI/rj
	QqXuDnpT1h1rmzMciTeeAQwgSPMJ3Cv1N3CrE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pyp6bMB7LbppE2ORb9LL8u6/ukTfka46
	Q2H2Adrzfv4y2o5DZ6PN9JSO6jJYDhPhfxIfkg8S245X5UtB83gF4VAy7EYF0eri
	daTIVl8E/hF6YiuBuBA0tEdWE/3pNfp0nOWU/VLj/sRwve1BoEHtoH8M2qVirn+s
	nsfMCfUrEdI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E4B4C7FD2;
	Thu, 12 Jan 2012 15:11:59 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6BF5C7FD1; Thu, 12 Jan 2012
 15:11:59 -0500 (EST)
In-Reply-To: <CALkWK0kk0mVNaetr=triuVYva7inyx2aZvam81qTVA9=Q=UzGw@mail.gmail.com>
 (Ramkumar Ramachandra's message of "Fri, 13 Jan 2012 00:55:58 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AEF97DEC-3D59-11E1-A29C-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188480>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Okay, just to make sure I understand this correctly: if more than one
> argument is literally specified, I should not set up the revision
> walker and pick the commits listed in revs->pending, correct?

Not really.

A rough approximation would be that if you see any negative ones (either
coming from A..B or ^A), you would always want to walk, giving everything
to prepare_revision_walk()-and-then-get_revision() machiery.

Otherwise you have only zero [*1*] or more positive ones, and you pick
them in the order you find in the pending list, without bothering the
revision traversal machinery at all [*2*].

> when I encounter the following command,
>
>   $ git cherry-pick maint ^master
>
> I should just pick two commits: maint, and ^master.

So the answer is aboslutely no. "maint ^master" is the same as saying
"master..maint".

[Footnote]

*1* You would probably want to error out if you got zero positive ones in
this case (i.e. absolutely nothing was given, neither positive nor
negative).

*2* The reason this is "rough" approximation is because we would probably
want to do Jonathan's "maint..master master..next" someday, and when that
happens, we would need to do much more than "do we have any negative? then
send it through to prepare_revision_walk()". But we are not there yet, so
I think the above is actually more or less the complete implementation.
