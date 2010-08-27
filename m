From: Dan Loewenherz <dloewenherz@gmail.com>
Subject: Does changing filename case breaks git's rename heuristic?
Date: Thu, 26 Aug 2010 21:57:43 -0700
Message-ID: <AANLkTinxvj85Jzb-ykK0=MmRHkz8aQzmVxexC8H+Xgno@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 27 06:58:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oor10-0002Bx-Pi
	for gcvg-git-2@lo.gmane.org; Fri, 27 Aug 2010 06:58:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753368Ab0H0E6E convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Aug 2010 00:58:04 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:42954 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753267Ab0H0E6D convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Aug 2010 00:58:03 -0400
Received: by iwn5 with SMTP id 5so2241191iwn.19
        for <git@vger.kernel.org>; Thu, 26 Aug 2010 21:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:from:date
         :message-id:subject:to:content-type:content-transfer-encoding;
        bh=brXi6u4SFlbk5t3z0vpeLz9st0PZDH/wREJ3uiUmfPk=;
        b=iuqNarDZlxxkco1uIJKBhFXOEwVQy+lj0S4B8PfCqxKAJLNpdxb0u2PHHHmCGlMd1b
         lyrqvPjXmSME0k3SjJ5XYopKGPUbjAJo0RPPVJiF56uEftpMnn9HwGRAF0AnkGWSxLCA
         vzRm4Ydo02P87XERb6TnNlKRJJdariy9r2A9Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        b=xQVHdVE9tMMMeQdaKESHPdWFHM3TODPa50rW/mUdHzabndJY+eR/995tTZDOA6c3F0
         oQL50sZnaINRDEJqLYXg7SHWpcGT6GPWUuf8TM1xVITT9pDJLgp8sylUGhQIxK3JMXp8
         2XTA7YReCAt8qt64kKUAICANaJ/nWX3iaUA7I=
Received: by 10.231.172.75 with SMTP id k11mr560866ibz.4.1282885083176; Thu,
 26 Aug 2010 21:58:03 -0700 (PDT)
Received: by 10.231.190.19 with HTTP; Thu, 26 Aug 2010 21:57:43 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154582>

Hi all,

I may be mistaking a design decision as a bug, but I wanted to throw
this out to the list to make sure. I think that re-enacting it will be
the best way to explain it.

$ mkdir test
$ cd test
$ git init
$ cat > readme
This is a test file.
^D
$=C2=A0git commit -am "first commit"
[master (root-commit) fae0d05] first commit
 1 files changed, 1 insertions(+), 0 deletions(-)

=46or personal reasons, I now want readme to be uppercase.

$ mv readme README
$ cat > README
This is the revised README.
$ git status -sb
## master
 M readme
$ git add README
$ git status -sb
## master
 M readme

At this point, I'm thinking that git is confused. Even though I've
added the README file, it still isn't staged. I follow up with the
obvious:

$ git add readme
$ git status -sb
## master
M  readme
$ git commit -m "change filename"
[master ecc009f] change filename
 1 files changed, 1 insertions(+), 1 deletions(-)

It kind of works, but not quite, since git still thinks the file is
called readme. I'd like to rename it, but whenever I run:

$ git mv readme README
fatal: destination exists, source=3Dreadme, destination=3DREADME

How about this:

$ mv README README.temp
$ git mv readme README
fatal: bad source, source=3Dreadme, destination=3DREADME

The only workable solution was this:

$ git mv readme readme.temp
$ git mv readme.temp README

I'm guessing this all has to do in some part with the logic behind
git's strategy for detecting renames. This case probably slipped under
the radar.

-Dan
