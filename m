From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 3/5] Makefile: learn to generate listings for targets
 requiring special flags
Date: Wed, 6 Jan 2010 02:06:03 -0600
Message-ID: <20100106080603.GD7298@progeny.tock>
References: <20091128112546.GA10059@progeny.tock>
 <20091128113709.GD10059@progeny.tock>
 <20100106080216.GA7298@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 06 09:06:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSQuB-0002mI-Kx
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jan 2010 09:06:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755466Ab0AFIGH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jan 2010 03:06:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755430Ab0AFIGG
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jan 2010 03:06:06 -0500
Received: from mail-iw0-f194.google.com ([209.85.223.194]:62015 "EHLO
	mail-iw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755429Ab0AFIGC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jan 2010 03:06:02 -0500
Received: by iwn32 with SMTP id 32so1438831iwn.33
        for <git@vger.kernel.org>; Wed, 06 Jan 2010 00:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=gp40cIKgZv5AVqZZHMLCyAlM1TaPFA9baPL6QC9H1dU=;
        b=kJteTjdjBNDSjcErxJ7N2zwB2uubb6Q4FJIXYpp/0V32bKeSD7e+4fYeYgVzqIW5YU
         pw3Bx0iQGZF+fNEi6ACE+Af+GWFZw/+kC4a/IQyHIaHYl1flDw+UgD7RCN0dSUglFFzq
         UalyNqYGnuSBV27F/72jrWxlG1XSg7ap9mKo0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=T+xQZTBBK3qziUU6ISsq5oYFJNJEHXHLsNBR19iih1xKbKKoLQ/vbVedMO8mH/kSg3
         3hOWTaBueXFyYgW/IBnyfCjijQJq2BA7UApdOVhfnneuKAR2s1q73ZiAkV4udcCKMTSH
         PWmbIW/mVOfuQHwFZ4WTLa/lIupvgKvao/ScA=
Received: by 10.231.9.33 with SMTP id j33mr249554ibj.37.1262765161931;
        Wed, 06 Jan 2010 00:06:01 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 22sm19431039iwn.8.2010.01.06.00.06.01
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 06 Jan 2010 00:06:01 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100106080216.GA7298@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136247>

'make git.s' to debug code generation of main() fails because
git.c makes use of preprocessor symbols such as GIT_VERSION that
are not set.  make does not generate code listings for
builtin_help.c, exec_cmd.c, builtin-init-db.c, config.c, http.c,
or http-walker.c either, for the same reason.

So pass the flags used to generate each .o file when generating
the corresponding assembler listing.

Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Makefile |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/Makefile b/Makefile
index 81190a6..3d774c6 100644
--- a/Makefile
+++ b/Makefile
@@ -1468,7 +1468,7 @@ strip: $(PROGRAMS) git$X
 	$(STRIP) $(STRIP_OPTS) $(PROGRAMS) git$X
 
 git.o: common-cmds.h
-git.o: ALL_CFLAGS += -DGIT_VERSION='"$(GIT_VERSION)"' \
+git.s git.o: ALL_CFLAGS += -DGIT_VERSION='"$(GIT_VERSION)"' \
 	'-DGIT_HTML_PATH="$(htmldir_SQ)"'
 
 git$X: git.o $(BUILTIN_OBJS) $(GITLIBS)
@@ -1476,7 +1476,7 @@ git$X: git.o $(BUILTIN_OBJS) $(GITLIBS)
 		$(BUILTIN_OBJS) $(ALL_LDFLAGS) $(LIBS)
 
 builtin-help.o: common-cmds.h
-builtin-help.o: ALL_CFLAGS += \
+builtin-help.s builtin-help.o: ALL_CFLAGS += \
 	'-DGIT_HTML_PATH="$(htmldir_SQ)"' \
 	'-DGIT_MAN_PATH="$(mandir_SQ)"' \
 	'-DGIT_INFO_PATH="$(infodir_SQ)"'
@@ -1637,21 +1637,21 @@ git.o git.spec \
 %.o: %.S
 	$(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) $<
 
-exec_cmd.o: ALL_CFLAGS += \
+exec_cmd.s exec_cmd.o: ALL_CFLAGS += \
 	'-DGIT_EXEC_PATH="$(gitexecdir_SQ)"' \
 	'-DBINDIR="$(bindir_relative_SQ)"' \
 	'-DPREFIX="$(prefix_SQ)"'
 
-builtin-init-db.o: ALL_CFLAGS += \
+builtin-init-db.s builtin-init-db.o: ALL_CFLAGS += \
 	-DDEFAULT_GIT_TEMPLATE_DIR='"$(template_dir_SQ)"'
 
-config.o: ALL_CFLAGS += -DETC_GITCONFIG='"$(ETC_GITCONFIG_SQ)"'
+config.s config.o: ALL_CFLAGS += -DETC_GITCONFIG='"$(ETC_GITCONFIG_SQ)"'
 
-http.o: ALL_CFLAGS += -DGIT_USER_AGENT='"git/$(GIT_VERSION)"'
+http.s http.o: ALL_CFLAGS += -DGIT_USER_AGENT='"git/$(GIT_VERSION)"'
 
 ifdef NO_EXPAT
 http-walker.o: http.h
-http-walker.o: ALL_CFLAGS += -DNO_EXPAT
+http-walker.s http-walker.o: ALL_CFLAGS += -DNO_EXPAT
 endif
 
 git-%$X: %.o $(GITLIBS)
-- 
1.6.6.rc2
