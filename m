From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: git add -p and unresolved conflicts
Date: Wed, 28 Mar 2012 17:33:46 +0200
Message-ID: <CABPQNSYp7k82mjzNqZmBX+7Dh6R7rgjQ3ZNqikZyM71GshMqqg@mail.gmail.com>
References: <CABPQNSYVXMxS3kugu1j=62ArJ_1saYYfMjJdZvqhjgPFGN=Eqw@mail.gmail.com>
 <7vbongyd67.fsf@alter.siamese.dyndns.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 28 17:34:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCutM-0001jd-No
	for gcvg-git-2@plane.gmane.org; Wed, 28 Mar 2012 17:34:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758091Ab2C1Pe2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Mar 2012 11:34:28 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:39303 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756518Ab2C1Pe1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Mar 2012 11:34:27 -0400
Received: by pbcun15 with SMTP id un15so1928045pbc.19
        for <git@vger.kernel.org>; Wed, 28 Mar 2012 08:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=jIcP5Y5zmPZXXCUgLL/Ov9JDYN8Ca1T3SNxgj7e9Cz0=;
        b=tjx8AWC55vbyz4K4e1ynt6t9j44Ry9l8q3mpYmvF7hSJbCdPontXLc6OC242mZHlIv
         lN7AZ4RWAdhXsiCv1evVcC3Vyg4rGMXNbs/3dwmO9wqHTkpCs2a0i3n37PwunbjgzsrB
         ba2Z0iYwgtqC4fOa9Uam/fXYPe7XdFPA/k89/mdn7Th9eblIMAUj0meP4yT0liOQrB/H
         nIhkpqb7JDuhhTTco0LJjxa3sD2gvSQ1dFH201woxGd+l4ZvkgwSSKU05Z4Id0ju+fxl
         W0AqU3b0SXFwfNBwQ8+bgjpNP3NiWZsOBDaYqndx2E7rj7dyp+0xS70cV8n3aymlsbNb
         XCpA==
Received: by 10.68.132.40 with SMTP id or8mr72677407pbb.34.1332948866935; Wed,
 28 Mar 2012 08:34:26 -0700 (PDT)
Received: by 10.68.1.135 with HTTP; Wed, 28 Mar 2012 08:33:46 -0700 (PDT)
In-Reply-To: <7vbongyd67.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194131>

On Wed, Mar 28, 2012 at 5:10 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Erik Faye-Lund <kusmabite@gmail.com> writes:
>
>> I'm running git version 1.7.9.msysgit.0.390.g01fca.dirty, and I've
>> noticed a puzzling behavior with "git add -p" on a conflicted file: =
it
>> seems to simply spew the diff and exit the process.
>
> Yeah, when I wrote the 'p'atch mode in "add--interactive", I wasn't
> interested at all in letting it be used on a conflicted path, so that=
 is
> not a designed-in behaviour but merely whatever it happens to do.

OK, that's pretty much what I suspected ;)

> So at
> least it should not allow the user to pick a path that has conflicts =
in
> it.

So, the options are:
 1) Keep the current behavior
 2) Abort with an error immediately if one of the picked paths are in
a conflicted state
 3) Abort with an error when first encounter a path that is in a
conflicted state
 4) Warn and skip any paths that are in a conflicted state
 5) Implement "git add -p" for conflicted files (if we can agree on a b=
ehavior)

1) and 3) makes little sense to me. 5) only makes sense if we can
agree on what should have happened.

> What the behaviour for people who *do* want to use the patch mode for
> conflicted paths should be is a separate matter. =A0As I said, I am n=
ot
> interested in it, so I wouldn't be the best person to design it.
>
> I mildly suspect nobody would come up with a sane behaviour, but what
> would I know...

Well, I can explain what I expected to happen:

I had stashed away some of my "hacking"-code to rebase a branch to the
current master. I was going to stage parts of the stashed changes as a
commit on top. However after rebasing, "git stash pop" lead to a
conflict. So I manually resolved the conflicts, but only wanted to
stage some of the hunks to be committed.

Now, what is obvious in hindsight, is that I should simply have done
"git reset" after resolving the conflicts manually. When I do "git add
-p", I add hunks to the index. But for a conflicted file, the index
isn't in a well-defined state (or, the contents of the file is in a
not-yet-defined state).

However, as it happened it made me confused (and a little bit
frustrated). I suspect this could confuse other users as well. Perhaps
we should implement 1) or 3) and come up with a helpful error/warning
message? I don't have a very strong opinion on which one is better,
but I suspect 3) is easier.
