From: Johan Herland <johan@herland.net>
Subject: [RFC 06/11] Add support for mark references as path names
Date: Mon, 27 Jul 2009 03:04:14 +0200
Message-ID: <1248656659-21415-7-git-send-email-johan@herland.net>
References: <1248656659-21415-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Johan Herland <johan@herland.net>, barkalow@iabervon.org,
	gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 27 03:06:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVEfT-0004JH-HG
	for gcvg-git-2@gmane.org; Mon, 27 Jul 2009 03:06:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755489AbZG0BFp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jul 2009 21:05:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755465AbZG0BFo
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Jul 2009 21:05:44 -0400
Received: from mx.getmail.no ([84.208.15.66]:43135 "EHLO
	get-mta-out03.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755460AbZG0BFn (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Jul 2009 21:05:43 -0400
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KNF0078G1PJZF40@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Mon, 27 Jul 2009 03:05:43 +0200 (MEST)
Received: from localhost.localdomain ([84.215.102.95])
 by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KNF004SX1O2UG30@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Mon, 27 Jul 2009 03:05:43 +0200 (MEST)
X-PMX-Version: 5.5.5.374460, Antispam-Engine: 2.7.1.369594,
 Antispam-Data: 2009.7.27.4819
X-Mailer: git-send-email 1.6.4.rc3.138.ga6b98.dirty
In-reply-to: <1248656659-21415-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124148>

When using a mark reference as a path name, the mark reference will be
expanded to the 40-byte hex version of the object name associated with the
mark. This is useful e.g. when importing notes objects (where the filenames
in a notes tree are the object names of the annotated objects).

Signed-off-by: Johan Herland <johan@herland.net>
---
 Documentation/git-fast-import.txt |    9 +++++++--
 fast-import.c                     |   11 +++++++++--
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index c2f483a..bbc8b78 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -487,12 +487,17 @@ in octal.  Git only supports the following modes:
 
 In both formats `<path>` is the complete path of the file to be added
 (if not already existing) or modified (if already existing).
+`<path>` may also be a mark reference (`:<idnum>`) set by a prior
+command, which will expand to a full 40-byte SHA-1 of the Git object
+associated with the mark. This is useful e.g. when importing commit
+notes (the filenames in a notes commit are the object names of the
+annotated commits).
 
 A `<path>` string must use UNIX-style directory separators (forward
 slash `/`), may contain any byte other than `LF`, and must not
-start with double quote (`"`).
+start with double quote (`"`) or colon (`:`).
 
-If an `LF` or double quote must be encoded into `<path>` shell-style
+If an `LF`, double quote or colon must be encoded into `<path>` shell-style
 quoting should be used, e.g. `"path/with\n and \" in it"`.
 
 The value of `<path>` must be in canonical form. That is it must not:
diff --git a/fast-import.c b/fast-import.c
index 8a7cdc1..3edfcf0 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -85,13 +85,13 @@ Format of STDIN stream:
      # common escapes of 'c' (e..g \n, \t, \\, \") or \nnn where nnn
      # is the signed byte value in octal.  Note that the only
      # characters which must actually be escaped to protect the
-     # stream formatting is: \, " and LF.  Otherwise these values
+     # stream formatting is: \, ", : and LF.  Otherwise these values
      # are UTF8.
      #
   ref_str     ::= ref;
   sha1exp_str ::= sha1exp;
   tag_str     ::= tag;
-  path_str    ::= path    | '"' quoted(path)    '"' ;
+  path_str    ::= path | '"' quoted(path) '"' | idnum;
   mode        ::= '100644' | '644'
                 | '100755' | '755'
                 | '120000'
@@ -1864,6 +1864,13 @@ static const char *get_path_str(
 	if (!unquote_c_style(sb, p, endp)) {
 		/* successfully unquoted C-style quoted name */
 		p = sb->buf;
+	} else if (*p == ':') {
+		/* resolve mark reference */
+		char *x;
+		struct object_entry *pe = find_mark(strtoumax(p + 1, &x, 10));
+		*endp = x;
+		strbuf_add(sb, sha1_to_hex(pe->sha1), 40);
+		p = sb->buf;
 	} else {
 		/* regular path ending at endc */
 		*endp = strchr(p, endc);
-- 
1.6.4.rc3.138.ga6b98.dirty
