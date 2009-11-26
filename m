From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: [PATCH/RFC 00/11] daemon-win32
Date: Thu, 26 Nov 2009 00:39:07 +0000
Message-ID: <1259195958-2372-1-git-send-email-kusmabite@gmail.com>
Cc: git@vger.kernel.org, dotzenlabs@gmail.com,
	Erik Faye-Lund <kusmabite@gmail.com>
To: msysgit@googlecode.com
X-From: git-owner@vger.kernel.org Thu Nov 26 01:39:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDSOI-0007hm-Bn
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 01:39:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934941AbZKZAjL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 19:39:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934914AbZKZAjL
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 19:39:11 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:41835 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934902AbZKZAjK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 19:39:10 -0500
Received: by ewy19 with SMTP id 19so295613ewy.21
        for <git@vger.kernel.org>; Wed, 25 Nov 2009 16:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=B7jo5y3b8fCjsXD4rtg7G6YrfigwfnbvU6Y246MK5yI=;
        b=Tjzl5HOpxsJelxcH3iXU80lAxp95EAjk+9DFcNZHPTEwb3exSi2MGpnQK2Qn0Qrnz+
         M/cLK7vzOnJHuD9uOjP658iQCyiPUZNnzoDz7DdrLmxqSLipq99QFM3WkGRkKRGww5bj
         48xx+YABfvGVyQimtWkqaTvp56DB3vRVZcCJ8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=vTUmYqJ6iu9PCcgWhXYiJMuUyry9MvHD9pZ3cYC7Or0/8kT2hH7l25IgqFZ4E7f4Zh
         Uf179H+eZdNU04UEKhW3YXvYedCBWxbCInh/l8djDqEUeHDSK8VjxS8+DN/sCAFLL6EG
         qp+MOgMgunxeXudQDveL0bvupBlyiFOXu0pmI=
Received: by 10.213.0.152 with SMTP id 24mr7421184ebb.29.1259195955029;
        Wed, 25 Nov 2009 16:39:15 -0800 (PST)
Received: from localhost (cm-84.215.142.12.getinternet.no [84.215.142.12])
        by mx.google.com with ESMTPS id 28sm384983eyg.28.2009.11.25.16.39.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 25 Nov 2009 16:39:14 -0800 (PST)
X-Mailer: git-send-email 1.6.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133718>

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
