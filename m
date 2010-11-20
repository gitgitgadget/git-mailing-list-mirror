From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 9/8] svn-fe: Test script for handling of dumps with --deltas
Date: Sat, 20 Nov 2010 13:30:16 -0600
Message-ID: <20101120193016.GJ17823@burratino>
References: <20101118050023.GA14861@burratino>
 <20101120004525.GA17445@burratino>
 <20101120192153.GA17823@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	David Barr <david.barr@cordelta.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 20 20:30:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJt92-0003bl-WE
	for gcvg-git-2@lo.gmane.org; Sat, 20 Nov 2010 20:30:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754870Ab0KTTa0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Nov 2010 14:30:26 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:38077 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754857Ab0KTTaY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Nov 2010 14:30:24 -0500
Received: by yxf34 with SMTP id 34so3369962yxf.19
        for <git@vger.kernel.org>; Sat, 20 Nov 2010 11:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=SLEmJNXDOZXyIBpqj3YjRSlwYhA2ARJ8XTCp+X65QKs=;
        b=B0wNLCqcC9CwreD0Fgd0o674Ss30OS+wC9+Vo3eOwWvtOs1TQ3Jr+W8AEG9peixjOV
         SIbFD9AGksF+7nHdMYBYt53va6mjq3zYcRaTmnOvK2Ffs8yrDyHUrVYR593Hx7w1QyT1
         RTEWN/0TGrWBPbdi+HwEmDtbBXcecPLpARP/k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=RwXuSbzR+udoh4tNkyNjYN+qMT5E9j2WCbXXEA8IY2son2dHlBBjg3ElK/07KcosFK
         m9+alempoxG8YK/J5/hcGJ/Xr45WYDZgSNX6KrzwEX7GF6Fd2u/oUA8X49pDKjke+CHT
         CiBfGRCZGqJ5pREFtEgolZwI10A+VRWM99swI=
Received: by 10.91.16.37 with SMTP id t37mr3157340agi.72.1290281423230;
        Sat, 20 Nov 2010 11:30:23 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id d15sm3470108ana.0.2010.11.20.11.30.21
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 20 Nov 2010 11:30:22 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101120192153.GA17823@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161839>

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 contrib/svn-fe/testme.sh |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)
 create mode 100755 contrib/svn-fe/testme.sh

diff --git a/contrib/svn-fe/testme.sh b/contrib/svn-fe/testme.sh
new file mode 100755
index 0000000..29e181f
--- /dev/null
+++ b/contrib/svn-fe/testme.sh
@@ -0,0 +1,16 @@
+#!/bin/sh
+# Usage:
+#	PATH=${git_src}/contrib/svn-fe:${git_src}/bin-wrappers:$PATH
+#	testme.sh http://cvs2svn.tigris.org/svn/cvs2svn 10 test.git
+set -e
+: ${1?"URL?"}
+: ${2?"How many revisions?"}
+: ${3?"Git directory?"}
+
+git init --bare "$3"
+rm -f "$3/backflow"
+mkfifo "$3/backflow"
+
+svnrdump dump -r1:"$2" "$1" |
+svn-fe 3<backflow |
+GIT_DIR=$3 git fast-import --cat-blob-fd=3 3>backflow
-- 
1.7.2.3
