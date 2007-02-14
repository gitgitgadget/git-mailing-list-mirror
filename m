From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: mingw, windows, crlf/lf, and git
Date: Tue, 13 Feb 2007 18:16:12 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702131813560.3604@woody.linux-foundation.org>
References: <45CFA30C.6030202@verizon.net> <200702130932.51601.litvinov2004@gmail.com>
 <Pine.LNX.4.63.0702131105240.1300@wbgn013.biozentrum.uni-wuerzburg.de>
 <200702131816.27705.litvinov2004@gmail.com> <eqt40c$5ov$1@sea.gmane.org>
 <Pine.LNX.4.64.0702131225070.3604@woody.linux-foundation.org>
 <45D2691C.4090005@verizon.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Mark Levedahl <mdl123@verizon.net>
X-From: git-owner@vger.kernel.org Wed Feb 14 03:16:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HH9gz-0007km-R7
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 03:16:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932253AbXBNCQT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Feb 2007 21:16:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932257AbXBNCQT
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Feb 2007 21:16:19 -0500
Received: from smtp.osdl.org ([65.172.181.24]:36974 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932253AbXBNCQS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Feb 2007 21:16:18 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l1E2GDhB014297
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 13 Feb 2007 18:16:13 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l1E2GCe2018844;
	Tue, 13 Feb 2007 18:16:13 -0800
In-Reply-To: <45D2691C.4090005@verizon.net>
X-Spam-Status: No, hits=-0.416 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.117__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39610>



On Tue, 13 Feb 2007, Mark Levedahl wrote:
> 
> The ternary value is definitely useful. As noted elsewhere, most tools on
> windows are very happy with \n ending, few honor those line endings when files
> are modified, and fewer still allow the user to specify use of \n for new
> files. However, cygwin tools in particular are not tolerant of crlf, so for
> that environment it makes sense to banish crlf and the input-only option is
> most likely the best default setting there.

Here's a UNTESTED patch on top of the patch I already sent, which allows 
you to do

	[core]
		AutoCRLF = input

and it should do only the CRLF->LF translation (ie it simplifies CRLF only 
when reading working tree files, but when checking out files, it leaves 
the LF alone, and doesn't turn it into a CRLF).

And by "untested" I mean that it looks ok and seems to compile, but I 
really didn't do anything else.

		Linus
---
diff --git a/config.c b/config.c
index ffe0212..e8ae919 100644
--- a/config.c
+++ b/config.c
@@ -325,6 +325,10 @@ int git_default_config(const char *var, const char *value)
 	}
 
 	if (!strcmp(var, "core.autocrlf")) {
+		if (value && !strcasecmp(value, "input")) {
+			auto_crlf = -1;
+			return 0;
+		}
 		auto_crlf = git_config_bool(var, value);
 		return 0;
 	}
diff --git a/convert.c b/convert.c
index c04b6c2..b5a47c2 100644
--- a/convert.c
+++ b/convert.c
@@ -133,7 +133,7 @@ int convert_to_working_tree(const char *path, char **bufp, unsigned long *sizep)
 	 * based on filename patterns. Right now we just do the
 	 * stupid auto-CRLF one.
 	 */
-	if (!auto_crlf)
+	if (auto_crlf <= 0)
 		return 0;
 
 	size = *sizep;
diff --git a/environment.c b/environment.c
index 2fa0960..570e32a 100644
--- a/environment.c
+++ b/environment.c
@@ -28,7 +28,7 @@ size_t packed_git_window_size = DEFAULT_PACKED_GIT_WINDOW_SIZE;
 size_t packed_git_limit = DEFAULT_PACKED_GIT_LIMIT;
 int pager_in_use;
 int pager_use_color = 1;
-int auto_crlf = 0;
+int auto_crlf = 0;	/* 1: both ways, -1: only when adding git objects */
 
 static const char *git_dir;
 static char *git_object_dir, *git_index_file, *git_refs_dir, *git_graft_file;
