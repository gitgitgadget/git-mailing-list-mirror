From: Jim Meyering <jim@meyering.net>
Subject: Re: [PATCH] git-log: detect dup and fdopen failure
Date: Wed, 27 Jun 2007 15:32:30 +0200
Message-ID: <87d4zho74h.fsf@rho.meyering.net>
References: <87wsxpobf0.fsf@rho.meyering.net>
	<81b0412b0706270548p6f694fd6x5f47cbefa16c08ac@mail.gmail.com>
	<87r6nxo8iq.fsf_-_@rho.meyering.net>
	<81b0412b0706270618p850df2dy41b2b797d82e3276@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 27 15:32:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3XdL-0000FP-I9
	for gcvg-git@gmane.org; Wed, 27 Jun 2007 15:32:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756254AbXF0Nce (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Jun 2007 09:32:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755645AbXF0Ncd
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jun 2007 09:32:33 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:58286 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755325AbXF0Ncd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jun 2007 09:32:33 -0400
Received: from mx.meyering.net (mx.meyering.net [82.230.74.64])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 64EAB5A2BD;
	Wed, 27 Jun 2007 15:32:32 +0200 (CEST)
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id D5E142C018; Wed, 27 Jun 2007 15:32:30 +0200 (CEST)
In-Reply-To: <81b0412b0706270618p850df2dy41b2b797d82e3276@mail.gmail.com> (Alex Riesen's message of "Wed\, 27 Jun 2007 15\:18\:47 +0200")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51041>

"Alex Riesen" <raa.lkml@gmail.com> wrote:

> On 6/27/07, Jim Meyering <jim@meyering.net> wrote:
>> I didn't see that fdopen could fail with ENOMEM.
>> That'll teach me to trust the man page.  I see POSIX does mention it.

s/trust/use/ :)

> I wouldn't trust Linux man pages nor POSIX, if I were you.

Ha.  Normally I don't rely solely on the man pages.

> Check if this works in some exotic but common
> environments (like MacOSX, Cygwin or HP-UX).

What do you mean?
I know that dup and fdopen work in those environments.

> (And yes, they probably are broken, and no, you can't fix them,
> and no, people are not going to stop using them).
>
>> +       if (!use_stdout) {
>> +               int fd = dup(1);
>> +               if (fd < 0 || (realstdout = fdopen(fd, "w")) == NULL)
>> +                       die("failed to duplicate standard output: %s",
>> +                           strerror(errno));
>> +       }
>
> Kinda stuffed in here. What's wrong with plain

It's ok, but for the fact that when dup fails, all you get
is the uninformative EINVAL from fdopen.

>  realstdout = fdopen(dup(1), "w");
>  if (!realstdout)
>    die("%s", strerror(errno));
>
> (Yes, I do think that "duplicate standard output" is useless,
> except for debugging. Exactly as strerror is, but that is shorter).

I like to include *something* in the diagnostic so that when someone
sees it and reports it developers have an easier time finding where it
comes from in the code.  Especially with something as unlikely (and hard
to reproduce) as this, that might be useful.
