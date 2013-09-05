From: John Szakmeister <john@szakmeister.net>
Subject: Zero padded file modes...
Date: Thu, 5 Sep 2013 10:00:39 -0400
Message-ID: <CAEBDL5W3DL0v=TusuB7Vg-4bWdAJh5d2Psc1N0Qe+KK3bZH3=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 05 16:00:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHa75-0000lo-Jg
	for gcvg-git-2@plane.gmane.org; Thu, 05 Sep 2013 16:00:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752529Ab3IEOAl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Sep 2013 10:00:41 -0400
Received: from mail-wi0-f171.google.com ([209.85.212.171]:56353 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752451Ab3IEOAl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Sep 2013 10:00:41 -0400
Received: by mail-wi0-f171.google.com with SMTP id hm2so3766806wib.10
        for <git@vger.kernel.org>; Thu, 05 Sep 2013 07:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:message-id:subject:from:to:content-type;
        bh=w4f+BRC1mKq7WpSy0oGEhMJ/GpnHXP53XILlSrvmbmw=;
        b=AZMZpZsXtWHPz4dcS9/i2ACDfow2DJTYT0pKkzH9gjo1FSOOkCQ/CNrrxyronOlL7q
         P+z60ulrLc4WRSrSoTb8OsbhawQpJgsZi4Yz/uS6ZVyfnjwS/g48ExqpWv/jTK7Ida8c
         JB4zt794J5bpzXbLh9Fl6LuCAgSLYpI+fhgVFJfF+VYPc7G0AjnCpYVSuhyZ9JAgcR8J
         AUSRe7kJMPs8+LbY8bQluxC89WOrkDBWw4mZnbg2ilZSdetkGim57A6dk0IdSfZAxTjo
         XzLNukDC1azO02o1iePI9hY/X8Vy3pJ/1JEmNmsJ9Ntvd3BSe/f4tmi/LlZWIU6weaJM
         2Qww==
X-Received: by 10.180.38.98 with SMTP id f2mr6489691wik.39.1378389639629; Thu,
 05 Sep 2013 07:00:39 -0700 (PDT)
Received: by 10.180.90.105 with HTTP; Thu, 5 Sep 2013 07:00:39 -0700 (PDT)
X-Google-Sender-Auth: F833XhxuVM-IExNIeBHYT9ppILk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233959>

I went to clone a repository from GitHub today and discovered
something interesting:

    :: git clone https://github.com/liebke/incanter.git
    Cloning into 'incanter'...
    remote: Counting objects: 10457, done.
    remote: Compressing objects: 100% (3018/3018), done.
    error: object 4946e1ba09ba5655202a7a5d81ae106b08411061:contains
zero-padded file modes
    fatal: Error in object
    fatal: index-pack failed

At first, it surprised me that no one has seen the issue before,
but then I remembered I have transfer.fsckObjects=true in my
config.  Turning it off, I was able to clone.  Running `git
fsck` I see:

    :: git fsck
    Checking object directories: 100% (256/256), done.
    warning in tree 4946e1ba09ba5655202a7a5d81ae106b08411061: contains
zero-padded file modes
    warning in tree 553c5e006e53a8360126f053c3ade3d1d063c2f5: contains
zero-padded file modes
    warning in tree 0a2e7f55d7f8e1fa5469e6d83ff20365881eed1a: contains
zero-padded file modes
    Checking objects: 100% (10560/10560), done.

So there appears to be several instances of the issue in the
tree.  Looking in the archives, I ran across this thread:

    http://comments.gmane.org/gmane.comp.version-control.git/143288

In there, Nicolas Pitre says:

> This is going to screw up pack v4 (yes, someday I'll have the
> time to make it real).

I don't know if this is still true, but given that patches are
being sent out about it, I thought it relevant.

Also, searching on the issue, you'll find that a number of
repositories have suffered from this problem, and it appears the
only fix will result in different commit ids.  Given all of
that, should Git be updated to cope with zero padded modes?  Or
is there no some way of fixing the issue that doesn't involve
changing commit ids?

Thanks!

-John
