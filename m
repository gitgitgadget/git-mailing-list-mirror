From: Will Entriken <fulldecent@gmail.com>
Subject: gc.linkedobjectdir discussion
Date: Tue, 24 Feb 2015 16:56:55 -0500
Message-ID: <CAFwrLX7AVbhbP-Ha3Vag+7o5a-8fSaQxxx+z0DRurdzY-pBwkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 24 22:57:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQNTQ-0002q0-A9
	for gcvg-git-2@plane.gmane.org; Tue, 24 Feb 2015 22:57:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752835AbbBXV44 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2015 16:56:56 -0500
Received: from mail-ig0-f173.google.com ([209.85.213.173]:61352 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752785AbbBXV4z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2015 16:56:55 -0500
Received: by mail-ig0-f173.google.com with SMTP id a13so30613932igq.0
        for <git@vger.kernel.org>; Tue, 24 Feb 2015 13:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=QV8bKZYjLgonnSsTqC7j3u326Rz+jY9ze7R9lJ9oV/Y=;
        b=Q4jMIrE9wlOQ3/rWyciZQxU9bW6rO221b1O/hxCK9dozWA1RZs0ekRAvsHbkP6cPO5
         nIDdRC1RE7/APtArIAwZ60/qd2kJf4xbHEhKC+JE6/cSTPtOvDq2/UB4GSs4zTjfZCwd
         UuqcS9Y1y4lcm6cykgCPzY1s1Ub/nAZvrQHK8Dx3dIkCNJi5LZ2JIysONCT8EwmyekQZ
         QJFVmgCC1B+QZW0TMMODmy3OvbEc/62+y+MSySdVxbUUPFDOwmDZrPp2jyyEdKrPfb03
         CCXJTmEJJd3NZpanNJZVqJEMrfNHuKRhB/khfsfrMiJds7jlJNM7s5dIw1qkJ/hio5DP
         7e5Q==
X-Received: by 10.50.79.166 with SMTP id k6mr473070igx.27.1424815015187; Tue,
 24 Feb 2015 13:56:55 -0800 (PST)
Received: by 10.36.80.201 with HTTP; Tue, 24 Feb 2015 13:56:55 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264350>

Hello,

This post presents an idea for storing git objects into a hard-linked
shared directory which would allow performance gains and safety so
that users can set it and forget it.

SETUP:
Users run `git config --global gc.linkedobjectdir ~/.gitsharedobjects`

USAGE - CACHE MISS:
During a pull, git will look for the needed object in LINKEDOBJECTDIR,
similar to how it looks in GIT_ALTERNATE_OBJECT_DIRECTORIES. If it is
not found, the object is received as normal and then hard linked into
the object store at LINKEDOBJECTDIR.

USAGE - CACHE HIT:
During another pull or clone on a different working directory, git
will find the required object in LINKEDOBJECTDIR and hard link into
the active repo's object store.

USAGE - DELETING:
Whenever deleting an object, git will stat the file to see to see if
its link count is 2, if so, both copies are deleted.

PERIODIC MAINTENANCE:
Periodically, git will check all objects in LINKEDOBJECTDIR for a link
count of 1 and delete such files. This will happen if a repository
with linking is deleted with `rm -rf`.

This feature would be a benefit to organizations which do lots of
cloning (think Travis CI) or users that clone the same project
multiple times or have the same file used across different repos.

Please share your thoughts.

Thank you,
Will
