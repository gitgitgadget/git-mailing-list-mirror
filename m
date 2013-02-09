From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: inotify to minimize stat() calls
Date: Sat, 9 Feb 2013 22:40:20 +0530
Message-ID: <CALkWK0=6_n4rf6AWci6J+uhGHpjTUmK7YFdVHuSJedN2zLWtMA@mail.gmail.com>
References: <CALkWK0=EP0Lv1F_BArub7SpL9rgFhmPtpMOCgwFqfJmVE=oa=A@mail.gmail.com>
 <7vehgqzc2p.fsf@alter.siamese.dyndns.org> <7va9rezaoy.fsf@alter.siamese.dyndns.org>
 <7vsj56w5y9.fsf@alter.siamese.dyndns.org> <9AF8A28B-71FE-4BBC-AD55-1DD3FDE8FFC3@gmail.com>
 <CALkWK0mttn6E+D-22UBbvDCuNEy_jNOtBaKPS-a8mTbO2uAF3g@mail.gmail.com>
 <CALkWK0nQVjKpyef8MDYMs0D9HJGCL8egypT3YWSdU8EYTO7Y+w@mail.gmail.com> <CACsJy8CEHzqH1X=v4yau0SyZwrZp1r6hNp=yXD+eZh1q_BS-0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Robert Zeh <robert.allan.zeh@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>, finnag@pvv.org
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 09 18:11:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4DxA-0001cF-S1
	for gcvg-git-2@plane.gmane.org; Sat, 09 Feb 2013 18:11:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760759Ab3BIRKl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2013 12:10:41 -0500
Received: from mail-ie0-f173.google.com ([209.85.223.173]:55466 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760757Ab3BIRKk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2013 12:10:40 -0500
Received: by mail-ie0-f173.google.com with SMTP id 9so6298577iec.18
        for <git@vger.kernel.org>; Sat, 09 Feb 2013 09:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=wwSdsInhMSd6qTTtutWBAjkHXb7rskBVlpar32YWBqs=;
        b=r7Kz6eMow5A3zEGK8dc8XsP/NgwJkJWv625YeftvyJ2xQWTViGDNmFmbphl8LwodBW
         ly0Jbx5h9eZa4pSCtfKkjP7Y9+Y44eyD7y59uk5BhoQlQOXtVLQdxaIrEXmCHf02NwUJ
         jVIuB0pGJYRVZz0o/9Ce0POgrnOJCZ06ykbZNcsS7+oF9NqW6vj5rUzjHcmKIxsK51ty
         F4EQ6YiVPyX6sMUjYvjyHngDcj6+GxvD8GxI8p7sfwTGjjVtzh2E9lF8JuC2cYLLtDd0
         EF9ZjYU9kwWjWi61qiwQThIk3jlBwVpNWwmNzrOfNFOGT2jT2d9N1Ziyft2ulyPK5tr3
         26KQ==
X-Received: by 10.42.18.138 with SMTP id x10mr13921105ica.22.1360429840426;
 Sat, 09 Feb 2013 09:10:40 -0800 (PST)
Received: by 10.64.86.18 with HTTP; Sat, 9 Feb 2013 09:10:20 -0800 (PST)
In-Reply-To: <CACsJy8CEHzqH1X=v4yau0SyZwrZp1r6hNp=yXD+eZh1q_BS-0g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215866>

Duy Nguyen wrote:
> How about this as a start? I did not really check what it does, but it
> does not look complicate enough to pull systemd in.
>
> http://article.gmane.org/gmane.comp.version-control.git/151934

Clever hack.  I didn't know that there was a switch called
core.ignoreStat which will disable automatic lstat() calls altogether.
 So, Finn advises that we set this switch and run igit instead of git.
 There's a git-inotify-daemon which runs inotifywait with -m forever,
updating a modified_files hash.  When it is sent a TERM from igit
(which is what happens immediately upon execution), it writes all this
collected information about modified files to a named pipe that igit
passes to it.  igit then does a git update-index --assume-unchained
--stdin to read the data from the pipe.  Towards the end of its life,
igit starts up a fresh git-inotify-daemon for future invocations.

Finn notes in the commit message that it offers no speedup, because
.gitignore files in every directory still have to be read.  I think
this is silly: we really should be caching .gitignore, and touching it
only when lstat() reports that the file has changed.

As far as a real implementation that we'd want to merge into git.git
is concerned, I have a few comments:
Running multiple daemons on-the-fly for monitoring filesystem changes
is not elegant at all.  Keeping track of the state of so many loose
daemons is a hard problem: how do we ensure any semblance of
reliability without that?  Systemd is a very big improvement over the
legacy of a hundred loose shell scripts that SysVInit demanded.  It
monitors and babysits daemons; it uses cgroups to even kill
misbehaving daemons.  I can inspect running daemons at any time, and
have a uniform way to start/ stop/ restart them.

Okay, now you're asking me to consider a system-wide daemon
independent of systemd.  It has to run with root privileges so it has
access to everyone's repositories, which means that people have to
trust it beyond doubt.  What does it do?  It has a generic API to
watch filesystem paths and report events over an IP socket.  Do you
think that this will only be useful to git?  Every other version
control system (and presumably many other pieces of software) will
want to use it.  One huge downside I see of making this part of
systemd is Ubuntu.  They've decided not to use systemd for some
unfathomable reason.

Really, the elephant in the room right now seems to be .gitignore.
Until that is fixed, there is really no use of writing this inotify
daemon, no?  Can someone enlighten me on how exactly .gitignore files
are processed?

> Youo may want to search the mail archive. This topic has come up a few
> times before, there may be other similar patches.

The thread you linked me to is a 2010 email, and now it's 2013.  We've
been silent about inotify for three years?

Thanks for your inputs, Duy.
