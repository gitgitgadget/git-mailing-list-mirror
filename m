From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] doc: technical details about the index file format
Date: Wed,  1 Sep 2010 19:53:45 +1000
Message-ID: <1283334825-18309-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	robin.rosenberg@dewire.com, srabbelier@gmail.com
X-From: git-owner@vger.kernel.org Wed Sep 01 11:54:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oqk1E-0007lt-G7
	for gcvg-git-2@lo.gmane.org; Wed, 01 Sep 2010 11:54:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754352Ab0IAJyI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Sep 2010 05:54:08 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:45777 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751870Ab0IAJyF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Sep 2010 05:54:05 -0400
Received: by pzk9 with SMTP id 9so2763015pzk.19
        for <git@vger.kernel.org>; Wed, 01 Sep 2010 02:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=qFUmv8e7JI3zWR8YYhAGZiwvAUPz6gBTd64oIldP7z0=;
        b=dlxPONvtXgEU75nqk7xJs+r/tRzUVUhGe1420gDAxsd9zy2jW9IYV2eBaRVlZcRNAs
         tL/DJEbJm6gvgdEB7o/rXlpw8z9W1KDOJhuEglFW8A4Z1IVpwGpU8onu1clHQIJP4O84
         drMj25jv4PgaFji6CUyaJGWRmLQ1aOnrOE21w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=MBdsIAYV433ZZwhil1Irt04FF4sFEhjFz7DUb/ojvRk7LvSa9inadX7zF4bozbu9lO
         nKx3pPxtq/QViclINqWFYn6q7BRGyJobl4lrQ5+BfPijUl3ya5BHXrRVgI9FKV8iWCAp
         hY7WXZJitsRU4JPGzayGdwBhPnZ33aoCvxFvg=
Received: by 10.142.135.2 with SMTP id i2mr7000964wfd.279.1283334843657;
        Wed, 01 Sep 2010 02:54:03 -0700 (PDT)
Received: from dektop ([119.12.250.225])
        by mx.google.com with ESMTPS id j5sm3485200wff.20.2010.09.01.02.53.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 01 Sep 2010 02:54:02 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Wed,  1 Sep 2010 19:53:52 +1000
X-Mailer: git-send-email 1.7.1.rc1.69.g24c2f7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155030>

This bases on the original work by Robin Rosenberg:

http://thread.gmane.org/gmane.comp.version-control.git/73471

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 I split index entry out so the overall format is clearer.

 Other changes:
 - mention of version 3
 - added ino and mode
 - added extended flags (v3)
 - entry sort order

 Again I don't realy know REUC extension, so only placeholder

 Documentation/technical/index-format.txt |  139 ++++++++++++++++++++++=
++++++++
 1 files changed, 139 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/technical/index-format.txt

diff --git a/Documentation/technical/index-format.txt b/Documentation/t=
echnical/index-format.txt
new file mode 100644
index 0000000..3e113ca
--- /dev/null
+++ b/Documentation/technical/index-format.txt
@@ -0,0 +1,139 @@
+GIT index format
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+=3D The git index file has the following format
+
+  All binary numbers are in network byte order. Version 2 is described
+  here unless stated otherwise.
+
+   - A 12-byte header consisting of
+
+     4-byte signature:
+       The signature is { 'D', 'I', 'R', 'C' }
+
+     4-byte version number:
+       The current supported versions are 2 and 3.
+
+     32-bit number of index entries.
+
+   - A number of sorted index entries
+
+   - Extensions
+
+     Extensions are identified by signature. Optional extensions can
+     be ignored if GIT does not understand them.
+
+     GIT currently supports tree cache and resolve undo extensions.
+
+     4-byte extension signature. If the first byte is 'A'..'Z' the
+     extension is optional and can be ignored.
+
+     32-bit size of the extension
+
+     Extension data
+
+   - 160-bit SHA-1 over the content of the index file before this
+     checksum.
+
+=3D=3D Index entry
+
+  Index entries are sorted with memcmp() by entry name. Entries with
+  the same name are sorted by their stage.
+
+  32-bit ctime seconds, the last time a file's metadata changed
+    this is stat(2) data
+
+  32-bit ctime nanoseconds (modulo 1G)
+    this is stat(2) data
+
+  32-bit mtime seconds, the last time a file's data changed
+    this is stat(2) data
+
+  32-bit mtime nanoseconds (modulo 1G)
+    this is stat(2) data
+
+  32-bit dev
+    this is stat(2) data
+
+  32-bit ino
+    this is stat(2) data
+
+  32-bit mode, split into (high to low bits)
+
+    4-bit object type
+      valid values in binary are 1000 (blob), 1010 (symbolic link)
+      and 1110 (gitlink)
+
+    3-bit unused
+
+    9-bit unix permission (only 0755 and 0644 are valid)
+
+  32-bit uid
+    this is stat(2) data
+
+  32-bit gid
+    this is stat(2) data
+
+  32-bit file size
+    This is the on-disk size from stat(2)
+
+  160-bit SHA-1 for the represented object
+
+  A 16-bit field split into (high to low bits)
+
+    1-bit assume-valid flag
+
+    1-bit extended flag (must be zero in version 2)
+
+    2-bit stage (during merge)
+
+    12-bit name length if the length is less than 0x0FFF
+
+  (Version 3) A 16-bit field, only applicable if the "extended flag"
+  above is 1, split into (high to low bits).
+
+    1-bit reserved for future
+
+    1-bit skip-worktree flag (used by sparse checkout)
+
+    1-bit intent-to-add flag (used by "git add -N")
+
+    13-bit unused, must be zero
+
+  Entry path name (variable length) relative to top-level directory
+    (without leading slash). '/' is used as path separator. Special
+    paths ".", ".." and ".git" (without quotes) are disallowed.
+    Trailing slash is also disallowed.
+
+  1-8 nul bytes as necessary to pad the entry to a multiple ot eight b=
ytes
+  while keeping the name NUL-terminated.
+
+=3D=3D Extensions
+
+=3D=3D=3D Tree cache
+
+  Tree cache extension contains pre-computes hashes for all trees that
+  can be derived from the index
+
+  - Extension tag { 'T', 'R', 'E', 'E' }
+
+  - 32-bit size
+
+  - A number of entries
+
+     NUL-terminated tree name
+
+     Blank-terminated ASCII decimal number of entries in this tree
+
+     Newline-terminated position of this tree in the parent tree. 0 fo=
r
+     the root tree
+
+     160-bit SHA-1 for this tree and it's children
+
+=3D=3D=3D Resolve undo
+
+  TODO
+
+  - Extension tag { 'R', 'E', 'U', 'C' }
+
+  - 32-bit size
--=20
1.7.1.rc1.69.g24c2f7
