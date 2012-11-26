From: esr@thyrsus.com (Eric S. Raymond)
Subject: [PATCH] Third try at documenting command integration requirements.
Date: Mon, 26 Nov 2012 00:35:57 -0500 (EST)
Message-ID: <20121126053557.E56434065F@snark.thyrsus.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 26 06:37:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TcrNS-00049o-7H
	for gcvg-git-2@plane.gmane.org; Mon, 26 Nov 2012 06:37:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753908Ab2KZFgv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2012 00:36:51 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:46900
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753402Ab2KZFgv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2012 00:36:51 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id E56434065F; Mon, 26 Nov 2012 00:35:57 -0500 (EST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210417>

This document contains no new policies or proposals; it attempts
to document established practices and interface requirements.

Signed-off-by: Eric S. Raymond <esr@thyrsus.com>
---
 Documentation/technical/api-command.txt |   91 +++++++++++++++++++++++++++++++
 1 file changed, 91 insertions(+)
 create mode 100644 Documentation/technical/api-command.txt

diff --git a/Documentation/technical/api-command.txt b/Documentation/technical/api-command.txt
new file mode 100644
index 0000000..c1c1afb
--- /dev/null
+++ b/Documentation/technical/api-command.txt
@@ -0,0 +1,91 @@
+= Integrating new subcommands =
+
+This is how-to documentation for people who want to add extension
+commands to git.  It should be read alongside api-builtin.txt.
+
+== Runtime environment ==
+
+git subcommands are standalone executables that live in the git
+execution directory, normally /usr/lib/git-core.  The git executable itself
+is a thin wrapper that sets GIT_DIR and passes command-line arguments
+to the subcommand.
+
+(If "git foo" is not found in the git exec path, the wrapper
+will look in the rest of your $PATH for it.  Thus, it's possible
+to write local git extensions that don't live in system space.)
+
+== Implementation languages ==
+
+Most subcommands are written in C or shell.  A few are written in
+Perl.  A tiny minority are written in Python.
+
+While we strongly encourage coding in portable C for portability, these
+specific scripting languages are also acceptable. We won't accept more
+without a very strong technical case, as we don't want to broaden the
+git suite's required dependencies.
+
+Python is fine for import utilities, surgical tools, remote helpers
+and other code at the edges of the git suite - but it should not yet
+be used for core functions. This may change in the future; the problem
+is that we need better Python integration in the git Windows installer
+before we can be confident people in that environment won't
+experience an unacceptably large loss of capability.
+
+C commands are normally written as single modules, named after the
+command, that link a collection of functions called libgit.  Thus,
+your command 'git-foo' would normally be implemented as a single
+"git-foo.c"; this organization makes it easy for people reading the
+code to find things.
+
+See the CodingGuidelines document for other guidance on what we consider
+good practice in C and shell, and api-builtin.txt for the support
+functions available to built-in commands written in C.
+
+== What every extension command needs ==
+
+You must have a man page, written in asciidoc (this is what git help
+followed by your subcommand name will display).  Be aware that there is
+a local asciidoc configuration and macros which you should use.  It's
+often helpful to start by cloning an existing page and replacing the
+text content.
+
+You must have a test, written to report in TAP (Test Anything Protocol).
+Tests are executables (usually shell scripts) that live in the 't' 
+subdirectory of the tree.  Each test name begins with 't' and a sequence
+number that controls where in the test sequence it will be executed;
+conventionally the rest of the name stem is that of the command 
+being tested.
+
+Read the file t/README to learn more about the conventions to be used
+in writing tests, and the test support library.
+
+== Integrating a command ==
+
+Here are the things you need to do when you want to merge a new 
+subcommand into the git tree.
+
+0. Don't forget to sign off your patch!
+
+1. Append your command name to one of the variables BUILTIN_OBJS,
+EXTRA_PROGRAMS, SCRIPT_SH, SCRIPT_PERL or SCRIPT_PYTHON.
+
+2. Drop its test in the t directory.
+
+3. If your command is implemented in an interpreted language with a 
+p-code intermediate form, make sure .gitignore in the main directory
+includes a pattern entry that ignores such files.  Python .pyc and
+.pyo files will already be covered.
+
+4. If your command has any dependency on a a particular version of
+your language, document it in the INSTALL file.
+
+5. There is a file command-list.txt in the distribution main directory
+that categorizes commands by type, so they can be listed in appropriate
+subsections in the documentation's summary command list.  Add an entry 
+for yours.  To understand the categories, look at git-cmmands.txt
+in the main directory.
+
+6. When your patch is merged, remind the maintainer to add something
+about it in the RelNotes file.
+
+That's all there is to it.
-- 
1.7.9.5

-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>

Whether the authorities be invaders or merely local tyrants, the
effect of such [gun control] laws is to place the individual at the 
mercy of the state, unable to resist.
        -- Robert Anson Heinlein, 1949
