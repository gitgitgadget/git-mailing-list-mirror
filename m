From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] doc: technical details about the index file format
Date: Thu,  2 Sep 2010 00:39:49 +1000
Message-ID: <1283351989-19426-1-git-send-email-pclouds@gmail.com>
References: <201009012054.20482.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	robin.rosenberg@dewire.com, srabbelier@gmail.com
X-From: git-owner@vger.kernel.org Thu Sep 02 01:31:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqwmW-0007k5-IJ
	for gcvg-git-2@lo.gmane.org; Thu, 02 Sep 2010 01:31:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755344Ab0IAXb0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Sep 2010 19:31:26 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:42117 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752517Ab0IAXb0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Sep 2010 19:31:26 -0400
Received: by pxi10 with SMTP id 10so3041656pxi.19
        for <git@vger.kernel.org>; Wed, 01 Sep 2010 16:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=3FaMJ6Sg0fC15V7bcOMVbceSBvVDKu6syU2Fqn0Ij9A=;
        b=Ibqc4vf47rbCJoXo/vMnrZjh/yoRL3qhr8fKdJuUAsR6Egvf+KsIQMGw/rYaIhO2t2
         +FzsbbRvuOdfbrmWpBfPU8WRQT3RTm9OzRck3A3u3I1wYRnehou+L+/LWtWrZJqyiONW
         ImE56RV454pRn9/+xbNWZ30DXMbbDtUsdUMto=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=NqX+mJhKcNNBSvydSROK5Kv/nBy1eBt+6qFlc1zzQos/GpSypJ4h8iqEFVpZuW58TC
         sobPz1BCvOb06pkgXC5ijNga8RqmO8htYu6tdO3F0HMpCtXWlGxwY4QjfbQq0p9IPgLl
         QuwFV2myF/OFzri3aVZyEdxbaHAhsuVy1mK28=
Received: by 10.115.90.18 with SMTP id s18mr9677259wal.7.1283383885452;
        Wed, 01 Sep 2010 16:31:25 -0700 (PDT)
Received: from dektop (dektec3.lnk.telstra.net [165.228.202.174])
        by mx.google.com with ESMTPS id k23sm19470721waf.17.2010.09.01.16.31.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 01 Sep 2010 16:31:24 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Thu,  2 Sep 2010 00:39:58 +1000
X-Mailer: git-send-email 1.7.1.rc1.69.g24c2f7
In-Reply-To: <201009012054.20482.robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155097>

This bases on the original work by Robin Rosenberg.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Fixups after Robin's review

 Documentation/technical/index-format.txt |  144 ++++++++++++++++++++++=
++++++++
 1 files changed, 144 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/technical/index-format.txt

diff --git a/Documentation/technical/index-format.txt b/Documentation/t=
echnical/index-format.txt
new file mode 100644
index 0000000..0285d88
--- /dev/null
+++ b/Documentation/technical/index-format.txt
@@ -0,0 +1,144 @@
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
+  Index entries are sorted in ascending order on the name field,
+  interpreted as a string of unsigned bytes. Entries with the same
+  name are sorted by their stage field.
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
+  Entry path name (variable length) relative to top level directory
+    (without leading slash). '/' is used as path separator. The specia=
l
+    paths ".", ".." and ".git" (without quotes) are disallowed.
+    Trailing slash is also disallowed.
+
+    The exact encoding is undefined, but the '.' and '/' characters
+    are encoded in 7-bit ASCII and the encoding cannot contain a nul
+    byte. Generally a superset of ASCII.
+
+  1-8 nul bytes as necessary to pad the entry to a multiple of eight b=
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
