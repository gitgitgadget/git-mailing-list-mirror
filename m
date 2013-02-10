From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: inotify to minimize stat() calls
Date: Sun, 10 Feb 2013 12:24:58 +0700
Message-ID: <CACsJy8DeM5--WVXg3b65RxLBS7Jho-7KmcGwWk7B5uAx77yOEw@mail.gmail.com>
References: <CALkWK0=EP0Lv1F_BArub7SpL9rgFhmPtpMOCgwFqfJmVE=oa=A@mail.gmail.com>
 <7vehgqzc2p.fsf@alter.siamese.dyndns.org> <7va9rezaoy.fsf@alter.siamese.dyndns.org>
 <7vsj56w5y9.fsf@alter.siamese.dyndns.org> <9AF8A28B-71FE-4BBC-AD55-1DD3FDE8FFC3@gmail.com>
 <CALkWK0mttn6E+D-22UBbvDCuNEy_jNOtBaKPS-a8mTbO2uAF3g@mail.gmail.com>
 <CALkWK0nQVjKpyef8MDYMs0D9HJGCL8egypT3YWSdU8EYTO7Y+w@mail.gmail.com>
 <CACsJy8CEHzqH1X=v4yau0SyZwrZp1r6hNp=yXD+eZh1q_BS-0g@mail.gmail.com> <CALkWK0=6_n4rf6AWci6J+uhGHpjTUmK7YFdVHuSJedN2zLWtMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Robert Zeh <robert.allan.zeh@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>, finnag@pvv.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 10 06:25:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4PQG-0004si-Uh
	for gcvg-git-2@plane.gmane.org; Sun, 10 Feb 2013 06:25:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750852Ab3BJFZ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2013 00:25:29 -0500
Received: from mail-oa0-f50.google.com ([209.85.219.50]:37296 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750837Ab3BJFZ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2013 00:25:28 -0500
Received: by mail-oa0-f50.google.com with SMTP id l20so5314076oag.37
        for <git@vger.kernel.org>; Sat, 09 Feb 2013 21:25:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=nFEgwP7reVErBsSNaY8X5SxcV54i/UxkAF5zsSElhIc=;
        b=Pat5qdepsal5VfQZYUOvMoIvp2LQiqnQGvCHCWOkSkcn4EagJppSWXoB65onZm6FcD
         Zf0GE9vlkoCO3RgblDH1RoWhrVoloYXn48+pC+lL3VXH6yTc3zev/EcQbmcJEEpFjvj2
         idm+hhEAx+sS6mOMT0b/z2FOVrT0Rob29j0bufAV6Y6heu2jIWmZs//MGtvKpTli4q6W
         69u52MHxKmGoPNy+CMUsSuFrjB6C47Jia9kfsWfzSgc+4CtX8cdIXCZH32+6EzSgpxQl
         cmYQ226Ih4jxfBJnWGjeu84y3CGHkRQeJx3KGy4tqtIw25rHPJNEtPnHb7p3YqGyOO6w
         FPAg==
X-Received: by 10.60.1.129 with SMTP id 1mr7667356oem.93.1360473928178; Sat,
 09 Feb 2013 21:25:28 -0800 (PST)
Received: by 10.76.154.197 with HTTP; Sat, 9 Feb 2013 21:24:58 -0800 (PST)
In-Reply-To: <CALkWK0=6_n4rf6AWci6J+uhGHpjTUmK7YFdVHuSJedN2zLWtMA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215898>

On Sun, Feb 10, 2013 at 12:10 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Finn notes in the commit message that it offers no speedup, because
> .gitignore files in every directory still have to be read.  I think
> this is silly: we really should be caching .gitignore, and touching it
> only when lstat() reports that the file has changed.
>
> ...
>
> Really, the elephant in the room right now seems to be .gitignore.
> Until that is fixed, there is really no use of writing this inotify
> daemon, no?  Can someone enlighten me on how exactly .gitignore files
> are processed?

.gitignore is a different issue. I think it's mainly used with
read_directory/fill_directory to collect ignored files (or not-ignored
files). And it's not always used (well, status and add does, but diff
should not). I think wee need to measure how much mass lstat
elimination gains us (especially on big repos) and how much
.gitignore/.gitattributes caching does. I don't think .gitignore has
such a big impact though. strace on git.git tells me "git status"
issues about 2500 lstat calls, and just 740 open+getdents calls (on
total 3800 syscalls). I will think if we can do something about
.gitignore/.gitattributes.
-- 
Duy
