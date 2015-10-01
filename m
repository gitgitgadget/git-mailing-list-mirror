From: Chris Packham <judge.packham@gmail.com>
Subject: [BUG?] applypatch-msg hook no-longer thinks stdin is a tty
Date: Thu, 1 Oct 2015 16:42:58 +1300
Message-ID: <CAFOYHZArBv=2E_YonCqOSC4mWk9=xkbG9FyB+zNFFAqmUBUKHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 01 05:43:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZhUly-0005ms-B3
	for gcvg-git-2@plane.gmane.org; Thu, 01 Oct 2015 05:43:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755305AbbJADnA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Sep 2015 23:43:00 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]:37126 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754929AbbJADm7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Sep 2015 23:42:59 -0400
Received: by igbni9 with SMTP id ni9so6000645igb.0
        for <git@vger.kernel.org>; Wed, 30 Sep 2015 20:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=yUR/u2Ml3+GeuWGZFziyddb39oN+cXCMR6kPRdqxsww=;
        b=IpNq3xzCGPDnVkDAcIrWy2xbW9T/YG4RXsszNmzI31pM7WAbtwChf7eOrXF2gsn3O4
         OaABk4mYjcvYt0aVkTlBj6wEzZAltxqw92CwJaGs23sVuvlqk3o5NHavgoFvqXz+I/zQ
         cOuzPs5aiGYW+IXFjIOuAEYA6rjnINfMo2Non50TLrubl9p7vPTMbAxmj6Qb3RGLXkl7
         sLXi3+u0eIngkaLx8mtMuc5LKYor045bwf3I3o2lZsdS4qzDcqYxr0kH6gQOI+FpZRT+
         uGMz5yW43ndZxE7nvPLqahxD1yNuqSzr9X+moCr/10CgfFqFALVBtg0W/pKA2WZI0f+1
         lPhA==
X-Received: by 10.50.114.5 with SMTP id jc5mr842039igb.25.1443670978950; Wed,
 30 Sep 2015 20:42:58 -0700 (PDT)
Received: by 10.79.109.71 with HTTP; Wed, 30 Sep 2015 20:42:58 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278884>

Hi,

I have a applypatch-msg hook that implements some policy for
acceptable commit messages and reject non-conformant patches. It also
is able to prompt me to override it's rejection. The prompting only
happens when stdin is a tty (as determined by pythons
sys.stdin.isatty())

For example this would reject the patch and cause am stop
 $ cat bad.patch | git am

And this would prompt me to allow the patch and am would proceed if I answer Y
  $ git am bad.patch
  Patch message invalid apply (Y/N)?

As of git 2.6 this has stopped working and stdin always fails the tty
check. Here's a minimal reproduction

$ cat >.git/hooks/applypatch-msg <<EOF
#!/usr/bin/env python
import sys
if sys.stdin.isatty():
    print("TTY")
else:
    print("NOT")
EOF
$ chmod +x .git/hooks/applypatch-msg

$ git checkout -b temp origin/master^
$ git format-patch master -1

# With git 2.6
$ git am 0001-Git-2.6.patch
NOT
Applying: Git 2.6

# With git 2.5.3
TTY
Applying: Git 2.6

Thanks,
Chris
