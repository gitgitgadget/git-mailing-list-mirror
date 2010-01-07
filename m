From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/5] Makefile: use target-specific variable to pass
 flags to cc
Date: Thu, 7 Jan 2010 01:42:53 -0600
Message-ID: <20100107074253.GA13125@progeny.tock>
References: <20091128112546.GA10059@progeny.tock>
 <20091128113709.GD10059@progeny.tock>
 <20100106080216.GA7298@progeny.tock>
 <20100106080504.GC7298@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 07 08:43:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSn1H-00009s-EK
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jan 2010 08:42:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754958Ab0AGHmz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jan 2010 02:42:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754698Ab0AGHmy
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jan 2010 02:42:54 -0500
Received: from mail-gx0-f217.google.com ([209.85.217.217]:63036 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753983Ab0AGHmy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jan 2010 02:42:54 -0500
Received: by gxk9 with SMTP id 9so39911545gxk.8
        for <git@vger.kernel.org>; Wed, 06 Jan 2010 23:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=6hAvm2vWrTM7J96KLySYlCHsye/7KGoVn8kDyQPrk/Q=;
        b=FmPtcRR8PkbibQ8QclVIISH10pJT0/pdIYLqAaVNbB0s/1UpVIao122dCtsfhg6p9Z
         V5Lc+dOyS9xYDh6qKQVMnIWDO3XwceiiNGcxwRjGTdNnMOHYK4GHEiUpXQkDsX4YY7Ml
         uHz2AlA+fdh1oly+Wz6qDcqF9XGZYzUr/0RsY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=cUmENUcpTuI+xsjSGpIs72Q9evXgFrivWo6dREIbXatIzuyx4jmYkZjHm0/zAhFrOg
         CxSCNTYgydprl07Lo8ZTvdNIiD+tzOA/zizSBpswWNH+D7TWOCVNmQR8I66zoufKMVzJ
         9etz2/+fIbUaQMI7dQyOBpY+vNvLLOBGQgfRg=
Received: by 10.101.55.4 with SMTP id h4mr3084245ank.49.1262850173033;
        Wed, 06 Jan 2010 23:42:53 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 21sm20170568iwn.14.2010.01.06.23.42.51
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 06 Jan 2010 23:42:52 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100106080504.GC7298@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136333>

Jonathan Nieder wrote:

> diff --git a/Makefile b/Makefile
> index ba4d071..81190a6 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1467,20 +1467,19 @@ shell_compatibility_test: please_set_SHELL_PATH_to_a_more_modern_shell
>  strip: $(PROGRAMS) git$X
>  	$(STRIP) $(STRIP_OPTS) $(PROGRAMS) git$X
>  
> -git.o: git.c common-cmds.h GIT-CFLAGS
> -	$(QUIET_CC)$(CC) -DGIT_VERSION='"$(GIT_VERSION)"' \
> -		'-DGIT_HTML_PATH="$(htmldir_SQ)"' \
> -		$(ALL_CFLAGS) -o $@ -c $(filter %.c,$^)
> +git.o: common-cmds.h
> +git.o: ALL_CFLAGS += -DGIT_VERSION='"$(GIT_VERSION)"' \
> +	'-DGIT_HTML_PATH="$(htmldir_SQ)"'
>  
[...]

One annoying feature I wasn't thinking of: the values of
target-specific variables propagate to the dependencies of a target
(why? I can't imagine), and GIT-CFLAGS keeps on changing because of
this.

Maybe a new CMD_CFLAGS variable is needed for this, i.e. something
like the following squashed in.

diff --git a/Makefile b/Makefile
index 2580e23..d20e456 100644
--- a/Makefile
+++ b/Makefile
@@ -1468,7 +1468,7 @@ strip: $(PROGRAMS) git$X
 	$(STRIP) $(STRIP_OPTS) $(PROGRAMS) git$X
 
 git.o: common-cmds.h
-git.o: ALL_CFLAGS += -DGIT_VERSION='"$(GIT_VERSION)"' \
+git.o: CMD_CFLAGS += -DGIT_VERSION='"$(GIT_VERSION)"' \
 	'-DGIT_HTML_PATH="$(htmldir_SQ)"'
 
 git$X: git.o $(BUILTIN_OBJS) $(GITLIBS)
@@ -1476,7 +1476,7 @@ git$X: git.o $(BUILTIN_OBJS) $(GITLIBS)
 		$(BUILTIN_OBJS) $(ALL_LDFLAGS) $(LIBS)
 
 builtin-help.o: common-cmds.h
-builtin-help.o: ALL_CFLAGS += \
+builtin-help.o: CMD_CFLAGS += \
 	'-DGIT_HTML_PATH="$(htmldir_SQ)"' \
 	'-DGIT_MAN_PATH="$(mandir_SQ)"' \
 	'-DGIT_INFO_PATH="$(infodir_SQ)"'
@@ -1630,28 +1630,31 @@ git.o git.spec \
 	$(patsubst %.perl,%,$(SCRIPT_PERL)) \
 	: GIT-VERSION-FILE
 
+# This can vary by target
+CMD_CFLAGS = $(ALL_CFLAGS)
+
 %.o: %.c GIT-CFLAGS
-	$(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) $<
+	$(QUIET_CC)$(CC) -o $*.o -c $(CMD_CFLAGS) $<
 %.s: %.c GIT-CFLAGS .FORCE-LISTING
-	$(QUIET_CC)$(CC) -S $(ALL_CFLAGS) $<
+	$(QUIET_CC)$(CC) -S $(CMD_CFLAGS) $<
 %.o: %.S GIT-CFLAGS
-	$(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) $<
+	$(QUIET_CC)$(CC) -o $*.o -c $(CMD_CFLAGS) $<
 
-exec_cmd.o: ALL_CFLAGS += \
+exec_cmd.o: CMD_CFLAGS += \
 	'-DGIT_EXEC_PATH="$(gitexecdir_SQ)"' \
 	'-DBINDIR="$(bindir_relative_SQ)"' \
 	'-DPREFIX="$(prefix_SQ)"'
 
-builtin-init-db.o: ALL_CFLAGS += \
+builtin-init-db.o: CMD_CFLAGS += \
 	-DDEFAULT_GIT_TEMPLATE_DIR='"$(template_dir_SQ)"'
 
-config.o: ALL_CFLAGS += -DETC_GITCONFIG='"$(ETC_GITCONFIG_SQ)"'
+config.o: CMD_CFLAGS += -DETC_GITCONFIG='"$(ETC_GITCONFIG_SQ)"'
 
-http.o: ALL_CFLAGS += -DGIT_USER_AGENT='"git/$(GIT_VERSION)"'
+http.o: CMD_CFLAGS += -DGIT_USER_AGENT='"git/$(GIT_VERSION)"'
 
 ifdef NO_EXPAT
 http-walker.o: http.h
-http-walker.o: ALL_CFLAGS += -DNO_EXPAT
+http-walker.o: CMD_CFLAGS += -DNO_EXPAT
 endif
 
 git-%$X: %.o $(GITLIBS)
