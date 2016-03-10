From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug: git branch -D can be used to delete branch which is currently checked out
Date: Thu, 10 Mar 2016 10:23:26 -0800
Message-ID: <xmqqfuvydwf5.fsf@gitster.mtv.corp.google.com>
References: <CE5AE06C-0909-414E-B901-7CCF3A259465@gmail.com>
	<xmqqvb4udyf9.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Marcus Kida <marcus.kida@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 10 19:23:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ae5FF-0004gb-WC
	for gcvg-git-2@plane.gmane.org; Thu, 10 Mar 2016 19:23:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754291AbcCJSX3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2016 13:23:29 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:54797 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753458AbcCJSX3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2016 13:23:29 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DC2B04A438;
	Thu, 10 Mar 2016 13:23:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gcOzmRAISb6ARWVs9xURhh7QAAk=; b=HYHwXz
	G50S0/KQ9kqPMLPQ3IIJoBUaRon3H4RgtdKKhercCLFCaLwMC5XBUzFHK9wdFckN
	/Er1s2a7KiLTYlSnG0f6hEKA503u6hNv5EeIuyhMp2gxR5VaB5J57lDPKyiTC373
	ZUGLuI1j5PWzlfGUYQ5O1hYRjKp5uE3y1zRLQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BT4TqqDvjD4DL+IDoGd2B7Gtwb8EhoXZ
	dKCOhJbBFWcu9/6pIeOwHpfZX/ex2nLxgbHkRlyvfIEnp6yOsZlgxpdkY2tUJIiO
	Iti12XRvzFE9xL7OGhSrhEksNkhBO8UMy2+fVOD5DhbLsQT6xnyNCZYEw41n6rGf
	SEqv+l9zZeo=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D36EF4A437;
	Thu, 10 Mar 2016 13:23:27 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 45E764A435;
	Thu, 10 Mar 2016 13:23:27 -0500 (EST)
In-Reply-To: <xmqqvb4udyf9.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Thu, 10 Mar 2016 09:40:10 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2EE3C81E-E6ED-11E5-90BB-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288631>

Junio C Hamano <gitster@pobox.com> writes:

> It is a possibility to teach the files backend of refs API that some
> filesystems are case insensitive and do something special about them,
> but I think in the longer term a more productive solution would be
> to use the upcoming "pluggable ref backend" subsystem and either
>
>  - use a backend that is not the "files" backend (e.g. lmdb backend,
>    or the tree-object based backend);
>
>  - add a variant of "files" backend but encodes the refnames in a
>    way that is safe on case insensitive filesystems.

A typofix s/but encodes/that encodes/ is needed to make this
sentence make any sense.  Sorry for a typo.

Just to elaborate a bit more, here is what I mean:

 - Thanks to recent work by David, Ronnie and Michael, we eradicated
   most if not all code that assume that the result of checking
   "test -f .git/refs/heads/foo" tells us if a branch 'foo' exists
   [*1*].  They all go through the API designed to allow different
   backends to access refs.

 - The traditional code that implemented 'foo' branch as writing a
   file '.git/refs/heads/foo' has been moved to a "files" backend.
   When used on a platform with case insensitive filesystem, it can
   answer "it exists" when asked about a branch 'Foo' (notice the
   case difference).

 - We could add a new backend that is still based largely on the
   existing "files" backend code, but stores 'foo' branch as a file
   ".git/refs/6865616473/666f6f" while storing another branch 'Foo'
   as ".git/refs/6865616473/466f6f" (I just used byte values in hex
   in this example, but of course you can use a more efficient and
   mostly human readable representations).

That way, even on a platform with case insensitive filesystem, you
do not have to worry about getting confused by the filesystem when
you have 'foo' and 'Foo' branches.


[Footnote]

*1* This is not strictly true even in the pre-pluggable ref backend
    world, as your refs may appear in the packed-refs file, but this
    detail does not matter in the larger picture.
