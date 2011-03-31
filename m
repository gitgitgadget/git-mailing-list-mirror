From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH maint resend] compat: add missing #include <sys/resource.h>
Date: Thu, 31 Mar 2011 17:59:09 -0500
Message-ID: <20110331225909.GA21429@elie>
References: <1300271879-2050-1-git-send-email-stsp@stsp.name>
 <20110318202351.GA22696@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Stefan Sperling <stsp@stsp.name>,
	Arnaud Lacombe <lacombar@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 01 00:59:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5Qpl-0008WB-1m
	for gcvg-git-2@lo.gmane.org; Fri, 01 Apr 2011 00:59:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759447Ab1CaW7S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2011 18:59:18 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:43957 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759435Ab1CaW7R (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2011 18:59:17 -0400
Received: by gxk21 with SMTP id 21so1183540gxk.19
        for <git@vger.kernel.org>; Thu, 31 Mar 2011 15:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=kZoSR0Q+gva8lKDtk2H7N64dgfO4WVfeILjymgf2UfI=;
        b=GU5vSrRwwXnQVV8Ikj1oJA3M6bgAzkL+3j+e5I0vxz2FEM78m8+Dg9YuZ7o+Xi2pst
         XiOwTs4nE6ACJzbEYxf13wC6GaHqrnNlbpJZ3fyyk1ZfEG1XEwEdbJ42QJGD442bn6Sz
         m9cmk6A3Nm+xwcUHDMQIjm8yUtA19LGFs6w0k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=feM90HoAnUpst3aHZTEQEnrbjB94mMLdmcUpo3hUs/n1PpUtyKazkVPnGTrv7S0zc/
         2LtXHYOVdG9ld5p2+mreKDfGIuFysOL14P0HqdejnXDUjFqg+num1K6OkG/NVikijGs+
         trMwrDQma/slFN65xZ/JWNa1jfQEKG5vYtVwY=
Received: by 10.236.185.41 with SMTP id t29mr2174049yhm.160.1301612356102;
        Thu, 31 Mar 2011 15:59:16 -0700 (PDT)
Received: from elie (adsl-68-255-107-98.dsl.chcgil.sbcglobal.net [68.255.107.98])
        by mx.google.com with ESMTPS id 23sm808466yhl.101.2011.03.31.15.59.14
        (version=SSLv3 cipher=OTHER);
        Thu, 31 Mar 2011 15:59:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110318202351.GA22696@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170541>

Date: Fri, 18 Mar 2011 15:23:52 -0500

Starting with commit c793430 (Limit file descriptors used by packs,
2011-02-28), git uses getrlimit to tell how many file descriptors it
can use.  Unfortunately it does not include the header declaring that
function, resulting in compilation errors:

 sha1_file.c: In function 'open_packed_git_1':
 sha1_file.c:718: error: storage size of 'lim' isn't known
 sha1_file.c:721: warning: implicit declaration of function 'getrlimit'
 sha1_file.c:721: error: 'RLIMIT_NOFILE' undeclared (first use in this function)
 sha1_file.c:718: warning: unused variable 'lim'

The standard header to include for this is <sys/resource.h> (which on
some systems itself requires declarations from <sys/types.h> or
<sys/time.h>).  Probably the problem was missed until now because in
current glibc sys/resource.h happens to be included by sys/wait.h.

MinGW does not provide sys/resource.h (and compat/mingw takes care of
providing getrlimit some other way), so add the missing #include to
the "#ifndef __MINGW32__" block in git-compat-util.h.

Reported-by: Stefan Sperling <stsp@stsp.name>
Tested-by: Stefan Sperling <stsp@stsp.name> [on OpenBSD]
Tested-by: Arnaud Lacombe <lacombar@gmail.com> [on FreeBSD 8]
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Oops, should have sent this as its own message before.  Thanks to
doug on irc for a ping.

 git-compat-util.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index bf947b1..79b5122 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -118,6 +118,7 @@
 #endif
 #ifndef __MINGW32__
 #include <sys/wait.h>
+#include <sys/resource.h>
 #include <sys/socket.h>
 #include <sys/ioctl.h>
 #include <termios.h>
-- 
1.7.4.2
