From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: "git am --abort" screwing up index?
Date: Sun, 16 Aug 2015 12:46:15 -0700
Message-ID: <CA+55aFwDkQAS8ULiLt9N5NVOYJ242Nd2MOWeiRX8HrVHXf2zog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>, Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 16 21:46:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZR3sq-0003ue-W0
	for gcvg-git-2@plane.gmane.org; Sun, 16 Aug 2015 21:46:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751429AbbHPTqQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Aug 2015 15:46:16 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:35676 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751081AbbHPTqQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Aug 2015 15:46:16 -0400
Received: by igbjg10 with SMTP id jg10so42298833igb.0
        for <git@vger.kernel.org>; Sun, 16 Aug 2015 12:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:message-id:subject:from:to:cc:content-type;
        bh=fERawN9VZDFq/uS4gR6zMv7QuQ/BQhhbCopscrtxZmo=;
        b=pb5ezwzhA30Gj0aRP56fFH88tGKkowJ8hBLDa/So12QIfjoGlFweH4gynUEVUWt4RR
         EkY2skK/6pKpgxYzWiW74tI/JNFXGI/69w1c5eC9LPGSbhR767/HcWlRgdsKj4KzLJ1z
         EaLGIuk0CzfICfeco3tAViVHlvGEJclWA2rqwxRSFwKV6cYHmXFfvmyWun5BGuKQ6Nvt
         O1nMVWW/jPyCLwq0l0ZlYPjHsAwtI2t191T4Us/u6M3slCXhRXjDDlPzv6ACHBcpOYRI
         w7WYpQLl93VfX3gz6IshMbPbA97wv+MLDS8CxZpqFoov7taTGwmfMdzOxs3Mr2biv340
         xApg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:date:message-id:subject:from:to:cc:content-type;
        bh=fERawN9VZDFq/uS4gR6zMv7QuQ/BQhhbCopscrtxZmo=;
        b=SSXVGaBivaU1mLEspjls+/YdXRcDqOuunmSdbQzLwWkCYGd1ipOJHgf7nDRaSNE4mg
         Qn8EDMUkr49rEmmRsaTA85leix1lo2hmSy7PifE5CPng4Ly3HpzsS6ORDSsKqj2K7m2h
         V2XRTG8fS8wwkDiA+WNwmEjF9tSFcCrytB87A=
X-Received: by 10.50.17.9 with SMTP id k9mr13383106igd.93.1439754375432; Sun,
 16 Aug 2015 12:46:15 -0700 (PDT)
Received: by 10.36.219.130 with HTTP; Sun, 16 Aug 2015 12:46:15 -0700 (PDT)
X-Google-Sender-Auth: 0oV11xIlEcrrUbHxq3TD4H_yzLY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276023>

So I just noticed while applying a patch with "git am" when I had a
dirty tree, and I ended up getting a failure and starting over:

   [torvalds@i7 linux]$ git am --abort
   [torvalds@i7 linux]$ git reset --hard
   Checking out files: 100% (50794/50794), done.0794)
   HEAD is now at 1efdb5f0a924 Merge tag 'scsi-fixes' of
git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi

and the thing I reacted to is that the "git reset --hard" re-checked
out all the files.

That implies that "git am --abort" ended up leaving the index in a bad
state, presumably it re-did the index entirely from HEAD, without
filling it in with the stat() details from the old index.

Maybe it has always done this, and I just haven't noticed (I usually
_just_ do the "git reset --hard" thing, don't ask me why I wanted to
be doubly sure this time). But maybe it's an effect of the new
built-in "am".

I'm about to go out and don't have time to debug this any further
right now, but I'll try to get back to it later. I thought I'd send
out this email in case it makes Paul goes "ahh, yes.. obvious"

Not a big deal - things *work* fine. But forcing checking out every
file obviously also means that subsequent builds end up being slowed
down etc.,.

                  Linus
