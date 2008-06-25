From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: [BUG] Recent git-svn gets checksum errors on very large fetches
Date: Tue, 24 Jun 2008 23:23:57 -0400
Message-ID: <32541b130806242023r167935f4off85cdd6a49d2750@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>, aroben@apple.com
X-From: git-owner@vger.kernel.org Wed Jun 25 05:24:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBLcu-0002wZ-0u
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 05:24:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754932AbYFYDYA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 23:24:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754852AbYFYDYA
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 23:24:00 -0400
Received: from fk-out-0910.google.com ([209.85.128.190]:24208 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752462AbYFYDX7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 23:23:59 -0400
Received: by fk-out-0910.google.com with SMTP id 18so3050361fkq.5
        for <git@vger.kernel.org>; Tue, 24 Jun 2008 20:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=hpJqfJD4A4SCsleM59IXxW8ygQrOu8xc2dTzILmINKE=;
        b=xt0QpHHfbRRfprU5v5lmhjZGnk9F67zPCoIyoJSEOL1JWyHdKNBvZPX8t1erbzFCit
         YhuaY7EgDI5vTCH3FlGt3YavlJFRymdX+x8B2sv+LQL7vUHBqlBJ8IRpP/MWHujOuRLK
         RScicEBraPN4hAzNACQUVEBwYCELyfrxzw+ns=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=xZKtZ0U+dQ7VpgC07M+YoH6btOccKZp+1Fe1TqPT/A8D66Xz9PZRUyvQ6dUfZhzlk2
         djh+ifzVYfDKkXY79Yajd0gySfdC1f+1l23tFt7vKc93iHuKR6BZf3RjQ9CgvcFdiyz4
         NUoIaF2TOTJyKaCI9yD3alweuUN0EDv1c5MB8=
Received: by 10.82.181.8 with SMTP id d8mr617975buf.54.1214364237729;
        Tue, 24 Jun 2008 20:23:57 -0700 (PDT)
Received: by 10.82.175.10 with HTTP; Tue, 24 Jun 2008 20:23:57 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86207>

My svn repo has 17000+ files in 1000+ directories.  I managed to
narrow my problem down to this sequence of steps:

    mkdir poo
    cd poo
    git init
    git svn init file:///home/averyp/svn.bak/branches/MyBranch
    git svn fetch -r3095 2>&1 | tee git.out

Which culminates in:

    Checksum mismatch: ThirdParty/whateverdir/blahblah
    expected: c342eaa17fe219a764c06642bb951474
        got: 848bbb56e4c22755ffb687fb70ae1ac6

For extra excitement, if I run the same command multiple times, the
exact file (blahblah) with the checksum mismatch differs each time.
However, it tends to be a file approximately the same "distance" down
in the fetch: it's almost always in whateverdir, which contains only
333 out of the 17000 files.

This leads me to believe there's a race condition or buffer problem
somewhere causing the problem.  Using git-bisect, I discovered that it
works fine in git 1.5.5.1, and that this patch is the one to blame:

  commit ffe256f9bac8a40ff751a9341a5869d98f72c285
  Author: Adam Roben <aroben@apple.com>
  Date:   Fri May 23 16:19:41 2008 +0200

    git-svn: Speed up fetch

Figures. :)

Reverting it directly seems to cause a conflict, so I can't test for
sure that the latest master with this patch reverted would work
correctly.

Not quite sure what could be at fault here, or what to do next.
Unfortunately it's hard to assemble a test case for timing-related
problems like this.  Thoughts?

Thanks,

Avery
