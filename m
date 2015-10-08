From: Hans Weltar <hansweltar@gmail.com>
Subject: Git deletes files when rebasing an amended merge-commit.
Date: Thu, 8 Oct 2015 14:56:44 +0200
Message-ID: <CAJqY2NUHg-7ghiNA7m+Q36LPhgG6tC6QDg2BP6f52fvDv6uAWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 08 14:56:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZkAkb-0002S7-Vf
	for gcvg-git-2@plane.gmane.org; Thu, 08 Oct 2015 14:56:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757186AbbJHM4q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2015 08:56:46 -0400
Received: from mail-wi0-f195.google.com ([209.85.212.195]:33188 "EHLO
	mail-wi0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754493AbbJHM4p (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Oct 2015 08:56:45 -0400
Received: by wicid10 with SMTP id id10so2050722wic.0
        for <git@vger.kernel.org>; Thu, 08 Oct 2015 05:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=VbIxXSL8lcHMuyZ+wfTASOexKamvmEHqYY3IDwVAY/k=;
        b=eEvcYMct6htJU/JLeqUeNRU7hd2wvG259l/HQAZ4Mb4ZOw7ILLbzJdGPUKwXrDatHo
         Vu83TiCrLjvGtFLiHFvne/XW+9W6ZS71Wbpop6JX+iyQQYIuzC5YM/Nf0BBe6OKRG8pu
         PHInWxQ+iVniBB4vlYb/RHhe43bSVwgfqO3pnYU4p50xDb2EjJw58rPMp+p6foqdZOlz
         aXREIRRa/v+oGvsfYHDYcHD0y0YIoFopMJGTF206reSg98OOeWiUAMuhCOITseJThQB2
         rRnmCUMVIkJcAYvYzaOm+EeIsPM74/qHsshERlsCmSUpzKgdvvvqfkQH6QLomVHrF/xS
         R2Qg==
X-Received: by 10.181.13.102 with SMTP id ex6mr4043584wid.64.1444309004490;
 Thu, 08 Oct 2015 05:56:44 -0700 (PDT)
Received: by 10.27.56.131 with HTTP; Thu, 8 Oct 2015 05:56:44 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279240>

When you have a fast-forwardable merge commit, you can amend this
commit to hold additional changes.
When you now do a rebase, git will believe this merge-commit is
fast-forwardable, and will delete all amended changes.
I believe when you amend a merge-commit it should become non-fastforwardable.

As rebase often needs to be applied (eg rebase -i; pull --rebase) this
is a rather insidious way to loose files without warning.

Here's a small testcase that creates a ff merge commit holding files
f1, f2 and f3. When you execute the last rebase command, the f3 file
will disappear from the filesystem.

git init
touch f1; git add f1; git commit -m "add f1"
git checkout -b mybranch
touch f2; git add f2; git commit -m "add f2"
git checkout master
git merge mybranch --no-ff -m "Merge mybranch"
touch f3; git add f3
git commit --amend -m "Add f2 and f3" # Amend merge
git rebase HEAD^ # f3 will sneakily be deleted, breaking the build and
giving you CI duty :)

kind regards
Hans
