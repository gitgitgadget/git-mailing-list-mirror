From: "Stefan-W. Hahn" <stefan.hahn@s-hahn.de>
Subject: Bug: Problem with CRLF line ending in git-diff with coloring
Date: Sun, 9 Feb 2014 12:01:55 +0100
Organization: -no organization-
Message-ID: <20140209110155.GB16189@scotty.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 09 12:02:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WCS9J-0002GT-Eb
	for gcvg-git-2@plane.gmane.org; Sun, 09 Feb 2014 12:02:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751886AbaBILCB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Feb 2014 06:02:01 -0500
Received: from moutng.kundenserver.de ([212.227.126.171]:62891 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751696AbaBILB6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Feb 2014 06:01:58 -0500
Received: from scotty.home (port-92-201-60-154.dynamic.qsc.de [92.201.60.154])
	by mrelayeu.kundenserver.de (node=mreue003) with ESMTP (Nemesis)
	id 0M4VfU-1VISLo2pwK-00yfs2; Sun, 09 Feb 2014 12:01:56 +0100
Received: from scotty.home (hs@localhost [127.0.0.1])
	by scotty.home (8.14.4/8.14.4/Debian-4) with ESMTP id s19B1txx023649
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 9 Feb 2014 12:01:55 +0100
Received: (from hs@localhost)
	by scotty.home (8.14.4/8.14.4/Submit) id s19B1tQD023648;
	Sun, 9 Feb 2014 12:01:55 +0100
X-Authentication-Warning: scotty.home: hs set sender to stefan.hahn@s-hahn.de using -f
Content-Disposition: inline
X-Mailer: Mutt http://www.mutt.org/
X-Editor: GNU Emacs http://www.gnu.org/
X-Accept-Language: de en
X-Location: Europe, Germany, Wolfenbuettel
X-GPG-Public-Key: gpg --keyserver keys.gnupg.net --recv-keys E4FCD563
X-GPG-Fingerprint: 0xE4FCD563 / EF09 97BB 3731 7DC7 25BA 5C39 185C F986 E4FC
 D563
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Virus-Scanned: clamav-milter 0.97.8 at scotty
X-Virus-Status: Clean
X-Provags-ID: V02:K0:6aIYVwTnoppasqaIUdE1yQs+4v9SDw+zQORiI92+Dgy
 +SSwaSAfpjVFdq/KCCv8hUe6x4M12Ewerb2U9P5jXqw6kivXAZ
 N11yYQAxeuUNiQrWglBiphZ+uSGcNTPSJI6WNTgUox5yknvKed
 XYAgSODDdhEKER6ljSVwTWzlEY7C3gNhIfJ88wrw+xY5VjxyZx
 0qOemj5eD3lASfWDLqPpsqjRyqVvytJ/a2KiRaWNqAZiD+HBA5
 3mx//2sxKRGK6zH32UqR3gK1HuK9LzN1f7DxyU8JdAdO+E0nAD
 oJJF0pJs9/auaijDTwYivW5FDqbAYiaM0fF5ECqCwnQqulxTWg
 ob5idx/Cj80MyT+T0Ht4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241873>

Good morning,

when diffing output where files have CRLF line ending, the coloring
seems wrong, because in changed lines the CR (^M) is highlighted,
even if the line ending has not changed.

The diff engine itself is correct.

I added a test case to show this behaviour.

The problem seems to come from emit_add_line() where ws_check_emit() is
called.  The parameter ecbdata->ws_rule has not set WS_CR_AT_EOL. In this
case ws_check_emit() handles the CR at eol as whitespace character and
therfore highlights it. This seems wrong for files with CRLF lineending.

,----
| static void emit_add_line(const char *reset,
| 			  struct emit_callback *ecbdata,
| 			  const char *line, int len)
| {
|         const char *ws = diff_get_color(ecbdata->color_diff, DIFF_WHITESPACE);
|         ...
|         
| 	if (!*ws)
|         ...
| 	else {
| 		/* Emit just the prefix, then the rest. */
| 		emit_line_0(ecbdata->opt, set, reset, '+', "", 0);
| 		ws_check_emit(line, len, ecbdata->ws_rule,
| 			      ecbdata->opt->file, set, reset, ws);
| 	}
| }
`----

If WS_CR_AT_EOL is set in ecbdata->ws_rule, it works correctly, but this seems
not the right solutions. (Sorry, but I'm not deep enough in the code to
propose a solution.)

Another nitpick: While writing the test it was unclear for me where the color
start and end sequences will be put. Here is a difference between old lines and
new lines, because old lines will be printed with emit_line_0() and new lines
with emit_line_0() + ws_check_emit(). So in case of new lines the "+" itself
is enclosed by the color sequences, where in case of the old lines the whole
line is enclosed by the color sequences.

I tested this with 6a7071958620dad (Git 1.9.0-rc3), but this is also wrong
in older versions.

With kind regards,
Stefan

---
 t/t4060-diff-eol.sh | 81 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 81 insertions(+), 0 deletion(-)
 create mode 100755 t/t4060-diff-eol.sh

diff --git a/t/t4060-diff-eol.sh b/t/t4060-diff-eol.sh
new file mode 100755
index 0000000..8cf9a69
--- /dev/null
+++ b/t/t4060-diff-eol.sh
@@ -0,0 +1,81 @@
+#!/bin/sh
+#
+# Copyright (c) 2014 Stefan-W. Hahn
+#
+
+test_description='Test coloring of diff with CRLF line ending.
+
+'
+. ./test-lib.sh
+
+get_color ()
+{
+	git config --get-color "$1"
+}
+
+tr 'Q' '\015' << EOF > x
+Zeile 1Q
+Zeile 2Q
+Zeile 3Q
+EOF
+
+git update-index --add x
+
+tr 'Q' '\015' << EOF > x
+Zeile 1Q
+Zeile 22Q
+Zeile 3Q
+EOF
+
+tr 'Q' '\015' << EOF > expect
+diff --git a/x b/x
+index 3411cc1..68a4b2c 100644
+--- a/x
++++ b/x
+@@ -1,3 +1,3 @@
+ Zeile 1Q
+-Zeile 2Q
++Zeile 22Q
+ Zeile 3Q
+EOF
+
+
+git -c color.diff=false diff > out
+test_expect_success "diff files ending with CRLF without color" '
+        test_cmp expect out'
+
+test_expect_success setup '
+        git config color.diff.plain black &&
+        git config color.diff.meta blue &&
+        git config color.diff.frag yellow &&
+        git config color.diff.func normal &&
+        git config color.diff.old red &&
+        git config color.diff.new green &&
+        git config color.diff.commit normal &&
+	c_reset=$(git config --get-color no.such.color reset) &&
+	c_plain=$(get_color color.diff.plain) &&
+	c_meta=$(get_color color.diff.meta) &&
+	c_frag=$(get_color color.diff.frag) &&
+	c_func=$(get_color color.diff.func) &&
+	c_old=$(get_color color.diff.old) &&
+	c_new=$(get_color color.diff.new) &&
+	c_commit=$(get_color color.diff.commit) &&
+	c_whitespace=$(get_color color.diff.whitespace)
+'
+
+tr 'Q' '\015' << EOF > expect
+${c_meta}diff --git a/x b/x${c_reset}
+${c_meta}index 3411cc1..68a4b2c 100644${c_reset}
+${c_meta}--- a/x${c_reset}
+${c_meta}+++ b/x${c_reset}
+${c_frag}@@ -1,3 +1,3 @@${c_reset}
+${c_plain} Zeile 1${c_reset}Q
+${c_old}-Zeile 2${c_reset}Q
+${c_new}+${c_reset}${c_new}Zeile 22${c_reset}Q
+${c_plain} Zeile 3${c_reset}Q
+EOF
+
+git -c color.diff=always diff > out
+test_expect_success "diff files ending with CRLF with color coding" 'test_cmp expect out'
+
+test_done
-- 
1.8.3.2.733.gf8abaeb



-- 
Stefan-W. Hahn                          It is easy to make things.
                                        It is hard to make things simple.
