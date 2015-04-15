From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Odd broken "--date=now" behavior in current git
Date: Tue, 14 Apr 2015 21:18:29 -0700
Message-ID: <CA+55aFxvcN8Dz-t6fi6etycg+AiyR0crXv5AcfCdv8ji-iNBpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 15 06:18:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YiEmY-0003r4-SB
	for gcvg-git-2@plane.gmane.org; Wed, 15 Apr 2015 06:18:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964787AbbDOESb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Apr 2015 00:18:31 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:33791 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751254AbbDOES3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Apr 2015 00:18:29 -0400
Received: by igbpi8 with SMTP id pi8so59963320igb.0
        for <git@vger.kernel.org>; Tue, 14 Apr 2015 21:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:message-id:subject:from:to:cc:content-type;
        bh=FDxDGMZAbEK95Kg6imUG3jWq2je+OuWe8m7jZFws9Uo=;
        b=JbY0BRtStHC4ftKMIn+s4uTd7sVmmHmM3zrnyUwlXR4WMJ/HgRJEFKvGi/fyuY+W3a
         iKJAI/8PRS7ZRs4BViaOCmITbzz1St8GFAruZJUfkEnlhMzeJUfd1jr6shTVZ81UusUZ
         HAd+xCHx0Yva2Ncyvcsn5NraGNOa9xbNisnXGpYPzXrcrJFe+WsdaUcelUW/a0Fl04HC
         l1QQ9wonrlK2p44KVwZNEu77qsMUrAG/coc36ndc2fxzKySWlmd3E8c5STxurZfPjmq9
         Xc+0sHKy44MNhB1jsfXVUm8yY4pSvX3ThcsDi6m5jZWLTaUm7LWrBs5+qPUf26a79yIr
         Z51A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:date:message-id:subject:from:to:cc:content-type;
        bh=FDxDGMZAbEK95Kg6imUG3jWq2je+OuWe8m7jZFws9Uo=;
        b=gI3EXlJ6Zkzwq4K4Wkx3X2zRDzyIXC3mS6tR56+s8M9VmP6mYA0SqWhwLnDcyuWYSH
         Z4sXwKs5gbzedhqc2tr/HkKuOuRwCeL7SqRfpjaDeDfFNKYGLC/oJxg50UEVb8jqErpV
         K/U7gL6EFle4yLfvwBZXcd/6wzYojwILeL604=
X-Received: by 10.42.38.208 with SMTP id d16mr20430987ice.45.1429071509224;
 Tue, 14 Apr 2015 21:18:29 -0700 (PDT)
Received: by 10.36.53.141 with HTTP; Tue, 14 Apr 2015 21:18:29 -0700 (PDT)
X-Google-Sender-Auth: XiH-RcJ07I9XtuN1csiZW3_-DCM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267183>

I just noticed this because I had amended some merge commits with

   git commit --amend --date=now

to update them, and that gets some funny broken timezones. I suspect
it's some silly daylight savings time issue.

Lookie here, I can reproduce it trivially with current git (in the git
repo itself):

    [torvalds@i7 git]$ date; git commit -m Test --allow-empty --date=now
    Tue Apr 14 21:11:03 PDT 2015
    [master ec7733db5360] Test
     Date: Tue Apr 14 20:11:03 2015 -0800

notice how the commit date message shows something funny. It shows an
hour earlier, but in -0800.

And the resulting commit is broken:

    [torvalds@i7 git]$ git show --pretty=fuller
    commit ec7733db5360966434e03eab1a849e6d4227231c (HEAD -> master)
    Author:     Linus Torvalds <torvalds@linux-foundation.org>
    AuthorDate: Tue Apr 14 20:11:03 2015 -0800
    Commit:     Linus Torvalds <torvalds@linux-foundation.org>
    CommitDate: Tue Apr 14 21:11:03 2015 -0700

        Test

notice how the AuthorDate has that "-0800", but the CommitDate has "-0700".

Hmm.

I can't be the only one seeing this? My guess is that there's a
missing initialization of tm.tm_isdst somewhere or whatever.

The above is with current git:

    [torvalds@i7 git]$ git version
    git version 2.4.0.rc2

Anybody?

                        Linus
