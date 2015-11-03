From: Felipe Sateler <fsateler@debian.org>
Subject: Bug: stash save -u removes (some) ignored files
Date: Tue, 3 Nov 2015 19:37:33 -0300
Message-ID: <CAAfdZj8=pqWDB9U3=bPeKXGzsZvzns2xX8WxEzQAy08wgSm=ZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 03 23:38:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtkDa-0004Wf-QS
	for gcvg-git-2@plane.gmane.org; Tue, 03 Nov 2015 23:38:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965038AbbKCWiO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2015 17:38:14 -0500
Received: from mail-ig0-f171.google.com ([209.85.213.171]:34529 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964839AbbKCWiO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2015 17:38:14 -0500
Received: by igpw7 with SMTP id w7so78623251igp.1
        for <git@vger.kernel.org>; Tue, 03 Nov 2015 14:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:from:date:message-id:subject:to:content-type;
        bh=2ynUxEOIcAN2aDFlFcu42vo3ymf1x/35mn+6xMz9CGk=;
        b=ROKsRGicZAz3/oA8iM59YT84m6yBz0fx2sYHVgkYdDTkqFL9hJnzyPmgx0/8aVmkcr
         yI0DEuIOVGu2whP5CIAHjq12RSZIoNCS+mGIFiefnbKuE1KKA6KF8ZH2av0b2fpb51KH
         WiHj1mhrCj8AzTmXTAHBFRfjy+VsjGYudNYXs1k5SDl9XOMpej3eYCIqEoxzsk6vUDCD
         9arTphcWWQIBU3PqWp29KTCH8leyN1msdWqaUigcPNTwFTB/wxRTSTMLAyFyBWTB3Y6w
         kBgLBDERaV7+/ytun/7NI3YListg230xA8Q8p8gYszQeyt/Wr31lTdxZeYoR9KSE85ID
         N6Kw==
X-Received: by 10.50.66.69 with SMTP id d5mr18155719igt.30.1446590293110; Tue,
 03 Nov 2015 14:38:13 -0800 (PST)
Received: by 10.107.131.101 with HTTP; Tue, 3 Nov 2015 14:37:33 -0800 (PST)
X-Google-Sender-Auth: JSNVdZpXf40KGPgKqQDHNhBB6As
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280829>

I have seen the following problem:

felipe@felipe:testgit% cat .gitignore
**/notrack/*
!**/notrack/track/
notrackfile**

felipe@felipe:testgit% find *
newfile
notrack
notrack/1
notrackfile1

felipe@felipe:testgit% git status --porcelain
?? newfile

felipe@felipe:testgit% git stash save -u
Saved working directory and index state WIP on master: 523cb39 Initial commit
HEAD is now at 523cb39 Initial commit

felipe@felipe:testgit% find *
notrackfile1

So, after a stash save, git decided to keep the untracked file in the
current directory, but not the ones inside the untracked directory.
However, the files were "correctly" ignored and did not appear on the stash:

felipe@felipe:testgit% git stash pop
Already up-to-date!
On branch master
Untracked files:
  (use "git add <file>..." to include in what will be committed)

        newfile

nothing added to commit but untracked files present (use "git add" to track)
Dropped refs/stash@{0} (e6508f345af1dd207557ad0291e7e3bce8a89b1e)

felipe@felipe:testgit% find *
newfile
notrackfile1

I think the correct behaviour should be to left the ignored files
untouched in both scenarios.

This is with git 2.6.1 (from debian).

I note that if I add a file inside the notrack/track directory, it is
correctly kept, but the files in notrack/ are still deleted.

-- 

Saludos,
Felipe Sateler
