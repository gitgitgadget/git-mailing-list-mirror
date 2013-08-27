From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] Document pack v4 format
Date: Tue, 27 Aug 2013 18:17:05 +0700
Message-ID: <1377602225-30439-1-git-send-email-pclouds@gmail.com>
References: <1377577567-27655-1-git-send-email-nico@fluxnic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@fluxnic.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 27 13:14:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEHE4-0002gR-JP
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 13:14:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752152Ab3H0LOQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Aug 2013 07:14:16 -0400
Received: from mail-pb0-f53.google.com ([209.85.160.53]:52820 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751851Ab3H0LOP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Aug 2013 07:14:15 -0400
Received: by mail-pb0-f53.google.com with SMTP id up15so4706954pbc.12
        for <git@vger.kernel.org>; Tue, 27 Aug 2013 04:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=HELyfbEfGSKOzEDhL303g98Uzki4zLQVsuN5P0WIA7w=;
        b=J9fdFs7fIUAEaVNAdDMmckFH/0UMU1y51pq7FgeNrOPyrNbq44OrUPdMTAXOltpw8D
         FEUa+gUbTjlTw2bBRX6k3mMZIyPE0BF6DPIcgpQWUyjdvMTHfw3MFsjSF4h0FpNT0OWQ
         UBkOZQ9bDpQaa08/dZvIok+m0MWHSVJny+LXS5+LQJ/LiBXCkFttgj8Q8dPCk1WEDzuk
         dpX4yLk967ZXCQddlZz3sJ8ImU0zm0WFm2KI6ZMZlE9rUAnjcUKfQFE+VjW+DuXI0mDY
         VIp49NxPTV93qT+i19P8V7+gvZBb6Xgd29RgAgWzmlJfbLxyrJDUjsL0qCTS23iCRfY+
         UuHA==
X-Received: by 10.68.162.97 with SMTP id xz1mr8191941pbb.166.1377602054823;
        Tue, 27 Aug 2013 04:14:14 -0700 (PDT)
Received: from lanh ([115.73.224.155])
        by mx.google.com with ESMTPSA id wp8sm23999051pbc.26.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 27 Aug 2013 04:14:14 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 27 Aug 2013 18:17:13 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1377577567-27655-1-git-send-email-nico@fluxnic.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233083>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 For my education but may help people who are interested in the
 format. Most is gathered from commit messages, except the delta tree
 entries.
=20
 .idx is not documented yet, but it does not change much and not the
 focus right now anyway.

 Documentation/technical/pack-format-v4.txt (new) | 110 +++++++++++++++=
++++++++
 1 file changed, 110 insertions(+)
 create mode 100644 Documentation/technical/pack-format-v4.txt

diff --git a/Documentation/technical/pack-format-v4.txt b/Documentation=
/technical/pack-format-v4.txt
new file mode 100644
index 0000000..9123a53
--- /dev/null
+++ b/Documentation/technical/pack-format-v4.txt
@@ -0,0 +1,110 @@
+Git pack v4 format
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+=3D=3D pack-*.pack files have the following format:
+
+   - A header appears at the beginning and consists of the following:
+
+     4-byte signature:
+	  The signature is: {'P', 'A', 'C', 'K'}
+
+     4-byte version number (network byte order): must be version
+     number 4
+
+     4-byte number of objects contained in the pack (network byte
+     order)
+
+   - (20 * nr_objects)-byte SHA-1 table: sorted in memcmp() order.
+
+   - Commit name dictionary: the uncompressed length in variable
+     encoding, followed by zlib-compressed dictionary. Each entry
+     consists of two prefix bytes storing timezone followed by a
+     NUL-terminated string.
+
+     Entries should be sorted by frequency so that the most frequent
+     entry has the smallest index, thus most efficient variable
+     encoding.
+
+   - Tree path dictionary: similar format to commit name
+     dictionary. Each entry consists of two prefix bytes storing entry
+     mode, then a NUL-terminated path name. Same sort order
+     recommendation applies.
+
+   - The header is followed by number of object entries, each of
+     which looks like this:
+
+     (undeltified representation)
+     n-byte type and length (4-bit type, (n-1)*7+4-bit length)
+     [uncompressed data]
+     [compressed data]
+
+     (deltified representation)
+     n-byte type and length (4-bit type, (n-1)*7+4-bit length)
+     base object name in SHA-1 reference encoding
+     compressed delta data
+
+     In undeltified format, blobs and tags do not have the
+     uncompressed data, all object content is compressed. Trees are
+     not compressed at all. Some headers in commits are stored
+     uncompressed, the rest is compressed.
+
+     All objects except trees are deltified and compressed the same
+     way in v3. Trees however are deltified differently and use
+     undeltified representation. See "Tree representation" below for
+     details.
+
+  - The trailer records 20-byte SHA-1 checksum of all of the above.
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
+  - Author reference: the index, in variable length encoding, to comit
+    name dictionary, which covers the name and also the time zone.
+
+  - Author timestamp in variable length encoding
+
+  - Committer reference: the index, in variable length encoding, to
+    comit name dictionary, which covers the name and also the time
+    zone.
+
+  - Committer timestamp in variable length encoding
+
+  - Compressed data of remaining header and the body
+
+=3D=3D=3D Tree representation
+
+  - n-byte type and length (4-bit type, (n-1)*7+4-bit length)
+
+  - Number of trees in variable length encoding
+
+  - A number of trees, each consists of
+
+    Path component reference: an index, in variable length encoding,
+    into tree path dictionary, which also covers entry mode.
+
+    SHA-1 in SHA-1 reference encoding.
+
+Path component reference zero is an indicator of deltified portion and
+has the following format:
+
+  - path component reference: zero
+
+  - index of the entry to copy from, in variable length encoding
+
+  - number of entries in variable length encoding
+
+  - base tree in SHA-1 reference encoding
+
+=3D=3D=3D SHA-1 reference encoding
+
+This encoding is used to encode SHA-1 efficiently if it's already in
+the SHA-1 table. It starts with an index number in variable length
+encoding. If it's not zero, its value minus one is the index in the
+SHA-1 table. If it's zero, 20 bytes of SHA-1 is followed.
--=20
1.8.2.83.gc99314b
