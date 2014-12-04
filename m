From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gc: support temporarily preserving garbage
Date: Thu, 04 Dec 2014 10:04:29 -0800
Message-ID: <xmqq388vuw9e.fsf@gitster.dls.corp.google.com>
References: <1415927805-53644-1-git-send-email-brodie@sf.io>
	<xmqqlhnd1j66.fsf@gitster.dls.corp.google.com>
	<20141117213442.GD15880@peff.net>
	<CADQoFhyxFNzazsEaE6Bk2W_KDhogBho8vgJXkDDPsYvC46ZX5Q@mail.gmail.com>
	<20141204091023.GB27455@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Brodie Rao <brodie@sf.io>, git@vger.kernel.org,
	Bryan Turner <bturner@atlassian.com>,
	Stefan Saasen <ssaasen@atlassian.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 04 19:04:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xwale-0000Ur-RM
	for gcvg-git-2@plane.gmane.org; Thu, 04 Dec 2014 19:04:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751761AbaLDSEi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 13:04:38 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57705 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751589AbaLDSEi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2014 13:04:38 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F07EA219F7;
	Thu,  4 Dec 2014 13:04:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7jX3pEVno8qd67Lt4XdSG2orhjE=; b=jr+fZo
	RhWSmV8Gc8XmseAWWHzdQn23Te0tcBmf/qGWDi1PwuKYTXYQ6hKW8LPyRcSV9ID3
	uQSpC9+toEgM1e2oZbpDB+1PRLC8lyYq9kvkmsO6CG5S75/fxtrHe8cnHZTDwaI0
	dKQJPl3/twxZ3rLIWF+kr9kmd9XG9bO6n3PaE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TPurVwldYDCEAAPqZuAm4GwYxDO2U7EZ
	F48EYS0SX4iVLj5vzYmoS7toMZwGcPmip/sZ5+lEc4diMa3clPn9VM/p2G2levt4
	RwRrLcQ+zXRE0cjPOzvDqwZNt6VbomPF6A5jXrpq0fuNfGn8JF4KNTqOjYgwoYFV
	P6ga7PYCI/g=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E5528219F2;
	Thu,  4 Dec 2014 13:04:35 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2AED2219DA;
	Thu,  4 Dec 2014 13:04:31 -0500 (EST)
In-Reply-To: <20141204091023.GB27455@peff.net> (Jeff King's message of "Thu, 4
	Dec 2014 04:10:23 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: FEDF25B0-7BDF-11E4-9A3A-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260772>

Jeff King <peff@peff.net> writes:

> On Wed, Dec 03, 2014 at 01:21:03PM -0800, Brodie Rao wrote:
>
>> > I think it is also not sufficient. This patch seems to cover only
>> > objects. But we assume that we can atomically rename() new versions of
>> > files into place whenever we like without disrupting existing readers.
>> > This is the case for ref updates (and packed-refs), as well as the index
>> > file.  The destination end of the rename is an unlink() in disguise, and
>> > would be susceptible to the same problems.
>> 
>> I'm not aware of renaming over files happening anywhere in gc-related
>> code. Do you think that's something that would need to be addressed in
>> the rest of the code base before going forward with this garbage
>> directory approach? If so, do you have any suggestions on how to
>> tackle that problem?
>
> As an example, if you run "git pack-refs --all --prune" (which is run by
> "git gc"), it will create a new pack-refs file and rename it into place.
> Another git program (say, "git for-each-ref") might be reading the file
> at the same time. If you run pack-refs and for-each-ref simultaneously
> in tight loops on your problematic NFS setup, what happens?
>
> I have no idea if it breaks or not. I don't have such a misbehaving
> system, and I don't know how rename() is implemented on it. But if it
> _is_ a problem of the same variety, then I don't see much point in
> making an invasive fix to address half of the problem areas, but not the
> other half (i.e., if we are still left with a broken git in this setup,
> was the invasive fix worth the cost?).
>
> If it is a problem (and again, I am just guessing), I'd imagine you
> would need a similar setup to what you proposed for unlink(): before
> renaming "packed-refs.lock" into "packed-refs", hard-link it into your
> "trash" area. And you'd probably want to intercept rename() there, to
> catch all places where we use this technique.

Also we need to take it into account that it is not an issue unique
to Git that the server side may expire these .nfsXXXXX entries left
by an NFS client ("silly rename") to keep files that have been
removed or renamed away alive.  Aren't there a knob on the NFS
server end to control how long these are kept unexpired to avoid
stale filehandle errors, so that not just Git but all applications
running on NFS client machines will not be hurt by it?

Working it around at the application program level for each and
every application that runs on a machine that can NFS mount
filesystems from elsewhere may be simply madness, no?
