From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: Shallow clones vs blame/log
Date: Wed, 2 Mar 2011 20:51:27 +0100
Message-ID: <AANLkTim87tZTN4FGLgwCHdAJH4dum4wBXqA=GcQm-uJ=@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 02 20:51:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pus58-0005G6-LD
	for gcvg-git-2@lo.gmane.org; Wed, 02 Mar 2011 20:51:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757341Ab1CBTv3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Mar 2011 14:51:29 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:48445 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756670Ab1CBTv2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2011 14:51:28 -0500
Received: by vxi39 with SMTP id 39so314315vxi.19
        for <git@vger.kernel.org>; Wed, 02 Mar 2011 11:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=A/hwfZZ2IGUrlv+MSipA+JJGNlWrLFjHFgSC81+v6Wo=;
        b=GoonkkdaK8uO0Qj9HfW+aJqhua08PZNc0fmgh7A29UotILZFG0+vQ6HKY4gZGY6c96
         /CAYBDLricB1es0dmsHmN8Fi/IsIHH+bQ8XdzOMOy4NOZ9SEMA2M0JY4b6y33RCpDcAL
         18nplQ/I2Hwp6Yk0NsmLGjEcQwev8fN3CwnVo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=WRHOyhcbOhkv9yK+y54HlerKszjbZ+STNS8f8pe0DJlOwZ4u+lRFVnXba1VXW77gt+
         bsZfrjw1end6FaYFZS3l6O2j0HfJ01PKnN0SjgGtNXs4vCOQmygV1wbQ/b1GlExxvZjg
         xPNrSqRL+/7d+ozUSYY8ZA5l6JIJr0yX2b0F8=
Received: by 10.220.168.13 with SMTP id s13mr71570vcy.0.1299095487773; Wed, 02
 Mar 2011 11:51:27 -0800 (PST)
Received: by 10.220.61.140 with HTTP; Wed, 2 Mar 2011 11:51:27 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168335>

Hi,

I'd like to confirm: when doing shallow clone with --depth=n, and then
using blame,
git does know only about n last revisions. For each change that happened before
shows "^commit" where "commit" is n+1 commit ?

I wonder if this can be more clear. I was bitten by this today. I was
using blame
on a file and it showed a commit and author for a line. But the line
was not changed
in that commit. Took me a while to understand that it's caused by
shallow copy...

I could be blamed for not reading git-blame man, but luckily ^commit is not
described there ;)

Also, git-log puts all not cloned commits into last not cloned commit,
and there's no
information that it's a "fake" commit.


Example:

/tmp$ mkdir r && cd r && git init && echo a > a && git add a && git
commit -a -m first && echo b > b && git add b && git commit -a -m
second && echo aa >> a && git commit -a -m third && echo bb >> b &&
git commit -a -m fourth  && cd ..
warning: templates not found /home/piotr/share/git-core/templates
Initialized empty Git repository in /tmp/r/.git/
[master (root-commit) 890ec47] first
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 a
[master f969fda] second
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 b
[master 20c3c2c] third
 1 files changed, 1 insertions(+), 0 deletions(-)
[master 9dcd745] fourth
 1 files changed, 1 insertions(+), 0 deletions(-)

/tmp$ DIR=clone1;  git clone --depth 1 file:///tmp/r $DIR && cd $DIR
&& git log --stat --oneline
Cloning into clone1...
warning: templates not found /home/piotr/share/git-core/templates
remote: Counting objects: 7, done.
remote: Compressing objects: 100% (4/4), done.
Receiving objects: 100% (7/7), 515 bytes, done.
remote: Total 7 (delta 0), reused 0 (delta 0)
9dcd745 fourth
 b |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)
20c3c2c third
 a |    2 ++
 b |    1 +
 2 files changed, 3 insertions(+), 0 deletions(-)

/tmp/clone1$ git blame a
^20c3c2c (Piotr Krukowiecki 2011-03-02 20:42:53 +0100 1) a
^20c3c2c (Piotr Krukowiecki 2011-03-02 20:42:53 +0100 2) aa

/tmp/clone1$ git blame b
^20c3c2c (Piotr Krukowiecki 2011-03-02 20:42:53 +0100 1) b
9dcd7453 (Piotr Krukowiecki 2011-03-02 20:42:53 +0100 2) bb
