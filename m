From: Levin Du <zslevin@gmail.com>
Subject: Re: Questions about git-push for huge repositories
Date: Tue, 8 Sep 2015 09:30:09 +0800
Message-ID: <CAN6cQGOO540FV9bTQPks+1nHS1xO10Rv8iNzAj8-cBihQ4_kEw@mail.gmail.com>
References: <CAN6cQGPcGpaXUGu_7aaeJtMbruMocte-5po97vG5r39f=YdTZQ@mail.gmail.com>
	<xmqq4mj7bfsf.fsf@gitster.mtv.corp.google.com>
	<CAN6cQGMf089ERn2kZbFpHJ6vyJ4BnjCm-m-E+hQsduH55XFvKw@mail.gmail.com>
	<CAN6cQGNGP+n3L=tuRCymOTWFCnFNsq-tFHkaNm+W=o726mjmmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 08 03:30:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZZ7jn-0000hG-8c
	for gcvg-git-2@plane.gmane.org; Tue, 08 Sep 2015 03:30:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752102AbbIHBaM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Sep 2015 21:30:12 -0400
Received: from mail-yk0-f182.google.com ([209.85.160.182]:35381 "EHLO
	mail-yk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751314AbbIHBaK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Sep 2015 21:30:10 -0400
Received: by ykdu9 with SMTP id u9so21896158ykd.2
        for <git@vger.kernel.org>; Mon, 07 Sep 2015 18:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=SsRVOsKJXqwnj+X7cqI//NEbLiXxMZZB3fftGUX0h7I=;
        b=noyJ41XBvTqTnzkFVHBo73bsHZmCNR07xsYzJKy+1kE/4gHa0ElZ23QY/UZ4BmoS0u
         34GJI/qRl5Z9NrHyeZfNOOFW1Z0J1WvpIv/HrlwNliDuVykN9OdI9lWreoLAhlUeVt1/
         yUFcg7ap9MTJZ+Md26sD9lBDFN+Kmb4bYfyDNJQvoG2lufTcSjm8Mgr0CqfSA6wEXYvX
         Out600y3S379NQpR2XSfP41Vv2Au9xj1z5+jLzOr3GkDwPB7aP5DUj4M2fovIYeWqBTn
         1MP4oVYoe/SlJCUUapHFvv5+kE5YKWS/cQXQYBIBkpK+yjNdDcBIBsHVAxdVdWTBtEVG
         s6YA==
X-Received: by 10.129.138.129 with SMTP id a123mr17647322ywg.29.1441675810035;
 Mon, 07 Sep 2015 18:30:10 -0700 (PDT)
Received: by 10.103.85.138 with HTTP; Mon, 7 Sep 2015 18:30:09 -0700 (PDT)
In-Reply-To: <CAN6cQGNGP+n3L=tuRCymOTWFCnFNsq-tFHkaNm+W=o726mjmmw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277481>

I consider 'git push' need further optimization.

Take kernel source code for example:

# Clone the kernel to A and B
$ git --version
git version 2.3.2
$ git clone --bare  ../kernel/ A
$ git clone --bare  ../kernel/ B

# Create the orphan commit and check
$ cd A
$ git branch test
Switched to a new branch 'test'
$ git replace --graft test
$ git rev-parse test
cbbae6741c60c9e09f87521e3a79810abd6a2fda
$ git rev-parse test^{tree}
929bdce0b48ca6079ad281a9d8ba24de3e49881a
$ git rev-parse replace/cbbae6741c60c9e09f87521e3a79810abd6a2fda
82d3e9ce1ca062c219f1209c5291ccd5603e5302
$ git rev-parse 82d3e9ce1ca062c219f1209c5291ccd5603e5302^{tree}
929bdce0b48ca6079ad281a9d8ba24de3e49881a
$ git log --pretty=oneline 82d3e9ce1ca062c219f1209c5291ccd5603e5302 | wc -l
1

We can see that commit 82d3e9ce1ca062c219f1209c5291ccd5603e5302 (root commit)
is meant to replace for commit cbbae6741c60c9e09f87521e3a79810abd6a2fda .
They both contain the same tree 929bdce0b48ca6079ad281a9d8ba24de3e49881a .

$ du -hs ../B
1.6G ../B
$ git push ../B 'refs/replace/*'
Counting objects: 51216, done.
Delta compression using up to 8 threads.
Compressing objects: 100% (48963/48963), done.
Writing objects: 100% (51216/51216), 139.61 MiB | 17.88 MiB/s, done.
Total 51216 (delta 3647), reused 34580 (delta 1641)
To ../B
* [new branch]
refs/replace/cbbae6741c60c9e09f87521e3a79810abd6a2fda ->
refs/replace/cbbae6741c60c9e09f87521e3a79810abd6a2fda
$ du -hs ../B
1.7G ../B

It takes some time for 'git push' to compress the objects and B has
finally increased 0.1G,
which is for the newly commit whose tree is already in the repository.
