From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: [PATCH v2 00/14] daemon-win32
Date: Fri, 15 Jan 2010 22:30:19 +0100
Message-ID: <1263591033-4992-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, j6t@kdbg.org,
	Erik Faye-Lund <kusmabite@gmail.com>
To: msysgit@googlegroups.com
X-From: git-owner@vger.kernel.org Fri Jan 15 22:31:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVtkz-0005SA-GW
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jan 2010 22:31:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758301Ab0AOVaz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Jan 2010 16:30:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758274Ab0AOVaz
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 16:30:55 -0500
Received: from mail-ew0-f209.google.com ([209.85.219.209]:42825 "EHLO
	mail-ew0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758259Ab0AOVay (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 16:30:54 -0500
Received: by ewy1 with SMTP id 1so568991ewy.28
        for <git@vger.kernel.org>; Fri, 15 Jan 2010 13:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=ydSvplyCWCxeODJ/gWC1f2uiGXNdUix1I+7mahWUt44=;
        b=ZNTXpviKDBbkJS9U7aQxI55xrbnI+r/123flq02xhEAOtU8w7VwiDRnDUyEKUopI72
         v7P30O0EhgLdjbBqah425jQEt4ZmzkhZaBuVZbM2ibl1rZ3M+veL6xoqLooH3PZfHL3x
         2nGAKrCmi58k7TcmiA0JGZ1wgcBEKi99+9110=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=I7d5bqtXhSZVViHGvuYa2iLkkgkkxhPEctL4Gz+QVXsCsTlmF3BF7eM6CMdekcmf4V
         JcNMuX2QrDoGakaxbNIbxle94yA37YzvSQpNMWIkHsXB82KYKn2/+qCvKenn9zHSGMh2
         7fUnnskpQXHX9oVhSbFDobTNYmZoLYcSC5Ges=
Received: by 10.213.97.22 with SMTP id j22mr171513ebn.96.1263591050789;
        Fri, 15 Jan 2010 13:30:50 -0800 (PST)
Received: from localhost (cm-84.215.142.12.getinternet.no [84.215.142.12])
        by mx.google.com with ESMTPS id 16sm1810302ewy.2.2010.01.15.13.30.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 15 Jan 2010 13:30:50 -0800 (PST)
X-Mailer: git-send-email 1.6.6.95.g5f22c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137119>

Here's the long overdue v2 of my daemon-win32 attempt. A lot
has happened since v1. Most importantly, I abandoned using
the async API to replace fork(), and went for explicitly
spawning child process that handle the connection.

The patches are on top of the current version of Junio's
master-branch.

When talking about patch numbers here, I'm referring to the numbers
from the previous round.

Patch 1 has been adjusted to work on top of Martin's ipv6 patches.

Patch 2 has been dropped, because it was made obsolete by the
changes to patch 3.

Patch 3 has been simplified as suggested by Hannes. The problem with
reporting IPv6 addresses should still be there in theory, but I
haven't been able to trigger it. I'm having a feeling that it's better
to do a case-by-case patch of the code that reports for this one.

Patch 4 and 5 are unchanged.

Patch 6 and 7 were dropped, in favour of a new approach.

Patch 8 has been updated as suggested.

Patch 9 has been rewritten to spawn a separate child process that
serves the client.

Patch 10 is unchanged

Patch 11 has been updated as suggested.

In addition, I've added a patch that add some needed support in
our waitpid()-emulation, a (very limited) kill()-emulation, a patch
that uses real PIDs on Windows (instead of process-local kernel-handles=
),
a patch that changes the code to use select() instead of poll() to wait
for socket-action (due to our limited poll-emulation). And there's a
patch that makes sure connections are reported from the root-process.

In addition, I've attached an updated version of the getaddrinfo()-fix
that Martin sent me privately. I removed Hannes sign-off (as requested =
by
Martin, due to the update)

The branch can also be found here:
http://repo.or.cz/w/git/kusma.git daemon-win32-v2

Puuuh, I hope I didn't miss anything important.


Erik Faye-Lund (10):
  inet_ntop: fix a couple of old-style decls
  mingw: support waitpid with pid > 0 and WNOHANG
  mingw: use real pid
  mingw: add kill emulation
  daemon: use explicit file descriptor
  daemon: use run-command api for async serving
  daemon: use full buffered mode for stderr
  mingw: compile git-daemon
  daemon: use select() instead of poll()
  daemon: report connection from root-process

Martin Storsj=C3=B6 (1):
  Improve the mingw getaddrinfo stub to handle more use cases

Mike Pape (3):
  mingw: add network-wrappers for daemon
  mingw: implement syslog
  compat: add inet_pton and inet_ntop prototypes

 Makefile           |   10 +-
 compat/inet_ntop.c |   22 ++----
 compat/inet_pton.c |    8 +-
 compat/mingw.c     |  141 +++++++++++++++++++++++++++++--
 compat/mingw.h     |   80 +++++++++++++++++-
 daemon.c           |  236 ++++++++++++++++++++++++++++----------------=
--------
 git-compat-util.h  |    9 ++
 7 files changed, 361 insertions(+), 145 deletions(-)
