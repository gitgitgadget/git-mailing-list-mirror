From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Apr 2014, #09; Tue, 29)
Date: Tue, 06 May 2014 17:01:59 -0700
Message-ID: <xmqqd2fqcv7s.fsf@gitster.dls.corp.google.com>
References: <xmqq7g67iwxc.fsf@gitster.dls.corp.google.com>
	<20140505184546.GB23935@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed May 07 02:02:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WhpJK-0003iH-H6
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 02:02:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752113AbaEGACG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2014 20:02:06 -0400
Received: from smtp.pobox.com ([208.72.237.35]:60483 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750904AbaEGACE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2014 20:02:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 10EAB15545;
	Tue,  6 May 2014 20:02:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oVeJsQiEktDSBhF9FK2Bds2UpGE=; b=cPomZa
	i2pJwsXf643S51LBqr8qsjnowGstVaHg0gIu3Fve4iJqm12cbX9thNrqyCyEQrpl
	riQOunO3saDzjYTi6JJDq93XeldRraYfO5af7ripayl7pKQO6U1WJ32arVB6LQaS
	vE7hOKVc55ne0jG4zdjnSV7pZLwwy8YNV/I8g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=A/Z3vmffSa3gNbJywmUylb4GjjaKUzN5
	y8ydZZloPXrBjDTgaieUcqryBuRX8rGS5eq51Pri86L1UkZ9XrQ3gJGGgxsTRLlA
	hVIlfsE7FBqjDn7G6vI3yj/J85/MUHCqTmjFJlL0RnEU6WpigOWkniYdW/50raMn
	ett9ncR8now=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0275715541;
	Tue,  6 May 2014 20:02:04 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 7D9E215534;
	Tue,  6 May 2014 20:02:01 -0400 (EDT)
In-Reply-To: <20140505184546.GB23935@serenity.lan> (John Keeping's message of
	"Mon, 5 May 2014 19:45:46 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D0BC2D74-D57A-11E3-920D-9CEB01674E00-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248272>

John Keeping <john@keeping.me.uk> writes:

> I'd like to register my opposition to moving git-remote-{bzr,hg} out of
> contrib/.
>
> I am not convinced that tools for interoperating with other VCSs need to
> be part of core Git; as Junio has pointed out previously, while contrib/
> was necessary ... Associated tools can
> therefore live on their own and do not need to be promoted as part of
> Git itself (as git-imerge is doing successfully).

Another thing to keep in mind is that we need to ensure that we give
a good way for these third-party tools to integrate well with the
core Git tools to form a single toolchest for the users.  I would
love to be able to do

    $ (cd git.git && make install)
    $ (cd git-imerge.git && make install)

and then say "git imerge", "git --help imerge", etc.  The same for
the remote helpers that we may be splitting out of my tree into
their own stand-alone projects.

I _think_ it probably is OK for git-imerge.git/Makefile to peek into
our Makefile, e.g.

    $ cd git-imerge.git
    $ make GIT_SOURCE_DIR=../git.git install

to learn where imerge should install its subcommand implementation
and documentation.  It might even want to borrow the test framework
by using $GIT_SOURCE_DIR/t/test-lib.sh or somesuch.  There may be
some changes the third-party tool authors would want to have in our
Makefile to help them better when building their tools this way; I
dunno.

I also think that there should be a way to make it really easy to
install these third-party tools to augment the installed version of
Git without having the source tree of Git.  We have ways for them to
ask us where things are expected to be, e.g.

    $ git --html-path
    $ git --man-path
    $ git --exec-path

but I am not sure if these are enough, or if it would help them to
add a bit more, then what these "a bit more" are.
