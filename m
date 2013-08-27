From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] Document pack v4 format
Date: Tue, 27 Aug 2013 14:53:01 -0400 (EDT)
Message-ID: <alpine.LFD.2.03.1308271433210.14472@syhkavp.arg>
References: <1377577567-27655-1-git-send-email-nico@fluxnic.net>
 <1377602225-30439-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_F57mw4C6Oc0ejt5j94QYNg)"
Cc: git@vger.kernel.org
To: =?VISCII?Q?Nguy=ADn_Th=E1i_Ng=F7c_Duy?= <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 27 20:53:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEOOA-0006AH-IB
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 20:53:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753298Ab3H0SxJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Aug 2013 14:53:09 -0400
Received: from relais.videotron.ca ([24.201.245.36]:55408 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752231Ab3H0SxI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Aug 2013 14:53:08 -0400
Received: from yoda.home ([70.83.209.44]) by VL-VM-MR001.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MS700FOXDSI7NC0@VL-VM-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 27 Aug 2013 14:53:06 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])	by yoda.home (Postfix)
 with ESMTPSA id 6DB712DA052D; Tue, 27 Aug 2013 14:53:06 -0400 (EDT)
In-reply-to: <1377602225-30439-1-git-send-email-pclouds@gmail.com>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233134>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_F57mw4C6Oc0ejt5j94QYNg)
Content-type: TEXT/PLAIN; charset=UTF-8
Content-transfer-encoding: 8BIT

On Tue, 27 Aug 2013, Nguyễn Thái Ngọc Duy wrote:

> 
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  For my education but may help people who are interested in the
>  format. Most is gathered from commit messages, except the delta tree
>  entries.

Excellent!  That's the kind of thing I need help with.

Some corrections below.

>  Documentation/technical/pack-format-v4.txt (new) | 110 +++++++++++++++++++++++
>  1 file changed, 110 insertions(+)
>  create mode 100644 Documentation/technical/pack-format-v4.txt
> 
> diff --git a/Documentation/technical/pack-format-v4.txt b/Documentation/technical/pack-format-v4.txt
> new file mode 100644
> index 0000000..9123a53
> --- /dev/null
> +++ b/Documentation/technical/pack-format-v4.txt
> @@ -0,0 +1,110 @@
> +Git pack v4 format
> +==================
> +
> +== pack-*.pack files have the following format:
> +
> +   - A header appears at the beginning and consists of the following:
> +
> +     4-byte signature:
> +	  The signature is: {'P', 'A', 'C', 'K'}
> +
> +     4-byte version number (network byte order): must be version
> +     number 4
> +
> +     4-byte number of objects contained in the pack (network byte
> +     order)

Conceptually, I'd suggest we don't talk about what follows as part of 
the header.  Maybe the "tables" section would make more sense.

> +   - (20 * nr_objects)-byte SHA-1 table: sorted in memcmp() order.
> +
> +   - Commit name dictionary: the uncompressed length in variable
> +     encoding, followed by zlib-compressed dictionary. Each entry
> +     consists of two prefix bytes storing timezone followed by a
> +     NUL-terminated string.
> +
> +     Entries should be sorted by frequency so that the most frequent
> +     entry has the smallest index, thus most efficient variable
> +     encoding.
> +
> +   - Tree path dictionary: similar format to commit name
> +     dictionary. Each entry consists of two prefix bytes storing entry
> +     mode, then a NUL-terminated path name. Same sort order
> +     recommendation applies.
> +
> +   - The header is followed by number of object entries, each of
> +     which looks like this:
> +
> +     (undeltified representation)
> +     n-byte type and length (4-bit type, (n-1)*7+4-bit length)
> +     [uncompressed data]
> +     [compressed data]
> +
> +     (deltified representation)
> +     n-byte type and length (4-bit type, (n-1)*7+4-bit length)
> +     base object name in SHA-1 reference encoding
> +     compressed delta data
> +
> +     In undeltified format, blobs and tags do not have the
> +     uncompressed data, all object content is compressed. Trees are
> +     not compressed at all. Some headers in commits are stored
> +     uncompressed, the rest is compressed.
> +
> +     All objects except trees are deltified and compressed the same
> +     way in v3. Trees however are deltified differently and use

Let's note that commits are not deltified at all.

> +     undeltified representation. See "Tree representation" below for
> +     details.
> +
> +  - The trailer records 20-byte SHA-1 checksum of all of the above.
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
> +  - Author reference: the index, in variable length encoding, to comit
> +    name dictionary, which covers the name and also the time zone.
> +
> +  - Author timestamp in variable length encoding
> +
> +  - Committer reference: the index, in variable length encoding, to
> +    comit name dictionary, which covers the name and also the time
> +    zone.
> +
> +  - Committer timestamp in variable length encoding
> +
> +  - Compressed data of remaining header and the body
> +
> +=== Tree representation
> +
> +  - n-byte type and length (4-bit type, (n-1)*7+4-bit length)
> +
> +  - Number of trees in variable length encoding

Maybe that would be better to refer to tree entries instead of trees.

> +  - A number of trees, each consists of
> +
> +    Path component reference: an index, in variable length encoding,
> +    into tree path dictionary, which also covers entry mode.

Note the index nust have 1 added due to 0 being reserved.

> +    SHA-1 in SHA-1 reference encoding.
> +
> +Path component reference zero is an indicator of deltified portion and
> +has the following format:
> +
> +  - path component reference: zero
> +
> +  - index of the entry to copy from, in variable length encoding

I'd say "index of the starting entry in the tree object to copy from" to 
be clearer.  Also bit 0 of this index has a special meaning, therefore 
the actual index must be shifted left by 1 bit.

> +  - number of entries in variable length encoding

"number of entries to copy ..."

> +
> +  - base tree in SHA-1 reference encoding

The presence of this one depends on bit 0 in the index above.  If that 
bit is set then this base tree is provided.  Otherwise it is not 
provided and the previous base tree reference encountered in this tree 
object should be used.  This is to avoid repeating a SHA1 reference,
especially if a literal 20-byte SHA1 has to be used, when multiple 
references to the same base tree are made which is likely to be the 
common case.

> +=== SHA-1 reference encoding
> +
> +This encoding is used to encode SHA-1 efficiently if it's already in
> +the SHA-1 table. It starts with an index number in variable length
> +encoding. If it's not zero, its value minus one is the index in the
> +SHA-1 table. If it's zero, 20 bytes of SHA-1 is followed.
> -- 
> 1.8.2.83.gc99314b

--Boundary_(ID_F57mw4C6Oc0ejt5j94QYNg)--
