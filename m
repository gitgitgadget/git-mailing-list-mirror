From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git status / git diff -C not detecting file copy
Date: Tue, 02 Dec 2014 09:57:07 -0800
Message-ID: <xmqqvblukk98.fsf@gitster.dls.corp.google.com>
References: <CAJxwDJzzNV77cTP4nbzgCvFjjqp3C4X8d3j6uwhYvK4+g4r1YQ@mail.gmail.com>
	<CAGyf7-E_y8zRUKh5RWvAhPXzSgpnVab6e=e1v92rSVVxf+LNJg@mail.gmail.com>
	<CAJxwDJzxUEd3czHpwDtKaERKDhvyCGOzGbKO4X9z44ugTJ2q4w@mail.gmail.com>
	<CAGyf7-F9twCEUY-LN=xEf4=gfNW8oLEHJmTjHRQ2MncHZ2emZQ@mail.gmail.com>
	<20141202065550.GB1948@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Bryan Turner <bturner@atlassian.com>,
	Pol Online <info@pol-online.net>,
	Git Users <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 02 18:57:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvrhO-0006lv-L2
	for gcvg-git-2@plane.gmane.org; Tue, 02 Dec 2014 18:57:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932784AbaLBR5N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2014 12:57:13 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58505 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932778AbaLBR5M (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2014 12:57:12 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A217623F2A;
	Tue,  2 Dec 2014 12:57:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=W3qXsuXn6fXsDZj2SW+qsWkkjG8=; b=LBdEQ8
	CUDSjVtHIVjo6EBBLiLMluG3Pt9E+qAOdsdYPmSmTeJAvwuyIzRstqCmk+mOxRjG
	/nVv1rYg4E/IpbPr4ZMNbJQxgsUr5b25Cq+wkX0SJn3y5lyqJlfv8+/zGuup5oZJ
	8I+bK28MvOq2L0xZj8Ymt7YoWNhmBDg5y/T7k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=e4zE2g70hJVHJbJmIu5osWa6N5tu7tzT
	rdBTuKb/ty7LFmZeW7fX1wh8rs5Fyb82JYNWrciBzPav6E3javIyBauIQg0cSFkF
	os1mllECQD5ZZFxALOSPXyesAI2TPqP5XI/+ywj6twbiZ+BS6sY7r+xmN69E1p23
	+a5Ev52hsPU=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9125923F28;
	Tue,  2 Dec 2014 12:57:11 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D2D4B23F23;
	Tue,  2 Dec 2014 12:57:09 -0500 (EST)
In-Reply-To: <20141202065550.GB1948@peff.net> (Jeff King's message of "Tue, 2
	Dec 2014 01:55:50 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A30083F4-7A4C-11E4-9682-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260587>

Jeff King <peff@peff.net> writes:

> Interestingly, the rename behavior dates all the way back to:
>
>   commit 753fd78458b6d7d0e65ce0ebe7b62e1bc55f3992
>   Author: Linus Torvalds <torvalds@ppc970.osdl.org>
>   Date:   Fri Jun 17 15:34:19 2005 -0700
>
>   Use "-M" instead of "-C" for "git diff" and "git status"
>   
>   The "C" in "-C" may stand for "Cool", but it's also pretty slow, since
>   right now it leaves all unmodified files to be tested even if there are
>   no new files at all.  That just ends up being unacceptably slow for big
>   projects, especially if it's not all in the cache.
> ...
> To get a rough sense of how much effort is entailed in the various
> options, here are "git log --raw" timings for git.git (all timings are
> warm cache, best-of-five, wall clock time):

The rationale of the change talks about "big projects" and your
analysis and argument to advocate reversion of that change is based
on "git.git"?  What is going on here?

Also our history is fairly unusual in that we do not have a lot of
renames (there was one large "s|builtin-|builtin/|" rename event,
but that is about it), which may not be a good example to base such
a design decision on.

It is a fine idea to make this configurable ("status.renames = -C"
or something, perhaps?), though.
