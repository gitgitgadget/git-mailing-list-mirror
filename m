From: Jim Meyering <jim@meyering.net>
Subject: Re: [PATCH] git-log: detect dup and fdopen failure
Date: Wed, 27 Jun 2007 16:06:06 +0200
Message-ID: <87zm2lmr01.fsf@rho.meyering.net>
References: <87wsxpobf0.fsf@rho.meyering.net>
	<81b0412b0706270548p6f694fd6x5f47cbefa16c08ac@mail.gmail.com>
	<87r6nxo8iq.fsf_-_@rho.meyering.net>
	<EF53B249-8430-4700-81AE-B97FD49FB955@adacore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Alex Riesen" <raa.lkml@gmail.com>, git@vger.kernel.org
To: Geert Bosch <bosch@adacore.com>
X-From: git-owner@vger.kernel.org Wed Jun 27 16:06:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3YA3-0000ba-RS
	for gcvg-git@gmane.org; Wed, 27 Jun 2007 16:06:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753842AbXF0OGK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Jun 2007 10:06:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752925AbXF0OGJ
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jun 2007 10:06:09 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:33195 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752933AbXF0OGH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jun 2007 10:06:07 -0400
Received: from mx.meyering.net (mx.meyering.net [82.230.74.64])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 7A2FD5A2CD;
	Wed, 27 Jun 2007 16:06:06 +0200 (CEST)
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id 52BE52A226; Wed, 27 Jun 2007 16:06:06 +0200 (CEST)
In-Reply-To: <EF53B249-8430-4700-81AE-B97FD49FB955@adacore.com> (Geert Bosch's message of "Wed\, 27 Jun 2007 09\:54\:57 -0400")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51046>

Geert Bosch <bosch@adacore.com> wrote:

> On Jun 27, 2007, at 09:02, Jim Meyering wrote:
>> -	if (!use_stdout)
>> -		realstdout = fdopen(dup(1), "w");
>> +	if (!use_stdout) {
>> +		int fd = dup(1);
>> +		if (fd < 0 || (realstdout = fdopen(fd, "w")) == NULL)
>> +			die("failed to duplicate standard output: %s",
>> +			    strerror(errno));
>> +	}
>
> This makes the code unreadable! A great way to ruin
> perfectly fine code is to add tons of error checking.
> The error checking is likely wrong (detects non-errors,
> or fails to detect real ones), and for sure makes code
> untestable  and unreadable.
>
> If we really case about catching such errors, write
> the code as:
> 	if (!use_stdout)
> 		realstdout = xfdopen(dup(1), "w");

Of course.  That is much more readable.
Though, perhaps you meant this?

> 		realstdout = xfdopen(xdup(1), "w");

If so, I'll be happy to prepare a patch to do that instead.
IMHO, we should never ignore syscall errors, and when preparing a
patch for a project like git (to which I haven't contributed much yet),
I prefer to keep the initial patch small and localized.

> where xfdopen is a wrapper around fdopen that dies in
> case of an error. This follows a practice we use elsewhere,
> and only adds one character to the code and only affects
> readability very slightly.
>
>> Without this, if you ever run out of file descriptors, dup will
>> fail (silently), fdopen will return NULL, and fprintf will
>> try to dereference NULL (i.e., usually segfault).
>
> As it is unlikely the failure mode will ever occur in practice,
> any way of aborting is fine. Even SIGSEGV would do: it would be
> trivial to find that we were leaking file descriptors or are out
> of memory. Oh, wait, that means we don't need any checking code
> at all...

Aren't you presuming the problem is easily reproducible
(and encountered by someone capable of investigating/reproducing),
or maybe that the abort left a usable core dump behind?

In my experience, the hardest bugs to track down are those
that are very rare and hard to reproduce.
