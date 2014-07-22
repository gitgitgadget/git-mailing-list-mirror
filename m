From: Jeffry Johnston <jeff@kidsquid.com>
Subject: .gitignore and git stash -u
Date: Tue, 22 Jul 2014 13:55:01 -0700
Message-ID: <CAH4Lw1p4UUAH5LcrVEcXtr75Jdfp8osYN2vUk=nkAttosOOjDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 22 22:55:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9h5Z-0001zP-QO
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jul 2014 22:55:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756807AbaGVUzD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2014 16:55:03 -0400
Received: from mail-yk0-f170.google.com ([209.85.160.170]:62984 "EHLO
	mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751482AbaGVUzB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2014 16:55:01 -0400
Received: by mail-yk0-f170.google.com with SMTP id 9so173395ykp.29
        for <git@vger.kernel.org>; Tue, 22 Jul 2014 13:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:message-id:subject:from:to:content-type;
        bh=NzyCFCYm4+p7C+SUyoIEFU1KxLq1QFNglkN0jEaJ9Qg=;
        b=K4Hq1ZyryyDJLuNPDnRAH+AYswaJLWP3wiKQn8u3yJ9p20D8wrEVSsT1F7y81bjsgi
         3fWRjRJnLgoIzfuBVsu51C6jSqUmfnrm4bEPffKNDF/mxevzwFo24UFEhnj9OesTC4t9
         OTWWtA4ppdtdDtPaoEgYoOCyK+VtoTEMMmPRFi3W+djUPZPxg9+bRVMIsMIhKka8Fewc
         MvpfprKBtiHvX8X3jGoNt/CjOXeeE7l8GbW1n254l9IQhBOvVXY6gcLhj+9bBqIaFXki
         je2dDCFDmguNLr3n1Tw7PJp72ciTe9+meL8ebxKkfk48gBZXaWCO+H4k/HvW7rEdH/i/
         IoCg==
X-Received: by 10.236.21.206 with SMTP id r54mr55356114yhr.88.1406062501177;
 Tue, 22 Jul 2014 13:55:01 -0700 (PDT)
Received: by 10.170.186.194 with HTTP; Tue, 22 Jul 2014 13:55:01 -0700 (PDT)
X-Google-Sender-Auth: orT4e7ZTTLaoH3LimgD2vEZMW4M
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254037>

We had been experiencing "random" deletions of files and directories,
and we finally figured out what they were: git stash -u.  A coworker
happened upon a webpage (after losing a weeks worth of experimental
work, back to his last backup), which described our problems exactly:

http://blog.icefusion.co.uk/git-stash-can-delete-ignored-files-git-stash-u/

The command git stash -u deletes ignored files from the hard drive..
very dangerous! Which leads me to my first question: Why does git
stash -u delete these files but a checkout doesn't? It seems
inconsistent.

We have the following in .gitignore, which is directly related to the
problems we're having (please note, we're using git on Windows, in
case that makes a syntax difference):

*/**/*
![Ss][Rr][Cc]/**/*

So what that does is ignores every file and subdirectory at the top
level, and then un-ignores Src/ and all files/dirs under that (we have
a few more that we unignore). The reason behind this is we have files
that are generated in the same tree as the source code, and
unfortunately it is infeasible to change that design. So, if someone
creates Data and puts their own custom configuration file it in, it
doesn't contaminate the repository. However, if course they don't want
to lose their configuration file either.

My understanding from the linked page is that our problem is having
the /* at the end which causes the files to be ignored and not the
directories themselves. However, I couldn't seem to find a combination
without the trailing /* that duplicated the functionality we had,  but
that prevented git stash from deleting our files. Can anyone provide
me with one? This is what I am really after.

I have come up with an inelegant workaround. If I add this line to .gitignore:

!Data/.placeholder

And then commit an empty .placeholder file, it seems to fix the
deletion problem. After that, we can place all sorts of untracked
files and sub-directories and they don't get deleted during a stash. I
guess it's because that tracked file keeps the directory "alive" in
some fashion, but I am not sure I understand why the sub-directories
are not deleted though, can anyone enlighten me on that? I would have
expected to have to put a .placeholder file in every sub-directory
under Data to prevent them from getting deleted too (because of the **
in the .gitignore line).

Another thing we were considering is modifying git itself to provide a
command-line option not to delete ignored files during a stash. Can
someone point me to the appropriate file?

Thanks a lot,
Jeff
