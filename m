From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] builtin-grep: workaround for non GNU grep.
Date: Wed, 17 May 2006 02:54:27 -0700
Message-ID: <7vves5geng.fsf_-_@assigned-by-dhcp.cox.net>
References: <f3d7535d0605161652n3b2ec033r874336082755e728@mail.gmail.com>
	<Pine.LNX.4.64.0605161904260.16475@g5.osdl.org>
	<7vejythvkr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 17 11:54:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgIjg-0004Iz-NQ
	for gcvg-git@gmane.org; Wed, 17 May 2006 11:54:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750780AbWEQJy3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 May 2006 05:54:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750785AbWEQJy3
	(ORCPT <rfc822;git-outgoing>); Wed, 17 May 2006 05:54:29 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:7151 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1750780AbWEQJy2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 May 2006 05:54:28 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060517095428.RNUS27327.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 17 May 2006 05:54:28 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vejythvkr.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 17 May 2006 02:03:32 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20179>

Some implementations do not know what to do with -H; define
NO_H_OPTION_IN_GREP when you build git if your grep lacks -H.

Most of the time, it can be worked around by prepending
/dev/null to the argument list, but that causes -L and -c to
slightly misbehave (they both expose /dev/null is given), so
when these options are given, do not run external grep that does
not understand -H.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 Junio C Hamano <junkio@cox.net> writes:

 > But I think this approach breaks -L; I do not think Solaris
 > supports -L, so it does not matter there, but on platforms that
 > knows how to do -L it does.

 So this is an updated version.  I am not proud of the handling
 of the new Makefile variable, although I like the C code that
 does not need #ifdef thanks to it.

 Makefile       |   11 +++++++++++
 builtin-grep.c |   22 +++++++++++++++++++---
 2 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 9ba608c..c67108d 100644
--- a/Makefile
+++ b/Makefile
@@ -46,6 +46,8 @@ # Patrick Mauritz).
 #
 # Define NO_MMAP if you want to avoid mmap.
 #
+# Define NO_H_OPTION_IN_GREP if your grep does not understand -H.
+#
 # Define WITH_OWN_SUBPROCESS_PY if you want to use with python 2.3.
 #
 # Define NO_IPV6 if you lack IPv6 support and getaddrinfo().
@@ -444,6 +446,12 @@ ifdef NO_ACCURATE_DIFF
 	ALL_CFLAGS += -DNO_ACCURATE_DIFF
 endif
 
+ifdef NO_H_OPTION_IN_GREP
+	NO_H_OPTION_IN_GREP=1
+else
+	NO_H_OPTION_IN_GREP=0
+endif
+
 # Shell quote (do not use $(call) to accomodate ancient setups);
 
 SHA1_HEADER_SQ = $(subst ','\'',$(SHA1_HEADER))
@@ -526,6 +534,9 @@ git$X git.spec \
 %.o: %.S
 	$(CC) -o $*.o -c $(ALL_CFLAGS) $<
 
+builtin-grep.o: builtin-grep.c
+	$(CC) -o $*.o -c $(ALL_CFLAGS) -DNO_H_OPTION_IN_GREP=$(NO_H_OPTION_IN_GREP) $<
+
 exec_cmd.o: exec_cmd.c
 	$(CC) -o $*.o -c $(ALL_CFLAGS) '-DGIT_EXEC_PATH="$(gitexecdir_SQ)"' $<
 
diff --git a/builtin-grep.c b/builtin-grep.c
index 66111de..36512d8 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -453,7 +453,6 @@ static int external_grep(struct grep_opt
 
 	len = nr = 0;
 	push_arg("grep");
-	push_arg("-H");
 	if (opt->fixed)
 		push_arg("-F");
 	if (opt->linenum)
@@ -503,7 +502,13 @@ static int external_grep(struct grep_opt
 		push_arg("-e");
 		push_arg(p->pattern);
 	}
-	push_arg("--");
+
+	if (NO_H_OPTION_IN_GREP)
+		push_arg("/dev/null");
+	else {
+		push_arg("-H");
+		push_arg("--");
+	}
 
 	hit = 0;
 	argc = nr;
@@ -535,8 +540,19 @@ #ifdef __unix__
 	 * Use the external "grep" command for the case where
 	 * we grep through the checked-out files. It tends to
 	 * be a lot more optimized
+	 *
+	 * Some grep implementations do not understand -H nor --
+	 * but /dev/null can be used as a substitution in most
+	 * cases.
+	 *
+	 * However -L and -c would slightly misbehave (-L would
+	 * list /dev/null as a hit, and -c would report 0 hits
+	 * from /dev/null); so do not use the external one on
+	 * such platforms.
 	 */
-	if (!cached) {
+	if (!cached &&
+	    (!NO_H_OPTION_IN_GREP ||
+	     (!opt->count && !opt->unmatch_name_only))) {
 		hit = external_grep(opt, paths, cached);
 		if (hit >= 0)
 			return hit;
-- 
1.3.3.g8a24
