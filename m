From: Junio C Hamano <gitster@pobox.com>
Subject: Re: RFC: git cat-file --follow-symlinks?
Date: Thu, 30 Apr 2015 13:05:40 -0700
Message-ID: <xmqqoam5xtyj.fsf@gitster.dls.corp.google.com>
References: <1430341032.14907.9.camel@ubuntu>
	<xmqqlhha4otr.fsf@gitster.dls.corp.google.com>
	<1430343059.14907.18.camel@ubuntu> <20150429214817.GA2725@peff.net>
	<1430346576.14907.40.camel@ubuntu> <20150429231150.GB3887@peff.net>
	<20150430003750.GA4258@peff.net> <1430355983.14907.55.camel@ubuntu>
	<20150430011612.GA7530@peff.net> <1430358345.14907.62.camel@ubuntu>
	<20150430033725.GB12361@peff.net> <1430421924.22711.57.camel@ubuntu>
	<xmqqegn1z9fp.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, David Turner <dturner@twopensource.com>
To: git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 30 22:05:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YnuiR-0001cn-98
	for gcvg-git-2@plane.gmane.org; Thu, 30 Apr 2015 22:05:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752843AbbD3UFo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Apr 2015 16:05:44 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51190 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752680AbbD3UFn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Apr 2015 16:05:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 48A2F4E309;
	Thu, 30 Apr 2015 16:05:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DiZDXIgMO9QC85RgTC6X+t2DFW0=; b=NQWeey
	PN8N0QBM15hGKGBdXmOuUlvRVa3euldbA0Fo+nRHk5Lwgl7e8tsuU+wUN/+NcdyE
	G6dXaqnnIH51OwewoLHL8/eoufZ81xxGMkQ4TMyO8NGpef5zIIFtiftJe1Q9Tyhc
	kUnx2EwzfbtjSX4FfdzEmmgOfQy+Fkp3Tl4SY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dMETbZXyA6fmhVvaVwMxRnovFtDQ/aND
	m32267S6mLvnp/ORa/0PoOLJp3pFQ0h2pC5nYcqE6oQw0zmzPwk73RaEfTDddJWu
	kY4sC3PjUSNktUrFGREhdbrzgnX18F8O5FFLXRWi2bo6y5qu9f0dbKQef6vwa+r7
	q8O9NEZdvqs=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 415C54E308;
	Thu, 30 Apr 2015 16:05:42 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B98DC4E307;
	Thu, 30 Apr 2015 16:05:41 -0400 (EDT)
In-Reply-To: <xmqqegn1z9fp.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 30 Apr 2015 12:46:02 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4733479E-EF74-11E4-A2F3-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268103>

Junio C Hamano <gitster@pobox.com> writes:

> ... In other words, ^{resolve} that is not followed by a
> colon and path is something entirely different from what we have
> been discussing.

Having said that, I am not saying that such an alternative "follow
symbolic links in many other places" is a worthless suggestion.

It just does not work as an extended SHA-1 syntax.

    git rev-parse HEAD^{resolve}:RelNotes HEAD:Documentation

would make sense; RelNotes, if it were a symbolic link, is resolved,
while Documentation will never be.  On the other hand

    git log next^{resolve} master -- Documentation

will not make any sense, as it is a totally conflicting request.
Does it resolve symlinks only when encountering a commit that the
traversal that started from 'next' happened to have reached before
the traversal from 'master' got there?  What should happen for
commits that are reachable from both?

So even if (and this is a big if) such an "aggressive symlink
following" mode were useful for some commands, I think the switch
belongs to the command, not the per-object syntax.
