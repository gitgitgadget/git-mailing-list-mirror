From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [msysGit] Pull request for msysGit patches
Date: Tue, 28 Sep 2010 16:08:38 -0500
Message-ID: <20100928210837.GA8317@capella.cs.uchicago.edu>
References: <87ocbitd33.fsf@fox.patthoyts.tk> <201009282252.25688.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>,
	msysgit@googlegroups.com, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Sep 28 23:08:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0hPp-0006zq-6K
	for gcvg-git-2@lo.gmane.org; Tue, 28 Sep 2010 23:08:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752855Ab0I1VIk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Sep 2010 17:08:40 -0400
Received: from camembert.cs.uchicago.edu ([128.135.164.153]:45075 "EHLO
	smtp.cs.uchicago.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750990Ab0I1VIj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Sep 2010 17:08:39 -0400
Received: from capella.cs.uchicago.edu (capella.cs.uchicago.edu [128.135.24.228])
	by smtp.cs.uchicago.edu (Postfix) with ESMTP id 2D79CBA4D;
	Tue, 28 Sep 2010 16:08:38 -0500 (CDT)
Received: by capella.cs.uchicago.edu (Postfix, from userid 10442)
	id 1FDB33085A; Tue, 28 Sep 2010 16:08:38 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <201009282252.25688.j6t@kdbg.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157472>

Johannes Sixt wrote:
> On Dienstag, 28. September 2010, Pat Thoyts wrote:

>> Johannes Schindelin (11):
>>       Avoid TAGS/tags warning from GNU Make
>
> OK.

Wasn't this one reviewed on-list recently?

-- 8< --
From: Junio C Hamano <gitster@pobox.com>
Subject: MinGW: avoid collisions between "tags" and "TAGS"

On case insensitive filesystems, "tags" and "TAGS" target will try to
overwrite the same file.  Allow MinGW to use "ETAGS" instead.

These two targets do produce real files; do not put them on .PHONY target
list.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Makefile |   15 +++++++++------
 1 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index b7a62cf..d3dcfb1 100644
--- a/Makefile
+++ b/Makefile
@@ -390,6 +390,8 @@ SCRIPTS = $(patsubst %.sh,%,$(SCRIPT_SH)) \
 	  $(patsubst %.py,%,$(SCRIPT_PYTHON)) \
 	  git-instaweb
 
+ETAGS_TARGET = TAGS
+
 # Empty...
 EXTRA_PROGRAMS =
 
@@ -1122,6 +1124,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	NO_REGEX = YesPlease
 	NO_PYTHON = YesPlease
 	BLK_SHA1 = YesPlease
+	ETAGS_TARGET = ETAGS
 	COMPAT_CFLAGS += -D__USE_MINGW_ACCESS -DNOGDI -Icompat -Icompat/fnmatch -Icompat/win32
 	COMPAT_CFLAGS += -DSTRIP_EXTENSION=\".exe\"
 	COMPAT_OBJS += compat/mingw.o compat/fnmatch/fnmatch.o compat/winansi.o \
@@ -1961,11 +1964,11 @@ info:
 pdf:
 	$(MAKE) -C Documentation pdf
 
-TAGS:
-	$(RM) TAGS
-	$(FIND) . -name '*.[hcS]' -print | xargs etags -a
+$(ETAGS_TARGET): FORCE
+	$(RM) $(ETAGS_TARGET)
+	$(FIND) . -name '*.[hcS]' -print | xargs etags -a -o $(ETAGS_TARGET)
 
-tags:
+tags: FORCE
 	$(RM) tags
 	$(FIND) . -name '*.[hcS]' -print | xargs ctags -a
 
@@ -2235,7 +2238,7 @@ clean:
 	$(RM) $(TEST_PROGRAMS)
 	$(RM) -r bin-wrappers
 	$(RM) -r $(dep_dirs)
-	$(RM) *.spec *.pyc *.pyo */*.pyc */*.pyo common-cmds.h TAGS tags cscope*
+	$(RM) *.spec *.pyc *.pyo */*.pyc */*.pyo common-cmds.h $(ETAGS_TARGET) tags cscope*
 	$(RM) -r autom4te.cache
 	$(RM) config.log config.mak.autogen config.mak.append config.status config.cache
 	$(RM) -r $(GIT_TARNAME) .doc-tmp-dir
@@ -2259,7 +2262,7 @@ endif
 
 .PHONY: all install clean strip
 .PHONY: shell_compatibility_test please_set_SHELL_PATH_to_a_more_modern_shell
-.PHONY: FORCE TAGS tags cscope
+.PHONY: FORCE cscope
 
 ### Check documentation
 #
-- 
1.7.3.1.gd86b1
