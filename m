From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH v7 00/16] daemon-win32
Date: Thu,  4 Nov 2010 02:35:08 +0100
Message-ID: <1288834524-2400-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 04 02:35:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDojz-00013V-Js
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 02:35:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754338Ab0KDBf3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Nov 2010 21:35:29 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:56990 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754294Ab0KDBf2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Nov 2010 21:35:28 -0400
Received: by eye27 with SMTP id 27so722316eye.19
        for <git@vger.kernel.org>; Wed, 03 Nov 2010 18:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=dIMJyoy4SDpmm7slm78JJTXBJavqRRkxKdWGQlFZcxI=;
        b=bGCSmbmmcDubm/O0j/3zN0Va+qUoYbrUysufVCvhxs5C8Cm/WT6VHsuOycdXTsocZG
         1kO+zGISxakjZmrohuB6xwGJCsHxHJI6bB1HI1vu8Le/z7p5C0i/DY0R+oSfnXUJ5wNv
         w4nCRXbNYkPepqm7JOyXThvXz3NJFqg0zlz54=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=O5DRSSDT36iFyv8agQmtFvEu7zfN2JH+gscW9yDK4hIZ+R93EgtaRPfBcRXz47NM/Z
         90oQNbKhx/6HG2J+/J1seIxWgVI6fTusLBhl38HArM/nI+nty0qZx/Tj5h222QRdG3tf
         bCUemvyqZOaEHkLt2gs4ouc+V+9x8TjSLYZyI=
Received: by 10.213.109.14 with SMTP id h14mr147076ebp.55.1288834526398;
        Wed, 03 Nov 2010 18:35:26 -0700 (PDT)
Received: from localhost (cm-84.215.188.225.getinternet.no [84.215.188.225])
        by mx.google.com with ESMTPS id w20sm7187862eeh.0.2010.11.03.18.35.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Nov 2010 18:35:25 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.165.gdfe39.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160662>

Here's the 7th iteration. This time two strict aliasing violations have
been fixed up (in "daemon: use run-command api for async serving" and
"daemon: get remote host address from root-process"), and a handle leak
(in "mingw: use real pid"), thanks to Pat Thoyts.

The series can also be pulled from the 'win32-daemon-v7' tag in
git://repo.or.cz/git/kusma.git

Erik Faye-Lund (12):
  inet_ntop: fix a couple of old-style decls
  mingw: use real pid
  mingw: support waitpid with pid > 0 and WNOHANG
  mingw: add kill emulation
  daemon: use run-command api for async serving
  daemon: use full buffered mode for stderr
  daemon: get remote host address from root-process
  mingw: import poll-emulation from gnulib
  mingw: use poll-emulation from gnulib
  daemon: use socklen_t
  daemon: make --inetd and --detach incompatible
  daemon: opt-out on features that require posix

Martin Storsj=C3=B6 (1):
  Improve the mingw getaddrinfo stub to handle more use cases

Mike Pape (3):
  mingw: add network-wrappers for daemon
  mingw: implement syslog
  compat: add inet_pton and inet_ntop prototypes

 Documentation/git-daemon.txt |    3 +-
 Makefile                     |   23 ++-
 compat/inet_ntop.c           |   22 +--
 compat/inet_pton.c           |    8 +-
 compat/mingw.c               |  237 ++++++++++++------
 compat/mingw.h               |   41 ++--
 compat/win32/sys/poll.c      |  596 ++++++++++++++++++++++++++++++++++=
++++++++
 compat/win32/sys/poll.h      |   53 ++++
 compat/win32/syslog.c        |   72 +++++
 compat/win32/syslog.h        |   20 ++
 daemon.c                     |  262 +++++++++++--------
 git-compat-util.h            |   11 +-
 12 files changed, 1117 insertions(+), 231 deletions(-)
 create mode 100644 compat/win32/sys/poll.c
 create mode 100644 compat/win32/sys/poll.h
 create mode 100644 compat/win32/syslog.c
 create mode 100644 compat/win32/syslog.h

--=20
1.7.3.2.162.g09d37
