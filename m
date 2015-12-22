From: Tarmigan <tarmigan+git@gmail.com>
Subject: git describe unexpected results
Date: Mon, 21 Dec 2015 23:03:20 -0800
Message-ID: <CAE1MmuE_aqO-JhXTyz-SRkm15uxcukveYTTd2W71R2Mp26oRhw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 22 08:03:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aBGz3-00036r-6S
	for gcvg-git-2@plane.gmane.org; Tue, 22 Dec 2015 08:03:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751623AbbLVHDl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Dec 2015 02:03:41 -0500
Received: from mail-yk0-f176.google.com ([209.85.160.176]:33987 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751237AbbLVHDk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Dec 2015 02:03:40 -0500
Received: by mail-yk0-f176.google.com with SMTP id p130so154980798yka.1
        for <git@vger.kernel.org>; Mon, 21 Dec 2015 23:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:from:date:message-id:subject:to:content-type;
        bh=1tNbiK8HoLtQ4FIag4bQ0Vjb2h0avs+V/MmPkwAEW0o=;
        b=ba3bxViQm1NfWHWmo02/xWNK75l3Mo8S4BwOJ2EU2URE8Ez5jtR/TxjylBo1+PRXqs
         YJKZK7VJedOW99HCadbaGJQhAarSLyFlBz339PxKegTYrHFnnxD4NvkRbLcSaKp8xZ3l
         Om/y+11Mu5Y7CHMPDPOZ21Yq2EDjroP5inA1M22G3WSVM+KnEW3+tXovLvywL4Yk+Q07
         mAjugk8rwtopusi2EPOuaSmil/8W7juOsK+IfD7cIrz+ZDGQj/h5ZFk8LugOpWdgCeHH
         1PhyVNETxpbnHSdzE65RezlFXe2qf8KsNARq3Objv+3uNZ+PpQNItUUdLVPKYKDMWU6Y
         HPpg==
X-Received: by 10.129.159.142 with SMTP id w136mr17670200ywg.62.1450767819577;
 Mon, 21 Dec 2015 23:03:39 -0800 (PST)
Received: by 10.129.44.10 with HTTP; Mon, 21 Dec 2015 23:03:20 -0800 (PST)
X-Google-Sender-Auth: Q8933vyh45B4Pa3PlIrzSmr9nhw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282833>

In a private repository, I have set of tags which are mostly linear
(each tag contains the previous one). I have created this repo with
fast-export --anonomize to reproduce the issue and it is available at
https://github.com/tarm/git_describe_repo.

Recently I ran git describe, but I did not get the most recent tag and
instead got the previous tag.  The HEAD commit contains both the older
and newer tagged commits, but for some reason chooses the older tag
which is farther away.  There is no tag that is an exact match.

Looking at the documentation for git-describe, I see this:

       If multiple tags were found during the walk then the tag which
       has the fewest commits different from the input commit-ish will
       be selected and output. Here fewest commits different is
       defined as the number of commits which would be shown by git
       log tag..input will be the smallest number of commits possible.

However, that is not what I actually see.

$ git checkout 8630841ef
$ git describe --debug --always --tags HEAD
searching to describe HEAD
finished search at 10b2bfb88802917b37c93620ae62cc2dca603425
lightweight      134 v1.6
annotated        439 v1.5
annotated        534 v1.4
lightweight      553 v1.7
traversed 577 commits
v1.6-134-g8630841

In particular, I actually expected git-describe to choose commit v1.7
as the base since the tags are in order:

$ git log --format=oneline v1.7..HEAD|wc -l
34
$ git log --format=oneline v1.6..HEAD|wc -l
134
$ git log --format=oneline v1.5..HEAD|wc -l
439
$ git log --format=oneline v1.4..HEAD|wc -l
534

I have tried this with the latest git.git HEAD (1d88dab) and see the
same issue.  Am I missing something about how git-describe chooses the
tag or is git-describe not behaving as documented?

Thanks,
Tarm
