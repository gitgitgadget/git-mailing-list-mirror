From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Add the tag.gpgsign option to sign all created tags
Date: Sun, 20 Mar 2016 22:50:48 -0700
Message-ID: <xmqq7fgwnzuv.fsf@gitster.mtv.corp.google.com>
References: <20160319182310.GA23124@spk-laptop>
	<20160320042912.GD18312@sigill.intra.peff.net>
	<20160320150703.GB5139@spk-laptop>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Laurent Arnoud <laurent@spkdev.net>
X-From: git-owner@vger.kernel.org Mon Mar 21 06:51:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahsk2-0006Xb-VF
	for gcvg-git-2@plane.gmane.org; Mon, 21 Mar 2016 06:51:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751676AbcCUFuy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2016 01:50:54 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:53621 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751623AbcCUFuw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2016 01:50:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 94CCF46432;
	Mon, 21 Mar 2016 01:50:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NZC2kVjMwjHu1MP8s4hX4sTVHN0=; b=cx8cWC
	Nz2tGDss1/0n9ZNJGEwaqEUD6grrBHDt2RLXIPhisl7f2YojoLq9itCUDJWHct45
	dk6dmTMiEVxeSWXVSJrPSHwNOzlCJL5IosKlCdtfn/nDh4/AIRHpR+DJrNfTHDZi
	Flb6vygG9IjEHVjsdNtTsqzUnM7VQdpcTA1PU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iIR/owGOOm0KFHYPtfGZX/0D8ZzR2alu
	yvgNoZPN1EIvwERdapQDa6KarOIvjyXQNGOkCU+aBW6i10vLqMh4QWbVVrIWjwvq
	B6eq2m6Z46QzIQA90nDZluJLBGiw6j+xFr/DQ7eAVN7FeiWzXM8fsgGRjP3F6CLz
	/YrRttv09JA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8213146431;
	Mon, 21 Mar 2016 01:50:50 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id ECF8046430;
	Mon, 21 Mar 2016 01:50:49 -0400 (EDT)
In-Reply-To: <20160320150703.GB5139@spk-laptop> (Laurent Arnoud's message of
	"Sun, 20 Mar 2016 16:07:03 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: DD938208-EF28-11E5-A55F-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289403>

Laurent Arnoud <laurent@spkdev.net> writes:

> The `tag.gpgsign` config option allows to sign all
> commits automatically.

I presume that you meant "all annotated tags" here.  But I am not
sure it this is sensible.

> Support `--no-sign` option to countermand configuration `tag.gpgsign`.

That sound quite counter-intuitive.

    $ git tag -s -m "my message" v1.0

is an explicit request to create a signed tag, as opposed to


    $ git tag -a -m "my message" v1.0

is an explicit request to create an unsigned annotated tag.  So 

I think a short-hand

    $ git tag -m "my message" v1.0

falls back to annotated and not signed tag, and I can understand
if the patch is about allowing the user to tweak this fallback to
create signed tag instead.

So I do not see why you need a new --no-sign option at all.  If
you have the configuration and you do want to create an unsigned
annotated tag one-shot, all you need is to explicitly ask for "-a"
i.e.

    $ git tag -a -m "my message" v1.0

isn't it?

If you are forcing users to always leave a message and then further
forcing users to always sign with the single new configuration, i.e.

    $ git tag v1.0
    ... opens the editor to ask for a message ...
    ... then makes the user sign with GPG ...

then I would first have to say that is a bad idea.

I can sort-of understand (but do not necessarily agree that it is a
good idea) adding new two configurations, i.e.

 - "even without -a/-s, force the user to annotate the tag" is one
   configuration, and

 - "even when the user did not say -s, force the user to sign an
   annotated tag" is the other.

And with such a system, I can see why you would need an option
"--lightweight" to force creation of a light-weight tag (i.e. to
countermand the first one).  You can view this new option as
something that sits next to existing -a/-s.  The current system lets
user choose among the three variants (lightweight, annotated and
signed) by not giving any, giving -a, and giving -s option
respectively, but with the "--lightweight" option, the user can ask
for one of the three explicitly, as opposed to using "lack of either
-a/-s" as a signal to create lightweight one.

And in the context of such a system, "--no-sign" may make sense to
override the second configuration (i.e. "force the user to sign an
annotated tag").

But otherwise, adding only "--no-sign" does not make much sense to
me, as it implies "not signing always means annotated", which is not
true.  It is unclear between lightweight and annotated which one the
user who says "--no-sign" really wants.
