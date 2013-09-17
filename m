From: Nicolas Adenis-Lamarre <nicolas.adenis.lamarre@gmail.com>
Subject: Locking files / git
Date: Tue, 17 Sep 2013 21:45:26 +0200
Message-ID: <CACPGbcsB-ieZnS5maQgtnRTifFON9fEFpCGGdHtQ2ZjySdxDYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 17 21:45:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VM1DK-00039E-A9
	for gcvg-git-2@plane.gmane.org; Tue, 17 Sep 2013 21:45:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753702Ab3IQTp2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Sep 2013 15:45:28 -0400
Received: from mail-vc0-f181.google.com ([209.85.220.181]:52870 "EHLO
	mail-vc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753358Ab3IQTp1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Sep 2013 15:45:27 -0400
Received: by mail-vc0-f181.google.com with SMTP id hz10so4603388vcb.12
        for <git@vger.kernel.org>; Tue, 17 Sep 2013 12:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=PfZ3xxKP6aGJDXoLxc+xeJ6JXl8Ale4+jmFIf/Nl/Oo=;
        b=itf406RoNyW+i/mlnm7GXAsY0q/z4mTe7uZZ0LiTtFY+u/t16J59xCwy7s1cqdj4WD
         kFFrw9T45APrS2Vrj9uAVk4doVVTAAtT+5Esm1rprtNlImVilJELRklqFF1CBY+htKqL
         XK28wVDjepIj82O+oOlTkBe6Qlg6mYclVK49JZZczXQAmPgXrRDkV5o8z3uyzxjcLaSQ
         gBpFxtNoAYISrBT/6PhuMT/QPYYdrGzUIC9j3JJatPIt/+cjGIv2K/D5KErd0swJZunG
         dWGPy2jSER74Dp7Zj6NhUY/N51s2cENRxXX05X9C1vgDGCxDfZpAjZhlLdbNACwBE4uz
         7TmQ==
X-Received: by 10.52.170.111 with SMTP id al15mr1394068vdc.43.1379447126803;
 Tue, 17 Sep 2013 12:45:26 -0700 (PDT)
Received: by 10.220.194.132 with HTTP; Tue, 17 Sep 2013 12:45:26 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234909>

Ooops. It seems that each time somebody says these two words together,
people hate him, and he is scorned by friends and family.

However,
- gitolite implement it (but gitolite is not git).
- In the documentation, each time the need is evocated, it is replace
by "do communication, don't use git for that". I'm still looking for
the good way to communicate this information. In my humble opinion,
git is a communication tool.
I won't explain here why it could be a if not good, at least helpfull
new feature (and everybody is not mandatory to use new feature),
I've still heard no argument about why it could not be accepted in git
better than "locking is bad".
I want to explain how I could implement it.

=46irstly, it would (in the general form ; some options could be added)
alter no existing command of git.
It would add 3 new commands :
- git lock [path]
- git unlock [path]
- git lslock

It would add 2 new files in .git :
- lockserver containing a ssh url of the git repository, not necessary
the source of the clone (in fact, the same content of the lockserver
file in the source of the clone so that people gets the same lock
server)
- lockedfiles containing the list of pathes of locked files (plus name
of the people locking, date) on the lock server.

git push would not be altered, however, you can imagine an option to
unlock all locked files by yourself.

the 3 new commands would require a communication to the lock server.
note that the idea is that everybody get the same lock server in any wo=
rkflow.
In case there was no server defined on the original git repository,
you have to communicate so that people configure the lockserver file.

git lock would put the path provided into the lock server
git unlock would remove the path provided from the lock server
git lslock would ask pathes to the lock server

You must have rules on your project, for example, lock a .doc file
each time you modify it.
If you follow that guideline, you=92ll be fine. If you don=92t, people
will hate you, and you=92ll be scorned by friends and family.
If you push a file which is not locked by you, any problem, it will
push (eventually, telling you that the file was locked and that your
project has some rules).

What about automatic unlocking to prevent from forgetting to unlock :
Something like pushing when the push server is the same as the lock
server could automatically unlock the file.
The question is when to unlock when you have a complex workflow with a =
dictator.
I agree i've not the best answer for the moment. Something like when
the developper have the files back, identically from the source of the
dictator. This point could be think more.

Scenario :
@alice : git lock src/main.c
@bob : git lock src/main.c
fatal: file src/main.c locked by alice
@alice : git unlock src/main.c
@bob : git lock src/main.c

=46or the moment, i want a first feedback, an intermediate between
"locking is bad" and "ok", but i would prefer in the negativ answer
something with arguments ("Take CVS as an example of what not to do;
if in doubt, make the exact opposite decision." is one), and in the
positiv answer, good remarks about problems with my implementation
that could make it better.

Perhaps this subject has already been discussed and is closed, in this
case, sorry, just give me the link i've not found please.

Nicolas Adenis-Lamarre
