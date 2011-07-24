From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 03/11] svn-fe: add EXTLIBS needed for parse-options
Date: Sun, 24 Jul 2011 15:14:39 +0200
Message-ID: <20110724131439.GC2934@elie.dc0b.debconf.org>
References: <1310559673-5026-1-git-send-email-divanorama@gmail.com>
 <1310559673-5026-4-git-send-email-divanorama@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Barr <davidbarr@google.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Dmitry Ivankov <divanorama@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 24 15:14:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QkyW9-0004Oy-LD
	for gcvg-git-2@lo.gmane.org; Sun, 24 Jul 2011 15:14:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752626Ab1GXNOp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jul 2011 09:14:45 -0400
Received: from mail-fx0-f52.google.com ([209.85.161.52]:33354 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752526Ab1GXNOo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jul 2011 09:14:44 -0400
Received: by fxd18 with SMTP id 18so7583788fxd.11
        for <git@vger.kernel.org>; Sun, 24 Jul 2011 06:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=1cLTleMvjaWzaSVmNhPUqWmGFDPYy119OkVXffW+YQY=;
        b=Rz5nGR9EWBI2erCNcvQWOPaGAEpfVLcv2mkvtl8K+EPSt7HakzW0uEVG0sM5Ao5kJZ
         RPKCjND5OcK0o+2P0zThfjzeP/kfbVVgCrLEALKF7CkI1n3dJ9VZOgxn7jyqaNB8ClDf
         aCM/DqgresYq3GBt7aQKv05aFkeHq0OJ/tL54=
Received: by 10.223.157.206 with SMTP id c14mr2412683fax.126.1311513283188;
        Sun, 24 Jul 2011 06:14:43 -0700 (PDT)
Received: from elie.dc0b.debconf.org ([78.28.140.4])
        by mx.google.com with ESMTPS id l22sm3191258fam.33.2011.07.24.06.14.41
        (version=SSLv3 cipher=OTHER);
        Sun, 24 Jul 2011 06:14:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1310559673-5026-4-git-send-email-divanorama@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177745>

Dmitry Ivankov wrote:

> Currently parse-options.o pull quite a big bunch of dependencies
> that are neither pulled in by svn-fe Makefile nor included in libgit.a.
>
> Use a temporary hack: put hardcoded EXTLIBS

In other words, this is a workaround for the lack of
http://thread.gmane.org/gmane.comp.version-control.git/176318/focus=176573
(Reduce parse-options.o dependencies).

> this may not work in all
> setups because /Makefile logic is not repeated.
>
> For example, one may need -lcrypto instead of -lssl or no crypto library
> if BLK_SHA1 is set, also an additional -lz or -lpcre could be required.

Better to pull in too many libs and let the operator remove them from
the Makefile than too few and make her guess.  Though of course
neither should be needed. :)

With the following applied on top locally, it works for me.

-- >8 --
Subject: squash! svn-fe: add EXTLIBS needed for parse-options

-lcrypto is needed for SHA-1 routines unless NO_OPENSSL or BLK_SHA1
is set, -lpcre is for grep if USE_LIBPCRE is set, and -lz is needed
throughout.

In the future, none of these should be needed, after a little
rearranging to ensure that parse-options.o has no references to
translation units that need to access the object db.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 contrib/svn-fe/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/svn-fe/Makefile b/contrib/svn-fe/Makefile
index dc6dafef..14b07b5b 100644
--- a/contrib/svn-fe/Makefile
+++ b/contrib/svn-fe/Makefile
@@ -8,7 +8,7 @@ CFLAGS = -g -O2 -Wall
 LDFLAGS =
 ALL_CFLAGS = $(CFLAGS)
 ALL_LDFLAGS = $(LDFLAGS)
-EXTLIBS = -lssl -lpthread
+EXTLIBS = -lssl -lcrypto -lpcre -lz -lpthread
 
 GIT_LIB = ../../libgit.a
 VCSSVN_LIB = ../../vcs-svn/lib.a
-- 
1.7.6
