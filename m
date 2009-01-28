From: Serge van den Boom <svdb@stack.nl>
Subject: [PATCH v2] Makefile: Make 'configure --with-expat=path' actually
 work
Date: Wed, 28 Jan 2009 21:43:57 +0100 (CET)
Message-ID: <alpine.BSF.2.00.0901282120240.74552@toad.stack.nl>
References: <alpine.BSF.2.00.0901251938120.97940@toad.stack.nl> <7vocxrqm57.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 28 21:46:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSHI4-0001h4-MB
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 21:45:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756672AbZA1UoE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 15:44:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759433AbZA1UoB
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 15:44:01 -0500
Received: from meestal-mk5.stack.nl ([131.155.140.149]:63690 "EHLO
	mx1.stack.nl" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1759436AbZA1UoA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 15:44:00 -0500
Received: from toad.stack.nl (toad.stack.nl [IPv6:2001:610:1108:5010::135])
	by mx1.stack.nl (Postfix) with ESMTP id 5A7703F715;
	Wed, 28 Jan 2009 21:43:57 +0100 (CET)
Received: by toad.stack.nl (Postfix, from userid 1106)
	id 52B7D73F8B; Wed, 28 Jan 2009 21:43:57 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by toad.stack.nl (Postfix) with ESMTP id 4C09E73F57;
	Wed, 28 Jan 2009 21:43:57 +0100 (CET)
In-Reply-To: <7vocxrqm57.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 2.00 (BSF 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107574>

While the configure script sets the EXPATDIR environment variable to
whatever value was passed to its option --with-expat as the prefix of
the location of the expat library and headers, the Makefile ignored it.
This patch fixes this bug.

Signed-off-by: Serge van den Boom <svdb@stack.nl>
---

On Wed, 28 Jan 2009, Junio C Hamano wrote:
> Serge van den Boom <svdb@stack.nl> writes:
> > The prefix specified with the --with-expat option of configure was not
> > actually used.
> 
> I see configure.ac already has support for autodetection but I realized it
> only after running "git grep EXPATDIR".  "Even though the configure script
> knows how to autodetect presence of the expat library and set EXPATDIR to
> the prefix of the location it was found, the Makefile ignored it and only
> honoured NO_EXPAT" might have been a better way to describe the breakage
> the patch fixes.

That's not entirely right, unless I'm missing something. The configure script
does not try to detect expat itself, though it passes on the argument
to --with-expat to the Makefile, via the EXPATDIR environment variable.

> If you look at the Makefile, you will notice a sequence of comments like
> this:
> 
>     # Define NO_CURL if you do not have libcurl installed.  git-http-pull and
>     # git-http-push are not built, and you cannot use http:// and https://
>     # transports.
>     #
>     # Define CURLDIR=/foo/bar if your curl header and library files are in
>     # /foo/bar/include and /foo/bar/lib directories.
>     #
> 
> Please add one for EXPATDIR, just after "Define NO_EXPAT if ...".  People
> who do not run ./configure but add their own customizations in config.mak
> should benefit from your patch as well.

Ok.

diff --git a/Makefile b/Makefile
index 9d451cf..a7310f2 100644
--- a/Makefile
+++ b/Makefile
@@ -23,6 +23,9 @@ all::
 # Define NO_EXPAT if you do not have expat installed.  git-http-push is
 # not built, and you cannot push using http:// and https:// transports.
 #
+# Define EXPATDIR=/foo/bar if your expat header and library files are in
+# /foo/bar/include and /foo/bar/lib directories.
+#
 # Define NO_D_INO_IN_DIRENT if you don't have d_ino in your struct dirent.
 #
 # Define NO_D_TYPE_IN_DIRENT if your platform defines DT_UNKNOWN but lacks
@@ -850,7 +853,12 @@ else
 		endif
 	endif
 	ifndef NO_EXPAT
-		EXPAT_LIBEXPAT = -lexpat
+		ifdef EXPATDIR
+			BASIC_CFLAGS += -I$(EXPATDIR)/include
+			EXPAT_LIBEXPAT = -L$(EXPATDIR)/$(lib) $(CC_LD_DYNPATH)$(EXPATDIR)/$(lib) -lexpat
+		else
+			EXPAT_LIBEXPAT = -lexpat
+		endif
 	endif
 endif
 
