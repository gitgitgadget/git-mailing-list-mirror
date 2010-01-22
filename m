From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Remove diff machinery dependency from read-cache
Date: Thu, 21 Jan 2010 20:21:55 -0800 (PST)
Message-ID: <alpine.LFD.2.00.1001212014481.13231@localhost.localdomain>
References: <alpine.LFD.2.00.1001211119130.13231@localhost.localdomain> <7vljfrp6g2.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.00.1001211215080.13231@localhost.localdomain> <alpine.LFD.2.00.1001211355500.13231@localhost.localdomain>
 <alpine.LFD.2.00.1001211515470.13231@localhost.localdomain> <7v636vj7c2.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.00.1001212131230.1726@xanadu.home> <7vvdeubxnh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@fluxnic.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 22 05:22:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYB2K-0008NM-Rs
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jan 2010 05:22:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752113Ab0AVEWP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2010 23:22:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751539Ab0AVEWL
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jan 2010 23:22:11 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:43575 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752095Ab0AVEWC (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Jan 2010 23:22:02 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o0M4Lu2c018702
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 21 Jan 2010 20:21:57 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id o0M4LtP0016212;
	Thu, 21 Jan 2010 20:21:55 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <7vvdeubxnh.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.448 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137737>



On Thu, 21 Jan 2010, Junio C Hamano wrote:

> Nicolas Pitre <nico@fluxnic.net> writes:
> 
> > I do use it, but for developing/debugging pack stuff.  I don't suggest
> > removing it, but I don't think making it a built-in has value either.
> 
> I thought people _might_ have used it for satistics purposes, but it
> appears that the command doesn't even give in-pack size of objects nor
> delta chain length, so probably anybody doing pack statistics would be
> using "verify-pack -v" and wouldn't mind if it became test-show-index.
> 
> > So I really think that Linus' patch (which is missing hex.c btw) is a 
> > good thing to do, even if only for the cleanup value.
> >
> > Then, git-show-index could probably become test-show-index and no longer 
> > leave the build directory.
> 
> Yeah, I think that is a sensible long term plan, too.

Note that there are other totally trivial git programs like 'git-var' that 
have exactly the same issue as 'git-show-index'.

Same details: it doesn't really want any diff machinery, doesn't want any 
git object handling, but can't avoid it because it uses xmalloc (through 
environment.c and config.c etc), so a program that _should_ be pretty 
trivially small again ends up being 200+kB in size even without debug 
info (and almost a megabyte with it).

So here's another trivial builtin-ification patch.

		Linus

---
 Makefile               |    2 +-
 var.c => builtin-var.c |    4 +---
 builtin.h              |    1 +
 git.c                  |    1 +
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index f9e4aa3..398b5fb 100644
--- a/Makefile
+++ b/Makefile
@@ -396,7 +396,6 @@ PROGRAMS += git-patch-id$X
 PROGRAMS += git-shell$X
 PROGRAMS += git-unpack-file$X
 PROGRAMS += git-upload-pack$X
-PROGRAMS += git-var$X
 PROGRAMS += git-http-backend$X
 
 # List built-in command $C whose implementation cmd_$C() is not in
@@ -703,6 +702,7 @@ BUILTIN_OBJS += builtin-update-index.o
 BUILTIN_OBJS += builtin-update-ref.o
 BUILTIN_OBJS += builtin-update-server-info.o
 BUILTIN_OBJS += builtin-upload-archive.o
+BUILTIN_OBJS += builtin-var.o
 BUILTIN_OBJS += builtin-verify-pack.o
 BUILTIN_OBJS += builtin-verify-tag.o
 BUILTIN_OBJS += builtin-write-tree.o
diff --git a/var.c b/builtin-var.c
similarity index 96%
rename from var.c
rename to builtin-var.c
index d9892f8..2280518 100644
--- a/var.c
+++ b/builtin-var.c
@@ -72,7 +72,7 @@ static int show_config(const char *var, const char *value, void *cb)
 	return git_default_config(var, value, cb);
 }
 
-int main(int argc, char **argv)
+int cmd_var(int argc, const char **argv, const char *prefix)
 {
 	const char *val;
 	int nongit;
@@ -80,8 +80,6 @@ int main(int argc, char **argv)
 		usage(var_usage);
 	}
 
-	git_extract_argv0_path(argv[0]);
-
 	setup_git_directory_gently(&nongit);
 	val = NULL;
 
diff --git a/builtin.h b/builtin.h
index 3aa6b6c..0c9c396 100644
--- a/builtin.h
+++ b/builtin.h
@@ -107,6 +107,7 @@ extern int cmd_update_ref(int argc, const char **argv, const char *prefix);
 extern int cmd_update_server_info(int argc, const char **argv, const char *prefix);
 extern int cmd_upload_archive(int argc, const char **argv, const char *prefix);
 extern int cmd_upload_tar(int argc, const char **argv, const char *prefix);
+extern int cmd_var(int argc, const char **argv, const char *prefix);
 extern int cmd_verify_tag(int argc, const char **argv, const char *prefix);
 extern int cmd_version(int argc, const char **argv, const char *prefix);
 extern int cmd_whatchanged(int argc, const char **argv, const char *prefix);
diff --git a/git.c b/git.c
index a952663..09d3272 100644
--- a/git.c
+++ b/git.c
@@ -373,6 +373,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "update-ref", cmd_update_ref, RUN_SETUP },
 		{ "update-server-info", cmd_update_server_info, RUN_SETUP },
 		{ "upload-archive", cmd_upload_archive },
+		{ "var", cmd_var },
 		{ "verify-tag", cmd_verify_tag, RUN_SETUP },
 		{ "version", cmd_version },
 		{ "whatchanged", cmd_whatchanged, RUN_SETUP | USE_PAGER },
