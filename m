From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pathspec: adjust prefixlen after striping trailing slash
Date: Wed, 22 Apr 2015 12:58:33 -0700
Message-ID: <xmqq1tjcdjfa.fsf@gitster.dls.corp.google.com>
References: <55300D2C.9030903@web.de>
	<1429319946-19890-1-git-send-email-pclouds@gmail.com>
	<5533A567.7070301@web.de>
	<CACsJy8A7+rQhn5ry6Z86SbeYHoDw=w7tB73Ls2V05E8F-JMnhA@mail.gmail.com>
	<xmqqy4lnmkbv.fsf@gitster.dls.corp.google.com>
	<CACsJy8B1QWzehAEtjnQeRJ8uehcFFDbdHSViwk_JtrtYehV8ZQ@mail.gmail.com>
	<xmqq8udlgpey.fsf@gitster.dls.corp.google.com>
	<5537F31D.4090704@web.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Dennis Kaarsemaker <dennis@kaarsemaker.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Apr 22 21:58:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yl0nF-0000ts-Ru
	for gcvg-git-2@plane.gmane.org; Wed, 22 Apr 2015 21:58:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753779AbbDVT6l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2015 15:58:41 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59868 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753132AbbDVT6l (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2015 15:58:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5BBBA4BC93;
	Wed, 22 Apr 2015 15:58:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=R+fjpJBG/r9BrfUs96lKo7n4OU8=; b=hOZhDw
	ui9C7LnCdD4SrpyRoyVbzJMQEZqh9w5S//u1t6oKJjFaYKrAg6eolSPlz8AzXTCw
	FOGJCYIaF/8P1KSfPcrj5SFpszUkW2eIPhOGp9mnr9jrV6iU4On2myDiGfWqFxYU
	vmXWrioyaGeRujO7nKzGl6fGT8I3QmyV36MCY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OiJvrPe7EEcFkFou6BiXeKVJCEwCcMRk
	rmmmS3wB6olUrNrQbR3Czbkq3o9LfgcRybTlwQ8NDMarKCg3lViDB/Dc5rvV83ks
	il24Fy6POJXBuXC2t+wc5Fn0fcZHAuahnwFnMCATT17gpRbsVxgruxzPB/iy/261
	d6n753ux01M=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 527724BC92;
	Wed, 22 Apr 2015 15:58:35 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C6F224BC90;
	Wed, 22 Apr 2015 15:58:34 -0400 (EDT)
In-Reply-To: <5537F31D.4090704@web.de> (Jens Lehmann's message of "Wed, 22 Apr
	2015 21:14:37 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F56A7C52-E929-11E4-8EC2-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267630>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Am 21.04.2015 um 23:08 schrieb Junio C Hamano:
>
>> I looked at the test script update.  The new test does (I am
>> rephrasing to make it clearer):
>>
>>      mkdir -p dir/ectory
>>      git init dir/ectory ;# a new directory inside top-level project
>>      (
>>          cd dir/ectory &&
>>          >test && git add test && git commit -m test
>>      )
>>      git add dir/ectory
>>
>> to set it up.  At this point, the top-level index knows dir/ectory
>> is a submodule.
>>
>> Then the test goes on to turn it a non submodule by
>>
>>      mv dir/ectory/.git dir/ectory/dotgit
>> ...
>
> We already do (2) in the cases you describe:
>
>    $ git add subrepo/a
>    fatal: Pathspec 'subrepo/a' is in submodule 'subrepo'
>    $ git -C subrepo add a
>    fatal: Pathspec 'a' is in submodule 'subrepo'
> ...
> So I'd vote to have (2) also for "git -C subrepo add .", which
> is what started this thread.

Does having "mv subrepo/.git subrepo/dotgit" before that "git add"
change your conclusion?

It is very clear to me that without that "mv" step, (2) is
absolutely the right thing to do, and I agree with you.

But it is unclear if we should still do (2) when "subrepo/.git" is
no longer there.  That has to be done manually and it may be an
indication that is clear enough that the end user wants the
directory to be a normal directory without any submodule involved,
in which case it may match the expectation of the user better to
just nuke the corresponding 160000 entry in the index and replace it
with files in there.  I dunno.

>> In my quick test, it appeared that the behaviour with this patch
>> applied was neither of the two and instead to silently do nothing,
>> and if that is the case I think it is quite wrong.
>
> Yep.
