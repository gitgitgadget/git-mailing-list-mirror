From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: win32-daemon breakage when merged to pu
Date: Tue, 9 Nov 2010 11:32:41 +0100
Message-ID: <AANLkTikXv8BhW-fz=pZ5iS6rHJB5mxMUhk0KFO3JSwWv@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>,
	Markus Duft <mduft@gentoo.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 09 11:33:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFlVm-0005UR-R0
	for gcvg-git-2@lo.gmane.org; Tue, 09 Nov 2010 11:33:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754851Ab0KIKdF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Nov 2010 05:33:05 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:54605 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754105Ab0KIKdC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Nov 2010 05:33:02 -0500
Received: by fxm16 with SMTP id 16so4803458fxm.19
        for <git@vger.kernel.org>; Tue, 09 Nov 2010 02:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to:from
         :date:message-id:subject:to:cc:content-type;
        bh=574TK8dB+Tu+UrK4CYjsFhobmklhmLDf4Z8SI39eUPA=;
        b=DkxExC9j1gXHB9GFsSn41OnArfzZPEWh3gdItZbRmwRxeO0RVfB2VcWz18nLxlc2I0
         NMUjkd3/khJalRfllD6QS6ne4fKVIk2KoVxWY+iH515qB5igduxB6PKb6Qad4dz5Uuqc
         6tZNjHiu3ylDAGf1vsU7lPa/jO50LVHKBqqrs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:from:date:message-id:subject:to:cc
         :content-type;
        b=nYZQpAbM85TB0l4qQW38Y0/ohVLO/XmeCYBwexXIfU1seqG0tBXoDQpAug62JqcKUu
         3WC1J65nO7XSFzumXHrVo3VQKsOCOIKcdnZ0FNx4TWxiOw9bKZU8S9iQ5aNTFM4zUQv5
         KCz8Ovm2GjNL1MR3a2+1GvzphdnCrto1/pOW4=
Received: by 10.223.78.136 with SMTP id l8mr4880210fak.82.1289298781407; Tue,
 09 Nov 2010 02:33:01 -0800 (PST)
Received: by 10.223.96.66 with HTTP; Tue, 9 Nov 2010 02:32:41 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161030>

The last commit in 'ef/mingw-daemon' (a666b47) builds just fine for
me, but the commit merging it (683df47: "Merge branch
'ef/mingw-daemon' into pu") does not:

$ make
    CC daemon.o
daemon.c: In function 'service_loop':
daemon.c:885: error: invalid application of 'sizeof' to incomplete type 'struct
pollfd'
daemon.c:888: error: invalid use of undefined type 'struct pollfd'
daemon.c:888: error: dereferencing pointer to incomplete type
daemon.c:889: error: invalid use of undefined type 'struct pollfd'
daemon.c:889: error: dereferencing pointer to incomplete type
daemon.c:889: error: 'POLLIN' undeclared (first use in this function)
daemon.c:889: error: (Each undeclared identifier is reported only once
daemon.c:889: error: for each function it appears in.)
daemon.c:899: warning: implicit declaration of function 'poll'
daemon.c:909: error: invalid use of undefined type 'struct pollfd'
daemon.c:909: error: dereferencing pointer to incomplete type
daemon.c:918: error: invalid use of undefined type 'struct pollfd'
daemon.c:918: error: dereferencing pointer to incomplete type
make: *** [daemon.o] Error 1

This is because the merge-commit (683df47) moves the inclusion of
<sys/poll.h> inside the "#ifndef __MINGW32__"-block, effectively
undoing part of fdc1211 ("mingw: use poll-emulation from gnulib").

I'm guessing this is because of a conflict with 2844923 ("add support
for the SUA layer (interix; windows)").

I supposed the correct conflict-resolution would be to keep Markus'
new conditional inclusion, but move it to the location I changed it
to. With this patch on top it compiles just fine for me:

diff --git a/git-compat-util.h b/git-compat-util.h
index 652e9b5..490f969 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -105,13 +105,13 @@
 #include <regex.h>
 #include <utime.h>
 #include <syslog.h>
-#ifndef __MINGW32__
-#include <sys/wait.h>
 #ifndef NO_SYS_POLL_H
 #include <sys/poll.h>
 #else
 #include <poll.h>
 #endif
+#ifndef __MINGW32__
+#include <sys/wait.h>
 #include <sys/socket.h>
 #include <sys/ioctl.h>
 #include <termios.h>
