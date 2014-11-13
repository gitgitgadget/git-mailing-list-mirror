From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git archiving only branch work
Date: Thu, 13 Nov 2014 13:48:12 -0800
Message-ID: <xmqq61eizs9v.fsf@gitster.dls.corp.google.com>
References: <5464a4e8.4a0.2bfa0e00.3067f800@geldenhuys.co.uk>
	<20141113133615.GA28346@lanh> <20141113200640.GB3869@peff.net>
	<xmqqvbmizu12.fsf@gitster.dls.corp.google.com>
	<20141113213318.GA7563@peff.net>
	<xmqqa93uzssv.fsf@gitster.dls.corp.google.com>
	<20141113213937.GD7563@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>,
	Graeme Geldenhuys <mailinglists@geldenhuys.co.uk>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 13 22:49:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xp2GL-0003EP-4x
	for gcvg-git-2@plane.gmane.org; Thu, 13 Nov 2014 22:49:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754108AbaKMVtE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2014 16:49:04 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62792 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753950AbaKMVtC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2014 16:49:02 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 538191DD84;
	Thu, 13 Nov 2014 16:49:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nPikBoeEownf6qkBouXT5Bq+5bk=; b=WRe0Mv
	kICIFmFdL80PTVgHGjIC7TWBV8LF3OyGG2IXSkA/Wk8E0wUkGud9M35WsNT00buj
	L5MpXRPXFnQL3eLyeXJLZhEyNqP5yKzrcuphLs069KLiZx3GW9Z5gLbi+Qsqo8Rw
	ZonevaM/EwpEMgK+myFLGVhkpkpuKDa/azEVo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TQPrOi91nfxO7GvuorUh2itaDi3RhvDJ
	i5V0q7Xtp4RjyCtfshjfpUdvVx/l3KMbVk+qtYI8xRzj2iJtw6DtLi4MzSqoTewn
	GBa2wTKcT8LBe9CwvFUmnZwXjTXcIKKsofhNdUpll0o/k9JwUH20mhSIBzJMzesb
	qKlDvdqBJB0=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4A7721DD83;
	Thu, 13 Nov 2014 16:49:01 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1BC4A1DD39;
	Thu, 13 Nov 2014 16:48:13 -0500 (EST)
In-Reply-To: <20141113213937.GD7563@peff.net> (Jeff King's message of "Thu, 13
	Nov 2014 16:39:38 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C455255A-6B7E-11E4-A8BE-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I agree they are technically orthogonal, but I cannot think of a case
> where I have ever generated actual _pathspecs_, which might have
> wildcards, and needed to use "-z". The point of using "-z" is that you
> do not know what crap you are feeding.

You do not have to generate, i.e. you should be allowed to do this:

    $ git cmd --stdin -z <list-of-patterns

And this is not about "flexibility".  Unless your plan is to forbid
a corner case you do not anticipate and always disable pathspec
globbing, you would need to say something like:

	--literal-pathspecs::

        	All Git command lines take dashed options first and
		then revs and then "pathspecs".  They are usually
		used to select the paths using glob(1)-like
		matching, but with this option they must match the
		paths byte-for-byte.

                Except when "--stdin -z" is used, in which case you
                need to give "--no-literal-pathspecs" if you want to
                feed patterns.

Which is awkward.  And "--stdin -z" is most likely used in scripts;
we are not forcing people to keep typing --literal-pathspecs by
leaving them orthogonal *and* people do not have to remember one
more exception (the default of --literal-pathspecs is flipped only
when --stdin -z is in use) to the rule.
