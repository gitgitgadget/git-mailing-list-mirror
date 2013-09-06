From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3] Document pack v4 format
Date: Fri,  6 Sep 2013 09:14:03 +0700
Message-ID: <1378433643-15638-1-git-send-email-pclouds@gmail.com>
References: <1377917393-28460-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 06 04:11:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHlWF-0007Vs-3a
	for gcvg-git-2@plane.gmane.org; Fri, 06 Sep 2013 04:11:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753734Ab3IFCLP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Sep 2013 22:11:15 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:47361 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753100Ab3IFCLO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Sep 2013 22:11:14 -0400
Received: by mail-pd0-f171.google.com with SMTP id g10so2600111pdj.30
        for <git@vger.kernel.org>; Thu, 05 Sep 2013 19:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=o72McHgPZksZH7bN9SSE1SCcDwt7Hp7ZzWCCa4SHRNc=;
        b=XxIW2zpVfW/F5KcTH73ZQOLyITkmiw5Yymf0JhwmJAvPSw0Z3Q7kpbfAJ/oEDjgel8
         qjLpLfJ1TziwdmjQNhrjsPNq/lMugWx+9n8130c70ZvLqNIiQmYeLD6ZXFxlQuAyU6/y
         +eL8dwdPrvUoeEtTwJuy1VXj/e9o7c1f03BMp5YpNj969HHiV5P1FB+cyKLoHKKx97V8
         PT6REAbOPgpmdg/talmGtBG4glFuOgs6ZVe+jR4Ed4hhC3SKysUeVTVpkzm8P5vKbGYq
         9Z3wHn1L7ag9qMqDQmZ2GxTTK586qCpxRdHUcnIQ2OITM6MbcdiqxXvuy8glXp1xoeYr
         Tg3Q==
X-Received: by 10.66.136.131 with SMTP id qa3mr1103952pab.77.1378433473908;
        Thu, 05 Sep 2013 19:11:13 -0700 (PDT)
Received: from lanh ([115.73.241.111])
        by mx.google.com with ESMTPSA id q1sm161929pbd.12.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 05 Sep 2013 19:11:13 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Fri, 06 Sep 2013 09:14:20 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1377917393-28460-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234012>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Should be up to date with Nico's latest implementation and also cover
 additions to the format that everybody seems to agree on:

  - new types for canonical trees and commits
  - sha-1 table covering missing objects in thin packs

 Documentation/technical/pack-format.txt | 133 ++++++++++++++++++++++++=
+++++++-
 1 file changed, 132 insertions(+), 1 deletion(-)

diff --git a/Documentation/technical/pack-format.txt b/Documentation/te=
chnical/pack-format.txt
index 8e5bf60..c5327ff 100644
--- a/Documentation/technical/pack-format.txt
+++ b/Documentation/technical/pack-format.txt
@@ -1,7 +1,7 @@
 Git pack format
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
-=3D=3D pack-*.pack files have the following format:
+=3D=3D pack-*.pack files version 2 and 3 have the following format:
=20
    - A header appears at the beginning and consists of the following:
=20
@@ -36,6 +36,132 @@ Git pack format
=20
   - The trailer records 20-byte SHA-1 checksum of all of the above.
=20
+=3D=3D pack-*.pack files version 4 have the following format:
+
+   - A header appears at the beginning and consists of the following:
+
+     4-byte signature:
+	The signature is: {'P', 'A', 'C', 'K'}
+
+     4-byte version number (network byte order): must be 4
+
+     4-byte number of objects contained in the pack (network byte orde=
r)
+
+   - A series of tables, described separately.
+
+   - The tables are followed by number of object entries, each of
+     which looks like below:
+
+     (undeltified representation)
+     n-byte type and length (4-bit type, (n-1)*7+4-bit length)
+     data
+
+     (deltified representation)
+     n-byte type and length (4-bit type, (n-1)*7+4-bit length)
+     base object name in SHA-1 reference encoding
+     compressed delta data
+
+     "type" is used to determine object type. Commit has type 1, tree
+     2, blob 3, tag 4, ref-delta 7, canonical-commit 9 (commit type
+     with bit 3 set), canonical-tree 10 (tree type with bit 3 set).
+     Compared to v2, ofs-delta type is not used, and canonical-commit
+     and canonical-tree are new types.
+
+     In undeltified format, blobs and tags ares compressed. Trees are
+     not compressed at all. Some headers in commits are stored
+     uncompressed, the rest is compressed. Tree and commit
+     representations are described in detail separately.
+
+     Blobs and tags are deltified and compressed the same way in
+     v3. Commits are not delitifed. Trees are deltified using
+     undeltified representation.
+
+     Trees and commits in canonical types are in the same format as
+     v2: in canonical format and deflated. They can be used for
+     completing thin packs or preserving somewhat ill-formatted
+     objects.
+
+  - The trailer records 20-byte SHA-1 checksum of all of the above.
+
+=3D=3D=3D Pack v4 tables
+
+ - A table of sorted SHA-1 object names for all objects contained in
+   the on-disk pack.
+
+   Thin packs are used for transferring on the wire and may omit base
+   objects, expecting the receiver to add them before writing to
+   disk. The SHA-1 table in thin packs must include the omitted object=
s
+   as well.
+
+   This table can be referred to using "SHA-1 reference encoding": the
+   index, in variable length encoding, to this table.
+
+ - Ident table: the uncompressed length in variable encoding,
+   followed by zlib-compressed dictionary. Each entry consists of
+   two prefix bytes storing timezone followed by a NUL-terminated
+   string.
+
+   Entries should be sorted by frequency so that the most frequent
+   entry has the smallest index, thus most efficient variable
+   encoding.
+
+   The table can be referred to using "ident reference encoding": the
+   index number, in variable length encoding, to this table.
+
+ - Tree path table: the same format to ident table. Each entry
+   consists of two prefix bytes storing tree entry mode, then a
+   NUL-terminated path name. Same sort order recommendation applies.
+
+=3D=3D=3D Commit representation
+
+  - n-byte type and length (4-bit type, (n-1)*7+4-bit length)
+
+  - Tree SHA-1 in SHA-1 reference encoding
+
+  - Parent count in variable length encoding
+
+  - Parent SHA-1s in SHA-1 reference encoding
+
+  - Author reference in ident reference encoding
+
+  - Author timestamp in variable length encoding
+
+  - Committer reference in ident reference encoding
+
+  - Committer timestamp, encoded as a difference against author
+    timestamp with the LSB used to indicate negative difference.
+
+  - Compressed data of remaining header and the body
+
+=3D=3D=3D Tree representation
+
+  - n-byte type and length (4-bit type, (n-1)*7+4-bit length)
+
+  - Number of tree entries in variable length encoding
+
+  - A number of entries, each can be in either forms
+
+    - INT(path_index << 1)        INT(sha1_index)
+
+    - INT((entry_start << 1) | 1) INT(entry_count << 1)
+
+    - INT((entry_start << 1) | 1) INT((entry_count << 1) | 1) INT(base=
_sha1_index)
+
+    INT() denotes a number in variable length encoding. path_index is
+    the index to the tree path table. sha1_index is the index to the
+    SHA-1 table. entry_start is the first tree entry to copy
+    from. entry_count is the number of tree entries to
+    copy. base_sha1_index is the index to SHA-1 table of the base tree
+    to copy from.
+
+    The LSB of the first number indicates whether it's a plain tree
+    entry (LSB not set), or an instruction to copy tree entries from
+    another tree (LSB set).
+
+    For copying from another tree, is the LSB of the second number is
+    set, it will be followed by a base tree SHA-1. If it's not set,
+    the last base tree will be used.
+
 =3D=3D Original (version 1) pack-*.idx files have the following format=
:
=20
   - The header consists of 256 4-byte network byte order
@@ -160,3 +286,8 @@ Pack file entry: <+
     corresponding packfile.
=20
     20-byte SHA-1-checksum of all of the above.
+
+=3D=3D Version 3 pack-*.idx files support only *.pack files version 4.=
 The
+   format is the same as version 2 except that the table of sorted
+   20-byte SHA-1 object names is missing in the .idx files. The same
+   table exists in .pack files and will be used instead.
--=20
1.8.2.83.gc99314b
