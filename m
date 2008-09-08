From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 2/3] asciidoc.conf: Steal updates from git
Date: Mon, 08 Sep 2008 23:08:05 +0200
Message-ID: <20080908210805.1957.79447.stgit@yoghurt>
References: <20080908210302.1957.44280.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 08 23:09:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcnzB-0008Tt-4f
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 23:09:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754058AbYIHVIQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Sep 2008 17:08:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754062AbYIHVIQ
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Sep 2008 17:08:16 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1924 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754051AbYIHVIJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2008 17:08:09 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1KcoJR-0003ci-00; Mon, 08 Sep 2008 22:30:21 +0100
In-Reply-To: <20080908210302.1957.44280.stgit@yoghurt>
User-Agent: StGIT/0.14.3.236.g0c611
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95303>

Steal updates to asciidoc.conf from git. Also, make sure that we use
the link:[] abd stglink:[] macros correctly everywhere.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 Documentation/asciidoc.conf |   79 +++++++++++++++++++++++++++++++----=
--------
 Documentation/stg.txt       |    2 +
 stgit/argparse.py           |    2 +
 stgit/commands/clone.py     |    4 +-
 4 files changed, 61 insertions(+), 26 deletions(-)


diff --git a/Documentation/asciidoc.conf b/Documentation/asciidoc.conf
index 4c83756..69447ab 100644
--- a/Documentation/asciidoc.conf
+++ b/Documentation/asciidoc.conf
@@ -1,51 +1,86 @@
-## gitlink: macro
-#
-# Usage: gitlink:command[manpage-section]
-#
-# Note, {0} is the manpage section, while {target} is the command.
-#
-# Show GIT link as: <command>(<section>); if section is defined, else =
just show
-# the command.
-
 [attributes]
-caret=3D^
+asterisk=3D&#42;
+plus=3D&#43;
+caret=3D&#94;
 startsb=3D&#91;
 endsb=3D&#93;
 tilde=3D&#126;
=20
 ifdef::backend-docbook[]
-[gitlink-inlinemacro]
-{0%{target}}
-{0#<citerefentry>}
-{0#<refentrytitle>{target}</refentrytitle><manvolnum>{0}</manvolnum>}
-{0#</citerefentry>}
-endif::backend-docbook[]
-
-ifdef::backend-docbook[]
+ifndef::docbook-xsl-172[]
 # "unbreak" docbook-xsl v1.68 for manpages. v1.69 works with or withou=
t this.
+# v1.72 breaks with this because it replaces dots not in roff requests=
=2E
 [listingblock]
 <example><title>{title}</title>
 <literallayout>
+ifdef::doctype-manpage[]
+&#10;.ft C&#10;
+endif::doctype-manpage[]
 |
+ifdef::doctype-manpage[]
+&#10;.ft&#10;
+endif::doctype-manpage[]
 </literallayout>
 {title#}</example>
+endif::docbook-xsl-172[]
+endif::backend-docbook[]
+
+ifdef::doctype-manpage[]
+ifdef::backend-docbook[]
+[header]
+template::[header-declarations]
+<refentry>
+<refmeta>
+<refentrytitle>{mantitle}</refentrytitle>
+<manvolnum>{manvolnum}</manvolnum>
+<refmiscinfo class=3D"source">StGit</refmiscinfo>
+<refmiscinfo class=3D"version">{stgit_version}</refmiscinfo>
+<refmiscinfo class=3D"manual">StGit Manual</refmiscinfo>
+</refmeta>
+<refnamediv>
+  <refname>{manname}</refname>
+  <refpurpose>{manpurpose}</refpurpose>
+</refnamediv>
+endif::backend-docbook[]
+endif::doctype-manpage[]
+
+## link: macro
+#
+# Usage: link:command[manpage-section]
+#
+# Note, {0} is the manpage section, while {target} is the command.
+#
+# Show link as: <command>(<section>); if section is defined, else just
+# show the command.
+
+ifdef::backend-docbook[]
+[link-inlinemacro]
+{0%{target}}
+{0#<citerefentry>}
+{0#<refentrytitle>{target}</refentrytitle><manvolnum>{0}</manvolnum>}
+{0#</citerefentry>}
 endif::backend-docbook[]
=20
 ifdef::backend-xhtml11[]
-[gitlink-inlinemacro]
+[link-inlinemacro]
 <a href=3D"{target}.html">{target}{0?({0})}</a>
 endif::backend-xhtml11[]
=20
-# stglink
+## stglink: macro
+#
+# Usage: stglink:command[]
+#
+# Show StGit link as: stg-<command>(1) in man pages, stg <command> in
+# html.
=20
 ifdef::backend-docbook[]
 [stglink-inlinemacro]
 <citerefentry>
-<refentrytitle>stg {target}</refentrytitle><manvolnum>1</manvolnum>
+  <refentrytitle>stg-{target}</refentrytitle><manvolnum>1</manvolnum>
 </citerefentry>
 endif::backend-docbook[]
=20
 ifdef::backend-xhtml11[]
 [stglink-inlinemacro]
-<a href=3D"stg-{target}.html">stg {target}(1)</a>
+<a href=3D"stg-{target}.html">stg {target}</a>
 endif::backend-xhtml11[]
diff --git a/Documentation/stg.txt b/Documentation/stg.txt
index f6cd815..a0b2176 100644
--- a/Documentation/stg.txt
+++ b/Documentation/stg.txt
@@ -245,7 +245,7 @@ CONFIGURATION MECHANISM
 -----------------------
=20
 Starting with 0.12, StGIT uses the same configuration mechanism as
-GIT.  See gitlink:git[7] for more details.
+GIT.  See link:git[7] for more details.
=20
 TEMPLATES
 ---------
diff --git a/stgit/argparse.py b/stgit/argparse.py
index 4cd9527..d0134f8 100644
--- a/stgit/argparse.py
+++ b/stgit/argparse.py
@@ -94,7 +94,7 @@ def write_asciidoc(cmd, f):
             o.write_asciidoc(f)
             f.write('\n')
     _write_underlined('StGit', '-', f)
-    f.write('Part of the StGit suite - see stglink:stg[1]\n')
+    f.write('Part of the StGit suite - see link:stg[1]\n')
=20
 def sign_options():
     def callback(option, opt_str, value, parser, sign_str):
diff --git a/stgit/commands/clone.py b/stgit/commands/clone.py
index d2c68bb..b83169e 100644
--- a/stgit/commands/clone.py
+++ b/stgit/commands/clone.py
@@ -24,10 +24,10 @@ help =3D 'Make a local clone of a remote repository=
'
 usage =3D ['<repository> <dir>']
 description =3D """
 Clone a git repository into the local directory <dir> (using
-gitlink:clone[]) and initialise the local branch "master".
+stglink:clone[]) and initialise the local branch "master".
=20
 This operation is for example suitable to start working using the
-"tracking branch" workflow (see gitlink:stg[1]). Other means to setup
+"tracking branch" workflow (see link:stg[1]). Other means to setup
 an StGit stack are stglink:init[] and the '--create' and '--clone'
 commands of stglink:branch[].
=20
