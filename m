From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Regression in `git add' in 1.7's 48ffef966c with a wildcard in 
	.gitignore
Date: Mon, 8 Mar 2010 17:08:23 +0000
Message-ID: <51dd1af81003080908i3bc94f27lc99e146bb57993ba@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 08 18:08:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NogRS-0006GQ-T1
	for gcvg-git-2@lo.gmane.org; Mon, 08 Mar 2010 18:08:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752954Ab0CHRI0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Mar 2010 12:08:26 -0500
Received: from mail-ew0-f216.google.com ([209.85.219.216]:34264 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751581Ab0CHRIZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Mar 2010 12:08:25 -0500
Received: by ewy8 with SMTP id 8so232574ewy.28
        for <git@vger.kernel.org>; Mon, 08 Mar 2010 09:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type;
        bh=0x+MeS4N1WcPguKKrOE287sg/HLEoBzx2ds2CxwqTLU=;
        b=Uut9d1/rcu8alSjLVO8JYCJeWqvNSrfDn8uqrBQFBsVdN5YmNAhtRo2Y6y1y9P4njP
         pwFTmCiRpmaciNw721fq0TFk3Lf0JASHeLXgJ6lItDaewJPi9BM6A2lA9GpLjpFQIT9L
         LqJaenu8GzZsSxzz32j457udhxvoqrLxGgUjs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=sKGLqHuXoU0P/zacEZc9nXvh9iUjXoTR9q4xjA356Y100poh0fJ6ILSekw9yGFZUzc
         A8eligcrjYYCbufpNWJLZgc4eU8XQOLYqa5FrKT91qZENQJcRarD/uL97Bl5Y9etejCd
         hgwGsdlDMsGzWcCcE0tUqJ/hzMmmavaBSQlfg=
Received: by 10.103.84.1 with SMTP id m1mr3703215mul.26.1268068103267; Mon, 08 
	Mar 2010 09:08:23 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141774>

I've discovered a regression in git-add the 1.7 release which I can't
see reported anywhere. It was introduced in
48ffef966c762578eb818c0c54a7e11dd054f5db by Junio C Hamano at Fri Jan
8 23:05:41 2010.

The problem is that when you have a .gitignore file with * in it
git-add will only complain that you're trying to add ignored files if
they're in the top level of your repository, for files in
subdirectories it now just silently fails:

    $ mkdir test && cd test && git init
    $ echo "*" > .gitignore
    $ mkdir directory && touch foo directory/foo

So far so good, now if I try to add 'foo' I get an error from both 1.6 and 1.7:

    $ git add foo
    The following paths are ignored by one of your .gitignore files:
    foo

But 1.7 just silently fails to add directory/foo to the index:

    $ git add directory/foo
    $ echo $?
    0

1.6 however does the right thing:

    $ git add directory/foo
    The following paths are ignored by one of your .gitignore files:
    directory/foo
    $ echo $?
    128

A test script / bisect script I used is available at
git://github.com/avar/git-add-fail.git I couldn't figure out how to
turn it into a Git test.
