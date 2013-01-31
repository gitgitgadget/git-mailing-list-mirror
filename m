From: "Constantine A. Murenin" <mureninc@gmail.com>
Subject: Why git-whatchanged shows a commit touching every file, but git-log doesn't?
Date: Thu, 31 Jan 2013 11:09:35 -0800
Message-ID: <CAPKkNb49FUgLxZxHmQJoqccQ1XVcFYbYF8kYDp0+Y27cmi56fg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 31 20:09:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0zWI-0003rj-6C
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jan 2013 20:09:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753950Ab3AaTJh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2013 14:09:37 -0500
Received: from mail-ia0-f176.google.com ([209.85.210.176]:38791 "EHLO
	mail-ia0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751945Ab3AaTJf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2013 14:09:35 -0500
Received: by mail-ia0-f176.google.com with SMTP id i18so4300707iac.21
        for <git@vger.kernel.org>; Thu, 31 Jan 2013 11:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:date:message-id:subject:from:to
         :content-type;
        bh=+RkMEuCbgY4u+6p6ZovGh3zVoauyYb4nxy7BRJAqv0U=;
        b=PxUaYmvjS4bc6cOuy0B0BMs3kms58nykEFeohDOn2mQB9l1Q+Ne9k/qKClbmo1jnwT
         6r8i1x8Vauoed9VXG1+RpWzFnmsblnx8J6hWGD6JRbh3NoEGZYiweUX3WDgrT31uBgYL
         SSH6d/4QQzgH/aMhAVPbtpiOJuDjlMugA+hX1i9Hguh+s+Dd9wy0wjWKlZjTsZKOzPlR
         iReAFXrz9y5bPOivgEcl6lwb+pCmXqcIF91zsmZZ3K3/rEqcQoDJ5sfme02AVkrWr31/
         WSuKJtJAcSrzw53UJE18/HEAmMKZx01cNPF1lDyYXt/U3GuJEHXLe3J8vSSGB4Pcq/cQ
         9hzA==
X-Received: by 10.50.41.225 with SMTP id i1mr2070143igl.100.1359659375414;
 Thu, 31 Jan 2013 11:09:35 -0800 (PST)
Received: by 10.64.166.66 with HTTP; Thu, 31 Jan 2013 11:09:35 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215151>

Hi,

DragonFly BSD uses git as its SCM, with one single repository and
branch for both the kernel and the whole userland.

On 2011-11-26 (1322296064), someone did a commit that somehow touched
every single file in the repository, even though most of the files
were not modified one bit.

That's the offending commit from 2011-11-26:

http://gitweb.dragonflybsd.org/dragonfly.git/commitdiff/86d7f5d305c6adaa56ff4582ece9859d73106103
https://github.com/DragonFlyBSD/DragonFlyBSD/commit/86d7f5d305c6adaa56ff4582ece9859d73106103

Since then, with some tools, if you look at file history for any file
anywhere in the repo, you can see that all files were changed on
2011-11-26 with that commit, but it's only shown in some tools, and
not shown in others.


For example, the bogus 2011-11-26 commit is not shown with the following:

 * git log sys/sys/sensors.h

 * https://github.com/DragonFlyBSD/DragonFlyBSD/commits/master/sys/sys/sensors.h


However, the bogus commit is [erroneously] shown with the following:

% git whatchanged --pretty=%at sys/sys/sensors.h | cat
1322296064

:000000 100644 0000000... 554cfc2... A  sys/sys/sensors.h
1191329821

:000000 100644 0000000... 554cfc2... A  sys/sys/sensors.h
%

Notice how the file was ]A]dded once again at 1322296064 without ever
being deleted, and that the dst sha1 is the same for both the latest
and the immediately prior revision of the file.


Gitweb, unlike github, would also show the erroneous commit from 2011-11:

http://gitweb.dragonflybsd.org/dragonfly.git/history/HEAD:/sys/sys/sensors.h


Another, more representative example, which shows that src sha1 (field
names are documented in git-diff-tree(1)) is always "0000000..." in
such bogus touch-all commits (even though it makes little sense when
you consider that the files were never deleted and still have the same
dst sha1):

% git whatchanged --pretty=%at sys/sys/sysctl.h | head -9
1322296064

:000000 100644 0000000... 6659977... A  sys/sys/sysctl.h
1296826445

:100644 100644 94b8d96... 6659977... M  sys/sys/sysctl.h
1292413105

:100644 100644 8c9deaa... 94b8d96... M  sys/sys/sysctl.h
%


So, my questions are as follows:

* How was it possible for all these files to be added without first
being deleted in the first place? Was / is it a bug in git (during a
commit) to allow something like that?

* Why do some tools compact such bogus commits out (and hide them from
the user), but some don't?

* Is there a way to make git-whatchanged and gitweb ignore such bogus
commits on files that weren't actually modified, just as git-log and
github already do?


P.S. I've asked this question on
http://stackoverflow.com/q/14632828/1122270, if anyone wants a cookie.


Best regards,
Constantine.
