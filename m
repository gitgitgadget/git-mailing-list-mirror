From: Junio C Hamano <gitster@pobox.com>
Subject: Re: breakage in revision traversal with pathspec
Date: Tue, 10 Sep 2013 15:23:50 -0700
Message-ID: <xmqq38pcwc21.fsf@gitster.dls.corp.google.com>
References: <xmqqy574y4pz.fsf@gitster.dls.corp.google.com>
	<522F8ED2.9000408@bracey.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kevin Bracey <kevin@bracey.fi>
X-From: git-owner@vger.kernel.org Wed Sep 11 00:24:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJWLp-0004lI-HG
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 00:24:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751534Ab3IJWX5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Sep 2013 18:23:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36817 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751213Ab3IJWX4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Sep 2013 18:23:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 130B640346;
	Tue, 10 Sep 2013 22:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FcqJLHHuRWp4VHQxN1zmaVAIi20=; b=Z7hZh0
	EPsW0YID5t0s+hLdDaCRr2bt59boZ72wYyfuWDJaekL4nH8xYe/CD5thiYP8nlyI
	i1RYxhHdwU9QFPaU4SjjjAzoy4bv78EjeAczWNAP5/twEpimJXmDYeblb7oY/w8b
	WyMD1QTciORiMnB7LBOxELITBT126WynZe2Nk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=A/LnkVaRqnOks6EcD5TuCqz8vRIZu5bo
	JW+B76fwM4phy7AyJWZWToPsWXZA+alLjVHdp2McDH0NyG4X0dEOhyA1MfVyI6UT
	Takrl5cy62w5I/PKDC+9cHvPWFa8WuqMOJCIsP+VS9NkKCHAHPKxU2ejsRJtCZfz
	NSSClB3sJIM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CD0BE4033E;
	Tue, 10 Sep 2013 22:23:54 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BA9674033A;
	Tue, 10 Sep 2013 22:23:53 +0000 (UTC)
In-Reply-To: <522F8ED2.9000408@bracey.fi> (Kevin Bracey's message of "Wed, 11
	Sep 2013 00:27:46 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: AD293952-1A67-11E3-8FBA-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234495>

Kevin Bracey <kevin@bracey.fi> writes:

> On 10/09/2013 20:19, Junio C Hamano wrote:
>> I am grumpy X-<.
>>
>> It appears that we introduced a large breakage during 1.8.4 cycle to
>> the revision traversal machinery and made pathspec-limited "git log"
>> pretty much useless.
>>
>> This command
>>
>>      $ git log v1.8.3.1..v1.8.4 -- git-cvsserver.perl
>>
>> reports that a merge 766f0f8ef7 (which did not touch the specified
>> path at all) touches it.
>>
>> Bisecting points at d0af663e (revision.c: Make --full-history
>> consider more merges, 2013-05-16).
>>
> That merge appearing *with* --full-history would seem like correct
> behaviour to me. Or at least it's what I intended.

Oh, of course.  "--full-history" is about showing any pointless
change, "the mainline was a lot more up-to-date and there were
changes relative to a fork based on an older baseline", so your
updated "log" should show that in the mainline git-cvsserver.perl
has been more fresh when that merge happened.  But it shouldn't
appear if the user does not ask for "--full-history".

> However, your particular example occurs *without*--full-history, which
> suggests a problem.

Yes.

> I note that "gitk v1.8.3^0..v1.8.4" and "git log --parents
> v1.8.3..v1.8.4" show that merge in Git 1.8.3, but not in Git 1.8.4. So
> we're going partially forwards, at least.

With the testcases demonstrating the cases your series fixed that
all look sensible, I think it is not really an option for us to
revert them; you do not have to defend it with "we are going
partially forwards" ;-).
