From: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
Subject: Re: [PATCH v2 4/6] build dashless "bin-wrappers" directory similar to installed bindir
Date: Tue, 1 Dec 2009 00:33:50 -0700
Message-ID: <20091201073350.GA528@comcast.net>
References: <1259561971-25730-1-git-send-email-mmogilvi_git@miniinfo.net> <1259561971-25730-2-git-send-email-mmogilvi_git@miniinfo.net> <1259561971-25730-3-git-send-email-mmogilvi_git@miniinfo.net> <1259561971-25730-4-git-send-email-mmogilvi_git@miniinfo.net> <1259561971-25730-5-git-send-email-mmogilvi_git@miniinfo.net> <7vmy241q75.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 01 08:36:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFNHp-0008Do-Ox
	for gcvg-git-2@lo.gmane.org; Tue, 01 Dec 2009 08:36:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753892AbZLAHfB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2009 02:35:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753875AbZLAHfB
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Dec 2009 02:35:01 -0500
Received: from qmta05.emeryville.ca.mail.comcast.net ([76.96.30.48]:33737 "EHLO
	QMTA05.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753688AbZLAHdq (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Dec 2009 02:33:46 -0500
Received: from OMTA12.emeryville.ca.mail.comcast.net ([76.96.30.44])
	by QMTA05.emeryville.ca.mail.comcast.net with comcast
	id BjYW1d0050x6nqcA5jZtFu; Tue, 01 Dec 2009 07:33:53 +0000
Received: from mmogilvi.homeip.net ([24.8.125.243])
	by OMTA12.emeryville.ca.mail.comcast.net with comcast
	id BjZs1d0045FCJCg8YjZsue; Tue, 01 Dec 2009 07:33:53 +0000
Received: by mmogilvi.homeip.net (Postfix, from userid 501)
	id 9656989115; Tue,  1 Dec 2009 00:33:50 -0700 (MST)
Content-Disposition: inline
In-Reply-To: <7vmy241q75.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.4i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134171>

On Sun, Nov 29, 2009 at 10:28:46PM -0800, Junio C Hamano wrote:
> Matthew Ogilvie <mmogilvi_git@miniinfo.net> writes:
> > +GIT_EXEC_PATH="__GIT_EXEC_PATH__"
> > +exec "${GIT_EXEC_PATH}/__PROG__" "$@"
> 
> Two issues, one minor and one not so minor but not grave:
> 
>  - Everywhere else we seem to use "@@UPPERCASE_NAME@@" not
>    double-underscore as placeholders like the above.
> 
>  - @@PROG@@ is under our control and it is easy for us to guarantee that
>    it won't have any funny letters, but GIT_EXEC_PATH is not.  Is it safe
>    to do a simple-minded "sed" replacement, or does it need the usual sq
>    trick employed in the other replacement in our Makefile?

You've already applied the v2 patch to pu, but if it is still
a concern, you might either add or squash in the patch at
the bottom of this message for the @@ vs __ issue.  But first,
some thoughts about escaping $(shell pwd):

-------------

The patch below also switches to using single quotes in the wrapper
script, but that by itself doesn't fix everything.  Basically it
fixes '"', '$', (and maybe/partially '\\') at the expense of
breaking '\''.  Several characters are still
broken: '\'', '|', '&', '\\', and maybe others.  Either option
should handle ' ' (space) OK.

The "standard" *_SQ replacement used elsewhere in the makefile
is inadequate in this context, since we really needs to escape
makefile, shell, sed, and then shell again.  It might be possible
to define something like the following, and then use it instead
of $(shell pwd).  You could also try several nested
$(subst ...)'s instead of sed.  I have not tried either of these.

build_dir_MQ=$(shell pwd | sed -e "s/'/'\"'\"'/g" \
                               -e 's/[|&\\]/\\&/g' \
                               -e "s/'/'\"'\"'/g" )

Rationale:

Working backwards, the last -e makes sure the sed argument doesn't
get split or combined by the shell before it gets to sed.  The
middle -e is intended to escape characters that sed would
misinterpret.  The first -e is so that single quotes get
properly interpreted by the shell that interprets
bin-wrappers/* generated scripts.

But I don't really think this is worth it:

1. I think there are parts of test-lib.sh (and maybe other places)
that don't even handle spaces in top-level $(pwd), let alone more
complicated characters.  (git itself should be robust, though)

2. Technically, stuff like SHELL_PATH_SQ (anything that is used
by the makefile as the replacement text for a sed 's' command) may
benefit from something similar.  (But other uses like -DVAR='$(xx_SQ)'
are probably perfect already.)

3. It doesn't seem like a severe restriction to require that users
build git in a directory with a reasonably normal full path name.

-------------

From: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
Date: Mon, 30 Nov 2009 22:57:40 -0700
Subject: [PATCH] wrap-for-bin.sh: Use @@var@@ for Makefile variable expansion

We use @@var@@-style variable expansion in most other places, so be
consistent with them.

Also, rename it to @@BUILD_DIR@@ to clarify what it is expanded with,
and use single quotes in wrap-for-bin.sh to reduce the number of shell
meta characters that might mess it up.

Signed-off-by: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
---
 Makefile        |    4 ++--
 wrap-for-bin.sh |   12 ++++++------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Makefile b/Makefile
index c8f0c5f..811db45 100644
--- a/Makefile
+++ b/Makefile
@@ -1791,8 +1791,8 @@ all:: $(TEST_PROGRAMS) $(test_bindir_programs)
 bin-wrappers/%: wrap-for-bin.sh
 	@mkdir -p bin-wrappers
 	$(QUIET_GEN)sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
-	     -e 's|__GIT_EXEC_PATH__|$(shell pwd)|' \
-	     -e 's|__PROG__|$(@F)|' < $< > $@ && \
+	     -e 's|@@BUILD_DIR@@|$(shell pwd)|' \
+	     -e 's|@@PROG@@|$(@F)|' < $< > $@ && \
 	chmod +x $@
 
 # GNU make supports exporting all variables by "export" without parameters.
diff --git a/wrap-for-bin.sh b/wrap-for-bin.sh
index ee2bc98..c5075c9 100644
--- a/wrap-for-bin.sh
+++ b/wrap-for-bin.sh
@@ -4,12 +4,12 @@
 # to run test suite against sandbox, but with only bindir-installed
 # executables in PATH.  The Makefile copies this into various
 # files in bin-wrappers, substituting
-# __GIT_EXEC_PATH__ and __PROG__.
+# @@BUILD_DIR@@ and @@PROG@@.
 
-GIT_EXEC_PATH="__GIT_EXEC_PATH__"
-GIT_TEMPLATE_DIR="__GIT_EXEC_PATH__/templates/blt"
-GITPERLLIB="__GIT_EXEC_PATH__/perl/blib/lib"
-PATH="__GIT_EXEC_PATH__/bin-wrappers:$PATH"
+GIT_EXEC_PATH='@@BUILD_DIR@@'
+GIT_TEMPLATE_DIR='@@BUILD_DIR@@/templates/blt'
+GITPERLLIB='@@BUILD_DIR@@/perl/blib/lib'
+PATH='@@BUILD_DIR@@/bin-wrappers:'"$PATH"
 export GIT_EXEC_PATH GIT_TEMPLATE_DIR GITPERLLIB PATH
 
-exec "${GIT_EXEC_PATH}/__PROG__" "$@"
+exec "${GIT_EXEC_PATH}/@@PROG@@" "$@"
-- 
1.6.4.GIT
