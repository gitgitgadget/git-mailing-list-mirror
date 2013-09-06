From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH v3] Document pack v4 format
Date: Thu, 05 Sep 2013 23:23:08 -0400 (EDT)
Message-ID: <alpine.LFD.2.03.1309052319310.20709@syhkavp.arg>
References: <1377917393-28460-1-git-send-email-pclouds@gmail.com>
 <1378433643-15638-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_warb/Y9gJnDSZyMcWPsjjA)"
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?VISCII?Q?Nguy=ADn_Th=E1i_Ng=F7c_Duy?= <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 06 05:23:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHme5-0000sn-1C
	for gcvg-git-2@plane.gmane.org; Fri, 06 Sep 2013 05:23:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758724Ab3IFDXf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Sep 2013 23:23:35 -0400
Received: from relais.videotron.ca ([24.201.245.36]:30341 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758219Ab3IFDXP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Sep 2013 23:23:15 -0400
Received: from yoda.home ([70.83.209.44]) by VL-VM-MR005.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MSO00ECTPEQB4A0@VL-VM-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 05 Sep 2013 23:23:14 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])	by yoda.home (Postfix)
 with ESMTPSA id 0A1372DA0547; Thu, 05 Sep 2013 23:23:14 -0400 (EDT)
In-reply-to: <1378433643-15638-1-git-send-email-pclouds@gmail.com>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
Content-id: <alpine.LFD.2.03.1309052320340.20709@syhkavp.arg>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234015>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_warb/Y9gJnDSZyMcWPsjjA)
Content-id: <alpine.LFD.2.03.1309052320341.20709@syhkavp.arg>
Content-type: TEXT/PLAIN; CHARSET=VISCII
Content-transfer-encoding: 8BIT

On Fri, 6 Sep 2013, Nguy­n Thái Ng÷c Duy wrote:

> 
> Signed-off-by: Nguy­n Thái Ng÷c Duy <pclouds@gmail.com>
> ---
>  Should be up to date with Nico's latest implementation and also cover
>  additions to the format that everybody seems to agree on:
> 
>   - new types for canonical trees and commits
>   - sha-1 table covering missing objects in thin packs

Great!  I've merged this into my branch with the following amendment:

diff --git a/Documentation/technical/pack-format.txt b/Documentation/technical/pack-format.txt
index 1980794..d0c2cde 100644
--- a/Documentation/technical/pack-format.txt
+++ b/Documentation/technical/pack-format.txt
@@ -81,6 +81,13 @@ Git pack format
      completing thin packs or preserving somewhat ill-formatted
      objects.
 
+     Thin packs are used for transferring on the wire and may omit delta
+     base objects, expecting the receiver to add them at the end of the pack
+     before writing to disk.  The number of objects contained in the pack
+     header must account for those omitted objects in any case. To indicate
+     no more objects are included in a thin pack, a "type 0" byte
+     indicator is inserted after the last transmitted object.
+
   - The trailer records 20-byte SHA-1 checksum of all of the above.
 
 === Pack v4 tables
@@ -88,10 +95,7 @@ Git pack format
  - A table of sorted SHA-1 object names for all objects contained in
    the on-disk pack.
 
-   Thin packs are used for transferring on the wire and may omit base
-   objects, expecting the receiver to add them before writing to
-   disk. The SHA-1 table in thin packs must include the omitted objects
-   as well.
+   The SHA-1 table in thin packs must include the omitted objects as well.
 
    This table can be referred to using "SHA-1 reference encoding": the
    index, in variable length encoding, to this table.
@@ -158,7 +162,7 @@ Git pack format
     entry (LSB not set), or an instruction to copy tree entries from
     another tree (LSB set).
 
-    For copying from another tree, is the LSB of the second number is
+    For copying from another tree, if the LSB of the second number is
     set, it will be followed by a base tree SHA-1. If it's not set,
     the last base tree will be used.
 

> diff --git a/Documentation/technical/pack-format.txt b/Documentation/technical/pack-format.txt
> index 8e5bf60..c5327ff 100644
> --- a/Documentation/technical/pack-format.txt
> +++ b/Documentation/technical/pack-format.txt
> @@ -1,7 +1,7 @@
>  Git pack format
>  ===============
>  
> -== pack-*.pack files have the following format:
> +== pack-*.pack files version 2 and 3 have the following format:
>  
>     - A header appears at the beginning and consists of the following:
>  
> @@ -36,6 +36,132 @@ Git pack format
>  
>    - The trailer records 20-byte SHA-1 checksum of all of the above.
>  
> +== pack-*.pack files version 4 have the following format:
> +
> +   - A header appears at the beginning and consists of the following:
> +
> +     4-byte signature:
> +	The signature is: {'P', 'A', 'C', 'K'}
> +
> +     4-byte version number (network byte order): must be 4
> +
> +     4-byte number of objects contained in the pack (network byte order)
> +
> +   - A series of tables, described separately.
> +
> +   - The tables are followed by number of object entries, each of
> +     which looks like below:
> +
> +     (undeltified representation)
> +     n-byte type and length (4-bit type, (n-1)*7+4-bit length)
> +     data
> +
> +     (deltified representation)
> +     n-byte type and length (4-bit type, (n-1)*7+4-bit length)
> +     base object name in SHA-1 reference encoding
> +     compressed delta data
> +
> +     "type" is used to determine object type. Commit has type 1, tree
> +     2, blob 3, tag 4, ref-delta 7, canonical-commit 9 (commit type
> +     with bit 3 set), canonical-tree 10 (tree type with bit 3 set).
> +     Compared to v2, ofs-delta type is not used, and canonical-commit
> +     and canonical-tree are new types.
> +
> +     In undeltified format, blobs and tags ares compressed. Trees are
> +     not compressed at all. Some headers in commits are stored
> +     uncompressed, the rest is compressed. Tree and commit
> +     representations are described in detail separately.
> +
> +     Blobs and tags are deltified and compressed the same way in
> +     v3. Commits are not delitifed. Trees are deltified using
> +     undeltified representation.
> +
> +     Trees and commits in canonical types are in the same format as
> +     v2: in canonical format and deflated. They can be used for
> +     completing thin packs or preserving somewhat ill-formatted
> +     objects.
> +
> +  - The trailer records 20-byte SHA-1 checksum of all of the above.
> +
> +=== Pack v4 tables
> +
> + - A table of sorted SHA-1 object names for all objects contained in
> +   the on-disk pack.
> +
> +   Thin packs are used for transferring on the wire and may omit base
> +   objects, expecting the receiver to add them before writing to
> +   disk. The SHA-1 table in thin packs must include the omitted objects
> +   as well.
> +
> +   This table can be referred to using "SHA-1 reference encoding": the
> +   index, in variable length encoding, to this table.
> +
> + - Ident table: the uncompressed length in variable encoding,
> +   followed by zlib-compressed dictionary. Each entry consists of
> +   two prefix bytes storing timezone followed by a NUL-terminated
> +   string.
> +
> +   Entries should be sorted by frequency so that the most frequent
> +   entry has the smallest index, thus most efficient variable
> +   encoding.
> +
> +   The table can be referred to using "ident reference encoding": the
> +   index number, in variable length encoding, to this table.
> +
> + - Tree path table: the same format to ident table. Each entry
> +   consists of two prefix bytes storing tree entry mode, then a
> +   NUL-terminated path name. Same sort order recommendation applies.
> +
> +=== Commit representation
> +
> +  - n-byte type and length (4-bit type, (n-1)*7+4-bit length)
> +
> +  - Tree SHA-1 in SHA-1 reference encoding
> +
> +  - Parent count in variable length encoding
> +
> +  - Parent SHA-1s in SHA-1 reference encoding
> +
> +  - Author reference in ident reference encoding
> +
> +  - Author timestamp in variable length encoding
> +
> +  - Committer reference in ident reference encoding
> +
> +  - Committer timestamp, encoded as a difference against author
> +    timestamp with the LSB used to indicate negative difference.
> +
> +  - Compressed data of remaining header and the body
> +
> +=== Tree representation
> +
> +  - n-byte type and length (4-bit type, (n-1)*7+4-bit length)
> +
> +  - Number of tree entries in variable length encoding
> +
> +  - A number of entries, each can be in either forms
> +
> +    - INT(path_index << 1)        INT(sha1_index)
> +
> +    - INT((entry_start << 1) | 1) INT(entry_count << 1)
> +
> +    - INT((entry_start << 1) | 1) INT((entry_count << 1) | 1) INT(base_sha1_index)
> +
> +    INT() denotes a number in variable length encoding. path_index is
> +    the index to the tree path table. sha1_index is the index to the
> +    SHA-1 table. entry_start is the first tree entry to copy
> +    from. entry_count is the number of tree entries to
> +    copy. base_sha1_index is the index to SHA-1 table of the base tree
> +    to copy from.
> +
> +    The LSB of the first number indicates whether it's a plain tree
> +    entry (LSB not set), or an instruction to copy tree entries from
> +    another tree (LSB set).
> +
> +    For copying from another tree, is the LSB of the second number is
> +    set, it will be followed by a base tree SHA-1. If it's not set,
> +    the last base tree will be used.
> +
>  == Original (version 1) pack-*.idx files have the following format:
>  
>    - The header consists of 256 4-byte network byte order
> @@ -160,3 +286,8 @@ Pack file entry: <+
>      corresponding packfile.
>  
>      20-byte SHA-1-checksum of all of the above.
> +
> +== Version 3 pack-*.idx files support only *.pack files version 4. The
> +   format is the same as version 2 except that the table of sorted
> +   20-byte SHA-1 object names is missing in the .idx files. The same
> +   table exists in .pack files and will be used instead.
> -- 
> 1.8.2.83.gc99314b
> 
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

--Boundary_(ID_warb/Y9gJnDSZyMcWPsjjA)--
