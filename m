From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: [PATCH/RFC 00/11] daemon-win32
Date: Thu, 26 Nov 2009 00:44:09 +0000
Message-ID: <1259196260-3064-1-git-send-email-kusmabite@gmail.com>
Cc: git@vger.kernel.org, dotzenlabs@gmail.com,
	Erik Faye-Lund <kusmabite@gmail.com>
To: msysgit@googlegroups.com
X-From: git-owner@vger.kernel.org Thu Nov 26 01:44:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDST5-0000z6-92
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 01:44:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965054AbZKZAoH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 19:44:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759876AbZKZAoG
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 19:44:06 -0500
Received: from ey-out-2122.google.com ([74.125.78.24]:40313 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759731AbZKZAoG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 19:44:06 -0500
Received: by ey-out-2122.google.com with SMTP id 4so88193eyf.19
        for <git@vger.kernel.org>; Wed, 25 Nov 2009 16:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=B7jo5y3b8fCjsXD4rtg7G6YrfigwfnbvU6Y246MK5yI=;
        b=h94oRYXQyaayXD5eFm3SmYuD3yyQEu0xWdLsntr0nLbjczzqGG5eGhUVTuOZY8npRD
         LT3tMU3MNzRMMeJXWKVcgDcKDmdm/QcKmhY94yMfvucApr0VcfsNGi+YQusC4B7pMrBR
         6vmUmSdTQhEJRuZq+X+t95WaR+N6V7cCQuYNU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=YSJxSdB5bb5m01t5AizRNkNzhW6K9FdK2khsMwE3bkq6PT+R2+Cqov7oa5GUKN2zsl
         WAef1VrYejkz1bQt/YwCyDKCwCERQbl2D/PceaNTL3MO0sNU3QcQYer8Ma4sZ2SAqE6P
         /QMtoDOdlED/6om7SpHmdEeA8QzNFp90drCbs=
Received: by 10.213.23.205 with SMTP id s13mr1413751ebb.4.1259196251502;
        Wed, 25 Nov 2009 16:44:11 -0800 (PST)
Received: from localhost (cm-84.215.142.12.getinternet.no [84.215.142.12])
        by mx.google.com with ESMTPS id 24sm390016eyx.30.2009.11.25.16.44.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 25 Nov 2009 16:44:10 -0800 (PST)
X-Mailer: git-send-email 1.6.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133731>

This is my stab at cleaning up Mike Pape's patches for git-daemon
on Windows for submission, plus some of my own.

* Patch 1-4 originate from Mike Pape, but have been cleaned up quite
  a lot by me. I hope Mike won't hate me. Credit have been retained,
  as all important code here were written by Mike. The commit
  messages were written mostly by me.

* Patch 5 is a trivial old-style function declaration fix.

* Patch 6 introduces two new functions to the run-command API,
  kill_async() and is_async_alive().

* Patch 7-8 removes the stdin/stdout redirection for the service
  functions, as redirecting won't work for the threaded version.

* Patch 9 converts the daemon-code to use the run-command API. This
  is the patch I expect to be the most controversial.

* Patch 10 is about using line-buffered mode instead of full-buffered
  mode for stderr.

* Patch 11 finally enables compilation of git-daemon on MinGW.

Let the flames begin!

Erik Faye-Lund (7):
  inet_ntop: fix a couple of old-style decls
  run-command: add kill_async() and is_async_alive()
  run-command: support input-fd
  daemon: use explicit file descriptor
  daemon: use run-command api for async serving
  daemon: use full buffered mode for stderr
  mingw: compile git-daemon

Mike Pape (4):
  mingw: add network-wrappers for daemon
  strbuf: add non-variadic function strbuf_vaddf()
  mingw: implement syslog
  compat: add inet_pton and inet_ntop prototypes

 Makefile           |    8 ++-
 compat/inet_ntop.c |   22 ++------
 compat/inet_pton.c |    8 ++-
 compat/mingw.c     |  111 +++++++++++++++++++++++++++++++++++++++++--
 compat/mingw.h     |   32 ++++++++++++
 daemon.c           |  134 ++++++++++++++++++++++++++--------------------------
 git-compat-util.h  |    9 ++++
 run-command.c      |   32 ++++++++++++-
 run-command.h      |    2 +
 strbuf.c           |   15 ++++--
 strbuf.h           |    1 +
 11 files changed, 274 insertions(+), 100 deletions(-)
