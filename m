From: Fredrik Medley <fredrik.medley@gmail.com>
Subject: Re: [PATCH] rebase-i-exec: Allow space in SHELL_PATH
Date: Fri, 13 Nov 2015 23:47:40 +0100
Message-ID: <CABA5-zmmKeeDDhSdan9sTppRVeDNuPiR8WX=P4Umdbq=ELafqw@mail.gmail.com>
References: <1447394599-16077-1-git-send-email-fredrik.medley@gmail.com>
 <20151113062534.GE32157@sigill.intra.peff.net> <CABA5-zk+RVBxfmuLyK8CcCFUpMXEzbHRKeWWV2SKsJqjnG-nfA@mail.gmail.com>
 <20151113222748.GA14830@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Users <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 13 23:48:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZxN91-0002AG-WC
	for gcvg-git-2@plane.gmane.org; Fri, 13 Nov 2015 23:48:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751167AbbKMWsB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Nov 2015 17:48:01 -0500
Received: from mail-oi0-f45.google.com ([209.85.218.45]:34069 "EHLO
	mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750872AbbKMWsA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Nov 2015 17:48:00 -0500
Received: by oies6 with SMTP id s6so58349596oie.1
        for <git@vger.kernel.org>; Fri, 13 Nov 2015 14:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Rp4XCYPuD2nNGnryNqnK3KGWCSYxVgPEe8YF87oeY24=;
        b=Xs7rsyKSNTG0olNby0wV0+zPkS/2no6YK5LQpAz6kKrbuPVRAySrmNS4ZqqGtsuJsR
         sGzx50+/pE5itoVYYMHDDZIfJCDzoUNmMkEs97DwHgTj6JZLmF9OZmw19sX67OsU8WYY
         YMLLDThQekaKXc3uaM6z5wgH5HFAiVf+uszjKg30zStbdkKbSCQU4hgYeVQTEQr+PPnO
         ftsB1mpKh19NOCozLqqkaECFM4FQdZ2kyTFT7QoR318gvm0ixIkpn+iNJWsfnaiOl7tu
         GJpyEnkt77Tl6y0QXgJyTOLZ32xeXyReifDzf1JZUQV0zH8wy41NXFXG+tZDv63TZdr9
         181w==
X-Received: by 10.202.195.132 with SMTP id t126mr13364463oif.117.1447454879622;
 Fri, 13 Nov 2015 14:47:59 -0800 (PST)
Received: by 10.202.97.196 with HTTP; Fri, 13 Nov 2015 14:47:40 -0800 (PST)
In-Reply-To: <20151113222748.GA14830@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281268>

2015-11-13 23:27 GMT+01:00 Jeff King <peff@peff.net>:
> On Fri, Nov 13, 2015 at 04:25:18PM +0100, Fredrik Medley wrote:
>
>> >> -             ${SHELL:-@SHELL_PATH@} -c "$rest" # Actual execution
>> >> +             "${SHELL:-@SHELL_PATH@}" -c "$rest" # Actual execution
>> >
>> > I think this is the right thing to do (at least I could not think of a
>> > case that would be harmed by it, and it certainly fixes your case). It
>> > looks like filter-branch would need a similar fix?
>> >
>> > I think this still isn't resilient to weird meta-characters in the
>> > @SHELL_PATH@, but as this is a build-time option, I think it's OK to let
>> > people who do
>> >
>> >   make SHELL_PATH='}"; rm -rf /'
>> >
>> > hang themselves.
>> >
>> > -Peff
>>
>> Okay, that's what @SHELL_PATH@ stands for. I just read the result
>> in the Windows installation that is something like ${SHELL:-/bin/sh}.
>> The shell script processor then replaces /bin/sh with
>> C:\Program Files\...\bin\sh.
>
> Hmm. Now I'm a bit puzzled. It sounds like the installed file does have
> @SHELL_PATH@ set to /bin/sh, which is normal. And presumably the setting
> containing space is coming from the $SHELL environment variable.
I wrote the email on another computer. Checking the system where I reinstalled
Git for Windows yesterday shows ${SHELL:-/bin/sh} and SHELL=/usr/bin/bash
When running "git rebase --interactive HEAD^ --exec 'echo $SHELL'", I get
mingw64/libexec/git-core/git-rebase--interactive: line 613:
C:/Program: No such file or directory

Fixing the double quotes, "git rebase --interactive HEAD^ --exec 'echo
$SHELL'" shows
C:/Program Files/Git/usr/bin/bash

>
> My original "I could not think of a case harmed by it" was because
> @SHELL_PATH@ also gets used on the shebang line at the beginning of the
> script. And that does not really handle command names with arguments
> well (you get one argument, and it better not have spaces in it). Of
> course, it _also_ does not handle command names with spaces in them,
> either (and there's no room for quoting there).
>
> So anything exotic pretty much has to be coming in from $SHELL, and my
> mention of filter-branch is not interesting; it just uses @SHELL_PATH@.
>
> So what are people putting in $SHELL? Obviously a shell path with a
> space in it wants the quotes. Do people do more exotic things like:
>
>   SHELL="my-shell --options"
>
> (I think a plausible option might be "--posix" for some shells).  That
> would break with your patch.
I agree, tricky case. Just to accept the fact that it won't work.

>
> I dunno. We usually try to err on the side of the status quo, so as to
> avoid breaking existing users. But I find the idea of $SHELL with
> options reasonably unlikely, so I think your patch is the right
> direction. I wish I understood better who was setting $SHELL and why,
> though.
I don't understand where $SHELL is being set neither.

>
> -Peff

/Fredrik
