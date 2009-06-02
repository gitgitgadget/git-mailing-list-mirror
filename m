From: Raman Gupta <rocketraman@fastmail.fm>
Subject: Cygwin: Initial clone of repo containing .gitattributes has modified
 files
Date: Tue, 02 Jun 2009 08:47:34 -0400
Message-ID: <4A251F66.2020809@fastmail.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 02 14:54:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBTVZ-0006eA-Kj
	for gcvg-git-2@gmane.org; Tue, 02 Jun 2009 14:54:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753192AbZFBMyR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2009 08:54:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751661AbZFBMyQ
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jun 2009 08:54:16 -0400
Received: from smtp108.rog.mail.re2.yahoo.com ([68.142.225.206]:26221 "HELO
	smtp108.rog.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752570AbZFBMyQ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Jun 2009 08:54:16 -0400
X-Greylist: delayed 398 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Jun 2009 08:54:15 EDT
Received: (qmail 13683 invoked from network); 2 Jun 2009 12:47:38 -0000
Received: from unknown (HELO apollo.rocketraman.com) (rocketraman@99.224.155.40 with login)
  by smtp108.rog.mail.re2.yahoo.com with SMTP; 2 Jun 2009 12:47:38 -0000
X-YMail-OSG: 7yimZfsVM1ms0VnQZvjGJQRYCwa9T.Enx.Wh.F47QEV_8I_6iI7j4xgKC1eItPGmxw--
X-Yahoo-Newman-Property: ymail-3
Received: from localhost (localhost.localdomain [127.0.0.1])
	by apollo.rocketraman.com (Postfix) with ESMTP id 41FB821C0528
	for <git@vger.kernel.org>; Tue,  2 Jun 2009 08:47:38 -0400 (EDT)
X-Virus-Scanned: amavisd-new at rocketraman.com
Received: from apollo.rocketraman.com ([127.0.0.1])
	by localhost (apollo.rocketraman.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gKL4xfysJK5F for <git@vger.kernel.org>;
	Tue,  2 Jun 2009 08:47:34 -0400 (EDT)
Received: from [192.168.1.5] (zeus.rocketraman.com [192.168.1.5])
	by apollo.rocketraman.com (Postfix) with ESMTP id 805C221C0527
	for <git@vger.kernel.org>; Tue,  2 Jun 2009 08:47:34 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
X-Enigmail-Version: 0.95.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120507>

When a repository containing a .gitattributes file, which contains
other files with -crlf set is cloned on cygwin, with autocrlf = true,
the initial checkout of the working copy sets the line endings for the
-crlf files incorrectly (it ignores the .gitattributes, presumably
because it hasn't been checked out yet).

After the checkout has been done, git does correctly mark the files
with -crlf as "modified" and a simple reset --hard fixes it, but this
is very confusing for the user as the user has not done anything -- it
is git itself that has "modified" the file by not assigning the
correct line endings.

Reproduction recipe (on a cygwin binmode mount):

---------------------------------------------------
$ git --version
git version 1.6.1.2
$ git config --global core.autocrlf true
$ git config --global core.safecrlf true
$ mkdir temp.git; cd temp.git; git init
$ cat | unix2dos > file_dos
DOS
line
endings
^D
$ cat > file_unix
UNIX
line
endings
^D
$ cat > .gitattributes
.gitattributes -crlf
file_unix -crlf
^D
$ git add .gitattributes *
$ git commit -m "Test"
$ cd ..
$ git clone temp.git tempclone.git
$ cd tempclone.git
$ git status
...
#      modified:  .gitattributes
#      modified:  file_unix
...
---------------------------------------------------

Also, in a related issue, git on cygwin requires .gitattributes itself
to be included in .gitattributes, otherwise with safecrlf = true you get:

$ git add .gitattributes
fatal: LF would be replaced by CRLF in .gitattributes

(since .gitattributes created with a cygwin editor on a binmode mount
uses unix line endings)

Cheers,
Raman Gupta
