From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: dmalloc and leaks in git
Date: Sat, 8 Dec 2007 15:53:44 -0500
Message-ID: <9e4733910712081253t7cd43f87o6001f32fddc01565@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Dec 08 21:54:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J16gb-00059y-Bw
	for gcvg-git-2@gmane.org; Sat, 08 Dec 2007 21:54:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751794AbXLHUxr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Dec 2007 15:53:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751640AbXLHUxr
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Dec 2007 15:53:47 -0500
Received: from wa-out-1112.google.com ([209.85.146.180]:9417 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750713AbXLHUxq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Dec 2007 15:53:46 -0500
Received: by wa-out-1112.google.com with SMTP id v27so2289345wah
        for <git@vger.kernel.org>; Sat, 08 Dec 2007 12:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=sV3cu5qljGoefU26USxXqoKxuoqlaRxvQfZbn9uBLoY=;
        b=l0PdgYZQyFm/HbuAB6UvwaUj4ylf/tKsTF+2KfTmvq0v0bGgV1Y9Mx5naHoskfcUsAlIVRtmg5GVXxmE74IMGuSoxRGDmzoELpYHMQ9/7qiyd2g0F0P4cr6G1i93vmHSt9FCaNteGsScEM8WoITqjbAgPkLbO4aWMKiC5yHLCuM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=TcXV5kd8r7DFsBTc7NwFK6TKjM+zSn2P6zTt982XU+FF8dcTyTW8YCGSyVC5n40BW/NazBcXFIbYyMwkE5UtjJ1X+IQRfEcf77tRbypQYiEv2Yrwssr+N1eI9m0eTmI7ZaR64z4m1gWJrF9zk4d4cOpkEIS/miwCV/GrJqLoz3s=
Received: by 10.114.173.15 with SMTP id v15mr1269613wae.1197147225015;
        Sat, 08 Dec 2007 12:53:45 -0800 (PST)
Received: by 10.114.208.17 with HTTP; Sat, 8 Dec 2007 12:53:44 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67568>

It is very easy to use dmalloc with git. Follow the instructions here,
http://dmalloc.com/docs/latest/online/dmalloc_4.html

But using dmalloc shows a pervasive problem, none of the git commands
are cleaning up after themselves. For example I ran a simple command,
git-status, and thousands of objects were not freed.

Normally this doesn't hurt since exiting the process obviously frees
all of the memory. But when programming this way it becomes impossible
to tell which leaks were on purpose and which were accidental.

To sort this out an #ifdef DMALLOC needs to be created and then code
for freeing all of the 'on purpose' leaks needs to be added in an
IFDEF right before the process exits. The test scripts can then be
modified to ensure that everything is freed when the command exits.

I've used this process on several projects I've managed and it is a
very good thing to do. Once the new infrastructure is in place leaks
can be detected automatically and nipped in the bud before they get
out of control. The key to making this work is getting code in place
in the #ifdef to free those "on-purpose" leaks.

I tried a couple of year ago to add leak detection to Mozilla but
Mozilla is way too far gone. There are 10,000 places where things are
allocated and not being freed. It is a huge manually intensive task
sorting out which of these were on-purpose vs accidental. If Mozilla
had followed a discipline of ensuring that nothing was every leaked
(by using the scheme above) a lot of recent leak clean up work could
have been avoided.

I don't know enough about the structure of git to add the cleanups in
#ifdefs before exit. People who wrote the commands are going to have
to help out with this.

diff --git a/Makefile b/Makefile
index 0a5df7a..426830c 100644
--- a/Makefile
+++ b/Makefile
@@ -752,7 +752,7 @@ SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))
 PERL_PATH_SQ = $(subst ','\'',$(PERL_PATH))
 TCLTK_PATH_SQ = $(subst ','\'',$(TCLTK_PATH))

-LIBS = $(GITLIBS) $(EXTLIBS)
+LIBS = $(GITLIBS) $(EXTLIBS) -ldmalloc

 BASIC_CFLAGS += -DSHA1_HEADER='$(SHA1_HEADER_SQ)' \
 	$(COMPAT_CFLAGS)
diff --git a/git-compat-util.h b/git-compat-util.h
index 79eb10e..8894c30 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -428,3 +428,5 @@ static inline int strtol_i(char const *s, int
base, int *result)
 }

 #endif
+
+#include "dmalloc.h"

-- 
Jon Smirl
jonsmirl@gmail.com
