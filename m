From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: inotify to minimize stat() calls
Date: Mon, 11 Feb 2013 10:03:52 +0700
Message-ID: <CACsJy8Aw1GpKXGwjMdzjXBxAMrC-q6HDSyi2u6EoXCYDV8fJ4Q@mail.gmail.com>
References: <CALkWK0=EP0Lv1F_BArub7SpL9rgFhmPtpMOCgwFqfJmVE=oa=A@mail.gmail.com>
 <7vehgqzc2p.fsf@alter.siamese.dyndns.org> <7va9rezaoy.fsf@alter.siamese.dyndns.org>
 <7vsj56w5y9.fsf@alter.siamese.dyndns.org> <9AF8A28B-71FE-4BBC-AD55-1DD3FDE8FFC3@gmail.com>
 <CALkWK0mttn6E+D-22UBbvDCuNEy_jNOtBaKPS-a8mTbO2uAF3g@mail.gmail.com>
 <CALkWK0nQVjKpyef8MDYMs0D9HJGCL8egypT3YWSdU8EYTO7Y+w@mail.gmail.com>
 <CACsJy8CEHzqH1X=v4yau0SyZwrZp1r6hNp=yXD+eZh1q_BS-0g@mail.gmail.com>
 <CALkWK0=6_n4rf6AWci6J+uhGHpjTUmK7YFdVHuSJedN2zLWtMA@mail.gmail.com>
 <CACsJy8DeM5--WVXg3b65RxLBS7Jho-7KmcGwWk7B5uAx77yOEw@mail.gmail.com>
 <20130210111732.GA24377@lanh> <CALkWK0kLieAfPihX3j=BzD+ndo-g-2210Za2xN=HbHcRVwgMtA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Robert Zeh <robert.allan.zeh@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>, finnag@pvv.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 04:04:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4jhH-0003kk-0O
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 04:04:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751253Ab3BKDEY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2013 22:04:24 -0500
Received: from mail-ob0-f178.google.com ([209.85.214.178]:44061 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751158Ab3BKDEX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2013 22:04:23 -0500
Received: by mail-ob0-f178.google.com with SMTP id wd20so5718813obb.9
        for <git@vger.kernel.org>; Sun, 10 Feb 2013 19:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=hyddNQBfNcTgZ2p4Yhyj3AsiVpgj7/x3wRbyuco9fxA=;
        b=jl1EAfKt8lfkrlXrh20h8x+lGibZqt2hoG35PRlOLErFYYOlDYla3kEK4e1yjSs1m4
         eHk0xGfeAIP5Z4ZmLLReIRCob890295JV9sArU3oXsgLLMDYRtdUKsxLmBjTnqRXLa0J
         87x1Ej6AcyOFuPiqHizexTpytzP6RKe0kv2y2j2BbJHJHpuSfHTu1DFaWgGipofY7KKx
         xO9Pq2ofcGKVtfYi1gpSsMG1Ydl6gz6xKGwr4RxFG7pCaASVO8QvI5kn2XvSZ0lNKmA5
         zFeONApezvH/8QcZxf6V4BJwJLsPTum9gUjvfojJVx7WzTVGc4AVgOJsWMvOjL9ozLTb
         9fPA==
X-Received: by 10.182.43.103 with SMTP id v7mr9516840obl.17.1360551862944;
 Sun, 10 Feb 2013 19:04:22 -0800 (PST)
Received: by 10.76.154.197 with HTTP; Sun, 10 Feb 2013 19:03:52 -0800 (PST)
In-Reply-To: <CALkWK0kLieAfPihX3j=BzD+ndo-g-2210Za2xN=HbHcRVwgMtA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215978>

On Sun, Feb 10, 2013 at 11:45 PM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> So you're skipping the rest of refresh_cache_ent(), which contains our
> lstat() and returning immediately.  Instead of marking paths with the
> "assume unchanged" bit, as core.ignoreStat does, you're directly
> attacking the function that refreshes the index and bypassing the
> lstat() call.  How are they different?  read-cache.c:1030 checks
> ce->flags & CE_VALID (which is set in read-cache.c:88 if
> assume_unchanged) and bypasses the lstat() call anyway.  So why didn't
> you just set core.ignoreStat for your test?

It just did not occur to me that core.ignoreStat does the same.

> Ah, read_directory(), from the .gitignore/ exclude angle.  Yes,
> read_directory() seems to be the main culprit there, from my reading
> of Documentation/technical/api-directory-listing.txt.
>
> So, what did you do?  You short-circuited the function into never
> executing read_directory_recursive(), so the opendir() and readdir()
> are gone.  I'm confused about what this means: will new directories
> fail to appear as "untracked" now?

No, read_directory returns the list of untracked/ignored files.
Returning empty lists means no untracked nor ignored files.
-- 
Duy
