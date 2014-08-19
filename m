From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] git-imap-send: use libcurl for implementation
Date: Tue, 19 Aug 2014 10:13:35 -0700
Message-ID: <xmqq61howgg0.fsf@gitster.dls.corp.google.com>
References: <53EA8C3E.1080500@raz.or.at> <20140813015917.GA30756@google.com>
	<20140817083022.GJ23808@peff.net> <53F0A66A.9000909@raz.or.at>
	<20140817184252.GB2200@peff.net> <53F33183.80802@raz.or.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
	git@vger.kernel.org, 434599@bugs.debian.org
To: Bernhard Reiter <ockham@raz.or.at>
X-From: git-owner@vger.kernel.org Tue Aug 19 19:13:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJmyk-0001zI-Od
	for gcvg-git-2@plane.gmane.org; Tue, 19 Aug 2014 19:13:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752505AbaHSRNq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2014 13:13:46 -0400
Received: from smtp.pobox.com ([208.72.237.35]:61215 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751653AbaHSRNp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2014 13:13:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 355513257A;
	Tue, 19 Aug 2014 13:13:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Bev/zb7Jkcnltc0ieaV9IU9Uc24=; b=Rcg7XW
	c6igMR80UEhkFqIABRAhqcfEW5Q5BDpgr6Q0oUKq2NOcIB0tkaYIur7iy+i8UZI5
	rEZ/DSTKkcDJP67LEFXhheH397Xk35NIQdrl00ohBaLAspUOKZK9rPnDLUBnBW+B
	MOD6nt30W4rYqcGAcyC90xovvSwRudyxSmnf0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yQ7nqE/zf/yW8wY/kePLW6B50U2nks7u
	sz6Ma83DDs2KS/r4F4qFmBAjBQQQZ+hqy0/o6kUtWEUAHBsMmxDpMYVVlNxRIYFk
	hYEkWsfNCNgu1wX2/HZe17ZXD+prhLOgUHWMY3rBnw9ezx4s3oqw7ONyAgfqEHGF
	mVGMgDZgUW4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2BB8532579;
	Tue, 19 Aug 2014 13:13:45 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 0CA643256D;
	Tue, 19 Aug 2014 13:13:36 -0400 (EDT)
In-Reply-To: <53F33183.80802@raz.or.at> (Bernhard Reiter's message of "Tue, 19
	Aug 2014 13:14:11 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 284522E4-27C4-11E4-B078-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255503>

Bernhard Reiter <ockham@raz.or.at> writes:

> Am 2014-08-17 um 20:42 schrieb Jeff King:
>> [...]
>> 
>>>> I'm not sure I understand this comment. Even if SSL is not in use,
>>>> wouldn't we be passing a regular pipe to curl, which would break?
>>>
>>> Yeah, we can't do that, and thus would have to keep the handwritten IMAP
>>> implementation just for the tunnel case (allowing to drop only the
>>> OpenSSL specific stuff), see my other email:
>>> http://www.mail-archive.com/git@vger.kernel.org/msg56791.html (the
>>> relevant part is pretty far down at the bottom).
>> 
>> I'd really love it if we could make this work with tunnels and
>> eventually get rid of the hand-written imap code entirely. I agree with
>> Jonathan that we probably need to keep it around a bit for people on
>> older curl, but dropping it is a good goal in the long run. That code
>> was forked from the isync project, but mangled enough that we could not
>> take bug fixes from upstream. As not many people use imap-send, I
>> suspect it is largely unmaintained and the source of many lurking
>> bugs[1]. Replacing it with curl's maintained implementation is probably
>> a good step.

I would agree with s/a good step/a good goal/ ;-)

> I'll work on this as soon as I find some time, but as that will include
> changes to run-command.c (and possibly other files?), I'd like to cover
> that in a commit of its own. Do you guys think the current patch [1] is
> good enough for "official" submission already?

My impression from reading the discussion in this thread has been
that the patch that started this thread would break the tunneling
code, i.e. is not there yet.  Or did you mean some other patch?

The other patch $gmane/255403 from you looked good and I think I
already have a copy queued on 'pu' as f9dc5d65 (git-imap-send:
simplify tunnel construction, 2014-08-13).

Thanks.


[References]

*$gmane/255403*
    http://thread.gmane.org/gmane.comp.version-control.git/255220/focus=255403
