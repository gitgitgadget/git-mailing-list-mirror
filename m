From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH] [WIP] safecrlf: Add mechanism to warn about irreversible crlf conversions
Date: Sat, 12 Jan 2008 18:54:13 +0100
Message-ID: <12001604531066-git-send-email-prohaska@zib.de>
References: <alpine.LFD.1.00.0801111103420.3148@woody.linux-foundation.org>
Cc: Steffen Prohaska <prohaska@zib.de>
To: torvalds@linux-foundation.org, dpotapov@gmail.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 12 18:55:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDkZS-0001c2-Dm
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 18:55:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755945AbYALRye (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2008 12:54:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755681AbYALRye
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jan 2008 12:54:34 -0500
Received: from mailer.zib.de ([130.73.108.11]:43434 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754219AbYALRyd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2008 12:54:33 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m0CHsEYx017500;
	Sat, 12 Jan 2008 18:54:14 +0100 (CET)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m0CHsDcU012475;
	Sat, 12 Jan 2008 18:54:13 +0100 (MET)
X-Mailer: git-send-email 1.5.2.4
In-Reply-To: <alpine.LFD.1.00.0801111103420.3148@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70338>

I promised to think about the CRLF discussion and here is what
I believe we could do:
 - Leave the current core.autocrlf mechanism as is.
 - Add a mechanism to warn the user if an irreversible conversion happens
 - After we have the mechanisms for configuring the conversion and for
   configuring the safety level, we can decide which defaults to use on
   the different platforms, namely Windows and Unix.

I propose to set the following defaults:
 - Unix: core.autocrlf=input, core.safecrlf=warn
 - Windows: core.autocrlf=true, core.safecrlf=warn

This patch is declared as WIP because tests and a documentation are missing.
I'm also not sure if calling warning() and die() is the right thing to do at
this place.  Interestingly, in some (all?) cases, crlf_to_git() is called two
times for a path during git add, resulting in the warning printed two times.  I
didn't yet analyze why this happens.  Maybe the the warnings and errors printed
should be more verbose?

[ Linus, Dimitry was right about stats.lf. ]

    Steffen

---- snip snap ---

CRLF conversion bears a slight chance of corrupting data.
autocrlf=true will convert CRLF to LF during commit and LF to
CRLF during checkout.  A file that containes a mixture of LF and
CRLF before the commit cannot be recreated by git.  For text
files this does not really matter because we do not care about
the line endings anyway; but for binary files that are
accidentally classified as text the conversion can result in
corrupted data.

If you recognize such corruption during commit you can easily fix
it by setting the conversion type explicitly in .gitattributes.
Right after committing you still have the original file in your
work tree and this file is not yet corrupted.

However, in mixed Windows/Unix environments text files quite
easily can end up containing a mixture of CRLF and LF line
endings and git should handle such situations gracefully.  For
example a user could copy a CRLF file from Windows to Unix and
mix it with an existing LF file there.  The result would contain
both types of line endings.

Unfortunately, the desired effect of cleaning up text files
with mixed lineendings and undesired effect of corrupting binary
files can not be distinguished.  In both cases CRLF are removed
in an irreversible way.  For text files this is the right thing
to do, while for binary file its corrupting data.

In a sane environment committing and checking out the same file
should not modify the origin file in the work tree.  For
autocrlf=input the original file must not contain CRLF.  For
autocrlf=true the original file must not contain LF without
preceding CR.  Otherwise the conversion is irreversible.  Note,
git might be able to recreate the original file with different
autocrlf settings, but in the current environment checking out
will yield a file that differs from the file before the commit.

This patch adds a mechanism that can either warn the user about
an irreversible conversion or can even refuse to convert.  The
mechanism is controlled by the variable core.safecrlf, with the
following values
 - false: disable safecrlf mechanism
 - warn: warn about irreversible conversions
 - true: refuse irreversible conversions

The default is to warn.

A concept of a safety check was originally proposed in a similar
way by Linus Torvalds.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 cache.h       |    8 ++++++++
 config.c      |    9 +++++++++
 convert.c     |   21 +++++++++++++++++++++
 environment.c |    1 +
 4 files changed, 39 insertions(+), 0 deletions(-)

diff --git a/cache.h b/cache.h
index 39331c2..4e03e3d 100644
--- a/cache.h
+++ b/cache.h
@@ -330,6 +330,14 @@ extern size_t packed_git_limit;
 extern size_t delta_base_cache_limit;
 extern int auto_crlf;
 
+enum safe_crlf {
+	SAFE_CRLF_FALSE = 0,
+	SAFE_CRLF_FAIL = 1,
+	SAFE_CRLF_WARN = 2,
+};
+
+extern enum safe_crlf safe_crlf;
+
 #define GIT_REPO_VERSION 0
 extern int repository_format_version;
 extern int check_repository_format(void);
diff --git a/config.c b/config.c
index 857deb6..0a46046 100644
--- a/config.c
+++ b/config.c
@@ -407,6 +407,15 @@ int git_default_config(const char *var, const char *value)
 		return 0;
 	}
 
+	if (!strcmp(var, "core.safecrlf")) {
+		if (value && !strcasecmp(value, "warn")) {
+			safe_crlf = SAFE_CRLF_WARN;
+			return 0;
+		}
+		safe_crlf = git_config_bool(var, value);
+		return 0;
+	}
+
 	if (!strcmp(var, "user.name")) {
 		strlcpy(git_default_name, value, sizeof(git_default_name));
 		return 0;
diff --git a/convert.c b/convert.c
index 4df7559..598cf0b 100644
--- a/convert.c
+++ b/convert.c
@@ -132,6 +132,27 @@ static int crlf_to_git(const char *path, const char *src, size_t len,
 				*dst++ = c;
 		} while (--len);
 	}
+	if (safe_crlf) {
+		if ((action == CRLF_INPUT) || auto_crlf <= 0) {
+			/* autocrlf=input: check if we removed CRLFs */
+			if (buf->len != dst - buf->buf) {
+				if (safe_crlf == SAFE_CRLF_WARN)
+					warning("Stripped CRLF from %s.", path);
+				else
+					die("Refusing to strip CRLF from %s.", path);
+			}
+		} else {
+			/* autocrlf=true: check if we had LFs (without CR) */
+			if (stats.lf != stats.crlf) {
+				if (safe_crlf == SAFE_CRLF_WARN)
+					warning(
+					  "Checkout will replace LFs with CRLF in %s", path);
+				else
+					die("Checkout would replace LFs with CRLF in %s", path);
+			}
+		}
+	}
+
 	strbuf_setlen(buf, dst - buf->buf);
 	return 1;
 }
diff --git a/environment.c b/environment.c
index 18a1c4e..e351e99 100644
--- a/environment.c
+++ b/environment.c
@@ -35,6 +35,7 @@ int pager_use_color = 1;
 char *editor_program;
 char *excludes_file;
 int auto_crlf = 0;	/* 1: both ways, -1: only when adding git objects */
+enum safe_crlf safe_crlf = SAFE_CRLF_WARN;
 unsigned whitespace_rule_cfg = WS_DEFAULT_RULE;
 
 /* This is set by setup_git_dir_gently() and/or git_default_config() */
-- 
1.5.4.rc2.60.g46ee
